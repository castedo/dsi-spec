---
title: "Document Succession Identifiers"
date: 2023-12-15
abstract: |
    **DOCUMENT TYPE**: Technical Specification

    A Document Succession Identifier (DSI) in a bibliographic reference enables
    long-term retrieval of a cited document from any compatible website.
    A DSI can refer to either a succession of document snapshots
    or a specific document snapshot.
    This allows readers to discover document updates
    while retaining access to earlier snapshots.

    This technical specification defines the textual format for a DSI and
    formalizes the core information of a document succession.
...


# Alternatives

* As of 2023, the website
  [try.perm.pub](https://try.perm.pub) hosts documentation, tutorials, and how-to
  guides on resources supporting Document Succession Identifiers (DSIs).
* For a non-technical document discussing DSIs and their motivation, refer to
  [Why Publish Digital Successions](https://perm.pub/wk1LzCaCSKkIvLAYObAvaoLNGPc).


# Document Successions

A document succession contains document snapshots.
Each snapshot is a fixed collection of bytes that can be identified by a
[Git](https://en.wikipedia.org/wiki/Git) [@enwiki:git] hash or equivalent
[Software Hash Identifier (SWHID)](https://swhid.org).
A snapshot can be either a file or a specially encoded directory that is compatible with
Git, SWHIDs, and the
[Software Heritage Archive](https://softwareheritage.org) [@cosmo_referencing_2020].

Edition numbers are assigned to each document snapshot in a document succession.
Once an edition number is assigned, the assignment does not change.
The only way a document succession can be modified is by amending the succession
with new edition numbers.


# Textual representation of a DSI

The textual representation of a Document Succession Identifier (DSI) is a base
identifier followed by an optional slash followed by an optional edition number.
The edition number is represented as one to four non-negative
integers, each one to four digits, separated by periods.

## Examples

Base DSI of this specification:
: `1wFGhvmv8XZfPx0O5Hya2e9AyXo`

DSI of the first edition:
: `1wFGhvmv8XZfPx0O5Hya2e9AyXo/1`

DSI of the first subedition of the first edition:
: `1wFGhvmv8XZfPx0O5Hya2e9AyXo/1.1`


## Base DSI as Git hash

As of 2023, the only implementation of DSI is based on
[Git](https://en.wikipedia.org/wiki/Git) [@enwiki:git].
Future implementations could use another hash mechanism as long as the probability of
identifier collision is sufficiently low.
With a Git-based implementation,
the base DSI is calculated from the Git initial commit of a document succession.
Git-compatible software can calculate a 20-byte binary hash that identifies the document
succession.
This 20-byte binary hash is usually represented textually as a 40-digit
hexadecimal number. However, for a DSI, this 20-byte binary hash has a 27-character
representation in standard base64url format (RFC 4648)[@rfc4648].

It is worth noting that when a new document succession (git initial commit) is created,
a user can choose not to use it and instead immediately create a new one with a
different base64url hash.
There is little cost in recreating new
git initial commits until an acceptable base64url identifier is found.



## Formal Definition in Extended Backus–Naur Form

Note that `N * [ x ]` matches zero to N repetitions of `x`.

```
dsi ::= [ prefix ] base_dsi [ "/" [ edition_number ] ] ;
base_dsi ::= ( 26 * b64u_digit ) b64u_digit27 ;
edition_number ::= int_number ( 3 * [ "." int_number ] ) ;
int_number ::= "0" | pos_dec_digit ( 3 * [ dec_digit ] );
pos_dec_digit := "1" ... "9" ;
dec_digit := "0" | pos_dec_digit;
b64u_digit ::= "A" ... "Z" | "a" ... "z" | dec_digit | "-" | "_" ;
b64u_digit27 ::= "A" | "E" | "I" | "M" | "Q" | "U" | "Y" | "c" |
                 "g" | "k" | "o" | "s" | "w" | "0" | "4" | "8" ;
```

The optional `prefix` is described in the following section.

## DSI Prefix

Depending on the application context, users might want to use a DSI with or without
a prefix.
A natural intuitive minimal prefix is `dsi:`
since the identifier name has the acronym "DSI".
For convenience on the web, some websites
can provide a URL that serves as a DSI prefix.

As of 2023, the tool [Hidos](https://pypi.org/project/hidos/) supports DSIs
with or without the minimal `dsi:` prefix in the `find` subcommand. For example:

```bash
$ hidos find dsi:1wFGhvmv8XZfPx0O5Hya2e9AyXo
gh-703611066 https://github.com/digital-successions/1wFGhvmv8XZfPx0O5Hya2e9AyXo.git
```

As of 2023, the website `perm.pub` supports a URL-based prefix `https://perm.pub/` for
DSIs of some documents. For example:

```bash
$ firefox https://perm.pub/1wFGhvmv8XZfPx0O5Hya2e9AyXo
```

## Future extensions

To support future enhancements,
there are three paths to extending this textual representation.
These paths involve using a base DSI where:

* a character is neither a slash (`/`) nor one of the 64 base64url characters,
* the number of characters is different than 27, or
* the 27th character is one of the 48 base64url characters that never appear
  as the last character of a base64url encoding of 40 bytes
  (that is, any base64url character that is not
  `A`, `E`, `I`, `M`, `Q`, `U`, `Y`, `c`, `g`, `k`, `o`, `s`, `w`, `0`, `4`, or `8`).


# Multilevel edition numbering

In the simplest scenario, edition numbers are positive integers.
However, multilevel edition numbering may be used for more advanced usage.
Multilevel numbering is commonly used in the numbering of chapters, sections,
and subsections (for example, chapter 2, section 2.4, subsection 2.4.3)
as well as software release versions (for example, software release 2.19.2).

An edition number prefix, such as `1`, can specify either a document snapshot or
the entire sequence of editions `1.1`, `1.2`, `1.3`, etc...
An edition number identifies either a document snapshot or a sequence of subordinate
edition numbers, but not both. Larger integers indicate newer editions
that obsolete older editions with smaller integers. The DSI specification does not
assign any semantic meaning to different number levels.


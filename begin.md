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

    This technical specification
    formally defines the textual format of a DSI and
    outlines the concept of a document succession.
...


# Alternative Documents

* As of 2023, the website
  [try.perm.pub](https://try.perm.pub) provides documentation, tutorials, and
  guides on resources supporting Document Succession Identifiers (DSIs).
* For a non-technical overview of DSIs and their purpose, visit
  [Why Publish Digital Successions](https://perm.pub/wk1LzCaCSKkIvLAYObAvaoLNGPc).


# Specification

## Document Successions

A document succession contains document snapshots,
each a static collection of bytes identified by a
[Git](https://en.wikipedia.org/wiki/Git) [@enwiki:git] hash or an equivalent
[Software Hash Identifier (SWHID)](https://swhid.org).
A snapshot can be either a file or a directory encoded for compatibility with
Git, SWHIDs, and the
[Software Heritage Archive](https://softwareheritage.org) [@cosmo_referencing_2020].

Each snapshot in a document succession is assigned at least one fixed edition number.
Edition number assignments are immutable.
Document successions are updated only by adding new edition numbers.

An edition number can be a single non-negative integer or a multilevel
tuple of two to four non-negative integers.

In a document succession, no fixed edition number can be a prefix of another.
For instance, if `1.2.3` is a fixed edition number, then `1.2` cannot be a fixed
edition number.
However, a non-fixed edition number can identify a dynamic sequence of editions,
such as `1.2` identifying the sequence `1.2.1`, `1.2.2`, and `1.2.3`.

Multilevel edition numbers resemble software package release numbers
(for example, software release 2.19.2).
Larger integers represent newer editions
within the same level of an edition number.
This specification does not assign semantic meaning
to specific levels in edition numbers.

The integer `0` has a special meaning in edition numbers.
An edition number with any zero component is considered *unlisted*.
Furthermore, the last component integer of a fixed edition number must not be zero.


## Textual Representation of a DSI

The textual representation of a Document Succession Identifier (DSI) is a base
identifier, optionally followed by a slash and an edition number.
The edition number is represented as one to four non-negative
integers, each less than one thousand, separated by periods.

### Examples

Base DSI of this specification:
: `1wFGhvmv8XZfPx0O5Hya2e9AyXo`

DSI of the first edition:
: `1wFGhvmv8XZfPx0O5Hya2e9AyXo/1`

DSI of the first subedition of the first edition:
: `1wFGhvmv8XZfPx0O5Hya2e9AyXo/1.1`


### Base DSI as Git Hash

As of 2023, DSIs are implemented using
[Git](https://en.wikipedia.org/wiki/Git) [@enwiki:git].
Future implementations may use different hashing mechanisms,
as long as the risk of identifier collision remains acceptably low.
In a Git-based implementation,
the base DSI is calculated from the initial commit of a document succession.
Git-compatible software calculates a 20-byte binary hash,
typically represented as a 40-digit hexadecimal string.
For DSIs, this hash is represented by a 27-character string
using the standard base64url format (RFC 4648)[@rfc4648].


### Formal Definition in Extended Backus—Naur Form

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

The optional `prefix` is unspecified and described in the discussion section.

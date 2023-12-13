---
title: "Document Succession Identifiers"
date: 2023-12-13
abstract: |
    **DOCUMENT TYPE**: Technical Specification

    A Document Succession Identifier (DSI) in a bibliographic reference enables
    long-term retrieval of a cited document from any compatible website.
    A DSI can refer to either a succession of document snapshots
    or a specific document snapshot when paired with an edition number.
    This allows readers to discover document updates
    while retaining access to earlier snapshots.

    This technical specification defines the textual format for a DSI and
    formalizes the core information of a document succession.
...


# Alternative Reading

* As of 2023, the website
  [try.perm.pub](https://try.perm.pub) hosts documentation, tutorials, and how-to
  guides on resources supporting Document Succession Identifiers (DSI).
* For a non-technical document discussing DSIs and their motivation, refer to
  [Why Publish Digital Successions](https://perm.pub/wk1LzCaCSKkIvLAYObAvaoLNGPc).


# Digital successions

A document succession contains digital objects,
which are fixed finite collections of bits.
Examples of digital objects include computer files and file system directories (folders).
Both [git](https://en.wikipedia.org/wiki/Git) [@enwiki:git] and [Software
Heritage](https://softwareheritage.org) [@cosmo_referencing_2020]
can represent a file system directory as a digital object.
Each digital object in a document succession represents a new edition of a previous digital object
and is assigned a number that determines its order.
The document succession expands, but the digital objects within the succession
remain unchanged.

In addition, a document succession is digitally signed.
In this specification, the digital signature is made using an SSH signing key via
[git](https://en.wikipedia.org/wiki/Git) [@enwiki:git].
When a document succession is first created, it only consists of a digitally signed
genesis record and no digital object editions.
A *Digital Succession Identifier* is an intrinsic identifier
[@cosmo_referencing_2020] [@dicosmo:hal-01865790] of the genesis record.

## Digital successions implemented via git

In the git implementation, the genesis record is a signed initial git commit with an
empty tree (and no parent). To expand the document succession, additional git commits
are made using the same signing key. The git tree of each commit is not a
digital object in the succession. Instead, it is a record of all the
digital object editions in the succession. The top-level directory consists of
subdirectories named as non-negative integers. Each subdirectory
contains either an entry named `object` or entries named as non-negative integers that are
subdirectories. An entry named `object` represents a digital object edition in the
document succession, which can be a file (git blob) or a directory (git tree).
For example, when a single file is added as edition 1, the full succession record is a
directory with the path `1/object` leading to a git blob representing edition 1.

# Multilevel edition numbering

In the simplest scenario, edition numbers are positive integers.
However, multilevel edition numbering may be used for more advanced usage.
Multilevel numbering is commonly used in the numbering of
chapters, sections, and subsections (e.g., chapter 2, section 2.4, subsection 2.4.3)
as well as software release versions (e.g., software release 2.19.2).

An edition number prefix, such as `1`, can specify either a digital object edition or
the entire sequence of editions `1.1`, `1.2`, `1.3`, etc...
An edition number identifies either a digital object edition or a sequence of subordinate
edition numbers, but not both. Larger integers indicate newer editions
that obsolete older editions with smaller integers. The DSI specification does not
assign any semantic meaning to different number levels.

# Textual representation of a Digital Succession Identifier

The textual representation of a Digital Succession Identifier (DSI) is a base
identifier followed by an optional slash followed by an optional edition number
(possibly multilevel). The edition number is represented as non-negative
integers separated by periods.

The base DSI is calculated from the git initial commit (genesis record) of a document
succession. Git-compatible software can calculate a 20-byte binary hash that identifies the document succession.
This 20-byte binary hash is usually represented textually as a 40-digit
hexadecimal number. However, for a DSI, this 20-byte binary hash has a 27-character
representation in standard base64url format (RFC 4648)[@rfc4648].

It is worth noting that when a new document succession (git initial commit) is created,
a user can choose not to use it and instead immediately create a new one with a different base64url text representation.
There is little cost in not using empty document successions and recreating new genesis
records (git initial commits) until an acceptable base64url identifier is found.

## Examples

Base DSI of this specification:
: `dsi:1wFGhvmv8XZfPx0O5Hya2e9AyXo`

DSI of the first edition:
: `dsi:1wFGhvmv8XZfPx0O5Hya2e9AyXo/1`

DSI of the first digital object (subedition) of the first edition:
: `dsi:1wFGhvmv8XZfPx0O5Hya2e9AyXo/1.1`

## Future extensions

To support future enhancements,
there are three paths to extending this textual representation.
These paths involve using a base DSI where:

* a character is neither a slash (`/`) nor one of the 64 base64url characters,
* the number of characters is different than 27, or
* the 27th character is one of the 48 base64url characters that never appear
  as the last character of a base64url encoding of 40 bytes
  (i.e., any base64url character that is not
  `A`, `E`, `I`, `M`, `Q`, `U`, `Y`, `c`, `g`, `k`, `o`, `s`, `w`, `0`, `4`, or `8`).


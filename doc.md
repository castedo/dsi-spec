<!-- copybreak off -->

---
title: "Document Succession Identifiers"
date: 2024-02-18
abstract: |
    **DOCUMENT TYPE**: Living Technical Specification

    A Document Succession Identifier (DSI) is designed for use within bibliographic
    references for the long-term retrieval of a document succession,
    a type of document that is correctable yet redistributable across multiple websites.
    This DSI specification works in conjunction with the
    Document Succession Git Layout (DSGL) specification,
    which is a storage format for document successions.
    A DSI can reference either an entire document succession or,
    when an edition number is included, specific document snapshots.
    This feature lets readers quickly access both the latest edition and earlier editions.
    This DSI specification does not define any specific format for document snapshots;
    however, an example is Baseprint document snapshots.
...

<!-- copybreak on -->

Related Resources
-----------------

* The website <https://baseprints.singlesource.pub/> is available as a forum
  for open discussion and tracking topics relating to this DSI specification
  and other specifications related to Baseprint document successions.
* As of 2023, the website
  [try.perm.pub](https://try.perm.pub) provides documentation, tutorials, and
  guides on resources that support Document Succession Identifiers (DSIs).
* For a non-technical overview of DSIs and their purpose, visit
  [Why Publish Digital Successions](https://perm.pub/wk1LzCaCSKkIvLAYObAvaoLNGPc).

<!-- copybreak -->

Scope
-----

This is a specification for interoperability with these free open-source software
reference implementations:

* the Python package [Epijats](https://pypi.org/project/epijats) version 1.3,
* the Python package [Hidos](https://pypi.org/project/hidos/) [@hidos:1.3], and
* the [Document Succession Highly Manual Toolkit](https://manual.perm.pub) [@dshmtm].


Informal Description
--------------------

### Base DSI

The textual representation of a Document Succession Identifier (DSI) consists of a *base
DSI*, which may be optionally followed by a slash and an edition number.

**Example**: Base DSI of this specification document.

> `1wFGhvmv8XZfPx0O5Hya2e9AyXo`

A base DSI is a 27-character string in base64url format (RFC 4648)[@rfc4648]
representing a 20-byte binary hash that identifies a document succession.
This DSI specification does not define a storage format for document successions.
However, the reference implementations for DSI also support the storage format defined
by Document Succession Git Layout (DSGL).
In DSGL,
the base DSI is calculated from the initial
[Git](https://en.wikipedia.org/wiki/Git) [@enwiki:git]
commit of a document succession.
A Git commit corresponds to a *core
[Software Hash Identifier (SWHID)](https://swhid.org) for revisions*.

### Document Snapshots

A document succession contains document snapshots,
which are static and digitally encoded.
In DSGL,
document snapshots are either Git blobs or Git trees,
which are identifiable by [Software Hash Identifiers (SWHIDs)](https://swhid.org)
and can be archived in the
[Software Heritage Archive](https://softwareheritage.org) [@cosmo_referencing_2020].

**Example**: SWHID of a document snapshot of this specification from 2023.

> `swh:1:dir:eb9dfc65c22cde7b558ca2070ed4b2950074ed2f`

**Example**: Permalink at the Software Heritage Archive.

> <https://archive.softwareheritage.org/swh:1:dir:eb9dfc65c22cde7b558ca2070ed4b2950074ed2f>

### Edition Numbers

Edition numbers identify document snapshots within a document succession.
An edition number is composed of one to four non-negative
integers, each less than one thousand, and separated by periods.

**Example**: DSI of the first edition.

> `1wFGhvmv8XZfPx0O5Hya2e9AyXo/1`

An edition number is *multilevel* if it is composed of more than one integer (separated
by a periods).

**Example**: DSI of the fourth subedition of the first edition.

> `1wFGhvmv8XZfPx0O5Hya2e9AyXo/1.4`

Every document snapshot in a document succession has an edition number assigned to it.

**Example**: Edition 1.4 is assigned to a document snapshot.

> `1wFGhvmv8XZfPx0O5Hya2e9AyXo/1.4`
>
> ↓
>
> `swh:1:dir:eb9dfc65c22cde7b558ca2070ed4b2950074ed2f`

In some formal contexts, such as code, it may be convenient to admit an *empty edition
number* which corresponds to an empty tuple with no non-negative integers.
Unless otherwise noted,
the unqualified term *edition number* means a non-empty edition number.

### Lower-level Edition Numbers

An edition number is *below* another edition number if it consists of
the same non-negative integers that start the other edition number.
For example, edition number `1.2.3` is below edition number `1.2`.
An edition number is *above* another if the other is *below* it.

If an edition number is assigned to a document snapshot,
then no edition number above or below it is assigned to a document snapshot.
If an edition numbers is not assigned to a document snapshot,
then it implicitly identifies a sequence of editions assigned to snapshots.
This sequence consists of all the edition numbers below it that are assigned to a snapshot.

**Example**: 

> `1wFGhvmv8XZfPx0O5Hya2e9AyXo/1`
>
> ↓
>
> `1wFGhvmv8XZfPx0O5Hya2e9AyXo/1.1`
>
> `1wFGhvmv8XZfPx0O5Hya2e9AyXo/1.2`
>
> `1wFGhvmv8XZfPx0O5Hya2e9AyXo/1.3`
>
> `1wFGhvmv8XZfPx0O5Hya2e9AyXo/1.4`

Reference implementation Epijats will generate webpage content for edition numbers
higher than edition numbers assigned to snapshots.
The snapshop that is the most advanced edition in a sequence will be used to generated
the a webpage.

### Obsolete Editions

Multilevel edition numbers resemble software package release numbers
(for example, software release 2.19.2).
The integers that compose an edition number can be given a lexicographic order, that is,
an ordering like a dictionary.
For example, `2.1` comes after `1.2` in this ordering.
The reference implementations present editions which precede another edition
in lexicographic order as *obsolete*.
The Epijats library generates webpage content which encourages readers to visit
the edition most advanced in this ordering.

### Unlisted Editions

The last integer is positive for an edition number assigned to a snapshot.
The reference implementation present edition numbers with a zero integer component as
*unlisted*.
In the case of Epijats, this results in unlisted edition numbers not being included by
default in prominent edition number lists.

<!-- copybreak off -->

Formal Definitions
------------------

### Textual Representation in Extended Backus—Naur Form

Note that `[ x ] * N` matches zero to N repetitions of `x`.

```
dsi ::= [ prefix ] base_dsi [ "/" [ edition_number ] ] ;
base_dsi ::= ( b64u_digit * 26 ) b64u_digit27 ;
edition_number ::= ( [ non_neg_int "." ] * 3 ) pos_int;
non_neg_int ::= "0" | pos_int ;
pos_int ::= pos_dec_digit ( [ dec_digit ] * 3 ) ;
pos_dec_digit := "1" ... "9" ;
dec_digit := "0" | pos_dec_digit;
b64u_digit ::= "A" ... "Z" | "a" ... "z" | dec_digit | "-" | "_" ;
b64u_digit27 ::= "A" | "E" | "I" | "M" | "Q" | "U" | "Y" | "c" |
                 "g" | "k" | "o" | "s" | "w" | "0" | "4" | "8" ;
```

The optional `prefix` is unspecified and is described in the discussion section that
follows.

<!-- copybreak off -->

### Data Model

Git records in DSGL contain much Git-specific information
that does not constitute the essential information of a document succession.
The following formal model captures the essential information of a document
succession.

Mathematically this model is a pair `(B, M)` where `B` is the base document succession
identifier and `M` is a mapping from edition numbers to document snapshots.
The base identifier `B` corresponds to the base DSI and the 20-byte Git hash of the
initial commit.
The domain of the mapping 'M' is a set of edition numbers which mathematically are
defined as non-empty tuples of non-negative integers.
The [DSI specification)](https://perm.pub/1wFGhvmv8XZfPx0O5Hya2e9AyXo)
places additional restrictions on what domain of edition numbers are valid.
The range of `M` consists of a set of digital objects that encode the document snapshots.
Any document snapshot that can be encoded as a Git blog or Git tree is compatible with
this model.
Git blobs and Git trees are supported by the core SWHIDs of `swh:1:cnt:` and `swh:1:dir:`.


Discussion
----------

### Public Archives

Due to the role of the Software Heritage Archive and the reference implementations of DSGL,
once a document succession is publicly archived with an 
edition number assigned to a document snapshot,
reassigned is particular difficult and unlikely to be achieved.
The only pragmatic way to update a document succession archived in the Software
Heritage Archive is to add new edition numbers, not reassign them.

### Optional DSI Prefix

Users may choose to use a DSI with or without
a prefix, depending on the application context.
An intuitive choice for a prefix is `dsi:`, which mirrors the acronym "DSI".
For added convenience, some websites provide a URL that serves as a DSI prefix.

As of 2023, the [Hidos](https://pypi.org/project/hidos/) tool supports DSIs
both with and without the `dsi:` prefix in its `find` subcommand. For example:

```bash
$ hidos find dsi:1wFGhvmv8XZfPx0O5Hya2e9AyXo
gh-703611066 https://github.com/digital-successions/1wFGhvmv8XZfPx0O5Hya2e9AyXo.git
```

As of 2023, the website `perm.pub` supports a URL-based prefix `https://perm.pub/`,
as demonstrated in the following example:

```bash
$ firefox https://perm.pub/1wFGhvmv8XZfPx0O5Hya2e9AyXo
```

### Detailed Examples

The following detailed examples are for the document succession of this specification.
The base DSI of a document succession in DSGL is a base64url representation of the Git
commit hash.

#### Base DSI

**Example**: Initial Git commit hash (in hexadecimal).

> `d7014686f9aff1765f3f1d0ee47c9ad9ef40c97a`

**Example**: SWHID for initial commit.

> `swh:1:rev:d7014686f9aff1765f3f1d0ee47c9ad9ef40c97a`

Hashes and SWHIDs can be used across multiple archives, such as
GitHub and the Software Heritage Archive:

> <https://github.com/document-succession/1wFGhvmv8XZfPx0O5Hya2e9AyXo/commit/d7014686f9aff1765f3f1d0ee47c9ad9ef40c97a>

> <https://archive.softwareheritage.org/swh:1:rev:d7014686f9aff1765f3f1d0ee47c9ad9ef40c97a>


<!-- copybreak off -->

### Future Extensions

Future implementations may use different hashing mechanisms for the base DSI,
as long as the risk of identifier collision remains acceptably low.

To accommodate future enhancements,
there are three methods to extend the textual representation of a DSI:

* Use a character that is neither a slash (`/`) nor one of the 64 base64url characters.
* Vary the number of characters from 27.
* Make the 27th character one of the 48 base64url characters that never appear
  as the last character in a base64url encoding of 40 bytes
  (that is, any base64url character other than
  `A`, `E`, `I`, `M`, `Q`, `U`, `Y`, `c`, `g`, `k`, `o`, `s`, `w`, `0`, `4`, or `8`).

<!-- copybreak off -->

### Use of Base64url Over Hexadecimal

The textual identifier uses "base64url" (Base 64 with a URL and filename safe alphabet) as
specified in RFC 4648 [@rfc4648].
Both base64url and hexadecimal have their advantages and disadvantages.

The main downside to base64url is its susceptibility to copy
errors when the copying process relies on human sight.
Certain fonts make a poor distinction between some characters.
For example, some popular sans serif fonts make no visual distinction
between capital 'I' and lowercase 'l'.

However, creators of a new document succession are not obligated to use
a specific DSI.
If a DSI is deemed unsuitable, generating a new one is straightforward.

The main advantage of base64url is its brevity,
requiring only 27 characters compared to 40 in hexadecimal.
Since DSIs are used in contexts similar to DOIs,
a 27-character identifier is more likely to be acceptable,
as it is comparable to the length of a long DOI.
Additionally, a shorter ID is more suitable for display on mobile devices,
reducing the likelihood of
truncation, horizontal scrolling, or the need for very small fonts.

The choice of base64url is partly made on the belief that
the following technology trends mitigate the copy-by-human-sight issue:

1) Use of hyperlinks, copy-and-paste, and QR codes.

2) Tools that generate websites and PDFs with customizable fonts.

3) Human-to-computer interfaces incorporating
   features like autocomplete and typo correction to mitigate input errors.

<!-- copybreak off -->

Acknowledgments
---------------

Thank you to Valentin Lorentz for raising questions about design choices
and pointing out an important shortcoming in how GPG digital signatures were used
in the initial implementation of the Hidos library (version 0.3) [@hidos:0.3].


Further Reading
---------------

* This specification is heavily influenced by the concept of *intrinsic identifier* and
  related concepts discussed in
  [@cosmo_referencing_2020] [@dicosmo:hal-01865790].

* For a discussion on various concepts and proposed terminology regarding persistent
  identifiers, see [@kunze_persistence_2017]. According to this proposed terminology,
  a DSI is a persistent identifier (PID) that is "frozen" and "waxing" with
  "intraversioned" and "extraversioned" PIDs depending on the edition number.


Changes
-------

### From Edition 1 to 2

* The term "digital succession" has been updated to "document succession."

### From Edition 1.2

* References to SSH signing keys have replaced mentions of GPG/PGP signing keys.

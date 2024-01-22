
# Document Successions Encoded with Git

When a document succession is first created with Git, it begins as an
initial Git commit without any document snapshots.
A *Document Succession Identifier* is an intrinsic identifier
[@cosmo_referencing_2020] [@dicosmo:hal-01865790] of the initial Git commit.
Subsequent Git commits add document snapshots to the document succession.
However, the Git tree of each commit does not represent a single document snapshot;
instead, it records all snapshots in the succession.
The top-level directory contains subdirectories named with non-negative integers.
Each subdirectory contains either an entry named `object` or further subdirectories also
named with non-negative integers.
An entry named `object` encodes a document snapshot,
which may be a file (Git blob) or a directory (Git tree).
For example, adding a single file as edition 1 results in a
directory path `1/object` that corresponds to a Git blob for edition 1.

<!-- copybreak -->

## Digital Signing

For testing purposes, a document succession in Git can be unsigned.
However, for public distribution, it must be signed.
Digital signatures are applied using SSH signing keys through
[Git](https://en.wikipedia.org/wiki/Git) [@enwiki:git].
Each commit in a signed document succession must be signed
and contain a `signed_succession` subdirectory that includes an
`allowed_signers` file listing the public keys authorized to extend the document
succession.

<!-- copybreak -->

## Implementation Choice Rationales

### Separation of Git History from Edition History

Representing the history of editions through means other than Git commit history
is a deliberate design choice.
Git commit history records all Git actions,
which can lead to inflexible and complicated non-linear histories.
Software Heritage automatically preserves Git commits,
increasing the risk that a Git commit history could become
an unintended complicated non-linear history.
Non-linear Git commit histories and merge commits might be useful in certain scenarios.

Separating edition history from Git commit history also allows
for future enhancements, such as retracting specific editions.

<!-- copybreak -->

### Use of Git Tree Paths Instead of Git Tags

In document successions, edition numbers are akin to software release versions,
which are typically identified using Git tags.
However, this specification adopts a different approach.
Edition numbers are recorded with file paths in Git trees rather than Git tags.
With this approach, a single latest Git commit captures a complete record of a document succession.
This means copying document successions is as easy as copying Git branches.
This is especially useful when consolidating records from multiple sources into a single Git repository.

In contrast, software projects, which often include release tags,
are copied by cloning the entire repository.
Using Git tags for edition numbers would
introduce the complexity of keeping a branch and edition number tags in sync,
thereby increasing the risk of problems during copying.

While branches in Git repositories are useful for managing document successions,
branch names do not constitute a part of the document succession record.

<!-- copybreak -->

# Acknowledgments

Thank you to Valentin Lorentz for raising questions about design choices
and pointing out an important shortcoming in how GPG digital signatures were used
in the initial implementation of the Hidos library (version 0.3) [@hidos:0.3].


# Further Reading

* This specification is heavily influenced by the concept of *intrinsic identifier* and
  related concepts discussed in
  [@cosmo_referencing_2020] [@dicosmo:hal-01865790].

* For a discussion on various concepts and proposed terminology regarding persistent
  identifiers, see [@kunze_persistence_2017]. According to the proposed terminology, a DSI is a
  persistent identifier (PID) that is "frozen" and "waxing" with "intraversioned"
  and "extraversioned" PIDs depending on the edition number.


# Changes

## From Edition 1 to 2

* The term "digital succession" has been updated to "document succession."

## From Edition 1.2

* References to SSH signing keys have replaced mentions of GPG/PGP signing keys.


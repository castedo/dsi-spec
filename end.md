
# Document Successions Encoded with Git

When a document succession is first created with Git, it starts as an
initial Git commit without any document snapshots.
A *Document Succession Identifier* is an intrinsic identifier
[@cosmo_referencing_2020] [@dicosmo:hal-01865790] of the initial Git commit.
To add document snapshots to a document succession, additional Git commits are added.
However, the Git tree of each commit does not represent a document snapshot;
it records all snapshots in the succession.
The top-level directory contains subdirectories named with non-negative integers.
Each subdirectory contains either an entry named `object` or subdirectories named with
non-negative integers.
An entry named `object` encodes a document snapshot,
which can be a file (Git blob) or a directory (Git tree).
For example, adding a single file as edition 1 results in a
directory path `1/object` that leads to a Git blob for edition 1.

## Digital Signing

For testing, a document succession in Git can be unsigned.
However, for public distribution, it must be signed.
Digital signatures are applied using SSH signing keys through
[Git](https://en.wikipedia.org/wiki/Git) [@enwiki:git].
Each commit in a signed document succession must be signed
and contain a `signed_succession` subdirectory containing an
`allowed_signers` file with the public keys authorized to extend the document
succession.


## Implementation Choice Rationales

### Separation of Git History from Edition History

Representing the history of editions by some means other than Git commit history
is a deliberate design choice.
Git commit history records all Git actions,
which can lead to inflexible and complicated non-linear histories.
Software Heritage automatically preserves Git commits,
which compounds the risk that a Git commit history
ends up as an unintended complicated non-linear history.
Non-linear Git commit histories and merge commits might be useful in certain scenarios.

Separating edition history from Git commit history also allows
for future enhancements, such as the retraction of specific editions.

### Use of Git Tree Paths instead of Git Tags

Edition numbers in document successions are akin to software release versions,
which are typically identified using Git tags.
However, this specification takes a different approach.
Edition numbers are recorded with file paths in Git trees rather than Git tags.
With this approach, a single latest Git commit captures a complete recording of a document succession.
This means copying document successions is as easy as copying Git branches.
This is especially useful when copying from multiple sources into a single Git repository.

In contrast, software projects, which often include release tags,
are copied by cloning the entire repository.
Using Git tags for edition numbers would
introduce a complexity of keeping a branch and edition number tags in sync,
and thus increase the risk of problems during copying.

Branches in Git repositories are useful for managing document successions,
but branch names do not form part of the document succession record.


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


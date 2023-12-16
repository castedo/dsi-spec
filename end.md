
# Document Successions Encoded with Git

When a document succession is first created with Git, it consists of only an
initial Git commit and no document snapshots.
A *Document Succession Identifier* is an intrinsic identifier
[@cosmo_referencing_2020] [@dicosmo:hal-01865790] of the initial Git commit.
To add document snapshots to a document succession, additional git commits are added.
The Git tree of each commit is not a document snapshot in the succession.
Instead, it is a record of all the document snapshots in the succession.
The top-level directory consists of subdirectories named as non-negative integers.
Each subdirectory contains either an entry named `object` or entries named as
non-negative integers that are subdirectories.
An entry named `object` represents a document snapshot in the
document succession, which can be a file (git blob) or a directory (git tree).
For example, when a single file is added as edition 1, the full succession record is a
directory with the path `1/object` leading to a git blob representing edition 1.

## Digital Signing

For testing purposes, a document succession in Git can be unsigned. But for public
sharing, a document succession must be signed.
Digital signatures are made using SSH signing keys via
[Git](https://en.wikipedia.org/wiki/Git) [@enwiki:git].
Each Git commit of a signed document succession must be signed
and contain a subdirectory named `signed_succession` that contains a file
`allowed_signers` with public signing keys that can extend the document
succession.


## Implementation Choice Rationales

### Separation of git history from edition history

A significant design choice is to not directly rely on git commit history
to determine the succession of editions.
Git commit history accurately records the actions performed with git, but it can be
inflexible and confusing for establishing a clean linear history. Software
Heritage automatically preserves git commits, which compounds the risk that git commits
do not correspond well, or even prevent, an intended clean linear history.
There may be situations where having merge commits and non-linear
git commit history will be convenient.

Having edition history separate from git history also provides a potential path
for an enhancement akin to retractions of specific editions.

### Use of git tree paths instead of git tags

Edition numbers are similar to release versions of software projects.
The usual practice in software development is to use git tags to identify releases.
In contrast, this specification takes a different approach. Edition numbers are
recorded with file paths in git trees rather than git tags.

The main reason for this different approach has to do with how document successions are
recorded and copied. A highly desirable feature for document successions is the ease of
copying without errors. It is
convenient to copy document successions from multiple sources and store them in a single
git repository. In this specification, a complete document succession is captured
by just a chain of commits (initial commit to latest commit).
In contrast, entire software projects, which often include release tags, are usually
copied by cloning an entire repository.
If edition numbers were recorded as git annotated tags, copying document successions
properly would be more complicated and error-prone (due to missing tags).

Git repository branches are a convenient tool for managing document successions.
However, branch names are not part of the document succession record.




# Acknowledgments

Thank you to Valentin Lorentz for questions about design choices
and pointing out an important shortcoming in how GPG digital signatures were used in the
initial implementation of the Hidos library (version 0.3) [@hidos:0.3].


# Further Reading

* This specification is heavily influenced by the concept of *intrinsic identifier* and
  related concepts discussed in
  [@cosmo_referencing_2020] [@dicosmo:hal-01865790].

* For a discussion on various concepts and proposed terminology about persistent
  identifiers, see [@kunze_persistence_2017]. In the proposed terminology, a DSI is a
  persistent identifier (PID) that is "frozen" and "waxing" with both "intraversioned"
  and "extraversioned" PIDs depending on the edition number.


# Changes

## From Edition 1 to 2

* Change "digital succession" wording to "document succession".

## From Edition 1.2

* Reference SSH signing keys instead of GPG/PGP signing keys.

## From Edition 0.2

* Section added about multilevel edition numbering.
* Design rationale added behind git tree paths instead of git tags.
* Note future expansion paths for text representation.


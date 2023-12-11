
# Minutiae

* A multilevel edition number should not have more than four levels (components).
  Edition number components (per level) must not be negative and should not exceed four
  decimal digits.


# Acknowledgments

Thank you to Valentin Lorentz for questions about design choices
and pointing out an important shortcoming in how GPG digital signatures were used in the
initial implementation of the hidos library (version 0.3) [@hidos:0.3].


# Further Reading

* This specification is heavily influenced by the concept of *intrinsic identifier* and
  related concepts discussed in
  [@cosmo_referencing_2020] [@dicosmo:hal-01865790].

* For a discussion on various concepts and proposed terminology about persistent
  identifiers, see [@kunze_persistence_2017]. In the proposed terminology, a DSI is a
  persistent identifier (PID) that is "frozen" and "waxing" with both intraversioned
  and extraversioned PIDs depending on the edition number. 


# Changes

## From edition 1.2

* Reference SSH signing keys instead of GPG/PGP signing keys.

## From edition 0.2

* Add section about multilevel edition numbering.
* Add design rationale behind git tree paths instead of git tags.
* Note future expansion paths for text representation.


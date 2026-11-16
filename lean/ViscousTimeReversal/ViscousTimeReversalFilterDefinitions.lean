import Mathlib.Tactic
import MentorStudentModel
import ViscousTimeReversalDefinitions
import ViscousTimeReversalBucketDefinitions
import ViscousTimeReversalMeterDefinitions

/-! Definitions for the write, the remainder and the filter loop.

At a write the overlap is counted into the user's bucket as far as it fits (`keptOverlap`).
What does not fit is the remainder. It goes out to be filtered, comes back to the user, and
what passes goes into the user's bucket; what is still not settled goes back to be filtered
again. -/

namespace ViscousTimeReversal

open MentorStudent

/-- The remainder of a write: the part of the overlap `d` that does not fit in a bucket at `s`. -/
def remainder (s d : ℚ) : ℚ := d - keptOverlap s d

/-- The filter loop at one moment: the user's bucket, the remainder still out to be filtered,
    and the total that has passed into the bucket so far. -/
structure FilterLoop where
  bucket : ℚ
  rest : ℚ
  passed : ℚ

/-- The loop right after a write of overlap `d` into a bucket at `s`. -/
def afterWriteLoop (s d : ℚ) : FilterLoop := ⟨s + keptOverlap s d, remainder s d, 0⟩

/-- One pass. The filter passes the share `q` of the remainder; the user counts it into the
    bucket as far as it fits (`keptOverlap`), and the rest goes back to be filtered again. -/
def filterPass (q : ℚ) (x : FilterLoop) : FilterLoop :=
  ⟨x.bucket + keptOverlap x.bucket (q * x.rest), x.rest - keptOverlap x.bucket (q * x.rest),
    x.passed + keptOverlap x.bucket (q * x.rest)⟩

/-- `n` passes of the loop. -/
def filterLoop (q : ℚ) (x : FilterLoop) : Nat → FilterLoop
  | 0 => x
  | n + 1 => filterPass q (filterLoop q x n)

/-- Passes with a meter move on the user's bucket before each one (a fill or an empty, as on
    the meter), in order. -/
def filterLoopWith (q : ℚ) (x : FilterLoop) (ms : List Move) : FilterLoop :=
  ms.foldl (fun y m => filterPass q ⟨m.apply y.bucket, y.rest, y.passed⟩) x

end ViscousTimeReversal

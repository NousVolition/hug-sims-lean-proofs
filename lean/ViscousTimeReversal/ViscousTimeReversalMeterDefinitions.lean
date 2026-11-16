import Mathlib.Tactic
import MentorStudentModel
import FullModel
import ViscousTimeReversalDefinitions
import ViscousTimeReversalBucketDefinitions

/-! Definitions for the meter, the two windows taking turns, the 0,0 bucket, reversal on a
whole, the back ticks and the count through 0.

The meter follows `docs/penne-leapfrog`: window A hops while window B stays fixed, then B hops
while A stays fixed, both start from the marked piece, and the penne continues past the edge
of the view. -/

namespace ViscousTimeReversal

open MentorStudent

/-! ## The meter -/

/-- A meter level from 0 to 5/5. -/
def InMeter (x : ℚ) : Prop := 0 ≤ x ∧ x ≤ 5 / 5

/-- The two moves on a meter: fill by an amount, or empty by an amount. -/
inductive Move where
  | fill (amount : ℚ)
  | empty (amount : ℚ)

/-- One move on a meter at level `x`. A fill stops at 5/5, an empty stops at 0, and a negative
    amount counts as 0. -/
def Move.apply : Move → ℚ → ℚ
  | .fill a, x => min (5 / 5) (x + max a 0)
  | .empty a, x => max 0 (x - max a 0)

/-- Any finite run of moves on one meter, in order. -/
def runMeter (x : ℚ) (ms : List Move) : ℚ := ms.foldl (fun y m => m.apply y) x

/-! ## Two windows taking turns -/

/-- The two meters of a couple: window A and window B. -/
structure Couple where
  a : ℚ
  b : ℚ

/-- Both meters lie in the meter. -/
def Couple.InMeter (c : Couple) : Prop := ViscousTimeReversal.InMeter c.a ∧ ViscousTimeReversal.InMeter c.b

/-- The marked piece: both meters start full, 5/5 and 5/5. -/
def markedPiece : Couple := ⟨5 / 5, 5 / 5⟩

/-- A hop: window A moves while window B stays fixed, or window B moves while window A stays
    fixed. -/
inductive Hop where
  | A (m : Move)
  | B (m : Move)

/-- One hop on a couple. -/
def Hop.apply : Hop → Couple → Couple
  | .A m, c => ⟨m.apply c.a, c.b⟩
  | .B m, c => ⟨c.a, m.apply c.b⟩

/-- Any finite run of hops, in order. -/
def leapfrog (c : Couple) (hs : List Hop) : Couple := hs.foldl (fun d h => h.apply d) c

/-- Both windows filled back to 5/5. -/
def refill : List Hop := [.A (.fill (5 / 5)), .B (.fill (5 / 5))]

/-- One round of amount `x`: A empties by `x` and fills by `x`, then B does the same. -/
def round (x : ℚ) : List Hop := [.A (.empty x), .A (.fill x), .B (.empty x), .B (.fill x)]

/-- Any number of rounds, one for each amount in the list. -/
def rounds (xs : List ℚ) : List Hop := xs.flatMap round

/-! ## The 0,0 meeting -/

/-- The 0,0 meeting: the two meters go into one bucket at the placement's shares, the first at
    the student's share `s` and the second at the mentor's share `1 - s`. -/
def meetAtZero (pl : Placement) (c : Couple) : ℚ := pl.student * c.a + pl.mentor * c.b

/-! ## Ticks in time -/

/-- The time of a tick counted from 0, in model time: its clock offset in microseconds. -/
noncomputable def tickTime (k : Tick) : ℝ := (k.offsetUs : ℝ) / 1000000

/-- The count through 0: place `n` (back ticks below 0, ahead ticks above 0) sits at time
    `n / 10`, one prime tick being 1/10 of model time. -/
noncomputable def countTime (n : ℤ) : ℝ := (n : ℝ) / 10

end ViscousTimeReversal

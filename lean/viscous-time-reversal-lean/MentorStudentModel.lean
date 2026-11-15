import Mathlib.Tactic.NormNum
import Mathlib.Data.Real.Basic
import Mathlib.Order.Lattice
import Mathlib.Data.Finset.Filter

/-! Mentor and student rules.

1. Tick 2 starts as mentor 1 + student 1 = 2.
2. The 0,0 event splits the 2, leaving one shared 1.
3. After the split, mentor + student always make 1. The relationship places
   the share: the student holds `s` and the mentor holds `1 - s`.
4. Movement speeds: mentor step 25*i and student (listener) step 32*i at the
   i-th prime tick, as in
   `lean/sims-mentor-first-thought-lean/MentorThoughtModel.lean`. -/
namespace MentorStudent

/-! ## Rules 1 and 2: the start and the split -/

/-- At tick 2 the mentor starts as a whole 1. -/
def startMentor : ℚ := 1

/-- At tick 2 the student starts as a whole 1. -/
def startStudent : ℚ := 1

/-- After the 0,0 event, one shared 1 is left. -/
def sharedWhole : ℚ := 1

/-! ## Rule 3: the share after the split -/

/-- The mentor holds whatever the student does not: `1 - s`. -/
def mentorOf (s : ℚ) : ℚ := sharedWhole - s

/-- A placement of the share by the relationship: the student's part `s`,
    between 0 and 1. -/
structure Placement where
  student : ℚ
  atLeastZero : 0 ≤ student
  atMostOne : student ≤ 1

/-- The mentor's part for a placement. -/
def Placement.mentor (p : Placement) : ℚ := mentorOf p.student

/-- Toddler example: student 0.1. -/
def toddler : Placement := ⟨1/10, by norm_num, by norm_num⟩

/-- Highly skilled student example: student 0.9. -/
def skilledStudent : Placement := ⟨9/10, by norm_num, by norm_num⟩

/-! ## Rule 4: movement speeds (as in MentorThoughtModel.lean) -/

def primeLabel (p : Nat) : Bool :=
  2 ≤ p && (List.range (p - 2)).all (fun i => p % (i + 2) != 0)

def labels : List Nat := (List.range 42).filter primeLabel

structure Tick where
  label : Nat
  listener : Nat
  mentor : Nat
  offsetUs : Nat
  deriving DecidableEq

def schedule : List Tick :=
  labels.zipIdx.map (fun (p,i) => ⟨p, 32*i, 25*i, 100000*i⟩)

/-- The gap: how far the student (listener) is ahead of the mentor. -/
def gap (t : Tick) : Nat := t.listener - t.mentor

/-- The PrimeMeter labels, as in
    `lean/hug-prime-meter-lean/PrimeMeter/Types.lean`. -/
def meterLabels : List Nat := [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,
  61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157]

/-! ## (A) Three separate switches -/

/-- The Hug cutoff value. -/
def herCutoff : ℚ := 1

/-- 0.015: a record value, separate from the Hug cutoff. -/
def recordCutoff : ℚ := 0.015

/-- `pos`, as in `lean/as-lean/ASModel.lean`. -/
def pos (x : ℝ) : ℝ := max x 0

/-- The three switch settings: Hug cutoff, Hug breathing on or off, and the
    clay and threshold that set A/S activation. -/
structure Switches where
  cutoff : ℚ
  breathingOn : Bool
  clay : ℝ
  threshold : ℝ

/-- Switch 1 output: the Hug cutoff. -/
def hugCutoff (s : Switches) : ℚ := s.cutoff

/-- Switch 2 output: the Hug breathing peak, 1/2 when on and 0 when off. -/
def breathingPeak (s : Switches) : ℚ := if s.breathingOn then 1/2 else 0

/-- Switch 3 output: A/S activation = pos(clay - threshold), as in ASModel.lean. -/
def asActivation (s : Switches) : ℝ := pos (s.clay - s.threshold)

/-! ## (B) Gap, touch and overlap -/

/-- Signed margin: where mine begins minus where yours ends. -/
def margin (mineBegins yoursEnds : ℝ) : ℝ := mineBegins - yoursEnds

inductive Contact where
  | gap | touch | overlap
  deriving DecidableEq

/-- More than 0 is a gap, exactly 0 is a touch, less than 0 is an overlap. -/
noncomputable def contact (mineBegins yoursEnds : ℝ) : Contact :=
  if 0 < margin mineBegins yoursEnds then .gap
  else if margin mineBegins yoursEnds = 0 then .touch else .overlap

/-- How far yours reaches past where mine begins. -/
def overlapSize (mineBegins yoursEnds : ℝ) : ℝ := yoursEnds - mineBegins

/-! ## (C) The chain keeps 4/5 -/

def keep : ℚ := 4/5
def loss : ℚ := 1/5

/-- Held after `n` ticks with no write: each tick loses 1/5 of what is held. -/
def held : Nat → ℚ
  | 0 => 1
  | n+1 => held n - loss * held n

/-- At a write the partner supplies the missing amount. -/
def partnerSupply (h : ℚ) : ℚ := 1 - h

/-- Held right after a write. -/
def afterWrite (h : ℚ) : ℚ := h + partnerSupply h

/-- The writes are at prime ticks 11, 23 and 41. -/
def writeTicks : List Nat := [11, 23, 41]

/-! ## (D) Window rule -/

/-- The candidates in a window from `back` to `front`. -/
def window (candidates : Finset ℤ) (back front : ℤ) : Finset ℤ :=
  candidates.filter (fun t => back ≤ t ∧ t ≤ front)

/-- `w` is a closest candidate in window `W` for the gaps `g`. -/
def Closest {α : Type} [LinearOrder α] (g : ℤ → α) (W : Finset ℤ) (w : ℤ) : Prop :=
  w ∈ W ∧ ∀ q ∈ W, g w ≤ g q

/-! ## Further rules, taken as definitions -/

/-- The total before the 0,0 event: mentor 1 + student 1 at tick 2. -/
def beforeSplit : ℚ := startMentor + startStudent

/-- The 0,0 event splits the 2 and leaves 1: after the split, student `s` plus
    mentor `1 - s`. -/
def splitEvent (s : ℚ) : ℚ := s + mentorOf s

/-- The freeze at prime tick index `i`: the tick is 23, the mentor part plus the
    student part is 1 there, and a write happens at that tick. -/
def Freeze (p : Placement) (i : Nat) : Prop :=
  labels[i]? = some 23 ∧ p.mentor + p.student = 1 ∧ (labels[i]?).any (· ∈ writeTicks) = true

/-- Forward or back. -/
inductive Direction where
  | forward | back
  deriving DecidableEq, Repr

/-- Triage: a cousin, twin or sexy prime, back or forward, opens a space that an
    overlap can move into. Cousin 4, twin 2, sexy 6. -/
def partnerGaps : List Nat := [4, 2, 6]

/-- The space a partner opens from tick `p` with gap `k`: forward `p + k`, back `p - k`. -/
def opening (p k : Nat) : Direction → Nat
  | .forward => p + k
  | .back => p - k

/-- The partners of tick `p` (gap, direction, tick) whose opened space is a prime tick. -/
def primePartners (p : Nat) : List (Nat × Direction × Nat) :=
  (partnerGaps.flatMap fun k => [Direction.forward, Direction.back].map fun d => (k, d, opening p k d)).filter
    fun x => primeLabel x.2.2

/-- The overlap `d` moves into the opened space; the student holds `s + d` and the
    mentor the rest. -/
def moveOverlap (s d : ℚ) : ℚ × ℚ := (s + d, mentorOf (s + d))

/-- Signed margin rule (where mine begins minus where yours ends): changing the
    student's share by `d` moves where the student begins from `b` to `b + d`.
    This is not the gap; the gap is the tick 23 freeze. -/
def moveBegin (b : ℝ) (d : ℚ) : ℝ := b + d

/-- Held counts prime ticks: the index of the last write tick (11, 23, 41) at or
    before prime tick index `i`, or 0 (tick 2, the start) if none. -/
def lastWrite (i : Nat) : Nat :=
  ((List.range (i+1)).filter (fun j => (labels[j]?).any (· ∈ writeTicks))).getLast?.getD 0

/-- Held at prime tick index `i`: (4/5) for each prime tick since the last write. -/
def heldAt (i : Nat) : ℚ := held (i - lastWrite i)

/-! ## The gap: the tick 23 freeze, where energy is not lost

Recorded values, copied as exact decimals (as exact rationals) from
`research/chat-research-update-2026-11-12/numerical/backward-onset/evidence/energy-work-check.json`
(sha256 5e2200033ed530c3dd497c87ad558669e6b1e11b51c1e3ec02dcb0139f853c29), rows at time 0.8,
sides "before write" and "after write". The file's definition: "Energy = kinetic + material +
mean excess heat. External work = threshold-force ledger[1] + breathing_work + write_work.
Viscous dissipation is internally transferred into heat, not separately subtracted from this
total." The file also says `no_exact_discrete_energy_identity_assumed`. -/

/-- One recorded energy row (kinetic, material, mean excess heat, energy E, the three work
    ledgers, external work W, and E − W), as printed in the record. -/
structure EnergyRow where
  kinetic : ℚ
  material : ℚ
  heat : ℚ
  energy : ℚ
  thresholdWork : ℚ
  breathingWork : ℚ
  writeWork : ℚ
  externalWork : ℚ
  energyMinusWork : ℚ

/-- Time 0.8, "before write" (checkpoint `prime-23-before-write.npz`). -/
def beforeWrite23 : EnergyRow where
  kinetic := (54422920858397501135 / 10 ^ 24 : ℚ)
  material := (7256375192995124665 / 10 ^ 25 : ℚ)
  heat := (20778002324220589589 / 10 ^ 22 : ℚ)
  energy := (21329487907997559724 / 10 ^ 22 : ℚ)
  thresholdWork := (9142883608428670664 / 10 ^ 24 : ℚ)
  breathingWork := (12416506524531780321 / 10 ^ 23 : ℚ)
  writeWork := (1164164805002657913 / 10 ^ 23 : ℚ)
  externalWork := (144949596903773053 / 10 ^ 21 : ℚ)
  energyMinusWork := (19879991938959829194 / 10 ^ 22 : ℚ)

/-- Time 0.8, "after write" (checkpoint `prime-23.npz`). -/
def afterWrite23 : EnergyRow where
  kinetic := (54422920858397501135 / 10 ^ 24 : ℚ)
  material := (72517787724888073476 / 10 ^ 26 : ℚ)
  heat := (20923182327573972374 / 10 ^ 22 : ℚ)
  energy := (21474663314930436192 / 10 ^ 22 : ℚ)
  thresholdWork := (9142883608428670664 / 10 ^ 24 : ℚ)
  breathingWork := (12416506524531780321 / 10 ^ 23 : ℚ)
  writeWork := (26159188732173286403 / 10 ^ 24 : ℚ)
  externalWork := (15946713758591976027 / 10 ^ 23 : ℚ)
  energyMinusWork := (19879991939071238589 / 10 ^ 22 : ℚ)

/-- The record's time for both rows: 0.8. -/
def write23Time : ℚ := 8/10

/-- One event-write record from
    `research/chat-research-update-2026-11-12/numerical/full-flow-energy/runs/journal-1/writes.json`
    (sha256 7b92ba9e643768495fdf55fbe0adb4198751a372488e5ed754d5c0dadc56b84d). -/
structure WriteRecord where
  slot : Nat
  time : ℚ
  work : ℚ
  stored : ℚ
  heat : ℚ
  energyError : ℚ

/-- Entry 402 of that file: kind "event", slot 1 (the second write), time 0.8. -/
def secondWrite : WriteRecord where
  slot := 1
  time := (8 / 10 ^ 1 : ℚ)
  work := (12850794744422023 / 10 ^ 21 : ℚ)
  stored := (-4095057776059904 / 10 ^ 25 : ℚ)
  heat := (12851204250199629 / 10 ^ 21 : ℚ)
  energyError := (606475590234079 / 10 ^ 33 : ℚ)

end MentorStudent

import Mathlib.Tactic
import MentorStudentModel
import HugWallPushProofs
import V3SourceSystem

/-! Definitions for prime ticks counted ahead and back, the paired buckets and the general bucket rule. -/

section

/-! Prime ticks counted ahead and back.

Every rule used here comes from `MentorStudentModel.lean` in this package:
`sharedWhole` (l.26), `mentorOf` (l.31), `Placement` (l.35-41), `primeLabel` and `labels`
(l.51-54), `Tick` and `schedule` (l.56-64), `gap` (l.67), `keep`, `loss`, `held` (l.121-127),
`partnerSupply`, `afterWrite` (l.130-133), `writeTicks` (l.136), `beforeSplit` (l.151),
`splitEvent` (l.155), `Freeze` (l.159-160), `Direction` (l.163-165), `partnerGaps` (l.169),
`opening` (l.172-174), `primePartners` (l.177-179), `moveOverlap` (l.183),
`lastWrite`, `heldAt` (l.192-196). -/

namespace ViscousTimeReversal

open MentorStudent

/-! ## The prime ticks -/

/-- The two directions of counting from a start at 0: ahead and back. Both are held at 0. -/
inductive Side where
  | forward | past
  deriving DecidableEq, Repr

/-- Where a prime tick sits, counted from 0: ahead is `+p`, back is `-p`. -/
def place : Side → Nat → ℤ
  | .forward, p => p
  | .past, p => -(p : ℤ)

/-! ## Statement 4's dial: the step sizes -/

/-- The imported schedule with the two step sizes as a dial: student `a*i`, mentor `b*i`. -/
def scheduleWith (a b : Nat) : List Tick :=
  labels.zipIdx.map (fun (p, i) => ⟨p, a * i, b * i, 100000 * i⟩)

/-! ## Statement 1: the past side runs on the same prime ticks -/

/-- The ticks counted back: the same ticks as counted ahead, each placed at `-p`. -/
def pastSchedule (a b : Nat) : List (Tick × ℤ) :=
  (scheduleWith a b).map (fun t => (t, place .past t.label))

/-! ## Statement 2: partners match ahead and back -/

/-! ## Statement 3: mentor + student = 1 at every past prime tick -/

/-! ## Statement 4: past steps use the same dial -/

/-- The gap at index `i` on the forward side. -/
def gapAt (a b i : Nat) : Option Nat := ((scheduleWith a b)[i]?).map gap

/-- The gap at index `i` on the past side. -/
def pastGapAt (a b i : Nat) : Option Nat := ((pastSchedule a b)[i]?).map (fun x => gap x.1)

/-- The gap in whole numbers that may go below 0. -/
def gapZ (a b i : Nat) : ℤ := (a * i : ℤ) - (b * i : ℤ)

/-! ## Statement 5: the past record is fixed -/

/-- The forward held value and the past record. -/
structure TwoSides where
  forwardHeld : ℚ
  pastRecord : Nat → ℚ

/-- One forward tick with no write: the forward side loses `loss`; the past record is untouched. -/
def forwardTick (s : TwoSides) : TwoSides :=
  { s with forwardHeld := s.forwardHeld - loss * s.forwardHeld }

/-! ## Statement 6: the loss is a dial -/

/-- The loss per tick: `k/5`, with `k` from 0 to 5. -/
def lossDial (k : Fin 6) : ℚ := (k.val : ℚ) / 5

/-- Held after `n` ticks with no write, for loss `k/5`. -/
def heldDial (k : Fin 6) : Nat → ℚ
  | 0 => 1
  | n + 1 => heldDial k n - lossDial k * heldDial k n

/-- Each side has its own dial. -/
structure Dials where
  forward : Fin 6
  past : Fin 6

def sideHeld (d : Dials) : Side → Nat → ℚ
  | .forward => heldDial d.forward
  | .past => heldDial d.past

/-! ## Statement 7: no loss at a write tick (the rule chosen for this check) -/

/-- The prime tick at index `i` is a write tick (11, 23 or 41), as in the imported `lastWrite`. -/
def isWrite (i : Nat) : Bool := (labels[i]?).any (· ∈ writeTicks)

/-- Held tick by tick along the prime ticks with loss `k/5`: a write tick takes no loss and the
    partner supplies the rest (`afterWrite`). -/
def runHeld (k : Fin 6) : Nat → ℚ
  | 0 => 1
  | i + 1 => if isWrite (i + 1) then afterWrite (runHeld k i)
      else runHeld k i - lossDial k * runHeld k i

/-! ## Statement 8: freeze ticks 41, 23 and 11 -/

def freezePartners : List Nat := [41, 23, 11]

/-- The imported `Freeze`, with tick `t` in place of 23. -/
def FreezeAt (pl : Placement) (i t : Nat) : Prop :=
  labels[i]? = some t ∧ pl.mentor + pl.student = 1 ∧ (labels[i]?).any (· ∈ writeTicks) = true

/-! ## Back openings counted below 0 -/

/-- A step back by `k` from tick `p`, counted with whole numbers that may go below 0, so it can
    go below 0. -/
def backStep (p k : Nat) : ℤ := (p : ℤ) - k

/-! ## Shares after an overlap move, from `mentorOf`, `splitEvent` and `moveOverlap` -/

end ViscousTimeReversal

end

section

/-! Paired buckets, partners past tick 41, the breath, and the one-start lead. -/

namespace ViscousTimeReversal

open MentorStudent

/-! ## Paired buckets -/

/-- A bucket at `k/5` with its partner at `(5-k)/5`. -/
def dialPair (k : Fin 6) : ℚ × ℚ := ((k.val : ℚ) / 5, (5 - (k.val : ℚ)) / 5)

/-- One partner step with dial `k`: `k/5` of the first bucket moves into its partner. -/
def triageMove (k : Fin 6) (x : ℚ × ℚ) : ℚ × ℚ :=
  (x.1 - lossDial k * x.1, x.2 + lossDial k * x.1)

/-- A write: the first bucket fills toward 1 only by what moves out of its partner. -/
def writeMove (x : ℚ × ℚ) : ℚ × ℚ := (x.1 + min (1 - x.1) x.2, x.2 - min (1 - x.1) x.2)

/-- The pair tick by tick along the prime ticks with dial `k`. -/
def runPair (k : Fin 6) : Nat → ℚ × ℚ
  | 0 => (1, 0)
  | i + 1 => if isWrite (i + 1) then writeMove (runPair k i) else triageMove k (runPair k i)

/-- Each direction runs its own pair with its own dial. -/
def sidePair (d : Dials) : Side → Nat → ℚ × ℚ
  | .forward => runPair d.forward
  | .past => runPair d.past

/-! ## Partners past tick 41 -/

/-- The partners of `p` whose tick is one of the labelled ticks. -/
def landed (p : Nat) : List (Nat × Direction × Nat) :=
  (primePartners p).filter (fun x => decide (x.2.2 ∈ labels))

/-- The partner with the smallest gap (the first one on a tie). -/
def pickNearest : List (Nat × Direction × Nat) → Option (Nat × Direction × Nat)
  | [] => none
  | x :: xs => match pickNearest xs with
    | none => some x
    | some y => if x.1 ≤ y.1 then some x else some y

/-- A partner that lands on a labelled tick stays; one that does not goes to the nearest
    partner that does. -/
def resolve (p : Nat) (x : Nat × Direction × Nat) : Option (Nat × Direction × Nat) :=
  if x.2.2 ∈ labels then some x else pickNearest (landed p)

/-- What a partner step carries: the two ticks (lower, higher), the gap, and the overlap. -/
def carried (p : Nat) (x : Nat × Direction × Nat) (d : ℚ) : Nat × Nat × Nat × ℚ :=
  (min p x.2.2, max p x.2.2, x.1, d)

/-! ## Statement 10: the breath -/

/-- The overlap kept so the student's share stays between 0 and 1. -/
def keptOverlap (s d : ℚ) : ℚ := max (-s) (min d (1 - s))

theorem keptOverlap_bounds (s d : ℚ) : 0 ≤ s + keptOverlap s d ∧ s + keptOverlap s d ≤ 1 := by
  unfold keptOverlap
  constructor
  · linarith [le_max_left (-s) (min d (1 - s))]
  · have : max (-s) (min d (1 - s)) ≤ 1 - s :=
      max_le (by linarith) (min_le_right _ _)
    linarith

/-- An overlap move that keeps the shares a `Placement`. -/
def moveWithin (p : Placement) (d : ℚ) : Placement :=
  ⟨(moveOverlap p.student (keptOverlap p.student d)).1,
    (keptOverlap_bounds p.student d).1, (keptOverlap_bounds p.student d).2⟩

/-! ## One full start ahead, found from the overlap -/

/-- Who is one full start ahead at a tick, found from the overlap move: 1 the student, -1 the
    mentor, 0 neither. -/
def lead (s d : ℚ) : ℤ :=
  if s < (moveOverlap s d).1 then 1 else if (moveOverlap s d).1 < s then -1 else 0

def studentStart (s d : ℚ) : ℤ := if lead s d = 1 then 1 else 0

def mentorStart (s d : ℚ) : ℤ := if lead s d = -1 then 1 else 0

/-- Student's time at tick `i`: 32 steps per tick, from its start, in the imported `studentStep`. -/
def studentTime (shares overlaps : ℕ → ℚ) (i : ℕ) : ℚ :=
  ((32 * ((i : ℤ) + studentStart (shares i) (overlaps i)) : ℤ) : ℚ) * HugWallPush.studentStep

/-- Mentor's time at tick `i`: 25 steps per tick, from its start, in the imported `mentorStep`. -/
def mentorTime (shares overlaps : ℕ → ℚ) (i : ℕ) : ℚ :=
  ((25 * ((i : ℤ) + mentorStart (shares i) (overlaps i)) : ℤ) : ℚ) * HugWallPush.mentorStep

end ViscousTimeReversal

end

section

/-! The general bucket rule. -/

namespace ViscousTimeReversal

open MentorStudent

open scoped BigOperators

/-! ## Buckets -/

/-- A full bucket over parts `ι`: each part has a clean amount and a dirty amount, neither below
    0, and all parts together make 1. -/
structure Bucket (ι : Type*) [Fintype ι] where
  clean : ι → ℚ
  dirty : ι → ℚ
  clean_nonneg : ∀ i, 0 ≤ clean i
  dirty_nonneg : ∀ i, 0 ≤ dirty i
  full : ∑ i, (clean i + dirty i) = 1

variable {ι : Type*} [Fintype ι]

/-- A part's share: its clean plus its dirty amount. -/
def Bucket.share (b : Bucket ι) (i : ι) : ℚ := b.clean i + b.dirty i

/-- Total dirty amount in a bucket. -/
def Bucket.dirtTotal (b : Bucket ι) : ℚ := ∑ i, b.dirty i

/-! ## Parts made of smaller parts -/

/-- Gathering parts: each part `i` goes into the larger part `f i`. -/
def Bucket.gather {κ : Type*} [Fintype κ] [DecidableEq κ] (f : ι → κ) (b : Bucket ι) :
    Bucket κ where
  clean k := ∑ i ∈ Finset.univ.filter (fun i => f i = k), b.clean i
  dirty k := ∑ i ∈ Finset.univ.filter (fun i => f i = k), b.dirty i
  clean_nonneg k := Finset.sum_nonneg (fun i _ => b.clean_nonneg i)
  dirty_nonneg k := Finset.sum_nonneg (fun i _ => b.dirty_nonneg i)
  full := by
    rw [← b.full, ← Finset.sum_fiberwise Finset.univ f (fun i => b.clean i + b.dirty i)]
    refine Finset.sum_congr rfl (fun k _ => ?_)
    rw [Finset.sum_add_distrib]

/-- A bucket whose parts are split into smaller parts (`κ i` inside part `i`) gathers back into a
    full bucket over the parts. -/
def Bucket.ofNested {κ : ι → Type*} [∀ i, Fintype (κ i)] [DecidableEq ι]
    (b : Bucket (Σ i, κ i)) : Bucket ι := b.gather Sigma.fst

/-! ## Meetings -/

/-- A meeting: for each part, the fraction `r i` (from 0 to 1) of its dirty amount that is
    swapped for the same amount of clean. -/
structure Meeting (ι : Type*) where
  r : ι → ℚ
  r_nonneg : ∀ i, 0 ≤ r i
  r_le_one : ∀ i, r i ≤ 1

/-- The bucket after a meeting. -/
def Bucket.meet (b : Bucket ι) (m : Meeting ι) : Bucket ι where
  clean i := b.clean i + m.r i * b.dirty i
  dirty i := b.dirty i - m.r i * b.dirty i
  clean_nonneg i := add_nonneg (b.clean_nonneg i) (mul_nonneg (m.r_nonneg i) (b.dirty_nonneg i))
  dirty_nonneg i := by
    have := mul_le_mul_of_nonneg_right (m.r_le_one i) (b.dirty_nonneg i)
    linarith
  full := by
    rw [← b.full]; refine Finset.sum_congr rfl (fun i _ => ?_); ring

/-- Any number of meetings, in order. -/
def Bucket.meetAll (b : Bucket ι) (ms : List (Meeting ι)) : Bucket ι := ms.foldl Bucket.meet b

/-! ## Two buckets meeting at the split -/

/-- Two full buckets meet at the split into one shared bucket: the first side's parts weighted by
    the placement's student share `s`, the second side's by `mentorOf s`. -/
def collide {κ : Type*} [Fintype κ] (p : Placement) (u : Bucket ι) (v : Bucket κ) :
    Bucket (ι ⊕ κ) where
  clean := Sum.elim (fun i => p.student * u.clean i) (fun k => p.mentor * v.clean k)
  dirty := Sum.elim (fun i => p.student * u.dirty i) (fun k => p.mentor * v.dirty k)
  clean_nonneg := by
    have hm : 0 ≤ p.mentor := by
      simp only [Placement.mentor, mentorOf, sharedWhole]; linarith [p.atMostOne]
    rintro (i | k)
    · exact mul_nonneg p.atLeastZero (u.clean_nonneg i)
    · exact mul_nonneg hm (v.clean_nonneg k)
  dirty_nonneg := by
    have hm : 0 ≤ p.mentor := by
      simp only [Placement.mentor, mentorOf, sharedWhole]; linarith [p.atMostOne]
    rintro (i | k)
    · exact mul_nonneg p.atLeastZero (u.dirty_nonneg i)
    · exact mul_nonneg hm (v.dirty_nonneg k)
  full := by
    rw [Fintype.sum_sum_type]
    simp only [Sum.elim_inl, Sum.elim_inr, ← mul_add, ← Finset.mul_sum, u.full, v.full, mul_one]
    simp [Placement.mentor, mentorOf, sharedWhole]

/-- The placement with the shares the other way round. -/
def swapPlacement (p : Placement) : Placement :=
  ⟨p.mentor, by simp only [Placement.mentor, mentorOf, sharedWhole]; linarith [p.atMostOne],
    by simp only [Placement.mentor, mentorOf, sharedWhole]; linarith [p.atLeastZero]⟩

/-! ## Separating after the meetings -/

/-- The first side's total in a shared bucket. -/
def leftTotal {κ : Type*} [Fintype κ] (b : Bucket (ι ⊕ κ)) : ℚ := ∑ i, b.share (Sum.inl i)

/-- The second side's total in a shared bucket. -/
def rightTotal {κ : Type*} [Fintype κ] (b : Bucket (ι ⊕ κ)) : ℚ := ∑ k, b.share (Sum.inr k)

/-- The second side taken back out, scaled to full. -/
def takeRight {κ : Type*} [Fintype κ] (b : Bucket (ι ⊕ κ)) (h : 0 < rightTotal b) : Bucket κ where
  clean k := b.clean (Sum.inr k) / rightTotal b
  dirty k := b.dirty (Sum.inr k) / rightTotal b
  clean_nonneg k := div_nonneg (b.clean_nonneg _) h.le
  dirty_nonneg k := div_nonneg (b.dirty_nonneg _) h.le
  full := by
    simp only [← add_div]; rw [← Finset.sum_div]
    exact div_self h.ne'

/-- The first side taken back out, scaled to full. -/
def takeLeft {κ : Type*} [Fintype κ] (b : Bucket (ι ⊕ κ)) (h : 0 < leftTotal b) : Bucket ι where
  clean i := b.clean (Sum.inl i) / leftTotal b
  dirty i := b.dirty (Sum.inl i) / leftTotal b
  clean_nonneg i := div_nonneg (b.clean_nonneg _) h.le
  dirty_nonneg i := div_nonneg (b.dirty_nonneg _) h.le
  full := by
    simp only [← add_div]; rw [← Finset.sum_div]
    exact div_self h.ne'

/-! ## The paired rule as a two-part bucket -/

/-- Moving clean amount `a` from part `j` to part `i`. -/
def Bucket.transfer [DecidableEq ι] (b : Bucket ι) (i j : ι) (hij : i ≠ j) (a : ℚ)
    (ha : 0 ≤ a) (haj : a ≤ b.clean j) : Bucket ι where
  clean x := if x = i then b.clean x + a else if x = j then b.clean x - a else b.clean x
  dirty := b.dirty
  clean_nonneg x := by
    split_ifs with h1 h2
    · linarith [b.clean_nonneg x]
    · subst h2; linarith
    · exact b.clean_nonneg x
  dirty_nonneg := b.dirty_nonneg
  full := by
    rw [← b.full]
    have key : ∀ x, ((if x = i then b.clean x + a else if x = j then b.clean x - a else b.clean x)
        + b.dirty x) = (b.clean x + b.dirty x) + ((if x = i then a else 0) - (if x = j then a else 0)) := by
      intro x
      by_cases h1 : x = i
      · subst h1; simp [hij]; ring
      · by_cases h2 : x = j
        · subst h2; simp [h1]; ring
        · simp [h1, h2]
    simp only [key, Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq',
      Finset.mem_univ, if_true, sub_self, add_zero]

/-- A pair `(x, y)` with `x + y = 1` as a two-part bucket, all clean. -/
def pairBucket (x y : ℚ) (hx : 0 ≤ x) (hy : 0 ≤ y) (h : x + y = 1) : Bucket Bool where
  clean := fun t => if t then x else y
  dirty := fun _ => 0
  clean_nonneg t := by cases t <;> simp [hx, hy]
  dirty_nonneg _ := le_rfl
  full := by simp [Fintype.sum_bool, h]

/-! ## Concrete check -/

/-- Three parts: shares 1/2, 1/3, 1/6 with dirt 1/4, 1/6, 0. -/
def threeParts : Bucket (Fin 3) where
  clean := ![1/4, 1/6, 1/6]
  dirty := ![1/4, 1/6, 0]
  clean_nonneg i := by fin_cases i <;> norm_num
  dirty_nonneg i := by fin_cases i <;> norm_num
  full := by simp [Fin.sum_univ_three]; norm_num

/-- A meeting swapping half the dirt at every part. -/
def halfMeeting : Meeting (Fin 3) := ⟨fun _ => 1/2, fun _ => by norm_num, fun _ => by norm_num⟩

/-! ## A start holds its history and what is ahead in one bucket -/

/-- A start (0): one full bucket whose parts are history parts `η` and ahead parts `φ`. Any part
    types are allowed, so a history with any number of parts fits. -/
abbrev Start (η φ : Type*) [Fintype η] [Fintype φ] := Bucket (η ⊕ φ)

variable {η φ : Type*} [Fintype η] [Fintype φ]

/-- A start with `n + 1` history parts and one ahead part: history all dirty, `1/(2(n+1))` each;
    ahead all clean, `1/2`. -/
def historyStart (n : Nat) : Start (Fin (n + 1)) Unit where
  clean := Sum.elim (fun _ => 0) (fun _ => 1/2)
  dirty := Sum.elim (fun _ => 1 / (2 * (n + 1))) (fun _ => 0)
  clean_nonneg := by rintro (i | u) <;> simp
  dirty_nonneg := by rintro (i | u) <;> simp; positivity
  full := by
    rw [Fintype.sum_sum_type]
    simp only [Sum.elim_inl, Sum.elim_inr, zero_add, add_zero, Finset.sum_const,
      Finset.card_univ, Fintype.card_fin, Fintype.card_unit, nsmul_eq_mul, one_mul]
    field_simp; push_cast; ring

/-- The meetings at the prime ticks, in order 2, 3, ..., 41: the meeting at tick `p` is `f p`. -/
def tickMeetings (f : Nat → Meeting ι) : List (Meeting ι) := labels.map f

/-! ## Break attempts -/

end ViscousTimeReversal

end

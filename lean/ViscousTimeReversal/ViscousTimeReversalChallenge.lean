import ViscousTimeReversalDefinitions
import ViscousTimeReversalBucketChallenge

namespace ViscousTimeReversal

open MentorStudent

/-- Reversing time about `T` twice gives back the original trace. -/
theorem reverseTime_twice (T t : ℝ) (f : ℝ → ℝ) :
    reverseTime T (reverseTime T f) t = f t := by sorry

/-- Reversing time flips the sign of the rate. -/
theorem timeReverse_derivative (f : ℝ → ℝ) (T t d : ℝ)
    (h : HasDerivAt f d (T - t)) :
    HasDerivAt (reverseTime T f) (-d) t := by sorry

/-- Reversing time turns a viscous rate `ν * lap` into `(-ν) * lap`. -/
theorem viscosity_reversal (f lap : ℝ → ℝ) (T t ν : ℝ)
    (h : HasDerivAt f (ν * lap (T - t)) (T - t)) :
    HasDerivAt (reverseTime T f) ((-ν) * lap (T - t)) t := by sorry

/-- Reversing time flips the sign of the whole right-hand side: transport, viscous and coupling terms. -/
theorem whole_rhs_reversal (f transport lap coupling : ℝ → ℝ) (T t ν : ℝ)
    (h : HasDerivAt f (transport (T - t) + ν * lap (T - t) + coupling (T - t))
      (T - t)) :
    HasDerivAt (reverseTime T f)
      (-transport (T - t) - ν * lap (T - t) - coupling (T - t)) t := by sorry

/-- The forward factor solves `y' = -(ν q) y`. -/
theorem forwardFactor_derivative (ν q t : ℝ) :
    HasDerivAt (forwardFactor ν q) (-(ν * q) * forwardFactor ν q t) t := by sorry

/-- The backward factor solves `y' = (ν q) y`. -/
theorem backwardFactor_derivative (ν q t : ℝ) :
    HasDerivAt (backwardFactor ν q) ((ν * q) * backwardFactor ν q t) t := by sorry

/-- Forward, a ripple is only damped. -/
theorem forward_damping (ν q t : ℝ) (hν : 0 ≤ ν) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    forwardFactor ν q t ≤ 1 := by sorry

/-- Backward, a ripple is only amplified. -/
theorem backward_amplification (ν q t : ℝ) (hν : 0 ≤ ν) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    1 ≤ backwardFactor ν q t := by sorry

/-- With positive viscosity, wave number and time, the forward damping is strict. -/
theorem forward_strict_damping (ν q t : ℝ) (hν : 0 < ν) (hq : 0 < q) (ht : 0 < t) :
    forwardFactor ν q t < 1 := by sorry

/-- With positive viscosity, wave number and time, the backward amplification is strict. -/
theorem backward_strict_amplification (ν q t : ℝ) (hν : 0 < ν) (hq : 0 < q) (ht : 0 < t) :
    1 < backwardFactor ν q t := by sorry

/-- Backward, finer ripples (larger `q`) are amplified at least as much. -/
theorem higher_frequency_amplification (ν q₁ q₂ t : ℝ) (hν : 0 ≤ ν) (ht : 0 ≤ t) (hq : q₁ ≤ q₂) :
    backwardFactor ν q₁ t ≤ backwardFactor ν q₂ t := by sorry

/-- The forward and backward factors multiply to exactly 1. -/
theorem factor_cancellation (ν q t : ℝ) :
    forwardFactor ν q t * backwardFactor ν q t = 1 := by sorry

/-- A negative time step reverses the viscous rate. -/
theorem negative_step_reverses_rate (h ν q a : ℝ) :
    eulerIncrement (-h) (viscousRate ν q a) = h * ((ν * q) * a) := by sorry

/-- A negative step with negated viscosity gives the same increment as the forward step. -/
theorem double_sign_flip_restores_forward (h ν q a : ℝ) :
    eulerIncrement (-h) (viscousRate (-ν) q a) = eulerIncrement h (viscousRate ν q a) := by sorry

/-- The split: 1 + 1 = 2 before it, one shared 1 after it, and it sits at tick 2 with mentor
    step 0, student step 0 and clock offset 0. Reversing time leaves the split where it is. -/
theorem split_at_tick_two :
    beforeSplit = 2 ∧ (∀ s : ℚ, splitEvent s = 1) ∧
    (schedule[0]?).map (fun k => (k.label, k.mentor, k.listener, k.offsetUs)) = some (2, 0, 0, 0) ∧
    aroundSplit 0 = 0 := by sorry

/-- Reversing time around the 0,0 split twice gives back exactly what was there. -/
theorem reverse_twice {α : Type} (f : ℝ → α) (t : ℝ) :
    reverseAroundSplit (reverseAroundSplit f) t = f t := by sorry

/-- Run backward, mentor + student still make 1 at every time. -/
theorem reversal_keeps_one (share : ℝ → Placement) (t : ℝ) :
    (reverseAroundSplit share t).mentor + (reverseAroundSplit share t).student = 1 := by sorry

/-- Read from the other side of the split, the margin (where mine begins minus where yours
    ends) changes sign and keeps its size. -/
theorem reflect_flips_margin (b e : ℝ) :
    margin (reflect b) (reflect e) = -(margin b e) := by sorry

/-- A forward gap becomes a backward overlap, and the overlap is exactly the size of the gap. -/
theorem forward_gap_becomes_backward_overlap (b e : ℝ) (h : contact b e = .gap) :
    contact (reflect b) (reflect e) = .overlap ∧
    overlapSize (reflect b) (reflect e) = margin b e := by sorry

/-- A touch stays a touch in both directions. -/
theorem touch_stays_touch (b e : ℝ) (h : contact b e = .touch) :
    contact (reflect b) (reflect e) = .touch := by sorry

/-- At tick 23 the student (listener) is at 256 and the mentor at 200: a gap of 56.
    Reflected through the split, it is an overlap of 56. -/
theorem tick23_gap_reverses_to_overlap :
    (schedule[8]?).map (fun k => (k.label, k.listener, k.mentor)) = some (23, 256, 200) ∧
    contact (256 : ℝ) 200 = .gap ∧ margin (256 : ℝ) 200 = 56 ∧
    contact (reflect 256) (reflect 200) = .overlap ∧
    overlapSize (reflect 256) (reflect 200) = 56 := by sorry

/-- The tick 23 freeze sits 0.8 after the split. Run backward it sits 0.8 before the split,
    and reversing twice returns it to 0.8. The freeze holds for every placement. -/
theorem freeze_at_tick23_both_ways (p : Placement) :
    Freeze p 8 ∧
    (schedule[8]?).map (fun k => (k.label, k.offsetUs)) = some (23, 800000) ∧
    aroundSplit ((800000 : ℝ) / 1000000) = -(4/5) ∧
    aroundSplit (aroundSplit (4/5)) = 4/5 := by sorry

/-- If the student's share changes by `d`, the student's start moves by `d`; run backward,
    the change is `-d`, the start moves back to where it was, and the shares still make 1. -/
theorem share_change_undone (s d : ℚ) (b e : ℝ) :
    moveBegin (moveBegin b d) (-d) = b ∧
    margin (moveBegin (moveBegin b d) (-d)) e = margin b e ∧
    mentorOf (s + d + -d) = mentorOf s ∧
    (s + d + -d) + mentorOf (s + d + -d) = 1 := by sorry

/-- The wall is the single-system viscosity, point by point. -/
theorem wall_is_single_system_viscosity (z : HugNavierSingle.Fields) (r : HugNavierSingle.Point) :
    HugNavierSingle.viscosity z r = wall (z.gAB r) (z.gBA r) := by sorry

/-- The thin wall is 1/50 and the thick wall is 1/10. -/
theorem thin_and_thick_wall : thinWall = 1/50 ∧ thickWall = 1/10 := by sorry

/-- With the guards between 0 and 1, the wall is between thin (1/50) and thick (1/10). -/
theorem wall_between_thin_and_thick (gAB gBA : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) :
    wall gAB gBA ∈ Set.Icc (1/50 : ℝ) (1/10) := by sorry

/-- Run backward, the wall's viscosity is between -1/10 and -1/50. -/
theorem reversed_wall_range (gAB gBA : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) :
    reversedWall gAB gBA ∈ Set.Icc (-1/10 : ℝ) (-1/50) := by sorry

/-- Reversing time around the split turns the wall term into the reversed wall term. -/
theorem wall_flips_under_reversal (f lap : ℝ → ℝ) (gAB gBA t : ℝ)
    (h : HasDerivAt f (wall gAB gBA * lap (aroundSplit t)) (aroundSplit t)) :
    HasDerivAt (reverseAroundSplit f) (reversedWall gAB gBA * lap (aroundSplit t)) t := by sorry

/-- Forward, the wall only damps. -/
theorem forward_wall_only_damps (gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    forwardFactor (wall gAB gBA) q t ≤ 1 := by sorry

/-- Backward, the wall only amplifies. -/
theorem backward_wall_only_amplifies (gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    1 ≤ backwardFactor (wall gAB gBA) q t := by sorry

/-- Backward, the thick wall amplifies most and the thin wall least. -/
theorem thick_wall_amplifies_most (gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    backwardFactor thinWall q t ≤ backwardFactor (wall gAB gBA) q t ∧
    backwardFactor (wall gAB gBA) q t ≤ backwardFactor thickWall q t := by sorry

/-- Forward, the thick wall damps most and the thin wall least. -/
theorem thick_wall_damps_most (gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    forwardFactor thickWall q t ≤ forwardFactor (wall gAB gBA) q t ∧
    forwardFactor (wall gAB gBA) q t ≤ forwardFactor thinWall q t := by sorry

/-- At the wall, the forward and backward factors multiply to exactly 1. -/
theorem wall_factors_multiply_to_one (gAB gBA q t : ℝ) :
    forwardFactor (wall gAB gBA) q t * backwardFactor (wall gAB gBA) q t = 1 := by sorry

/-- A backward step through the wall is the same as a forward step through the reversed wall. -/
theorem backward_step_is_reversed_wall (h gAB gBA q a : ℝ) :
    eulerIncrement (-h) (viscousRate (wall gAB gBA) q a) =
      eulerIncrement h (viscousRate (reversedWall gAB gBA) q a) := by sorry

/-- Counted forward from the split, what the wall takes is never negative. -/
theorem wall_takes_forward_from_split (a gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    0 ≤ takenForward a (wall gAB gBA) q t := by sorry

/-- Counted backward from the split, what the reversed wall gives is never negative. -/
theorem wall_gives_backward_from_split (a gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    0 ≤ givenBackward a (wall gAB gBA) q t := by sorry

/-- For a ≠ 0, q > 0 and t > 0, both amounts counted from the split are strictly positive,
    so their sum exceeds each one: the two directions add and do not cancel. -/
theorem both_directions_add (a gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1)
    (ha0 : a ≠ 0) (hq : 0 < q) (ht : 0 < t) :
    0 < takenForward a (wall gAB gBA) q t ∧ 0 < givenBackward a (wall gAB gBA) q t ∧
    takenForward a (wall gAB gBA) q t <
      takenForward a (wall gAB gBA) q t + givenBackward a (wall gAB gBA) q t ∧
    givenBackward a (wall gAB gBA) q t <
      takenForward a (wall gAB gBA) q t + givenBackward a (wall gAB gBA) q t := by sorry

end ViscousTimeReversal

import ViscousTimeReversalDefinitions
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace ViscousTimeReversal

open MentorStudent

/-- Reversing time about `T` twice gives back the original trace. -/
theorem reverseTime_twice (T t : ℝ) (f : ℝ → ℝ) :
    reverseTime T (reverseTime T f) t = f t := by
  simp [reverseTime]

/-- Reversing time flips the sign of the rate. -/
theorem timeReverse_derivative (f : ℝ → ℝ) (T t d : ℝ)
    (h : HasDerivAt f d (T - t)) :
    HasDerivAt (reverseTime T f) (-d) t := by
  unfold reverseTime
  simpa [Function.comp_def] using h.comp t (HasDerivAt.const_sub T (hasDerivAt_id t))

/-- Reversing time turns a viscous rate `ν * lap` into `(-ν) * lap`. -/
theorem viscosity_reversal (f lap : ℝ → ℝ) (T t ν : ℝ)
    (h : HasDerivAt f (ν * lap (T - t)) (T - t)) :
    HasDerivAt (reverseTime T f) ((-ν) * lap (T - t)) t := by
  simpa only [neg_mul] using timeReverse_derivative f T t (ν * lap (T - t)) h

/-- Reversing time flips the sign of the whole right-hand side: transport, viscous and coupling terms. -/
theorem whole_rhs_reversal (f transport lap coupling : ℝ → ℝ) (T t ν : ℝ)
    (h : HasDerivAt f (transport (T - t) + ν * lap (T - t) + coupling (T - t))
      (T - t)) :
    HasDerivAt (reverseTime T f)
      (-transport (T - t) - ν * lap (T - t) - coupling (T - t)) t := by
  simpa only [neg_add, sub_eq_add_neg] using
    timeReverse_derivative f T t
      (transport (T - t) + ν * lap (T - t) + coupling (T - t)) h

/-- The forward factor solves `y' = -(ν q) y`. -/
theorem forwardFactor_derivative (ν q t : ℝ) :
    HasDerivAt (forwardFactor ν q) (-(ν * q) * forwardFactor ν q t) t := by
  unfold forwardFactor
  simpa [mul_comm] using
    ((hasDerivAt_id t).const_mul (-(ν * q))).exp

/-- The backward factor solves `y' = (ν q) y`. -/
theorem backwardFactor_derivative (ν q t : ℝ) :
    HasDerivAt (backwardFactor ν q) ((ν * q) * backwardFactor ν q t) t := by
  unfold backwardFactor
  simpa [mul_comm] using
    ((hasDerivAt_id t).const_mul (ν * q)).exp

/-- Forward, a ripple is only damped. -/
theorem forward_damping (ν q t : ℝ) (hν : 0 ≤ ν) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    forwardFactor ν q t ≤ 1 := by
  calc
    forwardFactor ν q t ≤ Real.exp 0 := Real.exp_le_exp.mpr
      (mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr (mul_nonneg hν hq)) ht)
    _ = 1 := Real.exp_zero

/-- Backward, a ripple is only amplified. -/
theorem backward_amplification (ν q t : ℝ) (hν : 0 ≤ ν) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    1 ≤ backwardFactor ν q t := by
  calc
    (1 : ℝ) = Real.exp 0 := Real.exp_zero.symm
    _ ≤ backwardFactor ν q t := Real.exp_le_exp.mpr (mul_nonneg (mul_nonneg hν hq) ht)

/-- With positive viscosity, wave number and time, the forward damping is strict. -/
theorem forward_strict_damping (ν q t : ℝ) (hν : 0 < ν) (hq : 0 < q) (ht : 0 < t) :
    forwardFactor ν q t < 1 := by
  calc
    forwardFactor ν q t < Real.exp 0 := Real.exp_lt_exp.mpr
      (mul_neg_of_neg_of_pos (neg_neg_of_pos (mul_pos hν hq)) ht)
    _ = 1 := Real.exp_zero

/-- With positive viscosity, wave number and time, the backward amplification is strict. -/
theorem backward_strict_amplification (ν q t : ℝ) (hν : 0 < ν) (hq : 0 < q) (ht : 0 < t) :
    1 < backwardFactor ν q t := by
  calc
    (1 : ℝ) = Real.exp 0 := Real.exp_zero.symm
    _ < backwardFactor ν q t := Real.exp_lt_exp.mpr (mul_pos (mul_pos hν hq) ht)

/-- Backward, finer ripples (larger `q`) are amplified at least as much. -/
theorem higher_frequency_amplification (ν q₁ q₂ t : ℝ) (hν : 0 ≤ ν) (ht : 0 ≤ t) (hq : q₁ ≤ q₂) :
    backwardFactor ν q₁ t ≤ backwardFactor ν q₂ t := by
  exact Real.exp_le_exp.mpr
    (mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hq hν) ht)

/-- The forward and backward factors multiply to exactly 1. -/
theorem factor_cancellation (ν q t : ℝ) :
    forwardFactor ν q t * backwardFactor ν q t = 1 := by
  unfold forwardFactor backwardFactor
  rw [← Real.exp_add]
  have h : -(ν * q) * t + (ν * q) * t = 0 := by ring
  rw [h, Real.exp_zero]

/-- A negative time step reverses the viscous rate. -/
theorem negative_step_reverses_rate (h ν q a : ℝ) :
    eulerIncrement (-h) (viscousRate ν q a) = h * ((ν * q) * a) := by
  unfold eulerIncrement viscousRate
  ring

/-- A negative step with negated viscosity gives the same increment as the forward step. -/
theorem double_sign_flip_restores_forward (h ν q a : ℝ) :
    eulerIncrement (-h) (viscousRate (-ν) q a) = eulerIncrement h (viscousRate ν q a) := by
  unfold eulerIncrement viscousRate
  ring

/-! ## The 0,0 split and reversing around it -/

/-- The split: 1 + 1 = 2 before it, one shared 1 after it, and it sits at tick 2 with mentor
    step 0, student step 0 and clock offset 0. Reversing time leaves the split where it is. -/
theorem split_at_tick_two :
    beforeSplit = 2 ∧ (∀ s : ℚ, splitEvent s = 1) ∧
    (schedule[0]?).map (fun k => (k.label, k.mentor, k.listener, k.offsetUs)) = some (2, 0, 0, 0) ∧
    aroundSplit 0 = 0 := by
  refine ⟨by norm_num [beforeSplit, startMentor, startStudent], fun s => ?_, by decide, ?_⟩
  · simp [splitEvent, mentorOf, sharedWhole]
  · simp [aroundSplit]

/-- Reversing time around the 0,0 split twice gives back exactly what was there. -/
theorem reverse_twice {α : Type} (f : ℝ → α) (t : ℝ) :
    reverseAroundSplit (reverseAroundSplit f) t = f t := by
  simp [reverseAroundSplit, aroundSplit]

/-- Run backward, mentor + student still make 1 at every time. -/
theorem reversal_keeps_one (share : ℝ → Placement) (t : ℝ) :
    (reverseAroundSplit share t).mentor + (reverseAroundSplit share t).student = 1 := by
  simp [Placement.mentor, mentorOf, sharedWhole]

/-- 0.2 and 0.8: run backward, a student at 0.2 has a mentor at 0.8, and a student at 0.8 has
    a mentor at 0.2. -/
theorem fifth_and_four_fifths (share : ℝ → Placement) (t : ℝ) :
    ((share (aroundSplit t)).student = 1/5 → (reverseAroundSplit share t).mentor = 4/5) ∧
    ((share (aroundSplit t)).student = 4/5 → (reverseAroundSplit share t).mentor = 1/5) := by
  refine ⟨fun h => ?_, fun h => ?_⟩
  · simp only [reverseAroundSplit, Placement.mentor, mentorOf, sharedWhole, h]; norm_num
  · simp only [reverseAroundSplit, Placement.mentor, mentorOf, sharedWhole, h]; norm_num

/-! ## Gap, touch and overlap under reversal -/

/-- Read from the other side of the split, the margin (where mine begins minus where yours
    ends) changes sign and keeps its size. -/
theorem reflect_flips_margin (b e : ℝ) :
    margin (reflect b) (reflect e) = -(margin b e) := by
  simp only [margin, reflect]; ring

/-- A forward gap becomes a backward overlap, and the overlap is exactly the size of the gap. -/
theorem forward_gap_becomes_backward_overlap (b e : ℝ) (h : contact b e = .gap) :
    contact (reflect b) (reflect e) = .overlap ∧
    overlapSize (reflect b) (reflect e) = margin b e := by
  have hg : 0 < margin b e := by
    rcases lt_trichotomy (margin b e) 0 with h' | h' | h'
    · unfold contact at h; simp [not_lt.mpr h'.le, h'.ne] at h
    · unfold contact at h; simp [h'] at h
    · exact h'
  have hr : margin (reflect b) (reflect e) < 0 := by
    rw [reflect_flips_margin]; linarith
  refine ⟨?_, ?_⟩
  · unfold contact
    simp [not_lt.mpr hr.le, hr.ne]
  · simp only [overlapSize, margin, reflect]; ring

/-- A touch stays a touch in both directions. -/
theorem touch_stays_touch (b e : ℝ) (h : contact b e = .touch) :
    contact (reflect b) (reflect e) = .touch := by
  have h0 : margin b e = 0 := by
    rcases lt_trichotomy (margin b e) 0 with h' | h' | h'
    · unfold contact at h; simp [not_lt.mpr h'.le, h'.ne] at h
    · exact h'
    · unfold contact at h; simp [h'] at h
  have hr : margin (reflect b) (reflect e) = 0 := by
    rw [reflect_flips_margin, h0, neg_zero]
  unfold contact
  simp [hr]

/-- At tick 23 the student (listener) is at 256 and the mentor at 200: a gap of 56.
    Read backward, it is an overlap of 56. -/
theorem tick23_gap_reverses_to_overlap :
    (schedule[8]?).map (fun k => (k.label, k.listener, k.mentor)) = some (23, 256, 200) ∧
    contact (256 : ℝ) 200 = .gap ∧ margin (256 : ℝ) 200 = 56 ∧
    contact (reflect 256) (reflect 200) = .overlap ∧
    overlapSize (reflect 256) (reflect 200) = 56 := by
  have hg : contact (256 : ℝ) 200 = .gap := by
    unfold contact margin; norm_num
  refine ⟨by decide, hg, by norm_num [margin], (forward_gap_becomes_backward_overlap _ _ hg).1, ?_⟩
  rw [(forward_gap_becomes_backward_overlap _ _ hg).2]; norm_num [margin]

/-- The tick 23 freeze sits 0.8 after the split. Run backward it sits 0.8 before the split,
    and reversing twice returns it to 0.8. The freeze holds for every placement. -/
theorem freeze_at_tick23_both_ways (p : Placement) :
    Freeze p 8 ∧
    (schedule[8]?).map (fun k => (k.label, k.offsetUs)) = some (23, 800000) ∧
    aroundSplit ((800000 : ℝ) / 1000000) = -(4/5) ∧
    aroundSplit (aroundSplit (4/5)) = 4/5 := by
  refine ⟨⟨by decide, ?_, by decide⟩, by decide, ?_, ?_⟩
  · simp [Placement.mentor, mentorOf, sharedWhole]
  · norm_num [aroundSplit]
  · simp [aroundSplit]

/-- If the student's share changes by `d`, the student's start moves by `d`; run backward,
    the change is `-d`, the start moves back to where it was, and the shares still make 1. -/
theorem share_change_undone (s d : ℚ) (b e : ℝ) :
    moveBegin (moveBegin b d) (-d) = b ∧
    margin (moveBegin (moveBegin b d) (-d)) e = margin b e ∧
    mentorOf (s + d + -d) = mentorOf s ∧
    (s + d + -d) + mentorOf (s + d + -d) = 1 := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · simp only [moveBegin]; push_cast; ring
  · simp only [margin, moveBegin]; push_cast; ring
  · simp
  · simp [mentorOf, sharedWhole]

/-! ## The wall -/

/-- The wall is the single-system viscosity, point by point. -/
theorem wall_is_single_system_viscosity (z : HugNavierSingle.Fields) (r : HugNavierSingle.Point) :
    HugNavierSingle.viscosity z r = wall (z.gAB r) (z.gBA r) := rfl

/-- The thin wall is 1/50 and the thick wall is 1/10. -/
theorem thin_and_thick_wall : thinWall = 1/50 ∧ thickWall = 1/10 := by
  constructor <;> norm_num [thinWall, thickWall, wall]

/-- With the guards between 0 and 1, the wall is between thin (1/50) and thick (1/10). -/
theorem wall_between_thin_and_thick (gAB gBA : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) :
    wall gAB gBA ∈ Set.Icc (1/50 : ℝ) (1/10) := by
  obtain ⟨ha0, ha1⟩ := ha
  obtain ⟨hb0, hb1⟩ := hb
  constructor <;> simp only [wall] <;> linarith

/-- Run backward, the wall's viscosity is between -1/10 and -1/50. -/
theorem reversed_wall_range (gAB gBA : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) :
    reversedWall gAB gBA ∈ Set.Icc (-1/10 : ℝ) (-1/50) := by
  obtain ⟨h0, h1⟩ := wall_between_thin_and_thick gAB gBA ha hb
  constructor <;> simp only [reversedWall] <;> linarith

/-- Reversing time around the split turns the wall term into the reversed wall term. -/
theorem wall_flips_under_reversal (f lap : ℝ → ℝ) (gAB gBA t : ℝ)
    (h : HasDerivAt f (wall gAB gBA * lap (aroundSplit t)) (aroundSplit t)) :
    HasDerivAt (reverseAroundSplit f) (reversedWall gAB gBA * lap (aroundSplit t)) t := by
  have hneg : HasDerivAt aroundSplit (-1) t := hasDerivAt_neg t
  have hc := h.comp t hneg
  have he : reverseAroundSplit f = f ∘ aroundSplit := rfl
  rw [he]
  exact hc.congr_deriv (by unfold reversedWall; ring)

/-- Forward, the wall only damps. -/
theorem forward_wall_only_damps (gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    forwardFactor (wall gAB gBA) q t ≤ 1 := by
  have hν : 0 ≤ wall gAB gBA := by
    have := (wall_between_thin_and_thick gAB gBA ha hb).1; linarith
  calc
    forwardFactor (wall gAB gBA) q t ≤ Real.exp 0 := Real.exp_le_exp.mpr
      (mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr (mul_nonneg hν hq)) ht)
    _ = 1 := Real.exp_zero

/-- Backward, the wall only amplifies. -/
theorem backward_wall_only_amplifies (gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    1 ≤ backwardFactor (wall gAB gBA) q t := by
  have hν : 0 ≤ wall gAB gBA := by
    have := (wall_between_thin_and_thick gAB gBA ha hb).1; linarith
  calc
    (1 : ℝ) = Real.exp 0 := Real.exp_zero.symm
    _ ≤ backwardFactor (wall gAB gBA) q t :=
      Real.exp_le_exp.mpr (mul_nonneg (mul_nonneg hν hq) ht)

/-- Backward, the thick wall amplifies most and the thin wall least. -/
theorem thick_wall_amplifies_most (gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    backwardFactor thinWall q t ≤ backwardFactor (wall gAB gBA) q t ∧
    backwardFactor (wall gAB gBA) q t ≤ backwardFactor thickWall q t := by
  obtain ⟨h0, h1⟩ := wall_between_thin_and_thick gAB gBA ha hb
  obtain ⟨hthin, hthick⟩ := thin_and_thick_wall
  have hqt : 0 ≤ q * t := mul_nonneg hq ht
  constructor
  · unfold backwardFactor
    apply Real.exp_le_exp.mpr
    rw [mul_assoc, mul_assoc, hthin]
    exact mul_le_mul_of_nonneg_right h0 hqt
  · unfold backwardFactor
    apply Real.exp_le_exp.mpr
    rw [mul_assoc, mul_assoc, hthick]
    exact mul_le_mul_of_nonneg_right h1 hqt

/-- Forward, the thick wall damps most and the thin wall least. -/
theorem thick_wall_damps_most (gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    forwardFactor thickWall q t ≤ forwardFactor (wall gAB gBA) q t ∧
    forwardFactor (wall gAB gBA) q t ≤ forwardFactor thinWall q t := by
  obtain ⟨h0, h1⟩ := wall_between_thin_and_thick gAB gBA ha hb
  obtain ⟨hthin, hthick⟩ := thin_and_thick_wall
  have hqt : 0 ≤ q * t := mul_nonneg hq ht
  constructor
  · unfold forwardFactor
    apply Real.exp_le_exp.mpr
    rw [neg_mul, neg_mul, mul_assoc, mul_assoc, hthick]
    exact neg_le_neg (mul_le_mul_of_nonneg_right h1 hqt)
  · unfold forwardFactor
    apply Real.exp_le_exp.mpr
    rw [neg_mul, neg_mul, mul_assoc, mul_assoc, hthin]
    exact neg_le_neg (mul_le_mul_of_nonneg_right h0 hqt)

/-- At the wall, the forward and backward factors multiply to exactly 1. -/
theorem wall_factors_multiply_to_one (gAB gBA q t : ℝ) :
    forwardFactor (wall gAB gBA) q t * backwardFactor (wall gAB gBA) q t = 1 := by
  unfold forwardFactor backwardFactor
  rw [← Real.exp_add]
  have h : -(wall gAB gBA * q) * t + (wall gAB gBA * q) * t = 0 := by ring
  rw [h, Real.exp_zero]

/-- A backward step through the wall is the same as a forward step through the reversed wall. -/
theorem backward_step_is_reversed_wall (h gAB gBA q a : ℝ) :
    eulerIncrement (-h) (viscousRate (wall gAB gBA) q a) =
      eulerIncrement h (viscousRate (reversedWall gAB gBA) q a) := by
  unfold eulerIncrement viscousRate reversedWall
  ring

/-! ## Counting from the split in both directions -/

/-- Counted forward from the split, what the wall takes is never negative. -/
theorem wall_takes_forward_from_split (a gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    0 ≤ takenForward a (wall gAB gBA) q t := by
  have h1 := forward_wall_only_damps gAB gBA q t ha hb hq ht
  have h0 : 0 < forwardFactor (wall gAB gBA) q t := Real.exp_pos _
  have hsq : forwardFactor (wall gAB gBA) q t ^ 2 ≤ 1 := by nlinarith
  unfold takenForward kineticAtSplit kineticForward
  rw [mul_pow]
  nlinarith [sq_nonneg a]

/-- Counted backward from the split, what the reversed wall gives is never negative. -/
theorem wall_gives_backward_from_split (a gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    0 ≤ givenBackward a (wall gAB gBA) q t := by
  have h1 := backward_wall_only_amplifies gAB gBA q t ha hb hq ht
  have hsq : 1 ≤ backwardFactor (wall gAB gBA) q t ^ 2 := by nlinarith
  unfold givenBackward kineticAtSplit kineticBackward
  rw [mul_pow]
  nlinarith [sq_nonneg a]

/-- For a ripple that is there (a ≠ 0, q > 0) and any time away from the split (t > 0), both
    amounts counted from the split are strictly positive, so together they are more than
    either one alone: the two directions add and never cancel. -/
theorem both_directions_add (a gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1)
    (ha0 : a ≠ 0) (hq : 0 < q) (ht : 0 < t) :
    0 < takenForward a (wall gAB gBA) q t ∧ 0 < givenBackward a (wall gAB gBA) q t ∧
    takenForward a (wall gAB gBA) q t <
      takenForward a (wall gAB gBA) q t + givenBackward a (wall gAB gBA) q t ∧
    givenBackward a (wall gAB gBA) q t <
      takenForward a (wall gAB gBA) q t + givenBackward a (wall gAB gBA) q t := by
  have hν : 0 < wall gAB gBA := by
    have := (wall_between_thin_and_thick gAB gBA ha hb).1; linarith
  have hk : 0 < wall gAB gBA * q * t := mul_pos (mul_pos hν hq) ht
  have hF : forwardFactor (wall gAB gBA) q t < 1 := by
    unfold forwardFactor
    calc Real.exp (-(wall gAB gBA * q) * t) < Real.exp 0 :=
          Real.exp_lt_exp.mpr (by nlinarith)
      _ = 1 := Real.exp_zero
  have hF0 : 0 < forwardFactor (wall gAB gBA) q t := Real.exp_pos _
  have hB : 1 < backwardFactor (wall gAB gBA) q t := by
    unfold backwardFactor
    calc (1 : ℝ) = Real.exp 0 := Real.exp_zero.symm
      _ < Real.exp ((wall gAB gBA * q) * t) := Real.exp_lt_exp.mpr hk
  have ha2 : 0 < a ^ 2 := by positivity
  have hT : 0 < takenForward a (wall gAB gBA) q t := by
    unfold takenForward kineticAtSplit kineticForward
    rw [mul_pow]
    have : forwardFactor (wall gAB gBA) q t ^ 2 < 1 := by nlinarith
    nlinarith
  have hG : 0 < givenBackward a (wall gAB gBA) q t := by
    unfold givenBackward kineticAtSplit kineticBackward
    rw [mul_pow]
    have : 1 < backwardFactor (wall gAB gBA) q t ^ 2 := by nlinarith
    nlinarith
  exact ⟨hT, hG, by linarith, by linarith⟩

#print axioms reverseTime_twice
#print axioms timeReverse_derivative
#print axioms viscosity_reversal
#print axioms whole_rhs_reversal
#print axioms forwardFactor_derivative
#print axioms backwardFactor_derivative
#print axioms forward_damping
#print axioms backward_amplification
#print axioms forward_strict_damping
#print axioms backward_strict_amplification
#print axioms higher_frequency_amplification
#print axioms factor_cancellation
#print axioms negative_step_reverses_rate
#print axioms double_sign_flip_restores_forward
#print axioms split_at_tick_two
#print axioms reverse_twice
#print axioms reversal_keeps_one
#print axioms fifth_and_four_fifths
#print axioms reflect_flips_margin
#print axioms forward_gap_becomes_backward_overlap
#print axioms touch_stays_touch
#print axioms tick23_gap_reverses_to_overlap
#print axioms freeze_at_tick23_both_ways
#print axioms share_change_undone
#print axioms wall_is_single_system_viscosity
#print axioms thin_and_thick_wall
#print axioms wall_between_thin_and_thick
#print axioms reversed_wall_range
#print axioms wall_flips_under_reversal
#print axioms forward_wall_only_damps
#print axioms backward_wall_only_amplifies
#print axioms thick_wall_amplifies_most
#print axioms thick_wall_damps_most
#print axioms wall_factors_multiply_to_one
#print axioms backward_step_is_reversed_wall
#print axioms wall_takes_forward_from_split
#print axioms wall_gives_backward_from_split
#print axioms both_directions_add

end ViscousTimeReversal

import Mathlib
import HugWallPushDefinitions

noncomputable section

open scoped BigOperators

namespace HugWallPush

/-! ## 1. The wall cannot move the whole grid -/

section Wall

variable {G : Type*} [AddCommGroup G] [Fintype G]

theorem shifted_flux_sum (ν u : G → ℝ) (e : G) :
    ∑ i, flux ν u e (i - e) = ∑ i, flux ν u e i := by
  first
  | exact Equiv.sum_comp (Equiv.subRight e) (flux ν u e)
  | exact Fintype.sum_equiv (Equiv.subRight e) _ _ (fun _ => rfl)

/-- The wall never changes the total of the grid. -/
theorem wall_total_zero (ν u : G → ℝ) (e : G) : ∑ i, wallChange ν u e i = 0 := by
  simp only [wallChange]
  rw [Finset.sum_sub_distrib, shifted_flux_sum, sub_self]

/-- What the wall does to the motion is exactly minus the heat it makes. -/
theorem wall_energy (ν u : G → ℝ) (e : G) :
    ∑ i, u i * wallChange ν u e i = -wallHeat ν u e := by
  have h2 : ∑ i, u i * flux ν u e (i - e) = ∑ i, u (i + e) * flux ν u e i := by
    apply Fintype.sum_equiv (Equiv.subRight e)
    intro x
    first
    | simp only [Equiv.subRight_apply, sub_add_cancel]
    | simp
  have h1 : ∑ i, u i * wallChange ν u e i
      = ∑ i, u i * flux ν u e i - ∑ i, u i * flux ν u e (i - e) := by
    rw [← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl ?_
    intro i _
    simp only [wallChange]
    ring
  rw [h1, h2, ← Finset.sum_sub_distrib]
  unfold wallHeat
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl ?_
  intro i _
  simp only [flux]
  ring

/-- A wall of thickness zero or more makes heat zero or more. -/
theorem wallHeat_nonneg (ν u : G → ℝ) (e : G) (hν : ∀ i, 0 ≤ ν i) :
    0 ≤ wallHeat ν u e :=
  Finset.sum_nonneg (fun i _ => mul_nonneg (hν i) (sq_nonneg _))

/-- A wall of thickness zero or more only takes motion away. -/
theorem wall_only_takes (ν u : G → ℝ) (e : G) (hν : ∀ i, 0 ≤ ν i) :
    ∑ i, u i * wallChange ν u e i ≤ 0 := by
  rw [wall_energy]
  exact neg_nonpos.mpr (wallHeat_nonneg ν u e hν)

/-- With walls in every direction, the total of the grid still never changes. -/
theorem grid_total_zero {ι : Type*} (D : Finset ι) (step : ι → G) (ν : ι → G → ℝ)
    (u : G → ℝ) : ∑ i, gridChange D step ν u i = 0 := by
  simp only [gridChange]
  rw [Finset.sum_comm]
  exact Finset.sum_eq_zero (fun d _ => wall_total_zero (ν d) u (step d))

/-- With walls in every direction, what they do to the motion is exactly minus the
heat they make together. -/
theorem grid_energy {ι : Type*} (D : Finset ι) (step : ι → G) (ν : ι → G → ℝ)
    (u : G → ℝ) :
    ∑ i, u i * gridChange D step ν u i = -∑ d ∈ D, wallHeat (ν d) u (step d) := by
  simp only [gridChange, Finset.mul_sum]
  rw [Finset.sum_comm, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl (fun d _ => wall_energy (ν d) u (step d))

/-- In time: if every cell moves only by the wall, the total of the grid has rate zero. -/
theorem wall_keeps_total (ν : G → ℝ) (e : G) (u : ℝ → G → ℝ) (t : ℝ)
    (hu : ∀ i, HasDerivAt (fun s => u s i) (wallChange ν (u t) e i) t) :
    HasDerivAt (fun s => ∑ i, u s i) 0 t := by
  have h : HasDerivAt (fun s => ∑ i, u s i) (∑ i, wallChange ν (u t) e i) t :=
    HasDerivAt.fun_sum (fun i _ => hu i)
  rwa [wall_total_zero] at h

/-- In time: if every cell moves only by the wall and `H` gathers the heat the wall
makes, then motion plus heat has rate zero. The count closes. -/
theorem count_closes (ν : G → ℝ) (e : G) (u : ℝ → G → ℝ) (H : ℝ → ℝ) (t : ℝ)
    (hu : ∀ i, HasDerivAt (fun s => u s i) (wallChange ν (u t) e i) t)
    (hH : HasDerivAt H (wallHeat ν (u t) e) t) :
    HasDerivAt (fun s => (∑ i, u s i ^ 2) / 2 + H s) 0 t := by
  have hsq : ∀ i, HasDerivAt (fun s => u s i ^ 2)
      (2 * (u t i * wallChange ν (u t) e i)) t := by
    intro i
    have h := (hu i).fun_mul (hu i)
    have hf : (fun s => u s i ^ 2) = (fun s => u s i * u s i) := by
      funext s
      ring
    rw [hf]
    exact h.congr_deriv (by ring)
  have hsum : HasDerivAt (fun s => ∑ i, u s i ^ 2)
      (∑ i, 2 * (u t i * wallChange ν (u t) e i)) t :=
    HasDerivAt.fun_sum (fun i _ => hsq i)
  have htot := (hsum.div_const 2).fun_add hH
  convert htot using 1 <;> first | rfl | (rw [← Finset.mul_sum, wall_energy]; ring)

end Wall

/-! ## 2. The push moves the whole grid one way -/

section Push

variable {G : Type*} [AddCommGroup G] [Fintype G]

/-- With the wall and a push `-σ a i` in one fixed direction, the total changes by
exactly the push's total. The wall contributes nothing. -/
theorem push_changes_total (ν a : G → ℝ) (σ : ℝ) (e : G) (u : G → ℝ) :
    ∑ i, (wallChange ν u e i - σ * a i) = -(σ * ∑ i, a i) := by
  rw [Finset.sum_sub_distrib, wall_total_zero, Finset.mul_sum]
  ring

/-- If the activation is never negative and any cell is over the threshold, the total
moves one way, whatever the wall's thickness. -/
theorem push_moves_one_way (ν a : G → ℝ) (σ : ℝ) (e : G) (u : G → ℝ)
    (hσ : 0 < σ) (ha : ∀ i, 0 ≤ a i) (hon : ∃ j, 0 < a j) :
    ∑ i, (wallChange ν u e i - σ * a i) < 0 := by
  rw [push_changes_total]
  obtain ⟨j, hj⟩ := hon
  have hs : 0 < ∑ i, a i :=
    Finset.sum_pos' (fun i _ => ha i) ⟨j, Finset.mem_univ j, hj⟩
  have hp := mul_pos hσ hs
  linarith

/-- Only a push whose total is zero leaves the total of the grid alone. -/
theorem balanced_push_keeps_total (ν a : G → ℝ) (σ : ℝ) (e : G) (u : G → ℝ)
    (h0 : ∑ i, a i = 0) :
    ∑ i, (wallChange ν u e i - σ * a i) = 0 := by
  rw [push_changes_total, h0, mul_zero, neg_zero]

/-- In time: with the wall and the push, the total of the grid has rate
`-(σ * ∑ a)`, whatever the wall's thickness. -/
theorem push_moves_box (ν a : G → ℝ) (σ : ℝ) (e : G) (u : ℝ → G → ℝ) (t : ℝ)
    (hu : ∀ i, HasDerivAt (fun s => u s i) (wallChange ν (u t) e i - σ * a i) t) :
    HasDerivAt (fun s => ∑ i, u s i) (-(σ * ∑ i, a i)) t := by
  have h : HasDerivAt (fun s => ∑ i, u s i)
      (∑ i, (wallChange ν (u t) e i - σ * a i)) t :=
    HasDerivAt.fun_sum (fun i _ => hu i)
  rwa [push_changes_total] at h

end Push

/-! ## 3. Two sides meeting at balance through a wall -/

section TwoSides

theorem lin_deriv (c t : ℝ) : HasDerivAt (fun s : ℝ => c * s) c t := by
  first
  | simpa using (hasDerivAt_id t).const_mul c
  | simpa using (hasDerivAt_id' (x := t)).const_mul c

/-- Side A moves toward side B at rate `k` times the difference. -/
theorem sideA_deriv (m d k t : ℝ) :
    HasDerivAt (sideA m d k) (k * (sideB m d k t - sideA m d k t)) t := by
  have h := (((lin_deriv (-(2 * k)) t).exp).const_mul (d / 2)).const_add m
  convert h using 1 <;> first | rfl | (simp only [sideA, sideB]; ring)

/-- Side B moves toward side A at rate `k` times the difference. -/
theorem sideB_deriv (m d k t : ℝ) :
    HasDerivAt (sideB m d k) (k * (sideA m d k t - sideB m d k t)) t := by
  have h := (((lin_deriv (-(2 * k)) t).exp).const_mul (d / 2)).const_sub m
  convert h using 1 <;> first | rfl | (simp only [sideA, sideB]; ring)

/-- The average of the two sides never moves. -/
theorem average_fixed (m d k t : ℝ) : (sideA m d k t + sideB m d k t) / 2 = m := by
  simp only [sideA, sideB]
  ring

/-- The difference fades as `exp (-(2k) t)`. -/
theorem difference_fades (m d k t : ℝ) :
    sideA m d k t - sideB m d k t = d * Real.exp (-(2 * k) * t) := by
  simp only [sideA, sideB]
  ring

/-- A thicker wall balances the two sides faster. -/
theorem thicker_balances_faster (m d k₁ k₂ t : ℝ) (hk : k₁ ≤ k₂) (ht : 0 ≤ t) :
    |sideA m d k₂ t - sideB m d k₂ t| ≤ |sideA m d k₁ t - sideB m d k₁ t| := by
  rw [difference_fades, difference_fades, abs_mul, abs_mul,
    abs_of_pos (Real.exp_pos (-(2 * k₂) * t)), abs_of_pos (Real.exp_pos (-(2 * k₁) * t))]
  refine mul_le_mul_of_nonneg_left ?_ (abs_nonneg d)
  apply Real.exp_le_exp.mpr
  nlinarith [mul_nonneg (sub_nonneg.mpr hk) ht]

theorem exp_double (k t : ℝ) :
    Real.exp (-(4 * k) * t) = Real.exp (-(2 * k) * t) ^ 2 := by
  rw [sq, ← Real.exp_add]
  congr 1
  ring

/-- Motion plus heat stays fixed for all time: the count closes. -/
theorem two_sides_count_closes (m d k t : ℝ) :
    (sideA m d k t ^ 2 + sideB m d k t ^ 2) / 2 + twoSideHeat d k t
      = m ^ 2 + d ^ 2 / 4 := by
  simp only [sideA, sideB, twoSideHeat]
  rw [exp_double]
  ring

/-- The wall makes heat at rate `k` times the square of the difference. -/
theorem twoSideHeat_deriv (m d k t : ℝ) :
    HasDerivAt (twoSideHeat d k) (k * (sideA m d k t - sideB m d k t) ^ 2) t := by
  have h := (((lin_deriv (-(4 * k)) t).exp).const_sub 1).const_mul (d ^ 2 / 4)
  convert h using 1 <;> first | rfl | (simp only [sideA, sideB]; rw [exp_double]; ring)

/-- With a wall of thickness zero or more, the heat made is zero or more. -/
theorem twoSideHeat_nonneg (d k t : ℝ) (hk : 0 ≤ k) (ht : 0 ≤ t) :
    0 ≤ twoSideHeat d k t := by
  have h0 : -(4 * k) * t ≤ 0 := by nlinarith [mul_nonneg hk ht]
  have h1 : Real.exp (-(4 * k) * t) ≤ 1 := by
    rw [← Real.exp_zero]
    exact Real.exp_le_exp.mpr h0
  simp only [twoSideHeat]
  exact mul_nonneg (by positivity) (by linarith)

end TwoSides

/-! ## 4. The floor of the tanh dip -/

section Dip

theorem half_one_add_tanh_le (y : ℝ) : (1 + Real.tanh y) / 2 ≤ Real.exp (2 * y) := by
  have hc : 0 < Real.cosh y := Real.cosh_pos y
  have h1 : 1 + Real.tanh y = (Real.cosh y + Real.sinh y) / Real.cosh y := by
    rw [add_div, div_self hc.ne', Real.tanh_eq_sinh_div_cosh]
  rw [h1, Real.cosh_add_sinh, div_div, div_le_iff₀ (mul_pos hc two_pos), Real.cosh_eq]
  have e1 : Real.exp (2 * y) * ((Real.exp y + Real.exp (-y)) / 2 * 2)
      = Real.exp (3 * y) + Real.exp y := by
    rw [show (Real.exp y + Real.exp (-y)) / 2 * 2 = Real.exp y + Real.exp (-y) by ring,
      mul_add, ← Real.exp_add, ← Real.exp_add,
      show 2 * y + y = 3 * y by ring, show 2 * y + -y = y by ring]
  rw [e1]
  linarith [Real.exp_pos (3 * y)]

/-- The tanh response, in units of `ε`, never goes below `-1 / (2e)`. -/
theorem dip_floor_normalized (y : ℝ) :
    -(1 / (2 * Real.exp 1)) ≤ y * (1 + Real.tanh y) / 2 := by
  have he1 : 0 < Real.exp 1 := Real.exp_pos 1
  rcases le_or_gt 0 y with hy | hy
  · have ht : 0 ≤ 1 + Real.tanh y := by linarith [Real.neg_one_lt_tanh y]
    have h1 : 0 ≤ y * (1 + Real.tanh y) / 2 := div_nonneg (mul_nonneg hy ht) (by norm_num)
    have h2 : 0 ≤ 1 / (2 * Real.exp 1) := by positivity
    linarith
  · have hle := half_one_add_tanh_le y
    have ha : y * Real.exp (2 * y) ≤ y * (1 + Real.tanh y) / 2 := by
      rw [mul_div_assoc]
      exact mul_le_mul_of_nonpos_left hle hy.le
    have hkey := Real.add_one_le_exp (-1 - 2 * y)
    have hmul : Real.exp (-1 - 2 * y) * Real.exp (2 * y) = Real.exp (-1) := by
      rw [← Real.exp_add]
      congr 1
      ring
    have hpos : 0 < Real.exp (2 * y) := Real.exp_pos _
    have hb : -(2 * y) * Real.exp (2 * y) ≤ Real.exp (-1) := by
      rw [← hmul]
      exact mul_le_mul_of_nonneg_right (by linarith) hpos.le
    have hinv : Real.exp (-1) = 1 / Real.exp 1 := by
      rw [Real.exp_neg, one_div]
    have hc : 1 / (2 * Real.exp 1) = Real.exp (-1) / 2 := by
      rw [hinv]
      first | ring | field_simp
    rw [hc]
    first | linarith | nlinarith [ha, hb]

/-- The tanh response `q (1 + tanh (q/ε)) / 2` never goes below `-ε / (2e)`. -/
theorem dip_floor (ε q : ℝ) (hε : 0 < ε) :
    -(ε / (2 * Real.exp 1)) ≤ q * (1 + Real.tanh (q / ε)) / 2 := by
  have h := mul_le_mul_of_nonneg_left (dip_floor_normalized (q / ε)) hε.le
  have hq : ε * (q / ε) = q := mul_div_cancel₀ q hε.ne'
  have e1 : ε * (q / ε * (1 + Real.tanh (q / ε)) / 2)
      = q * (1 + Real.tanh (q / ε)) / 2 := by
    calc ε * (q / ε * (1 + Real.tanh (q / ε)) / 2)
        = ε * (q / ε) * (1 + Real.tanh (q / ε)) / 2 := by ring
      _ = q * (1 + Real.tanh (q / ε)) / 2 := by rw [hq]
  have e2 : ε * -(1 / (2 * Real.exp 1)) = -(ε / (2 * Real.exp 1)) := by ring
  rw [e1, e2] at h
  exact h

/-- If the base viscosity covers the dip, the total viscosity is never negative:
nothing runs backward. -/
theorem total_viscosity_never_negative (μ σ ε q : ℝ) (hσ : 0 ≤ σ) (hε : 0 < ε)
    (hμ : σ * (ε / (2 * Real.exp 1)) ≤ μ) :
    0 ≤ μ + σ * (q * (1 + Real.tanh (q / ε)) / 2) := by
  have h := mul_le_mul_of_nonneg_left (dip_floor ε q hε) hσ
  have e : σ * -(ε / (2 * Real.exp 1)) = -(σ * (ε / (2 * Real.exp 1))) := by ring
  rw [e] at h
  linarith

end Dip

/-! ## 5. The record with a delayed baseline, and with a frozen one

The record steps as `A (n + 1) = A n + γ h (breath now − baseline)`, as in
`A' = γ (U − U_baseline)` taken in steps of size `h`. The breath is indexed so that
`U 0, …, U (m − 1)` are the `m` steps before the start (the history the delay needs),
and the breath at step `n` is `U (n + m)`. With the delayed baseline, the baseline at
step `n` is the breath from `m` steps back, `U n`. -/

section Breath

/-- The differences `f (n + m) − f n` over the first `N` steps add up to the last `m`
values minus the first `m` values. -/
theorem breath_telescopes (f : ℕ → ℝ) (m N : ℕ) :
    ∑ n ∈ Finset.range N, (f (n + m) - f n)
      = ∑ n ∈ Finset.range m, f (N + n) - ∑ n ∈ Finset.range m, f n := by
  induction N with
  | zero => simp
  | succ N ih =>
    have e1 : ∑ x ∈ Finset.range (m + 1), f (N + x)
        = ∑ x ∈ Finset.range m, f (N + x) + f (N + m) := Finset.sum_range_succ _ _
    have e2 : ∑ x ∈ Finset.range (m + 1), f (N + x)
        = ∑ x ∈ Finset.range m, f (N + (x + 1)) + f N := Finset.sum_range_succ' _ _
    have e3 : ∑ x ∈ Finset.range m, f (N + (x + 1))
        = ∑ x ∈ Finset.range m, f (N + 1 + x) := by
      refine Finset.sum_congr rfl ?_
      intro x _
      congr 1
      omega
    rw [Finset.sum_range_succ, ih]
    linarith [e1, e2, e3]

/-- With the delayed baseline, the record is always its start plus `γ h` times
(the last breath added up − the first breath added up). -/
theorem delayed_baseline_record (A U : ℕ → ℝ) (γ h : ℝ) (m : ℕ)
    (hstep : ∀ n, A (n + 1) = A n + γ * h * (U (n + m) - U n)) (N : ℕ) :
    A N = A 0 + γ * h *
      (∑ n ∈ Finset.range m, U (N + n) - ∑ n ∈ Finset.range m, U n) := by
  have hsum : A N = A 0 + γ * h * ∑ n ∈ Finset.range N, (U (n + m) - U n) := by
    induction N with
    | zero => simp
    | succ N ih =>
      rw [hstep, ih, Finset.sum_range_succ]
      ring
  rw [hsum, breath_telescopes]

/-- With the delayed baseline and the breath staying between `lo` and `hi`, the record
never moves more than `γ h m (hi − lo)` from where it started. It cannot pile up. -/
theorem delayed_baseline_bounded (A U : ℕ → ℝ) (γ h lo hi : ℝ) (m : ℕ)
    (hγh : 0 ≤ γ * h) (hU : ∀ n, lo ≤ U n ∧ U n ≤ hi)
    (hstep : ∀ n, A (n + 1) = A n + γ * h * (U (n + m) - U n)) (N : ℕ) :
    |A N - A 0| ≤ γ * h * (m * (hi - lo)) := by
  have hd : A N - A 0 = γ * h *
      (∑ n ∈ Finset.range m, U (N + n) - ∑ n ∈ Finset.range m, U n) := by
    rw [delayed_baseline_record A U γ h m hstep N]
    ring
  rw [hd, abs_mul, abs_of_nonneg hγh]
  refine mul_le_mul_of_nonneg_left ?_ hγh
  have h1 : ∑ n ∈ Finset.range m, U (N + n) ≤ ∑ n ∈ Finset.range m, hi :=
    Finset.sum_le_sum (fun n _ => (hU (N + n)).2)
  have h2 : ∑ n ∈ Finset.range m, lo ≤ ∑ n ∈ Finset.range m, U (N + n) :=
    Finset.sum_le_sum (fun n _ => (hU (N + n)).1)
  have h3 : ∑ n ∈ Finset.range m, U n ≤ ∑ n ∈ Finset.range m, hi :=
    Finset.sum_le_sum (fun n _ => (hU n).2)
  have h4 : ∑ n ∈ Finset.range m, lo ≤ ∑ n ∈ Finset.range m, U n :=
    Finset.sum_le_sum (fun n _ => (hU n).1)
  rw [Finset.sum_const, Finset.card_range, nsmul_eq_mul] at h1 h2 h3 h4
  rw [abs_le]
  constructor <;> linarith

/-- With the baseline frozen and the breath always at least `c` above it, the record
grows by at least `γ h c` every step: it only breathes in. -/
theorem frozen_baseline_fills (A U : ℕ → ℝ) (γ h b c : ℝ) (hγh : 0 ≤ γ * h)
    (hU : ∀ n, b + c ≤ U n)
    (hstep : ∀ n, A (n + 1) = A n + γ * h * (U n - b)) (N : ℕ) :
    A 0 + γ * h * c * N ≤ A N := by
  induction N with
  | zero => simp
  | succ N ih =>
    rw [hstep]
    have hc : γ * h * c ≤ γ * h * (U N - b) :=
      mul_le_mul_of_nonneg_left (by linarith [hU N]) hγh
    push_cast
    first | linarith | nlinarith [ih, hc]

end Breath

/-! ## 6. The clock in the two sides

The mentor takes 25 steps and the student 32 steps per prime tick (a prime tick is
1/10 of model time), both starting at 0. The freeze sits at tick 23, time 8/10.
At the freeze the two sides close their gap with the shares 0.2 (mentor) and
0.8 (student), used here as each side's weight in the balance. -/

section Clock

/-- At the freeze (tick 23, time 8/10) the mentor has taken 200 steps and the
student 256. -/
theorem freeze_step_counts :
    (200 : ℚ) * mentorStep = 8 / 10 ∧ (256 : ℚ) * studentStep = 8 / 10 := by
  constructor <;> norm_num [mentorStep, studentStep]

/-- The two clocks land on the same instant exactly at whole prime ticks: mentor step `k`
and student step `j` are the same instant only when `k = 25 n` and `j = 32 n`. -/
theorem clocks_meet_at_ticks (k j : ℕ) :
    (k : ℚ) * mentorStep = (j : ℚ) * studentStep ↔ ∃ n : ℕ, k = 25 * n ∧ j = 32 * n := by
  constructor
  · intro h
    have h' : (32 * k : ℚ) = 25 * j := by
      simp only [mentorStep, studentStep] at h
      linarith
    have hn : 32 * k = 25 * j := by exact_mod_cast h'
    have h25 : 25 ∣ k := by
      have hd : 25 ∣ 32 * k := ⟨j, hn⟩
      first
      | exact (Nat.Coprime.dvd_mul_left (by norm_num : Nat.Coprime 25 32)).mp hd
      | omega
    obtain ⟨n, rfl⟩ := h25
    exact ⟨n, rfl, by omega⟩
  · rintro ⟨n, rfl, rfl⟩
    simp only [mentorStep, studentStep]
    push_cast
    ring

/-- The shares make the whole: 0.2 + 0.8 = 1. -/
theorem shares_whole : (1 / 5 : ℝ) + 4 / 5 = 1 := by norm_num

/-- The balance point lies between the two sides. -/
theorem balance_between (xM xS : ℝ) (h : xM ≤ xS) :
    xM ≤ balance xM xS ∧ balance xM xS ≤ xS := by
  unfold balance
  constructor <;> linarith

/-- Closing the gap: the mentor moves 0.8 of it and the student 0.2. -/
theorem gap_split (xM xS : ℝ) :
    balance xM xS - xM = 4 / 5 * (xS - xM) ∧ xS - balance xM xS = 1 / 5 * (xS - xM) := by
  unfold balance
  constructor <;> ring

/-- Closing the gap at the freeze keeps the shared total. -/
theorem freeze_keeps_total (xM xS : ℝ) :
    1 / 5 * balance xM xS + 4 / 5 * balance xM xS = 1 / 5 * xM + 4 / 5 * xS := by
  unfold balance
  ring

/-- Closing the gap at the freeze gives off exactly (0.2 × 0.8) / 2 = 2/25 of the squared
gap. The energy has to go somewhere. -/
theorem freeze_gives_off (xM xS : ℝ) :
    (1 / 5 * xM ^ 2 + 4 / 5 * xS ^ 2) / 2 - (1 / 5 + 4 / 5) * balance xM xS ^ 2 / 2
      = 2 / 25 * (xS - xM) ^ 2 := by
  unfold balance
  ring

/-- What the freeze gives off is never negative. -/
theorem freeze_gives_off_nonneg (xM xS : ℝ) :
    0 ≤ (1 / 5 * xM ^ 2 + 4 / 5 * xS ^ 2) / 2 - (1 / 5 + 4 / 5) * balance xM xS ^ 2 / 2 := by
  rw [freeze_gives_off]
  positivity

end Clock

/-! ## 7. The clay wall

The force on the fluid is the drag `−K g χ u` (`K = 1/η` the hug's pushback, `g` the
clay's integrity, `χ` the clay band), and the integrity takes the exact step
`g ↦ b/(a+b) + (g − b/(a+b)) exp(−(a+b) dt)`, with `a` the yield rate where fluid
pushes through faster than the yield speed and `b` the recovery rate elsewhere.
(In `integrityStep`, `a` and `b` are these two rates; everywhere else in this section
`a` is the push's activation from section 2.) -/

section ClayWall

variable {G : Type*} [AddCommGroup G] [Fintype G]

/-- The clay never makes negative heat. -/
theorem clayHeat_nonneg (K : ℝ) (g χ u : G → ℝ) (hK : 0 ≤ K) (hg : ∀ i, 0 ≤ g i)
    (hχ : ∀ i, 0 ≤ χ i) : 0 ≤ clayHeat K g χ u :=
  Finset.sum_nonneg (fun i _ =>
    mul_nonneg (mul_nonneg (mul_nonneg hK (hg i)) (hχ i)) (sq_nonneg _))

/-- What the clay does to the motion is exactly minus the heat it makes. -/
theorem clay_energy (K : ℝ) (g χ u : G → ℝ) :
    ∑ i, u i * clayDrag K g χ u i = -clayHeat K g χ u := by
  unfold clayDrag clayHeat
  rw [← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl ?_
  intro i _
  ring

/-- Wall and clay together only take motion away, by exactly the heat they make. -/
theorem wall_clay_energy (ν g χ u : G → ℝ) (K : ℝ) (e : G) :
    ∑ i, u i * (wallChange ν u e i + clayDrag K g χ u i)
      = -(wallHeat ν u e + clayHeat K g χ u) := by
  simp only [mul_add]
  rw [Finset.sum_add_distrib, wall_energy, clay_energy]
  ring

/-- With the wall, the push and the clay, the total of the grid changes at rate
`−σ Σ a − K Σ g χ u`. The wall adds nothing; the clay acts against the motion itself. -/
theorem clay_push_total (ν a g χ u : G → ℝ) (σ K : ℝ) (e : G) :
    ∑ i, (wallChange ν u e i - σ * a i + clayDrag K g χ u i)
      = -(σ * ∑ i, a i) - K * ∑ i, g i * χ i * u i := by
  rw [Finset.sum_add_distrib, push_changes_total]
  have h : ∑ i, clayDrag K g χ u i = -(K * ∑ i, g i * χ i * u i) := by
    rw [Finset.mul_sum, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl ?_
    intro i _
    simp only [clayDrag]
    ring
  rw [h]
  ring

/-- If the whole box moves together at speed `U`, its total changes at rate
`−σ Σ a − K U Σ g χ`. -/
theorem uniform_box_rate (ν a g χ u : G → ℝ) (σ K U : ℝ) (e : G) (hu : ∀ i, u i = U) :
    ∑ i, (wallChange ν u e i - σ * a i + clayDrag K g χ u i)
      = -(σ * ∑ i, a i) - K * U * ∑ i, g i * χ i := by
  rw [clay_push_total]
  have h : ∑ i, g i * χ i * u i = U * ∑ i, g i * χ i := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl ?_
    intro i _
    rw [hu i]
    ring
  rw [h]
  ring

/-- That rate always points the box's speed toward the settling speed
`−σ Σ a / (K Σ g χ)`: it is `−(K Σ g χ)` times the distance from it. -/
theorem uniform_box_toward_settling (s KS U : ℝ) (hKS : KS ≠ 0) :
    -s - KS * U = -KS * (U - (-s / KS)) := by
  have h : KS * (-s / KS) = -s := mul_div_cancel₀ (-s) hKS
  linear_combination (-1 : ℝ) * h

/-- The same, in the box's own terms: when the whole box moves together, its total
changes at rate `−(K Σ g χ)` times its distance from the settling speed
`−σ Σ a / (K Σ g χ)`. The clay brakes the whole box; the wall alone cannot. -/
theorem clay_brakes_box (ν a g χ u : G → ℝ) (σ K U : ℝ) (e : G) (hu : ∀ i, u i = U)
    (hS : K * ∑ i, g i * χ i ≠ 0) :
    ∑ i, (wallChange ν u e i - σ * a i + clayDrag K g χ u i)
      = -(K * ∑ i, g i * χ i)
          * (U - (-(σ * ∑ i, a i) / (K * ∑ i, g i * χ i))) := by
  rw [uniform_box_rate ν a g χ u σ K U e hu]
  have h := uniform_box_toward_settling (σ * ∑ i, a i) (K * ∑ i, g i * χ i) U hS
  linear_combination h

/-- Where the clay has fully given way (`g = 0` everywhere), the brake is gone and the
push moves the total exactly as it does with the wall alone. -/
theorem broken_clay_no_brake (ν a g χ u : G → ℝ) (σ K : ℝ) (e : G) (hg : ∀ i, g i = 0) :
    ∑ i, (wallChange ν u e i - σ * a i + clayDrag K g χ u i) = -(σ * ∑ i, a i) := by
  rw [clay_push_total]
  simp [hg]

/-- The box's speed changes at rate `−c` times its distance from the settling speed. -/
theorem boxSpeed_deriv (Vs V0 c t : ℝ) :
    HasDerivAt (boxSpeed Vs V0 c) (-c * (boxSpeed Vs V0 c t - Vs)) t := by
  have h := (((lin_deriv (-c) t).exp).const_mul (V0 - Vs)).const_add Vs
  convert h using 1 <;> first | rfl | (simp only [boxSpeed]; ring)

/-- With `c ≥ 0`, the box never gets further from the settling speed than it started:
no runaway. -/
theorem boxSpeed_settles (Vs V0 c t : ℝ) (hc : 0 ≤ c) (ht : 0 ≤ t) :
    |boxSpeed Vs V0 c t - Vs| ≤ |V0 - Vs| := by
  have e1 : boxSpeed Vs V0 c t - Vs = (V0 - Vs) * Real.exp (-c * t) := by
    simp only [boxSpeed]
    ring
  have h1 : Real.exp (-c * t) ≤ 1 := by
    rw [← Real.exp_zero]
    exact Real.exp_le_exp.mpr (by nlinarith [mul_nonneg hc ht])
  rw [e1, abs_mul, abs_of_pos (Real.exp_pos (-c * t))]
  exact mul_le_of_le_one_right (abs_nonneg _) h1

/-- The exact step keeps the integrity between 0 and 1. -/
theorem integrity_stays (a b g dt : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hab : 0 < a + b)
    (hdt : 0 ≤ dt) (hg0 : 0 ≤ g) (hg1 : g ≤ 1) :
    0 ≤ integrityStep a b g dt ∧ integrityStep a b g dt ≤ 1 := by
  have hE0 : 0 < Real.exp (-(a + b) * dt) := Real.exp_pos _
  have hE1 : Real.exp (-(a + b) * dt) ≤ 1 := by
    rw [← Real.exp_zero]
    exact Real.exp_le_exp.mpr (by nlinarith [mul_nonneg hab.le hdt])
  have hq0 : 0 ≤ b / (a + b) := div_nonneg hb hab.le
  have hq1 : b / (a + b) ≤ 1 := (div_le_one₀ hab).mpr (by linarith)
  unfold integrityStep
  constructor
  · nlinarith [mul_nonneg (sub_nonneg.mpr hE1) hq0, mul_nonneg hE0.le hg0]
  · nlinarith [mul_nonneg (sub_nonneg.mpr hE1) (sub_nonneg.mpr hq1),
      mul_nonneg hE0.le (sub_nonneg.mpr hg1)]

/-- Where fluid pushes through and nothing recovers (`b = 0`), the clay only gives way:
its integrity shrinks by `exp (−a dt)` each step. -/
theorem integrity_yields (a g dt : ℝ) :
    integrityStep a 0 g dt = g * Real.exp (-a * dt) := by
  simp only [integrityStep, add_zero, zero_div, zero_add, sub_zero]

/-- Where nothing pushes through (`a = 0`), the clay heals toward 1. -/
theorem integrity_recovers (b g dt : ℝ) (hb : b ≠ 0) :
    integrityStep 0 b g dt = 1 + (g - 1) * Real.exp (-b * dt) := by
  simp only [integrityStep, zero_add, div_self hb]

end ClayWall

end HugWallPush

import ViscousTimeReversalWirtingerProofs
import ViscousTimeReversalTorusDefinitions

/-! Proofs of the Poincaré inequality on the discrete 3-torus, built on the cycle inequality
`CycleWirtinger.wirtinger` and its sharpness `CycleWirtinger.wirtinger_sharp`. -/

open Finset
open scoped Real

namespace TorusPoincare

variable {Y : Type*} [Fintype Y]

/-- Cauchy–Schwarz for a mean: `a ((∑ x)/a)² ≤ ∑ x²`. -/
theorem mean_sq_le (a : ℕ) [NeZero a] (x : ZMod a → ℝ) :
    (a : ℝ) * ((∑ j, x j) / a) ^ 2 ≤ ∑ j, x j ^ 2 := by
  have ha : (0 : ℝ) < a := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne a)
  have h := sq_sum_le_card_mul_sum_sq (s := (univ : Finset (ZMod a))) (f := x)
  rw [card_univ, ZMod.card] at h
  have e : (a : ℝ) * ((∑ j, x j) / a) ^ 2 = (∑ j, x j) ^ 2 / a := by
    field_simp
  rw [e, div_le_iff₀ ha]
  linarith

/-- Averaging along one direction does not raise the energy of a step `σ` in the others. -/
theorem step_mean_le (a : ℕ) [NeZero a] (σ : Y → Y) (f : ZMod a → Y → ℝ) :
    (a : ℝ) * ∑ y, ((∑ j, f j (σ y)) / a - (∑ j, f j y) / a) ^ 2 ≤
      ∑ j, ∑ y, (f j (σ y) - f j y) ^ 2 := by
  rw [mul_sum, sum_comm (s := (univ : Finset (ZMod a)))]
  refine sum_le_sum (fun y _ => ?_)
  have h := mean_sq_le a (fun j => f j (σ y) - f j y)
  simp only [sum_sub_distrib, sub_div] at h
  exact h

/-- Adding one cycle direction: from a gap `μ` on `Y` and a gap `gap a` on the cycle, the
product has gap `min (gap a) μ`, for any energy on `Y` that averaging does not raise. -/
theorem add_direction (a : ℕ) [NeZero a] (E : (Y → ℝ) → ℝ) (μ : ℝ)
    (hE : ∀ g : Y → ℝ, ∑ y, g y = 0 → μ * ∑ y, g y ^ 2 ≤ E g)
    (hJ : ∀ f : ZMod a → Y → ℝ, (a : ℝ) * E (fun y => (∑ j, f j y) / a) ≤ ∑ j, E (f j))
    (f : ZMod a → Y → ℝ) (h0 : ∑ j, ∑ y, f j y = 0) :
    min (gap a) μ * ∑ j, ∑ y, f j y ^ 2 ≤
      ∑ y, ∑ j, (f (j + 1) y - f j y) ^ 2 + ∑ j, E (f j) := by
  have ha : (0 : ℝ) < a := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne a)
  set m : Y → ℝ := fun y => (∑ j, f j y) / a with hm
  have hs : ∀ y, ∑ j, f j y = a * m y := by
    intro y; simp only [hm]; field_simp
  have hm0 : ∑ y, m y = 0 := by
    simp only [hm, ← sum_div]; rw [sum_comm, h0, zero_div]
  have hline : ∀ y, gap a * ∑ j, (f j y - m y) ^ 2 ≤ ∑ j, (f (j + 1) y - f j y) ^ 2 := by
    intro y
    have hz : ∑ j, (f j y - m y) = 0 := by
      rw [sum_sub_distrib, sum_const, card_univ, ZMod.card, nsmul_eq_mul, hs]; ring
    have hw := CycleWirtinger.wirtinger (fun j => f j y - m y) hz
    simp only [sub_sub_sub_cancel_right] at hw
    exact hw
  have hsplit : ∑ j, ∑ y, f j y ^ 2 = ∑ y, ∑ j, (f j y - m y) ^ 2 + a * ∑ y, m y ^ 2 := by
    rw [sum_comm, mul_sum, ← sum_add_distrib]
    refine sum_congr rfl (fun y _ => ?_)
    have e : ∀ j, (f j y - m y) ^ 2 = f j y ^ 2 - 2 * m y * f j y + m y ^ 2 := fun j => by ring
    simp only [e, sum_add_distrib, sum_sub_distrib, ← mul_sum, sum_const, card_univ, ZMod.card,
      nsmul_eq_mul]
    rw [hs]; ring
  have hL : gap a * ∑ y, ∑ j, (f j y - m y) ^ 2 ≤ ∑ y, ∑ j, (f (j + 1) y - f j y) ^ 2 := by
    rw [mul_sum]; exact sum_le_sum (fun y _ => hline y)
  have hg0 : 0 ≤ ∑ y, ∑ j, (f j y - m y) ^ 2 := by positivity
  have hm2 : 0 ≤ ∑ y, m y ^ 2 := by positivity
  have h1 := mul_le_mul_of_nonneg_right (min_le_left (gap a) μ) hg0
  have h2 : (a : ℝ) * (min (gap a) μ * ∑ y, m y ^ 2) ≤ a * E m :=
    mul_le_mul_of_nonneg_left ((mul_le_mul_of_nonneg_right (min_le_right (gap a) μ) hm2).trans
      (hE m hm0)) ha.le
  have h3 := hJ f
  rw [hsplit]
  nlinarith [h1, h2, h3, hL]

/-- **Poincaré inequality on the discrete 2-torus.** -/
theorem plane (b c : ℕ) [NeZero b] [NeZero c] (f : ZMod b → ZMod c → ℝ)
    (h0 : ∑ j, ∑ k, f j k = 0) :
    min (gap b) (gap c) * ∑ j, ∑ k, f j k ^ 2 ≤
      ∑ j, ∑ k, ((f (j + 1) k - f j k) ^ 2 + (f j (k + 1) - f j k) ^ 2) := by
  have h := add_direction b (fun g : ZMod c → ℝ => ∑ k, (g (k + 1) - g k) ^ 2) (gap c)
    (fun g hg => CycleWirtinger.wirtinger g hg)
    (fun f => step_mean_le b (fun k => k + 1) f) f h0
  rw [sum_comm (s := (univ : Finset (ZMod c)))] at h
  simpa only [sum_add_distrib] using h

/-- **Poincaré inequality on the discrete 3-torus.** For `f` with sum zero on
`ZMod a × ZMod b × ZMod c`, the smallest of the three cycle gaps times `∑ f²` is at most the
Dirichlet energy. -/
theorem torus (a b c : ℕ) [NeZero a] [NeZero b] [NeZero c] (f : ZMod a → ZMod b → ZMod c → ℝ)
    (h0 : ∑ i, ∑ j, ∑ k, f i j k = 0) :
    min (gap a) (min (gap b) (gap c)) * ∑ i, ∑ j, ∑ k, f i j k ^ 2 ≤ energy f := by
  have h := add_direction (Y := ZMod b × ZMod c) a
    (fun g => ∑ y : ZMod b × ZMod c, ((g (y.1 + 1, y.2) - g y) ^ 2 + (g (y.1, y.2 + 1) - g y) ^ 2))
    (min (gap b) (gap c))
    (fun g hg => by
      have := plane b c (fun j k => g (j, k)) (by rw [← Fintype.sum_prod_type]; exact hg)
      simpa only [Fintype.sum_prod_type] using this)
    (fun f => by
      have h1 := step_mean_le a (fun y : ZMod b × ZMod c => (y.1 + 1, y.2)) f
      have h2 := step_mean_le a (fun y : ZMod b × ZMod c => (y.1, y.2 + 1)) f
      simp only [sum_add_distrib, mul_add]
      linarith)
    (fun i y => f i y.1 y.2) (by simp only [Fintype.sum_prod_type]; exact h0)
  simp only [Fintype.sum_prod_type] at h
  have hD : ∑ j : ZMod b, ∑ k : ZMod c, ∑ i : ZMod a, (f (i + 1) j k - f i j k) ^ 2 =
      ∑ i, ∑ j, ∑ k, (f (i + 1) j k - f i j k) ^ 2 := by
    calc _ = ∑ j : ZMod b, ∑ i : ZMod a, ∑ k : ZMod c, (f (i + 1) j k - f i j k) ^ 2 :=
          sum_congr rfl (fun j _ => sum_comm)
      _ = _ := sum_comm
  rw [hD] at h
  unfold energy
  simp only [sum_add_distrib] at h ⊢
  linarith

/-- The gap decreases with the cycle length, for lengths at least `2`. -/
theorem gap_anti {m n : ℕ} (hm : 2 ≤ m) (hmn : m ≤ n) : gap n ≤ gap m := by
  unfold gap
  have hm0 : (0 : ℝ) < m := by exact_mod_cast (by omega : 0 < m)
  have hn0 : (0 : ℝ) < n := by exact_mod_cast (by omega : 0 < n)
  have hmn' : (m : ℝ) ≤ n := by exact_mod_cast hmn
  have h2 : (2 : ℝ) ≤ m := by exact_mod_cast hm
  have hle : 2 * π / n ≤ 2 * π / m := div_le_div_of_nonneg_left (by positivity) hm0 hmn'
  have hpi : 2 * π / m ≤ π := by
    rw [div_le_iff₀ hm0]; nlinarith [Real.pi_pos]
  have := Real.cos_le_cos_of_nonneg_of_le_pi (by positivity) hpi hle
  linarith

/-- With `2 ≤ b ≤ a` and `2 ≤ c ≤ a`, the smallest gap is the gap of the longest side. -/
theorem gap_min {a b c : ℕ} (hb : 2 ≤ b) (hc : 2 ≤ c) (hba : b ≤ a) (hca : c ≤ a) :
    min (gap a) (min (gap b) (gap c)) = gap a := by
  exact min_eq_left (le_min (gap_anti hb hba) (gap_anti hc hca))

/-- **Sharpness.** For `3 ≤ a`, the cosine `cos (2π i / a)` along the first direction has sum zero
and Dirichlet energy exactly `gap a · ∑ f²`. -/
theorem torus_sharp (a b c : ℕ) [NeZero a] [NeZero b] [NeZero c] (ha : 3 ≤ a) :
    ∑ i : ZMod a, ∑ _j : ZMod b, ∑ _k : ZMod c, Real.cos (2 * π * i.val / a) = 0 ∧
    energy (fun (i : ZMod a) (_ : ZMod b) (_ : ZMod c) => Real.cos (2 * π * i.val / a)) =
      gap a * ∑ i : ZMod a, ∑ _j : ZMod b, ∑ _k : ZMod c, Real.cos (2 * π * i.val / a) ^ 2 := by
  obtain ⟨h1, h2⟩ := CycleWirtinger.wirtinger_sharp (n := a) ha
  simp only [sum_const, card_univ, ZMod.card, nsmul_eq_mul]
  refine ⟨?_, ?_⟩
  · rw [← mul_sum, ← mul_sum, h1]; ring
  · unfold energy
    simp only [sub_self, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, add_zero,
      sum_const, card_univ, ZMod.card, nsmul_eq_mul]
    rw [← mul_sum, ← mul_sum, h2, ← mul_sum, ← mul_sum]
    unfold gap; ring

/-- **The bound is attained.** With `3 ≤ a`, `2 ≤ b ≤ a` and `2 ≤ c ≤ a`, the constant in `torus`
equals `gap a`, and the cosine of `torus_sharp` meets it with equality. -/
theorem torus_attained (a b c : ℕ) [NeZero a] [NeZero b] [NeZero c] (ha : 3 ≤ a) (hb : 2 ≤ b)
    (hc : 2 ≤ c) (hba : b ≤ a) (hca : c ≤ a) :
    energy (fun (i : ZMod a) (_ : ZMod b) (_ : ZMod c) => Real.cos (2 * π * i.val / a)) =
      min (gap a) (min (gap b) (gap c)) *
        ∑ i : ZMod a, ∑ _j : ZMod b, ∑ _k : ZMod c, Real.cos (2 * π * i.val / a) ^ 2 := by
  rw [gap_min hb hc hba hca]
  exact (torus_sharp a b c ha).2

/-- **The mean has no gap.** Without the sum-zero condition no constant `C` bounds `∑ f²` by the
energy: constants have zero energy. -/
theorem mean_has_no_gap (a b c : ℕ) [NeZero a] [NeZero b] [NeZero c] (C : ℝ) :
    ¬ ∀ f : ZMod a → ZMod b → ZMod c → ℝ, ∑ i, ∑ j, ∑ k, f i j k ^ 2 ≤ C * energy f := by
  intro h
  have h1 := h (fun _ _ _ => 1)
  unfold energy at h1
  simp only [sub_self, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, add_zero,
    sum_const_zero, mul_zero, one_pow, sum_const, card_univ, ZMod.card, nsmul_eq_mul,
    mul_one] at h1
  have : (0 : ℝ) < (a : ℝ) * (b * c) := by
    have := NeZero.ne a; have := NeZero.ne b; have := NeZero.ne c
    positivity
  linarith

/-- The scaled gap `N² · gap N` never exceeds `(2π)²`. -/
theorem scaled_gap_le (N : ℕ) : (N : ℝ) ^ 2 * gap N ≤ (2 * π) ^ 2 := by
  rcases Nat.eq_zero_or_pos N with rfl | hN
  · simp; positivity
  have hN0 : (0 : ℝ) < N := by exact_mod_cast hN
  have h := Real.one_sub_sq_div_two_le_cos (x := 2 * π / N)
  unfold gap
  have e : (N : ℝ) ^ 2 * (2 * π / N) ^ 2 = (2 * π) ^ 2 := by field_simp
  nlinarith [sq_nonneg (N : ℝ)]

/-- The scaled gap `N² · gap N` tends to `(2π)²`. -/
theorem scaled_gap_tendsto :
    Filter.Tendsto (fun N : ℕ => (N : ℝ) ^ 2 * gap N) Filter.atTop (nhds ((2 * π) ^ 2)) := by
  have hlow : ∀ᶠ N : ℕ in Filter.atTop,
      (2 * π) ^ 2 - (5 / 48 * (2 * π) ^ 4) / ((N : ℝ) ^ 2) ≤ (N : ℝ) ^ 2 * gap N := by
    filter_upwards [Filter.eventually_ge_atTop 7] with N hN
    have hN0 : (7 : ℝ) ≤ N := by exact_mod_cast hN
    have hNp : (0 : ℝ) < N := by linarith
    set x := 2 * π / N with hx
    have hx0 : 0 ≤ x := by positivity
    have hx1 : |x| ≤ 1 := by
      rw [abs_of_nonneg hx0, hx, div_le_one hNp]; linarith [Real.pi_lt_d2]
    have hb := Real.cos_bound hx1
    have hb' := (abs_le.mp hb).2
    rw [abs_of_nonneg hx0] at hb'
    unfold gap
    have e1 : (N : ℝ) ^ 2 * x ^ 2 = (2 * π) ^ 2 := by rw [hx]; field_simp
    have e2 : (N : ℝ) ^ 2 * x ^ 4 = (2 * π) ^ 4 / (N : ℝ) ^ 2 := by rw [hx]; field_simp
    have e3 : (5 / 48 * (2 * π) ^ 4) / ((N : ℝ) ^ 2) = 5 / 48 * ((2 * π) ^ 4 / (N : ℝ) ^ 2) := by
      ring
    rw [← hx, e3, ← e2, ← e1]
    clear_value x
    have hp := mul_le_mul_of_nonneg_left hb' (sq_nonneg (N : ℝ))
    ring_nf at hp ⊢
    linarith
  have hlim : Filter.Tendsto (fun N : ℕ => (2 * π) ^ 2 - (5 / 48 * (2 * π) ^ 4) / ((N : ℝ) ^ 2))
      Filter.atTop (nhds ((2 * π) ^ 2)) := by
    have h := tendsto_const_div_atTop_nhds_zero_nat (5 / 48 * (2 * π) ^ 4)
    have h2 : Filter.Tendsto (fun N : ℕ => (5 / 48 * (2 * π) ^ 4) / ((N : ℝ) ^ 2))
        Filter.atTop (nhds 0) := by
      refine tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds h ?_ ?_
      · exact Filter.Eventually.of_forall (fun N => by positivity)
      · filter_upwards [Filter.eventually_ge_atTop 1] with N hN
        have h1 : (1 : ℝ) ≤ N := by exact_mod_cast hN
        apply div_le_div_of_nonneg_left (by positivity) (by positivity)
        nlinarith
    simpa using (tendsto_const_nhds (x := (2 * π) ^ 2)).sub h2
  exact tendsto_of_tendsto_of_tendsto_of_le_of_le' hlim tendsto_const_nhds hlow
    (Filter.Eventually.of_forall scaled_gap_le)

end TorusPoincare

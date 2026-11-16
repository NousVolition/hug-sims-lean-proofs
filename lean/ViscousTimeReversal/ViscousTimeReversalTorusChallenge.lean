import ViscousTimeReversalWirtingerChallenge
import ViscousTimeReversalTorusDefinitions

/-! Statements of the Poincaré inequality on the discrete 3-torus, built on the cycle inequality
`CycleWirtinger.wirtinger` and its sharpness `CycleWirtinger.wirtinger_sharp`. -/

open Finset
open scoped Real

namespace TorusPoincare

variable {Y : Type*} [Fintype Y]

/-- Cauchy–Schwarz for a mean: `a ((∑ x)/a)² ≤ ∑ x²`. -/
theorem mean_sq_le (a : ℕ) [NeZero a] (x : ZMod a → ℝ) :
    (a : ℝ) * ((∑ j, x j) / a) ^ 2 ≤ ∑ j, x j ^ 2 := by
  sorry

/-- Averaging along one direction does not raise the energy of a step `σ` in the others. -/
theorem step_mean_le (a : ℕ) [NeZero a] (σ : Y → Y) (f : ZMod a → Y → ℝ) :
    (a : ℝ) * ∑ y, ((∑ j, f j (σ y)) / a - (∑ j, f j y) / a) ^ 2 ≤
      ∑ j, ∑ y, (f j (σ y) - f j y) ^ 2 := by
  sorry

/-- Adding one cycle direction: from a gap `μ` on `Y` and a gap `gap a` on the cycle, the
product has gap `min (gap a) μ`, for any energy on `Y` that averaging does not raise. -/
theorem add_direction (a : ℕ) [NeZero a] (E : (Y → ℝ) → ℝ) (μ : ℝ)
    (hE : ∀ g : Y → ℝ, ∑ y, g y = 0 → μ * ∑ y, g y ^ 2 ≤ E g)
    (hJ : ∀ f : ZMod a → Y → ℝ, (a : ℝ) * E (fun y => (∑ j, f j y) / a) ≤ ∑ j, E (f j))
    (f : ZMod a → Y → ℝ) (h0 : ∑ j, ∑ y, f j y = 0) :
    min (gap a) μ * ∑ j, ∑ y, f j y ^ 2 ≤
      ∑ y, ∑ j, (f (j + 1) y - f j y) ^ 2 + ∑ j, E (f j) := by
  sorry

/-- **Poincaré inequality on the discrete 2-torus.** -/
theorem plane (b c : ℕ) [NeZero b] [NeZero c] (f : ZMod b → ZMod c → ℝ)
    (h0 : ∑ j, ∑ k, f j k = 0) :
    min (gap b) (gap c) * ∑ j, ∑ k, f j k ^ 2 ≤
      ∑ j, ∑ k, ((f (j + 1) k - f j k) ^ 2 + (f j (k + 1) - f j k) ^ 2) := by
  sorry

/-- **Poincaré inequality on the discrete 3-torus.** For `f` with sum zero on
`ZMod a × ZMod b × ZMod c`, the smallest of the three cycle gaps times `∑ f²` is at most the
Dirichlet energy. -/
theorem torus (a b c : ℕ) [NeZero a] [NeZero b] [NeZero c] (f : ZMod a → ZMod b → ZMod c → ℝ)
    (h0 : ∑ i, ∑ j, ∑ k, f i j k = 0) :
    min (gap a) (min (gap b) (gap c)) * ∑ i, ∑ j, ∑ k, f i j k ^ 2 ≤ energy f := by
  sorry

/-- The gap decreases with the cycle length, for lengths at least `2`. -/
theorem gap_anti {m n : ℕ} (hm : 2 ≤ m) (hmn : m ≤ n) : gap n ≤ gap m := by
  sorry

/-- With `2 ≤ b ≤ a` and `2 ≤ c ≤ a`, the smallest gap is the gap of the longest side. -/
theorem gap_min {a b c : ℕ} (hb : 2 ≤ b) (hc : 2 ≤ c) (hba : b ≤ a) (hca : c ≤ a) :
    min (gap a) (min (gap b) (gap c)) = gap a := by
  sorry

/-- **Sharpness.** For `3 ≤ a`, the cosine `cos (2π i / a)` along the first direction has sum zero
and Dirichlet energy exactly `gap a · ∑ f²`. -/
theorem torus_sharp (a b c : ℕ) [NeZero a] [NeZero b] [NeZero c] (ha : 3 ≤ a) :
    ∑ i : ZMod a, ∑ _j : ZMod b, ∑ _k : ZMod c, Real.cos (2 * π * i.val / a) = 0 ∧
    energy (fun (i : ZMod a) (_ : ZMod b) (_ : ZMod c) => Real.cos (2 * π * i.val / a)) =
      gap a * ∑ i : ZMod a, ∑ _j : ZMod b, ∑ _k : ZMod c, Real.cos (2 * π * i.val / a) ^ 2 := by
  sorry

/-- **The bound is attained.** With `3 ≤ a`, `2 ≤ b ≤ a` and `2 ≤ c ≤ a`, the constant in `torus`
equals `gap a`, and the cosine of `torus_sharp` meets it with equality. -/
theorem torus_attained (a b c : ℕ) [NeZero a] [NeZero b] [NeZero c] (ha : 3 ≤ a) (hb : 2 ≤ b)
    (hc : 2 ≤ c) (hba : b ≤ a) (hca : c ≤ a) :
    energy (fun (i : ZMod a) (_ : ZMod b) (_ : ZMod c) => Real.cos (2 * π * i.val / a)) =
      min (gap a) (min (gap b) (gap c)) *
        ∑ i : ZMod a, ∑ _j : ZMod b, ∑ _k : ZMod c, Real.cos (2 * π * i.val / a) ^ 2 := by
  sorry

/-- **The mean has no gap.** Without the sum-zero condition no constant `C` bounds `∑ f²` by the
energy: constants have zero energy. -/
theorem mean_has_no_gap (a b c : ℕ) [NeZero a] [NeZero b] [NeZero c] (C : ℝ) :
    ¬ ∀ f : ZMod a → ZMod b → ZMod c → ℝ, ∑ i, ∑ j, ∑ k, f i j k ^ 2 ≤ C * energy f := by
  sorry

/-- The scaled gap `N² · gap N` never exceeds `(2π)²`. -/
theorem scaled_gap_le (N : ℕ) : (N : ℝ) ^ 2 * gap N ≤ (2 * π) ^ 2 := by
  sorry

/-- The scaled gap `N² · gap N` tends to `(2π)²`. -/
theorem scaled_gap_tendsto :
    Filter.Tendsto (fun N : ℕ => (N : ℝ) ^ 2 * gap N) Filter.atTop (nhds ((2 * π) ^ 2)) := by
  sorry

end TorusPoincare

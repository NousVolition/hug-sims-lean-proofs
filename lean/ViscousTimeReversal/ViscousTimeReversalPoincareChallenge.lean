import ViscousTimeReversalFilterChallenge
import ViscousTimeReversalPoincareDefinitions

/-! Statements of the discrete Poincaré–Wirtinger inequality on a path. Source: `discrete-poincare-lean/Poincare.lean` (sha256 e4a76d125f57885221ac70ed59749b9ea12143bcbca3a71c56e74ee6c05b4fd0). -/

open Finset

namespace DiscretePoincare

/-- The change from `i` to `j` is the sum of the steps between them. -/
theorem telescope (f : ℕ → ℝ) {i j : ℕ} (h : i ≤ j) :
    f j - f i = ∑ k ∈ Ico i j, (f (k + 1) - f k) := by
  sorry

/-- Any squared difference on the path is at most `(n-1)` times the Dirichlet energy. -/
theorem step_bound (f : ℕ → ℝ) (n : ℕ) {i j : ℕ} (hij : i ≤ j) (hj : j < n) :
    (f j - f i) ^ 2 ≤ ((n - 1 : ℕ) : ℝ) * dirichlet f n := by
  sorry

/-- The pair identity: `∑ᵢ ∑ⱼ (f i - f j)² = 2 n ∑ f² - 2 (∑ f)²`. -/
theorem pair_sum (f : ℕ → ℝ) (n : ℕ) :
    ∑ i ∈ range n, ∑ j ∈ range n, (f i - f j) ^ 2
      = 2 * n * ∑ i ∈ range n, f i ^ 2 - 2 * (∑ i ∈ range n, f i) ^ 2 := by
  sorry

/-- **Discrete Poincaré–Wirtinger inequality.** On a path of `n` points, mean-zero data satisfy
`2 ∑ f² ≤ n (n-1) ∑ (f (k+1) - f k)²`. -/
theorem poincare (f : ℕ → ℝ) (n : ℕ) (hmean : ∑ i ∈ range n, f i = 0) :
    2 * ∑ i ∈ range n, f i ^ 2 ≤ n * ((n - 1 : ℕ) : ℝ) * dirichlet f n := by
  sorry

/-- **The mean has no gap.** Without the mean-zero condition no constant works: on any
nonempty path, constants have zero Dirichlet energy and positive norm. -/
theorem mean_has_no_gap (n : ℕ) (hn : 0 < n) (C : ℝ) :
    ¬ ∀ f : ℕ → ℝ, ∑ i ∈ range n, f i ^ 2 ≤ C * dirichlet f n := by
  sorry

end DiscretePoincare

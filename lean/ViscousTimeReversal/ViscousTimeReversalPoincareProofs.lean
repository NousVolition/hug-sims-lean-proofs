import ViscousTimeReversalFilterProofs
import ViscousTimeReversalPoincareDefinitions

/-! Proofs of the discrete Poincaré–Wirtinger inequality on a path. Source: `discrete-poincare-lean/Poincare.lean` (sha256 e4a76d125f57885221ac70ed59749b9ea12143bcbca3a71c56e74ee6c05b4fd0). -/

open Finset

namespace DiscretePoincare

/-- The change from `i` to `j` is the sum of the steps between them. -/
theorem telescope (f : ℕ → ℝ) {i j : ℕ} (h : i ≤ j) :
    f j - f i = ∑ k ∈ Ico i j, (f (k + 1) - f k) := by
  rw [Finset.sum_Ico_eq_sub _ h, Finset.sum_range_sub, Finset.sum_range_sub]
  ring

/-- Any squared difference on the path is at most `(n-1)` times the Dirichlet energy. -/
theorem step_bound (f : ℕ → ℝ) (n : ℕ) {i j : ℕ} (hij : i ≤ j) (hj : j < n) :
    (f j - f i) ^ 2 ≤ ((n - 1 : ℕ) : ℝ) * dirichlet f n := by
  have hsub : Ico i j ⊆ range (n - 1) := by
    intro k hk
    simp only [Finset.mem_Ico, Finset.mem_range] at hk ⊢
    omega
  have h1 : |f j - f i| ≤ ∑ k ∈ range (n - 1), |f (k + 1) - f k| := by
    rw [telescope f hij]
    exact (Finset.abs_sum_le_sum_abs _ _).trans
      (Finset.sum_le_sum_of_subset_of_nonneg hsub (fun k _ _ => abs_nonneg _))
  have h2 := sq_sum_le_card_mul_sum_sq (s := range (n - 1)) (f := fun k => |f (k + 1) - f k|)
  have h3 : (f j - f i) ^ 2 ≤ (∑ k ∈ range (n - 1), |f (k + 1) - f k|) ^ 2 := by
    rw [← sq_abs]
    exact pow_le_pow_left₀ (abs_nonneg _) h1 2
  simp only [sq_abs, Finset.card_range] at h2
  unfold dirichlet
  linarith [h2, h3]

/-- The pair identity: `∑ᵢ ∑ⱼ (f i - f j)² = 2 n ∑ f² - 2 (∑ f)²`. -/
theorem pair_sum (f : ℕ → ℝ) (n : ℕ) :
    ∑ i ∈ range n, ∑ j ∈ range n, (f i - f j) ^ 2
      = 2 * n * ∑ i ∈ range n, f i ^ 2 - 2 * (∑ i ∈ range n, f i) ^ 2 := by
  have inner : ∀ i, ∑ j ∈ range n, (f i - f j) ^ 2
      = n * f i ^ 2 - 2 * f i * ∑ j ∈ range n, f j + ∑ j ∈ range n, f j ^ 2 := by
    intro i
    have e : ∀ j ∈ range n, (f i - f j) ^ 2 = f i ^ 2 - 2 * f i * f j + f j ^ 2 :=
      fun j _ => by ring
    rw [Finset.sum_congr rfl e, Finset.sum_add_distrib, Finset.sum_sub_distrib,
      Finset.sum_const, Finset.card_range, nsmul_eq_mul, ← Finset.mul_sum]
  rw [Finset.sum_congr rfl (fun i _ => inner i)]
  simp only [Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_const, Finset.card_range,
    nsmul_eq_mul, ← Finset.mul_sum, ← Finset.sum_mul]
  ring

/-- **Discrete Poincaré–Wirtinger inequality.** On a path of `n` points, mean-zero data satisfy
`2 ∑ f² ≤ n (n-1) ∑ (f (k+1) - f k)²`. -/
theorem poincare (f : ℕ → ℝ) (n : ℕ) (hmean : ∑ i ∈ range n, f i = 0) :
    2 * ∑ i ∈ range n, f i ^ 2 ≤ n * ((n - 1 : ℕ) : ℝ) * dirichlet f n := by
  rcases Nat.eq_zero_or_pos n with hn | hn
  · subst hn
    simp [dirichlet]
  have hpair := pair_sum f n
  rw [hmean] at hpair
  have hbound : ∑ i ∈ range n, ∑ j ∈ range n, (f i - f j) ^ 2
      ≤ ∑ i ∈ range n, ∑ j ∈ range n, ((n - 1 : ℕ) : ℝ) * dirichlet f n := by
    apply Finset.sum_le_sum
    intro i hi
    apply Finset.sum_le_sum
    intro j hj
    rw [Finset.mem_range] at hi hj
    rcases le_total j i with h | h
    · exact step_bound f n h hi
    · calc (f i - f j) ^ 2 = (f j - f i) ^ 2 := by ring
        _ ≤ ((n - 1 : ℕ) : ℝ) * dirichlet f n := step_bound f n h hj
  simp only [Finset.sum_const, Finset.card_range, nsmul_eq_mul] at hbound
  have hnpos : (0 : ℝ) < n := by exact_mod_cast hn
  nlinarith [hpair, hbound, hnpos]

/-- **The mean has no gap.** Without the mean-zero condition no constant works: on any
nonempty path, constants have zero Dirichlet energy and positive norm. -/
theorem mean_has_no_gap (n : ℕ) (hn : 0 < n) (C : ℝ) :
    ¬ ∀ f : ℕ → ℝ, ∑ i ∈ range n, f i ^ 2 ≤ C * dirichlet f n := by
  intro h
  have h1 : ∑ i ∈ range n, (1 : ℝ) ^ 2 ≤ C * dirichlet (fun _ => (1 : ℝ)) n := h (fun _ => 1)
  have hD : dirichlet (fun _ => (1 : ℝ)) n = 0 := by
    unfold dirichlet
    simp
  have hQ : ∑ i ∈ range n, (1 : ℝ) ^ 2 = n := by simp
  rw [hD, mul_zero, hQ] at h1
  have hpos : (0 : ℝ) < n := by exact_mod_cast hn
  linarith

end DiscretePoincare

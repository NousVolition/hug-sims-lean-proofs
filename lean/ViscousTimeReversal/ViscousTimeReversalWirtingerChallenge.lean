import ViscousTimeReversalPoincareChallenge
import ViscousTimeReversalWirtingerDefinitions

/-! Statements of the sharp discrete Wirtinger inequality on a cycle. Source: `cycle-wirtinger-lean/Wirtinger.lean` (sha256 37cd9d37bc25ba9ec776accc23631b645f7d57f3932973ffbc850d06daa1546a), with two proof-only repairs recorded in `source-provenance.json`. -/

open Finset ComplexConjugate
open scoped Real

namespace CycleWirtinger

variable {n : ℕ} [NeZero n]

/-! ## The character -/

/-- Orthogonality: `∑ₖ e(k m)` is `n` if `m = 0` and `0` otherwise. -/
lemma ortho (m : ZMod n) :
    ∑ k : ZMod n, ZMod.stdAddChar (k * m) = if m = 0 then (n : ℂ) else 0 := by
  sorry

/-- The conjugate of `e(x)` is `e(-x)`. -/
lemma conj_e (x : ZMod n) : conj (ZMod.stdAddChar x) = ZMod.stdAddChar (-x) := by
  sorry

/-- `e(k) = exp(i · 2π k / n)`. -/
lemma e_eq_exp (k : ZMod n) :
    ZMod.stdAddChar k = Complex.exp (((2 * π * k.val / n : ℝ) : ℂ) * Complex.I) := by
  sorry

/-- `|e(k) - 1|² = 2 - 2 cos (2π k / n)`. -/
lemma normSq_e_sub_one (k : ZMod n) :
    Complex.normSq (ZMod.stdAddChar k - 1) = 2 - 2 * Real.cos (2 * π * k.val / n) := by
  sorry

/-- `|e(-k) - 1|² = |e(k) - 1|²`. -/
lemma normSq_e_neg_sub_one (k : ZMod n) :
    Complex.normSq (ZMod.stdAddChar (-k) - 1) = Complex.normSq (ZMod.stdAddChar k - 1) := by
  sorry

/-! ## The gap -/

/-- For `1 ≤ m` and `2m ≤ n`, `cos (2π m / n) ≤ cos (2π / n)`. -/
lemma cos_step {m : ℕ} (hm1 : 1 ≤ m) (h2 : 2 * m ≤ n) :
    Real.cos (2 * π * m / n) ≤ Real.cos (2 * π / n) := by
  sorry

/-- Every nonzero frequency is at least as far from `1` as the first: `cos (2π k/n) ≤ cos (2π/n)`. -/
lemma cos_le (k : ZMod n) (hk : k ≠ 0) :
    Real.cos (2 * π * k.val / n) ≤ Real.cos (2 * π / n) := by
  sorry

/-! ## Fourier -/

/-- Conjugation reverses frequency for real data. -/
lemma fourier_neg (f : ZMod n → ℝ) (k : ZMod n) : fourier f (-k) = conj (fourier f k) := by
  sorry

/-- Parseval, in the form `∑ₖ F(k) F(-k) = n ∑ⱼ f(j)²`. -/
lemma parseval (f : ZMod n → ℝ) :
    ∑ k, fourier f k * fourier f (-k) = (n : ℂ) * ∑ j, (f j : ℂ) ^ 2 := by
  sorry

/-- Parseval for real data: `∑ₖ |F k|² = n ∑ⱼ f j ²`. -/
lemma parseval_real (f : ZMod n → ℝ) :
    ∑ k, Complex.normSq (fourier f k) = n * ∑ j, f j ^ 2 := by
  sorry

/-- The step `j ↦ f (j+1) - f j` multiplies the `k`-th coefficient by `e(-k) - 1`. -/
lemma fourier_step (f : ZMod n → ℝ) (k : ZMod n) :
    fourier (fun j => f (j + 1) - f j) k = (ZMod.stdAddChar (-k) - 1) * fourier f k := by
  sorry

/-! ## The inequality and its sharpness -/

/-- **Sharp discrete Wirtinger inequality on the cycle.** -/
theorem wirtinger (f : ZMod n → ℝ) (hmean : ∑ j, f j = 0) :
    (2 - 2 * Real.cos (2 * π / n)) * ∑ j, f j ^ 2 ≤ ∑ j, (f (j + 1) - f j) ^ 2 := by
  sorry

/-- `(Re u)² = (|u|² + Re (u²)) / 2`. -/
lemma re_sq (u : ℂ) : u.re ^ 2 = (Complex.normSq u + (u * u).re) / 2 := by
  sorry

/-- If `2 ≠ 0` in `ZMod n`, then `∑ⱼ (Re (e(j) w))² = n |w|² / 2`. -/
lemma sum_re_sq (w : ℂ) (h2 : (2 : ZMod n) ≠ 0) :
    ∑ j : ZMod n, ((ZMod.stdAddChar j * w).re) ^ 2 = n * Complex.normSq w / 2 := by
  sorry

/-- **The constant cannot be improved.** For `n ≥ 3`, `f j = cos (2π j / n)` has mean zero and
attains equality. -/
theorem wirtinger_sharp (hn : 3 ≤ n) :
    ∑ j : ZMod n, Real.cos (2 * π * j.val / n) = 0 ∧
    ∑ j : ZMod n, (Real.cos (2 * π * (j + 1).val / n) - Real.cos (2 * π * j.val / n)) ^ 2
      = (2 - 2 * Real.cos (2 * π / n)) * ∑ j : ZMod n, Real.cos (2 * π * j.val / n) ^ 2 := by
  sorry

end CycleWirtinger

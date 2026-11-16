import ViscousTimeReversalPoincareProofs
import ViscousTimeReversalWirtingerDefinitions

/-! Proofs of the sharp discrete Wirtinger inequality on a cycle. Source: `cycle-wirtinger-lean/Wirtinger.lean` (sha256 37cd9d37bc25ba9ec776accc23631b645f7d57f3932973ffbc850d06daa1546a), with two proof-only repairs recorded in `source-provenance.json`. -/

open Finset ComplexConjugate
open scoped Real

namespace CycleWirtinger

variable {n : ℕ} [NeZero n]

/-! ## The character -/

/-- Orthogonality: `∑ₖ e(k m)` is `n` if `m = 0` and `0` otherwise. -/
lemma ortho (m : ZMod n) :
    ∑ k : ZMod n, ZMod.stdAddChar (k * m) = if m = 0 then (n : ℂ) else 0 := by
  rw [AddChar.sum_mulShift m (ZMod.isPrimitive_stdAddChar n), ZMod.card, Nat.cast_ite, Nat.cast_zero]

/-- The conjugate of `e(x)` is `e(-x)`. -/
lemma conj_e (x : ZMod n) : conj (ZMod.stdAddChar x) = ZMod.stdAddChar (-x) := by
  rw [ZMod.stdAddChar_apply, ZMod.stdAddChar_apply, AddChar.map_neg_eq_inv,
    Circle.coe_inv_eq_conj]

/-- `e(k) = exp(i · 2π k / n)`. -/
lemma e_eq_exp (k : ZMod n) :
    ZMod.stdAddChar k = Complex.exp (((2 * π * k.val / n : ℝ) : ℂ) * Complex.I) := by
  rw [ZMod.stdAddChar_apply, ZMod.toCircle_apply]
  congr 1
  push_cast
  ring

/-- `|e(k) - 1|² = 2 - 2 cos (2π k / n)`. -/
lemma normSq_e_sub_one (k : ZMod n) :
    Complex.normSq (ZMod.stdAddChar k - 1) = 2 - 2 * Real.cos (2 * π * k.val / n) := by
  rw [e_eq_exp, Complex.normSq_apply, Complex.sub_re, Complex.sub_im, Complex.one_re,
    Complex.one_im, Complex.exp_ofReal_mul_I_re, Complex.exp_ofReal_mul_I_im]
  linear_combination Real.sin_sq_add_cos_sq (2 * π * k.val / n)

/-- `|e(-k) - 1|² = |e(k) - 1|²`. -/
lemma normSq_e_neg_sub_one (k : ZMod n) :
    Complex.normSq (ZMod.stdAddChar (-k) - 1) = Complex.normSq (ZMod.stdAddChar k - 1) := by
  rw [← conj_e, ← Complex.normSq_conj, map_sub, Complex.conj_conj, map_one]

/-! ## The gap -/

/-- For `1 ≤ m` and `2m ≤ n`, `cos (2π m / n) ≤ cos (2π / n)`. -/
lemma cos_step {m : ℕ} (hm1 : 1 ≤ m) (h2 : 2 * m ≤ n) :
    Real.cos (2 * π * m / n) ≤ Real.cos (2 * π / n) := by
  have hnpos : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have ha : 0 ≤ 2 * π / n := by positivity
  apply Real.cos_le_cos_of_nonneg_of_le_pi ha
  · have h : (2 * (m : ℝ)) / n ≤ 1 := by
      rw [div_le_one hnpos]
      exact_mod_cast h2
    calc 2 * π * m / n = π * (2 * m / n) := by ring
      _ ≤ π * 1 := mul_le_mul_of_nonneg_left h Real.pi_pos.le
      _ = π := mul_one π
  · have h1 : (1 : ℝ) ≤ m := by exact_mod_cast hm1
    calc 2 * π / n = 2 * π / n * 1 := (mul_one _).symm
      _ ≤ 2 * π / n * m := mul_le_mul_of_nonneg_left h1 ha
      _ = 2 * π * m / n := by ring

/-- Every nonzero frequency is at least as far from `1` as the first: `cos (2π k/n) ≤ cos (2π/n)`. -/
lemma cos_le (k : ZMod n) (hk : k ≠ 0) :
    Real.cos (2 * π * k.val / n) ≤ Real.cos (2 * π / n) := by
  have hm1 : 1 ≤ k.val := Nat.one_le_iff_ne_zero.mpr (fun h => hk ((ZMod.val_eq_zero k).mp h))
  have hmn : k.val < n := ZMod.val_lt k
  have hnpos : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have hn0 : (n : ℝ) ≠ 0 := hnpos.ne'
  rcases le_or_gt (2 * k.val) n with h2 | h2
  · exact cos_step hm1 h2
  · have harg : 2 * π * ((n - k.val : ℕ) : ℝ) / n = 2 * π - 2 * π * k.val / n := by
      rw [Nat.cast_sub hmn.le, eq_sub_iff_add_eq, ← add_div, ← mul_add, sub_add_cancel,
        mul_div_assoc, div_self hn0, mul_one]
    have hc : Real.cos (2 * π * k.val / n) = Real.cos (2 * π * ((n - k.val : ℕ) : ℝ) / n) := by
      rw [harg, Real.cos_two_pi_sub]
    rw [hc]
    exact cos_step (by omega) (by omega)

/-! ## Fourier -/

/-- Conjugation reverses frequency for real data. -/
lemma fourier_neg (f : ZMod n → ℝ) (k : ZMod n) : fourier f (-k) = conj (fourier f k) := by
  simp only [fourier, map_sum, map_mul, Complex.conj_ofReal, conj_e]
  refine Finset.sum_congr rfl (fun j _ => ?_)
  rw [mul_neg]

/-- Parseval, in the form `∑ₖ F(k) F(-k) = n ∑ⱼ f(j)²`. -/
lemma parseval (f : ZMod n → ℝ) :
    ∑ k, fourier f k * fourier f (-k) = (n : ℂ) * ∑ j, (f j : ℂ) ^ 2 := by
  have h1 : ∀ k, fourier f k * fourier f (-k)
      = ∑ j, ∑ l, (f j : ℂ) * f l * ZMod.stdAddChar (k * (j - l)) := by
    intro k
    simp only [fourier, Finset.sum_mul_sum]
    refine Finset.sum_congr rfl (fun j _ => Finset.sum_congr rfl (fun l _ => ?_))
    rw [show k * (j - l) = j * k + l * -k by ring, AddChar.map_add_eq_mul]
    ring
  have h2 : ∀ j l : ZMod n, ∑ k, (f j : ℂ) * f l * ZMod.stdAddChar (k * (j - l))
      = if j = l then (n : ℂ) * (f j : ℂ) ^ 2 else 0 := by
    intro j l
    rw [← Finset.mul_sum, ortho]
    simp only [sub_eq_zero]
    split_ifs with h
    · subst h
      ring
    · ring
  calc ∑ k, fourier f k * fourier f (-k)
      = ∑ k, ∑ j, ∑ l, (f j : ℂ) * f l * ZMod.stdAddChar (k * (j - l)) :=
        Finset.sum_congr rfl (fun k _ => h1 k)
    _ = ∑ j, ∑ l, ∑ k, (f j : ℂ) * f l * ZMod.stdAddChar (k * (j - l)) := by
        rw [Finset.sum_comm]
        exact Finset.sum_congr rfl (fun j _ => Finset.sum_comm)
    _ = ∑ j, ∑ l, (if j = l then (n : ℂ) * (f j : ℂ) ^ 2 else 0) := by
        simp only [h2]
    _ = ∑ j, (n : ℂ) * (f j : ℂ) ^ 2 := by
        simp
    _ = (n : ℂ) * ∑ j, (f j : ℂ) ^ 2 := by
        rw [Finset.mul_sum]

/-- Parseval for real data: `∑ₖ |F k|² = n ∑ⱼ f j ²`. -/
lemma parseval_real (f : ZMod n → ℝ) :
    ∑ k, Complex.normSq (fourier f k) = n * ∑ j, f j ^ 2 := by
  have h := parseval f
  simp only [fourier_neg, Complex.mul_conj] at h
  exact_mod_cast h

/-- The step `j ↦ f (j+1) - f j` multiplies the `k`-th coefficient by `e(-k) - 1`. -/
lemma fourier_step (f : ZMod n → ℝ) (k : ZMod n) :
    fourier (fun j => f (j + 1) - f j) k = (ZMod.stdAddChar (-k) - 1) * fourier f k := by
  have hshift : ∑ j, (f (j + 1) : ℂ) * ZMod.stdAddChar (j * k)
      = ZMod.stdAddChar (-k) * fourier f k := by
    rw [fourier, Finset.mul_sum]
    exact Fintype.sum_equiv (Equiv.addRight 1) _ _ (fun j => by
      simp only [Equiv.coe_addRight]
      rw [show j * k = (j + 1) * k + -k by ring, AddChar.map_add_eq_mul]
      ring)
  have hsplit : fourier (fun j => f (j + 1) - f j) k
      = ∑ j, (f (j + 1) : ℂ) * ZMod.stdAddChar (j * k) - fourier f k := by
    simp only [fourier, Complex.ofReal_sub, sub_mul, Finset.sum_sub_distrib]
  rw [hsplit, hshift]
  ring

/-! ## The inequality and its sharpness -/

/-- **Sharp discrete Wirtinger inequality on the cycle.** -/
theorem wirtinger (f : ZMod n → ℝ) (hmean : ∑ j, f j = 0) :
    (2 - 2 * Real.cos (2 * π / n)) * ∑ j, f j ^ 2 ≤ ∑ j, (f (j + 1) - f j) ^ 2 := by
  have hg := parseval_real (fun j => f (j + 1) - f j)
  beta_reduce at hg
  have hf := parseval_real f
  have hmult : ∀ k, Complex.normSq (fourier (fun j => f (j + 1) - f j) k)
      = Complex.normSq (ZMod.stdAddChar k - 1) * Complex.normSq (fourier f k) := by
    intro k
    rw [fourier_step, Complex.normSq_mul, normSq_e_neg_sub_one]
  have hF0 : fourier f 0 = 0 := by
    simp only [fourier, mul_zero, AddChar.map_zero_eq_one, mul_one]
    exact_mod_cast hmean
  have hterm : ∀ k, (2 - 2 * Real.cos (2 * π / n)) * Complex.normSq (fourier f k)
      ≤ Complex.normSq (ZMod.stdAddChar k - 1) * Complex.normSq (fourier f k) := by
    intro k
    by_cases hk : k = 0
    · simp [hk, hF0]
    · apply mul_le_mul_of_nonneg_right _ (Complex.normSq_nonneg _)
      rw [normSq_e_sub_one]
      have := cos_le k hk
      linarith
  have hsum : (2 - 2 * Real.cos (2 * π / n)) * ∑ k, Complex.normSq (fourier f k)
      ≤ ∑ k, Complex.normSq (fourier (fun j => f (j + 1) - f j) k) := by
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum (fun k _ => (hterm k).trans_eq (hmult k).symm)
  rw [hf, hg] at hsum
  have hnpos : (0 : ℝ) < n := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne n)
  nlinarith [hsum, hnpos]

/-- `(Re u)² = (|u|² + Re (u²)) / 2`. -/
lemma re_sq (u : ℂ) : u.re ^ 2 = (Complex.normSq u + (u * u).re) / 2 := by
  rw [Complex.normSq_apply, Complex.mul_re]
  ring

/-- If `2 ≠ 0` in `ZMod n`, then `∑ⱼ (Re (e(j) w))² = n |w|² / 2`. -/
lemma sum_re_sq (w : ℂ) (h2 : (2 : ZMod n) ≠ 0) :
    ∑ j : ZMod n, ((ZMod.stdAddChar j * w).re) ^ 2 = n * Complex.normSq w / 2 := by
  have hsq : ∑ j : ZMod n, ZMod.stdAddChar j * ZMod.stdAddChar j = 0 := by
    have h := ortho (n := n) 2
    rw [if_neg h2] at h
    rw [← h]
    refine Finset.sum_congr rfl (fun j _ => ?_)
    rw [← AddChar.map_add_eq_mul, ← two_mul, mul_comm]
  have hre : ∑ j : ZMod n, ((ZMod.stdAddChar j * w) * (ZMod.stdAddChar j * w)).re = 0 := by
    rw [← Complex.re_sum]
    have h : ∑ j : ZMod n, (ZMod.stdAddChar j * w) * (ZMod.stdAddChar j * w)
        = (w * w) * ∑ j : ZMod n, ZMod.stdAddChar j * ZMod.stdAddChar j := by
      rw [Finset.mul_sum]
      exact Finset.sum_congr rfl (fun j _ => by ring)
    rw [h, hsq, mul_zero, Complex.zero_re]
  have hn1 : ∀ j : ZMod n, Complex.normSq (ZMod.stdAddChar j * w) = Complex.normSq w := by
    intro j
    rw [Complex.normSq_mul, ZMod.stdAddChar_apply, Circle.normSq_coe, one_mul]
  simp only [re_sq, hn1]
  rw [← Finset.sum_div, Finset.sum_add_distrib, hre, Finset.sum_const, Finset.card_univ,
    ZMod.card, nsmul_eq_mul]
  ring

/-- **The constant cannot be improved.** For `n ≥ 3`, `f j = cos (2π j / n)` has mean zero and
attains equality. -/
theorem wirtinger_sharp (hn : 3 ≤ n) :
    ∑ j : ZMod n, Real.cos (2 * π * j.val / n) = 0 ∧
    ∑ j : ZMod n, (Real.cos (2 * π * (j + 1).val / n) - Real.cos (2 * π * j.val / n)) ^ 2
      = (2 - 2 * Real.cos (2 * π / n)) * ∑ j : ZMod n, Real.cos (2 * π * j.val / n) ^ 2 := by
  haveI : Fact (1 < n) := ⟨by omega⟩
  have hre : ∀ j : ZMod n, Real.cos (2 * π * j.val / n) = (ZMod.stdAddChar j).re := by
    intro j
    rw [e_eq_exp, Complex.exp_ofReal_mul_I_re]
  have h2 : (2 : ZMod n) ≠ 0 := by
    intro h
    have h' : ((2 : ℕ) : ZMod n) = 0 := by exact_mod_cast h
    rw [ZMod.natCast_eq_zero_iff] at h'
    have := Nat.le_of_dvd (by norm_num) h'
    omega
  constructor
  · simp only [hre]
    rw [← Complex.re_sum]
    have h1 := ortho (n := n) 1
    rw [if_neg one_ne_zero] at h1
    simp only [mul_one] at h1
    rw [h1, Complex.zero_re]
  · have hstep : ∀ j : ZMod n, (ZMod.stdAddChar (j + 1)).re - (ZMod.stdAddChar j).re
        = (ZMod.stdAddChar j * (ZMod.stdAddChar (1 : ZMod n) - 1)).re := by
      intro j
      rw [AddChar.map_add_eq_mul, ← Complex.sub_re]
      congr 1
      ring
    simp only [hre, hstep]
    have hA := sum_re_sq (ZMod.stdAddChar (1 : ZMod n) - 1) h2
    have hB := sum_re_sq (1 : ℂ) h2
    simp only [mul_one, Complex.normSq_one] at hB
    rw [hA, hB, normSq_e_sub_one, ZMod.val_one, Nat.cast_one, mul_one]
    ring

end CycleWirtinger

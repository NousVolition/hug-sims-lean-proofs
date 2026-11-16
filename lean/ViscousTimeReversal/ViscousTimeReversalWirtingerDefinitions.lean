import Mathlib

/-!
# The sharp discrete Wirtinger inequality on a cycle

For `f : ZMod n → ℝ` with `∑ j, f j = 0`,

  `(2 - 2 cos (2π/n)) * ∑ j, f j ^ 2 ≤ ∑ j, (f (j + 1) - f j) ^ 2`   (`wirtinger`),

and for `n ≥ 3` the constant is attained by `f j = cos (2π j / n)` (`wirtinger_sharp`), so it is
the best possible. `2 - 2 cos (2π/n) = 4 sin² (π/n)` is the smallest nonzero eigenvalue of the
cycle Laplacian: the spectral gap of `ZMod n`.

The proof is by the discrete Fourier transform built on `ZMod.stdAddChar`, with orthogonality from
`AddChar.sum_mulShift`:

* `parseval_real`: `∑ₖ |F k|² = n ∑ⱼ f j ²`;
* `fourier_step`: the step `j ↦ f (j+1) - f j` multiplies `F k` by `e(-k) - 1`;
* `normSq_e_sub_one`: `|e(k) - 1|² = 2 - 2 cos (2π k/n)`, which for `k ≠ 0` is at least the gap
  (`cos_le`).

Source: `cycle-wirtinger-lean/Wirtinger.lean` (sha256 37cd9d37bc25ba9ec776accc23631b645f7d57f3932973ffbc850d06daa1546a), with two proof-only repairs recorded in `source-provenance.json`.
Definitions; the statements are in `ViscousTimeReversalWirtingerChallenge.lean` and the proofs in
`ViscousTimeReversalWirtingerProofs.lean`.
-/

open Finset ComplexConjugate
open scoped Real

namespace CycleWirtinger

variable {n : ℕ} [NeZero n]

/-- Fourier coefficients of a real function on the cycle `ZMod n`. -/
noncomputable def fourier (f : ZMod n → ℝ) (k : ZMod n) : ℂ :=
  ∑ j, (f j : ℂ) * ZMod.stdAddChar (j * k)

end CycleWirtinger

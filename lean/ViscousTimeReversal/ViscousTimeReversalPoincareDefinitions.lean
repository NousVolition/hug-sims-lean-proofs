import Mathlib

/-!
# A discrete Poincaré–Wirtinger inequality on a path

For values `f 0, …, f (n-1)` on a path of `n` points with mean zero,

  `2 * ∑ f i ^ 2 ≤ n * (n - 1) * ∑ (f (k+1) - f k) ^ 2`,

so the quadratic form of the path Laplacian is bounded below by `2 / (n (n-1))` times the
squared norm on mean-zero data: a spectral gap with an explicit constant. The mean-zero
condition cannot be dropped: constants have zero Dirichlet energy and positive norm.

The constant `n (n-1) / 2` is not sharp (the sharp one grows like `n² / π²`); it comes from an
elementary argument: telescoping, Cauchy–Schwarz, and the pair identity
`∑ᵢ ∑ⱼ (f i - f j)² = 2 n ∑ f² - 2 (∑ f)²`.

Source: `discrete-poincare-lean/Poincare.lean` (sha256 e4a76d125f57885221ac70ed59749b9ea12143bcbca3a71c56e74ee6c05b4fd0). Definitions; the statements are in
`ViscousTimeReversalPoincareChallenge.lean` and the proofs in `ViscousTimeReversalPoincareProofs.lean`.
-/

open Finset

namespace DiscretePoincare

/-- Dirichlet energy of `f` on the path `0, …, n-1`: the sum of squared steps. -/
def dirichlet (f : ℕ → ℝ) (n : ℕ) : ℝ := ∑ k ∈ range (n - 1), (f (k + 1) - f k) ^ 2

end DiscretePoincare

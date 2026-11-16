import Mathlib

/-!
# A Poincaré inequality on the discrete 3-torus

On `ZMod a × ZMod b × ZMod c`, for `f` with `∑ f = 0`,

  `min (gap a) (min (gap b) (gap c)) * ∑ f ² ≤ energy f`   (`torus`),

where `gap n = 2 - 2 cos (2π/n)` is the spectral gap of the cycle `ZMod n` and `energy f` sums the
squared forward differences in the three coordinate directions. For `3 ≤ a` with `2 ≤ b ≤ a` and
`2 ≤ c ≤ a`, the constant is `gap a` and the cosine `cos (2π i / a)` along the first direction
meets it with equality (`torus_sharp`, `torus_attained`), so it is the best possible.

The proof adds one cycle direction at a time (`add_direction`): split `f` into its mean along the
new direction and the remainder, apply the cycle inequality `CycleWirtinger.wirtinger` to the
remainder on each line, and the inequality for the other directions to the mean, which has sum
zero and no more energy than the average of the slices (`step_mean_le`). This gives `plane` on
`ZMod b × ZMod c` and then `torus`.

Without the sum-zero condition there is no bound (`mean_has_no_gap`). The scaled gap
`N² · gap N` stays at or below `(2π)²` (`scaled_gap_le`) and tends to it (`scaled_gap_tendsto`).

Definitions; the statements are in `ViscousTimeReversalTorusChallenge.lean` and the proofs in
`ViscousTimeReversalTorusProofs.lean`.
-/

open Finset
open scoped Real

namespace TorusPoincare

/-- The spectral gap of the cycle `ZMod n`: `2 - 2 cos (2π/n)`. -/
noncomputable def gap (n : ℕ) : ℝ := 2 - 2 * Real.cos (2 * π / n)

/-- Dirichlet energy on the discrete 3-torus: squared forward differences in the three
coordinate directions. -/
noncomputable def energy {a b c : ℕ} [NeZero a] [NeZero b] [NeZero c]
    (f : ZMod a → ZMod b → ZMod c → ℝ) : ℝ :=
  ∑ i, ∑ j, ∑ k, ((f (i + 1) j k - f i j k) ^ 2 + (f i (j + 1) k - f i j k) ^ 2 +
    (f i j (k + 1) - f i j k) ^ 2)

end TorusPoincare

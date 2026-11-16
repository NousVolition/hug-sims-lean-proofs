import Mathlib
import HugWallPushDefinitions

noncomputable section

open scoped BigOperators

namespace HugWallPush

/-! ## 1. The wall cannot move the whole grid -/

section Wall

variable {G : Type*} [AddCommGroup G] [Fintype G]

theorem shifted_flux_sum (ν u : G → ℝ) (e : G) :
    ∑ i, flux ν u e (i - e) = ∑ i, flux ν u e i := by sorry

/-- The wall never changes the total of the grid. -/
theorem wall_total_zero (ν u : G → ℝ) (e : G) : ∑ i, wallChange ν u e i = 0 := by sorry

/-- What the wall does to the motion is exactly minus the heat it makes. -/
theorem wall_energy (ν u : G → ℝ) (e : G) :
    ∑ i, u i * wallChange ν u e i = -wallHeat ν u e := by sorry

/-- A wall of thickness zero or more makes heat zero or more. -/
theorem wallHeat_nonneg (ν u : G → ℝ) (e : G) (hν : ∀ i, 0 ≤ ν i) :
    0 ≤ wallHeat ν u e := by sorry

/-- A wall of thickness zero or more only takes motion away. -/
theorem wall_only_takes (ν u : G → ℝ) (e : G) (hν : ∀ i, 0 ≤ ν i) :
    ∑ i, u i * wallChange ν u e i ≤ 0 := by sorry

/-- With walls in every direction, the total of the grid still never changes. -/
theorem grid_total_zero {ι : Type*} (D : Finset ι) (step : ι → G) (ν : ι → G → ℝ)
    (u : G → ℝ) : ∑ i, gridChange D step ν u i = 0 := by sorry

/-- With walls in every direction, what they do to the motion is exactly minus the
heat they make together. -/
theorem grid_energy {ι : Type*} (D : Finset ι) (step : ι → G) (ν : ι → G → ℝ)
    (u : G → ℝ) :
    ∑ i, u i * gridChange D step ν u i = -∑ d ∈ D, wallHeat (ν d) u (step d) := by sorry

/-- In time: if every cell moves only by the wall, the total of the grid has rate zero. -/
theorem wall_keeps_total (ν : G → ℝ) (e : G) (u : ℝ → G → ℝ) (t : ℝ)
    (hu : ∀ i, HasDerivAt (fun s => u s i) (wallChange ν (u t) e i) t) :
    HasDerivAt (fun s => ∑ i, u s i) 0 t := by sorry

/-- In time: if every cell moves only by the wall and `H` gathers the heat the wall
makes, then motion plus heat has rate zero. The count closes. -/
theorem count_closes (ν : G → ℝ) (e : G) (u : ℝ → G → ℝ) (H : ℝ → ℝ) (t : ℝ)
    (hu : ∀ i, HasDerivAt (fun s => u s i) (wallChange ν (u t) e i) t)
    (hH : HasDerivAt H (wallHeat ν (u t) e) t) :
    HasDerivAt (fun s => (∑ i, u s i ^ 2) / 2 + H s) 0 t := by sorry

end Wall

/-! ## 2. The push moves the whole grid one way -/

section Push

variable {G : Type*} [AddCommGroup G] [Fintype G]

/-- With the wall and a push `-σ a i` in one fixed direction, the total changes by
exactly the push's total. The wall contributes nothing. -/
theorem push_changes_total (ν a : G → ℝ) (σ : ℝ) (e : G) (u : G → ℝ) :
    ∑ i, (wallChange ν u e i - σ * a i) = -(σ * ∑ i, a i) := by sorry

/-- If the activation is never negative and any cell is over the threshold, the total
moves one way, whatever the wall's thickness. -/
theorem push_moves_one_way (ν a : G → ℝ) (σ : ℝ) (e : G) (u : G → ℝ)
    (hσ : 0 < σ) (ha : ∀ i, 0 ≤ a i) (hon : ∃ j, 0 < a j) :
    ∑ i, (wallChange ν u e i - σ * a i) < 0 := by sorry

/-- Only a push whose total is zero leaves the total of the grid alone. -/
theorem balanced_push_keeps_total (ν a : G → ℝ) (σ : ℝ) (e : G) (u : G → ℝ)
    (h0 : ∑ i, a i = 0) :
    ∑ i, (wallChange ν u e i - σ * a i) = 0 := by sorry

/-- In time: with the wall and the push, the total of the grid has rate
`-(σ * ∑ a)`, whatever the wall's thickness. -/
theorem push_moves_box (ν a : G → ℝ) (σ : ℝ) (e : G) (u : ℝ → G → ℝ) (t : ℝ)
    (hu : ∀ i, HasDerivAt (fun s => u s i) (wallChange ν (u t) e i - σ * a i) t) :
    HasDerivAt (fun s => ∑ i, u s i) (-(σ * ∑ i, a i)) t := by sorry

end Push

/-! ## 3. Two sides meeting at balance through a wall -/

section TwoSides

theorem lin_deriv (c t : ℝ) : HasDerivAt (fun s : ℝ => c * s) c t := by sorry

/-- Side A moves toward side B at rate `k` times the difference. -/
theorem sideA_deriv (m d k t : ℝ) :
    HasDerivAt (sideA m d k) (k * (sideB m d k t - sideA m d k t)) t := by sorry

/-- Side B moves toward side A at rate `k` times the difference. -/
theorem sideB_deriv (m d k t : ℝ) :
    HasDerivAt (sideB m d k) (k * (sideA m d k t - sideB m d k t)) t := by sorry

/-- The average of the two sides never moves. -/
theorem average_fixed (m d k t : ℝ) : (sideA m d k t + sideB m d k t) / 2 = m := by sorry

/-- The difference fades as `exp (-(2k) t)`. -/
theorem difference_fades (m d k t : ℝ) :
    sideA m d k t - sideB m d k t = d * Real.exp (-(2 * k) * t) := by sorry

/-- A thicker wall balances the two sides faster. -/
theorem thicker_balances_faster (m d k₁ k₂ t : ℝ) (hk : k₁ ≤ k₂) (ht : 0 ≤ t) :
    |sideA m d k₂ t - sideB m d k₂ t| ≤ |sideA m d k₁ t - sideB m d k₁ t| := by sorry

theorem exp_double (k t : ℝ) :
    Real.exp (-(4 * k) * t) = Real.exp (-(2 * k) * t) ^ 2 := by sorry

/-- Motion plus heat stays fixed for all time: the count closes. -/
theorem two_sides_count_closes (m d k t : ℝ) :
    (sideA m d k t ^ 2 + sideB m d k t ^ 2) / 2 + twoSideHeat d k t
      = m ^ 2 + d ^ 2 / 4 := by sorry

/-- The wall makes heat at rate `k` times the square of the difference. -/
theorem twoSideHeat_deriv (m d k t : ℝ) :
    HasDerivAt (twoSideHeat d k) (k * (sideA m d k t - sideB m d k t) ^ 2) t := by sorry

/-- With a wall of thickness zero or more, the heat made is zero or more. -/
theorem twoSideHeat_nonneg (d k t : ℝ) (hk : 0 ≤ k) (ht : 0 ≤ t) :
    0 ≤ twoSideHeat d k t := by sorry

end TwoSides

/-! ## 4. The floor of the tanh dip -/

section Dip

theorem half_one_add_tanh_le (y : ℝ) : (1 + Real.tanh y) / 2 ≤ Real.exp (2 * y) := by sorry

/-- The tanh response, in units of `ε`, never goes below `-1 / (2e)`. -/
theorem dip_floor_normalized (y : ℝ) :
    -(1 / (2 * Real.exp 1)) ≤ y * (1 + Real.tanh y) / 2 := by sorry

/-- The tanh response `q (1 + tanh (q/ε)) / 2` never goes below `-ε / (2e)`. -/
theorem dip_floor (ε q : ℝ) (hε : 0 < ε) :
    -(ε / (2 * Real.exp 1)) ≤ q * (1 + Real.tanh (q / ε)) / 2 := by sorry

/-- If the base viscosity covers the dip, the total viscosity is never negative:
nothing runs backward. -/
theorem total_viscosity_never_negative (μ σ ε q : ℝ) (hσ : 0 ≤ σ) (hε : 0 < ε)
    (hμ : σ * (ε / (2 * Real.exp 1)) ≤ μ) :
    0 ≤ μ + σ * (q * (1 + Real.tanh (q / ε)) / 2) := by sorry

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
      = ∑ n ∈ Finset.range m, f (N + n) - ∑ n ∈ Finset.range m, f n := by sorry

/-- With the delayed baseline, the record is always its start plus `γ h` times
(the last breath added up − the first breath added up). -/
theorem delayed_baseline_record (A U : ℕ → ℝ) (γ h : ℝ) (m : ℕ)
    (hstep : ∀ n, A (n + 1) = A n + γ * h * (U (n + m) - U n)) (N : ℕ) :
    A N = A 0 + γ * h *
      (∑ n ∈ Finset.range m, U (N + n) - ∑ n ∈ Finset.range m, U n) := by sorry

/-- With the delayed baseline and the breath staying between `lo` and `hi`, the record
never moves more than `γ h m (hi − lo)` from where it started. It cannot pile up. -/
theorem delayed_baseline_bounded (A U : ℕ → ℝ) (γ h lo hi : ℝ) (m : ℕ)
    (hγh : 0 ≤ γ * h) (hU : ∀ n, lo ≤ U n ∧ U n ≤ hi)
    (hstep : ∀ n, A (n + 1) = A n + γ * h * (U (n + m) - U n)) (N : ℕ) :
    |A N - A 0| ≤ γ * h * (m * (hi - lo)) := by sorry

/-- With the baseline frozen and the breath always at least `c` above it, the record
grows by at least `γ h c` every step: it only breathes in. -/
theorem frozen_baseline_fills (A U : ℕ → ℝ) (γ h b c : ℝ) (hγh : 0 ≤ γ * h)
    (hU : ∀ n, b + c ≤ U n)
    (hstep : ∀ n, A (n + 1) = A n + γ * h * (U n - b)) (N : ℕ) :
    A 0 + γ * h * c * N ≤ A N := by sorry

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
    (200 : ℚ) * mentorStep = 8 / 10 ∧ (256 : ℚ) * studentStep = 8 / 10 := by sorry

/-- The two clocks land on the same instant exactly at whole prime ticks: mentor step `k`
and student step `j` are the same instant only when `k = 25 n` and `j = 32 n`. -/
theorem clocks_meet_at_ticks (k j : ℕ) :
    (k : ℚ) * mentorStep = (j : ℚ) * studentStep ↔ ∃ n : ℕ, k = 25 * n ∧ j = 32 * n := by sorry

/-- The shares make the whole: 0.2 + 0.8 = 1. -/
theorem shares_whole : (1 / 5 : ℝ) + 4 / 5 = 1 := by sorry

/-- The balance point lies between the two sides. -/
theorem balance_between (xM xS : ℝ) (h : xM ≤ xS) :
    xM ≤ balance xM xS ∧ balance xM xS ≤ xS := by sorry

/-- Closing the gap: the mentor moves 0.8 of it and the student 0.2. -/
theorem gap_split (xM xS : ℝ) :
    balance xM xS - xM = 4 / 5 * (xS - xM) ∧ xS - balance xM xS = 1 / 5 * (xS - xM) := by sorry

/-- Closing the gap at the freeze keeps the shared total. -/
theorem freeze_keeps_total (xM xS : ℝ) :
    1 / 5 * balance xM xS + 4 / 5 * balance xM xS = 1 / 5 * xM + 4 / 5 * xS := by sorry

/-- Closing the gap at the freeze gives off exactly (0.2 × 0.8) / 2 = 2/25 of the squared
gap. The energy has to go somewhere. -/
theorem freeze_gives_off (xM xS : ℝ) :
    (1 / 5 * xM ^ 2 + 4 / 5 * xS ^ 2) / 2 - (1 / 5 + 4 / 5) * balance xM xS ^ 2 / 2
      = 2 / 25 * (xS - xM) ^ 2 := by sorry

/-- What the freeze gives off is never negative. -/
theorem freeze_gives_off_nonneg (xM xS : ℝ) :
    0 ≤ (1 / 5 * xM ^ 2 + 4 / 5 * xS ^ 2) / 2 - (1 / 5 + 4 / 5) * balance xM xS ^ 2 / 2 := by sorry

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
    (hχ : ∀ i, 0 ≤ χ i) : 0 ≤ clayHeat K g χ u := by sorry

/-- What the clay does to the motion is exactly minus the heat it makes. -/
theorem clay_energy (K : ℝ) (g χ u : G → ℝ) :
    ∑ i, u i * clayDrag K g χ u i = -clayHeat K g χ u := by sorry

/-- Wall and clay together only take motion away, by exactly the heat they make. -/
theorem wall_clay_energy (ν g χ u : G → ℝ) (K : ℝ) (e : G) :
    ∑ i, u i * (wallChange ν u e i + clayDrag K g χ u i)
      = -(wallHeat ν u e + clayHeat K g χ u) := by sorry

/-- With the wall, the push and the clay, the total of the grid changes at rate
`−σ Σ a − K Σ g χ u`. The wall adds nothing; the clay acts against the motion itself. -/
theorem clay_push_total (ν a g χ u : G → ℝ) (σ K : ℝ) (e : G) :
    ∑ i, (wallChange ν u e i - σ * a i + clayDrag K g χ u i)
      = -(σ * ∑ i, a i) - K * ∑ i, g i * χ i * u i := by sorry

/-- If the whole box moves together at speed `U`, its total changes at rate
`−σ Σ a − K U Σ g χ`. -/
theorem uniform_box_rate (ν a g χ u : G → ℝ) (σ K U : ℝ) (e : G) (hu : ∀ i, u i = U) :
    ∑ i, (wallChange ν u e i - σ * a i + clayDrag K g χ u i)
      = -(σ * ∑ i, a i) - K * U * ∑ i, g i * χ i := by sorry

/-- That rate always points the box's speed toward the settling speed
`−σ Σ a / (K Σ g χ)`: it is `−(K Σ g χ)` times the distance from it. -/
theorem uniform_box_toward_settling (s KS U : ℝ) (hKS : KS ≠ 0) :
    -s - KS * U = -KS * (U - (-s / KS)) := by sorry

/-- The same, in the box's own terms: when the whole box moves together, its total
changes at rate `−(K Σ g χ)` times its distance from the settling speed
`−σ Σ a / (K Σ g χ)`. The clay brakes the whole box; the wall alone cannot. -/
theorem clay_brakes_box (ν a g χ u : G → ℝ) (σ K U : ℝ) (e : G) (hu : ∀ i, u i = U)
    (hS : K * ∑ i, g i * χ i ≠ 0) :
    ∑ i, (wallChange ν u e i - σ * a i + clayDrag K g χ u i)
      = -(K * ∑ i, g i * χ i)
          * (U - (-(σ * ∑ i, a i) / (K * ∑ i, g i * χ i))) := by sorry

/-- Where the clay has fully given way (`g = 0` everywhere), the brake is gone and the
push moves the total exactly as it does with the wall alone. -/
theorem broken_clay_no_brake (ν a g χ u : G → ℝ) (σ K : ℝ) (e : G) (hg : ∀ i, g i = 0) :
    ∑ i, (wallChange ν u e i - σ * a i + clayDrag K g χ u i) = -(σ * ∑ i, a i) := by sorry

/-- The box's speed changes at rate `−c` times its distance from the settling speed. -/
theorem boxSpeed_deriv (Vs V0 c t : ℝ) :
    HasDerivAt (boxSpeed Vs V0 c) (-c * (boxSpeed Vs V0 c t - Vs)) t := by sorry

/-- With `c ≥ 0`, the box never gets further from the settling speed than it started:
no runaway. -/
theorem boxSpeed_settles (Vs V0 c t : ℝ) (hc : 0 ≤ c) (ht : 0 ≤ t) :
    |boxSpeed Vs V0 c t - Vs| ≤ |V0 - Vs| := by sorry

/-- The exact step keeps the integrity between 0 and 1. -/
theorem integrity_stays (a b g dt : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) (hab : 0 < a + b)
    (hdt : 0 ≤ dt) (hg0 : 0 ≤ g) (hg1 : g ≤ 1) :
    0 ≤ integrityStep a b g dt ∧ integrityStep a b g dt ≤ 1 := by sorry

/-- Where fluid pushes through and nothing recovers (`b = 0`), the clay only gives way:
its integrity shrinks by `exp (−a dt)` each step. -/
theorem integrity_yields (a g dt : ℝ) :
    integrityStep a 0 g dt = g * Real.exp (-a * dt) := by sorry

/-- Where nothing pushes through (`a = 0`), the clay heals toward 1. -/
theorem integrity_recovers (b g dt : ℝ) (hb : b ≠ 0) :
    integrityStep 0 b g dt = 1 + (g - 1) * Real.exp (-b * dt) := by sorry

end ClayWall

end HugWallPush

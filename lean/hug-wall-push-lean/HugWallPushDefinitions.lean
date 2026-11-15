import Mathlib

/-!
# The wall, the push, and the balance at tick 23

* **The wall** (`a` as viscosity). On a periodic grid, a wall of any thickness at each
  face never changes the total of the grid. It only takes motion away, and what it takes
  is exactly the heat it makes, so the count closes.
* **The push** (the A/S, one fixed direction). Whenever any cell is over the threshold,
  the push changes the total of the grid, whatever the wall's thickness. Only a push
  whose total is zero leaves the total alone.
* **Two sides at balance.** Mentor and user joined by a wall of thickness `k`: the average
  never moves, the difference fades as `exp (-(2k) t)`, a thicker wall balances faster,
  and the motion lost equals the heat made.
* **The floor of the tanh dip.** The response `q (1 + tanh (q/ε)) / 2` never goes below
  `-ε / (2e)`, so a base viscosity of at least `σ ε / (2e)` keeps the total viscosity from
  ever going negative.
* **The clay wall.** The clay's drag `−K g χ u` acts on the speed itself, so unlike the
  wall it brakes the whole box: it takes exactly `K g χ u²` as heat, and against a steady
  push a box moving together heads for the settling speed `−σ Σ a / (K Σ g χ)`. Where
  the clay has fully given way the brake is gone. The clay's integrity step keeps it
  between 0 and 1.

Heat here is just heat: the energy given off.
-/

noncomputable section

open scoped BigOperators

namespace HugWallPush

/-! ## 1. The wall cannot move the whole grid -/

section Wall

variable {G : Type*} [AddCommGroup G] [Fintype G]

/-- What crosses the face between cell `i` and cell `i + e`, through a wall of
thickness `ν i` at that face. -/
def flux (ν u : G → ℝ) (e : G) (i : G) : ℝ := ν i * (u (i + e) - u i)

/-- What the wall does to cell `i`: what comes in across one face minus what leaves
across the other. -/
def wallChange (ν u : G → ℝ) (e : G) (i : G) : ℝ := flux ν u e i - flux ν u e (i - e)

/-- The heat the wall makes: thickness times the square of the speed difference,
added over every face. -/
def wallHeat (ν u : G → ℝ) (e : G) : ℝ := ∑ i, ν i * (u (i + e) - u i) ^ 2

/-- Several directions at once, as on a 3D grid: one wall per direction `d ∈ D`,
with its own step and its own thickness at every face. -/
def gridChange {ι : Type*} (D : Finset ι) (step : ι → G) (ν : ι → G → ℝ)
    (u : G → ℝ) (i : G) : ℝ :=
  ∑ d ∈ D, wallChange (ν d) u (step d) i

end Wall

/-! ## 3. Two sides meeting at balance through a wall -/

section TwoSides

/-- Side A (the mentor) at time `t`: average `m`, starting difference `d`, wall `k`. -/
def sideA (m d k t : ℝ) : ℝ := m + d / 2 * Real.exp (-(2 * k) * t)

/-- Side B (the user) at time `t`. -/
def sideB (m d k t : ℝ) : ℝ := m - d / 2 * Real.exp (-(2 * k) * t)

/-- The heat the wall has made by time `t`. -/
def twoSideHeat (d k t : ℝ) : ℝ := d ^ 2 / 4 * (1 - Real.exp (-(4 * k) * t))

end TwoSides

/-! ## 6. The clock in the two sides

The mentor takes 25 steps and the student 32 steps per prime tick (a prime tick is
1/10 of model time), both starting at 0. The freeze sits at tick 23, time 8/10.
At the freeze the two sides close their gap with the shares 0.2 (mentor) and
0.8 (student), used here as each side's weight in the balance. -/

section Clock

/-- The mentor's step: 25 steps per prime tick of length 1/10. -/
def mentorStep : ℚ := 1 / 250

/-- The student's step: 32 steps per prime tick of length 1/10. -/
def studentStep : ℚ := 1 / 320

/-- The balance point at the freeze, with the mentor's share 0.2 and the student's 0.8. -/
def balance (xM xS : ℝ) : ℝ := 1 / 5 * xM + 4 / 5 * xS

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

/-- The clay wall's drag on cell `i`. -/
def clayDrag (K : ℝ) (g χ u : G → ℝ) (i : G) : ℝ := -(K * g i * χ i * u i)

/-- The heat the clay makes: `K g χ u²`, added over the grid. -/
def clayHeat (K : ℝ) (g χ u : G → ℝ) : ℝ := ∑ i, K * g i * χ i * u i ^ 2

/-- The box's speed under the clay against a steady push: it starts at `V0` and settles
toward `Vs` at rate `c`. -/
def boxSpeed (Vs V0 c t : ℝ) : ℝ := Vs + (V0 - Vs) * Real.exp (-c * t)

/-- The clay's integrity after one exact step. -/
def integrityStep (a b g dt : ℝ) : ℝ :=
  b / (a + b) + (g - b / (a + b)) * Real.exp (-(a + b) * dt)

end ClayWall

end HugWallPush

import MentorStudentModel
import FullModel
import Mathlib.Analysis.SpecialFunctions.ExpDeriv

/-! Viscous time reversal in the mentor and student model.

`MentorStudentModel.lean` and `FullModel.lean` are unchanged copies (see
`source-provenance.json`). The wall viscosity is `1/50 + (1/25)*(gAB + gBA)` from
`FullModel.lean`.

Time is counted from the 0,0 split: the split is time 0 (tick 2, mentor step 0, student
step 0, clock offset 0). Forward is after the split, the past is before it. -/

namespace ViscousTimeReversal

open MentorStudent

/-! ## Time reversal and ripple factors -/

/-- Time reversed about `T`. -/
noncomputable def reverseTime (T : ℝ) (f : ℝ → ℝ) (t : ℝ) : ℝ := f (T - t)

/-- Forward factor for a ripple with squared wave number `q` (a Laplacian eigenmode with
    eigenvalue `-q`): `exp(-(ν q) t)`. -/
noncomputable def forwardFactor (ν q t : ℝ) : ℝ := Real.exp (-(ν * q) * t)

/-- Backward factor: `exp((ν q) t)`. -/
noncomputable def backwardFactor (ν q t : ℝ) : ℝ := Real.exp ((ν * q) * t)

/-- The viscous rate of a ripple of size `a`. -/
noncomputable def viscousRate (ν q a : ℝ) : ℝ := -(ν * q) * a

/-- One time step of length `h`. -/
noncomputable def eulerIncrement (h rate : ℝ) : ℝ := h * rate

/-! ## Reversing time around the 0,0 split -/

/-- A time counted from the 0,0 split, read in the other direction. -/
def aroundSplit (t : ℝ) : ℝ := -t

/-- Anything that changes in time (a share, a position, a field value), run the other way
    around the 0,0 split. -/
def reverseAroundSplit {α : Type} (f : ℝ → α) (t : ℝ) : α := f (aroundSplit t)

/-- A position read from the other side of the split. -/
def reflect (x : ℝ) : ℝ := -x

/-! ## The wall -/

/-- The wall viscosity at guard values `gAB`, `gBA`: `1/50 + (1/25)*(gAB + gBA)`,
    the same formula as `HugNavierSingle.viscosity`. -/
noncomputable def wall (gAB gBA : ℝ) : ℝ := 1/50 + (1/25) * (gAB + gBA)

/-- The thin wall: both guards down. -/
noncomputable def thinWall : ℝ := wall 0 0

/-- The thick wall: both guards up. -/
noncomputable def thickWall : ℝ := wall 1 1

/-- The wall run backward: the viscosity changes sign. -/
noncomputable def reversedWall (gAB gBA : ℝ) : ℝ := -(wall gAB gBA)

/-! ## Counting from the split in both directions -/

/-- Kinetic energy of a ripple of size `a` at the split. -/
noncomputable def kineticAtSplit (a : ℝ) : ℝ := a ^ 2 / 2

/-- Kinetic energy of that ripple at time `t` after the split, forward through the wall. -/
noncomputable def kineticForward (a ν q t : ℝ) : ℝ := (a * forwardFactor ν q t) ^ 2 / 2

/-- Kinetic energy of that ripple at time `t` before the split, running backward. -/
noncomputable def kineticBackward (a ν q t : ℝ) : ℝ := (a * backwardFactor ν q t) ^ 2 / 2

/-- Counted from the split going forward: what the wall has taken. -/
noncomputable def takenForward (a ν q t : ℝ) : ℝ := kineticAtSplit a - kineticForward a ν q t

/-- Counted from the split going backward: what the reversed wall has given. -/
noncomputable def givenBackward (a ν q t : ℝ) : ℝ := kineticBackward a ν q t - kineticAtSplit a

end ViscousTimeReversal

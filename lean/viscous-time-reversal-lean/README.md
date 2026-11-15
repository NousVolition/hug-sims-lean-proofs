# Viscosity under time reversal

**Verification: NOT_RUN** for this revision. See [verification-report.json](verification-report.json).

## At a glance

The sign flip of viscosity under time reversal is proved, not assumed: it follows from the chain rule on real functions. Forward, a ripple is only damped; backward, it is only amplified; finer ripples are amplified at least as much as coarser ones; the forward and backward factors multiply to exactly 1. The damping, amplification and factor statements also hold at the wall `1/50 + (1/25)(gAB + gBA)`, with time counted from the 0,0 split.

| Question | Answer |
| --- | --- |
| Viscosity breaks time reversal | Yes |
| Why | Proved, not assumed |
| Effect on the flow | Yes |
| Stated at the wall and the 0,0 split | Yes |

## Model

Time is counted from the 0,0 split at tick 2: forward is after the split, the past is before it. The wall is the single-system viscosity `1/50 + (1/25)(gAB + gBA)`; the thin wall (both guards down) is `1/50` and the thick wall (both guards up) is `1/10`.

[TREE.md](TREE.md) connects the 37 statements. Each statement has its own page with the Lean statement as checked, plain-words versions in English, Español, Français, Deutsch, 中文, 日本語, العربية, हिन्दी and Português, and Lean/Unicode, ASCII and LaTeX forms. Only the Lean files are checked.

## Statements

Time reversal and ripple factors (14). For `v(t) = f(T - t)`, the chain rule gives `v'(t) = -f'(T - t)`; a viscous rate `ν lap` becomes `-ν lap`, and the whole scalar right-hand side changes sign. For a Laplacian eigenmode with eigenvalue `-q`, the forward factor `exp(-(ν*q)*t)` is at most 1 and the backward factor `exp((ν*q)*t)` is at least 1, strictly when `ν`, `q` and `t` are positive. Larger `q` is amplified at least as much backward. The two factors multiply to 1. A negative step reverses the rate; negating viscosity as well restores the forward increment.

The 0,0 split, shares, gap and freeze (9). Reversing around the split twice is the identity. Mentor + student = 1 is kept under reversal. Reflected through the split, the margin changes sign: a forward gap becomes a backward overlap of the same size, and a touch stays a touch. At tick 23 the student at 256 and the mentor at 200 give a gap of 56, which reflects to an overlap of 56. The tick 23 freeze is 0.8 after the split and, reversed, 0.8 before it. A change in the student's share is undone by the reversed change.

The wall (14). The wall equals `HugNavierSingle.viscosity` point by point. It lies in `[1/50, 1/10]`, and reversed in `[-1/10, -1/50]`. Reversal turns the wall term into the reversed wall term. Forward the wall only damps and backward it only amplifies; the thick wall damps and amplifies most. The wall factors multiply to 1. A backward step through the wall equals a forward step through the reversed wall. Counted from the split, what the wall takes forward and what the reversed wall gives backward are nonnegative, strictly positive for a nonzero ripple, and add without cancelling.

## Files

`ViscousTimeReversalDefinitions.lean` holds the definitions. `ViscousTimeReversalChallenge.lean` freezes the 37 statements and is excluded from the solution's imports. `ViscousTimeReversalProofs.lean` holds the proofs. `MentorStudentModel.lean` and `FullModel.lean` are copies with unchanged definitions; only comments differ from the sources, as recorded in [source-provenance.json](source-provenance.json). Definitions, statements, solution, copied models and dependency pins are hashed in `verification-inputs.json`.

From this directory, `lake build` builds the proofs. The repository's **Lean verification** workflow also compares the frozen statements, runs both kernels and checks the dependency lists of all 37 theorems.

## Scope

These statements concern the time change, the wall value and a single scalar ripple. They do not certify the full coupled Hug evolution, its numerical solver, threshold-1 histories, energy residuals, or Yang–Mills/readJet claims.

# Viscosity under time reversal

**Verification: NOT_RUN** for this revision. The [report](verification-report.json) records the status of Comparator, Lean’s kernel, nanoda and the default build.

## At a glance

This package does not assume that viscosity flips sign under time reversal: it proves why viscosity breaks time reversal, from the chain rule on real functions, and what the flip does to the flow. Forward, a ripple is only damped; backward, it is only amplified; finer ripples are amplified at least as much as coarser ones; and the forward and backward factors multiply to exactly 1. The damping, amplification and factor statements are also proved at the wall `1/50 + (1/25)(gAB + gBA)`, with time counted from the 0,0 split.

| Question | Answer |
| --- | --- |
| Shows that viscosity breaks time reversal | Yes |
| Shows why | Yes (proved, not assumed) |
| Shows what it does to the flow | Yes |
| Uses the wall and the 0,0 split | Yes |

This package states viscous time reversal in the mentor and student model. Time is counted from the 0,0 split at tick 2: forward is after the split, the past is before it. The wall is the single-system viscosity `1/50 + (1/25)(gAB + gBA)`: the thin wall (both guards down) is `1/50` and the thick wall (both guards up) is `1/10`.

The [tree](TREE.md) connects all 38 statements. Each statement has its own page with the Lean statement exactly as checked, plain-words versions in English, Español, Français, Deutsch, 中文, 日本語, العربية, हिन्दी and Português, and the statement in Lean/Unicode, ASCII and LaTeX. Only the Lean files are checked; the pages are reading aids.

## Statements

Time reversal and ripple factors (14): for `v(t) = f(T - t)`, the chain rule gives `v'(t) = -f'(T - t)`, so a viscous rate `ν lap` becomes `-ν lap` and the whole scalar right-hand side changes sign. For a Laplacian eigenmode with eigenvalue `-q`, the forward factor `exp(-(ν*q)*t)` is at most 1 and the backward factor `exp((ν*q)*t)` is at least 1 (strictly when `ν`, `q`, `t` are positive); larger `q` is amplified at least as much backward; the two factors multiply to 1; a negative step reverses the rate, and negating viscosity as well restores the forward increment.

The 0,0 split, shares, gap and freeze (10): reversing around the split twice is the identity; mentor + student = 1 is kept under reversal, including 0.2 and 0.8; read from the other side of the split, the margin changes sign, so a forward gap becomes a backward overlap of the same size and a touch stays a touch; at tick 23 the student at 256 and the mentor at 200 give a gap of 56 that reads backward as an overlap of 56; the tick 23 freeze sits 0.8 after the split and 0.8 before it when reversed; a change in the student's share is undone by the reversed change.

The wall (14): the wall equals `HugNavierSingle.viscosity` point by point; it lies in `[1/50, 1/10]` and reversed in `[-1/10, -1/50]`; reversal turns the wall term into the reversed wall term; forward the wall only damps and backward it only amplifies, with the thick wall damping and amplifying most; the wall factors multiply to 1; a backward step through the wall equals a forward step through the reversed wall; counted from the split, what the wall takes forward and what the reversed wall gives backward are nonnegative, strictly positive for a ripple that is there, and they add without cancelling.

## Files

`ViscousTimeReversalDefinitions.lean` holds the definitions, `ViscousTimeReversalChallenge.lean` freezes the 38 statements and is excluded from the solution's imports, and `ViscousTimeReversalProofs.lean` holds the proofs. `MentorStudentModel.lean` and `FullModel.lean` are unchanged copies; their sources and hashes are in [source-provenance.json](source-provenance.json). Definitions, statements, solution, copied models and dependency pins are hashed in `verification-inputs.json`.

From this directory, `lake build` builds the proofs. The repository's **Lean verification** workflow also compares the frozen statements, runs both kernels and checks the dependency lists of all 38 theorems.

## Scope

These statements concern the time change, the wall value and a single scalar ripple. They do not certify the full coupled Hug evolution, its numerical solver, threshold-1 histories, energy residuals, or Yang–Mills/readJet claims.

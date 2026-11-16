# Viscosity under time reversal

**Verification: PASS** for Comparator, Lean’s kernel, nanoda and the default build. All 37 configured statements passed in [GitHub run 43703185290](https://github.com/NousVolition/hug-sims-lean-proofs/actions/runs/43703185290); every statement depends only on `propext`, `Classical.choice` and `Quot.sound`. The [report](verification-report.json), [logs and axiom lists](evidence-linux/) and [checked revision and input hashes](evidence-linux/source.json) are saved in this package.

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

## Starts and the bucket rule (104)

These statements import the rules in `MentorStudentModel.lean` and use none of the time-reversal results above.

Prime ticks counted ahead and back. Counted back (place `-p`), the ticks are the same prime ticks as counted ahead (place `p`): one to one, index by index, with the same gaps for any step sizes. A back step is counted with whole numbers that may go below 0, so 2 back by 4 is `-2`. The back partners of 41, 23 and 11 are 37, 19, 17, 7 and 5, each matched with the tick counted ahead at the same index. Mentor + student = 1 at every tick.

Paired buckets. Two parts fill `k/5` and `(5 - k)/5`; a write moves one into the other and the pair keeps its total. An overlap move keeps both shares between 0 and 1 and their sum at 1. Either one may be ahead by at most one full start when the steps between ticks match, and which one is ahead can change at any tick.

The bucket rule. These hold for any finite type of parts, every share, every meeting and any number of meetings. A bucket is full: each part has a clean and a dirty amount, and all parts together make 1. Parts can be made of smaller parts. A meeting swaps some dirty amount for clean: each share stays the same, clean never falls and dirty never rises. Two full buckets meet into one full bucket with no order between them. Taken back out, both are full. The second holds only its own parts, with no more dirt than it brought. The first never has more dirt than it brought, and has strictly less where a meeting swapped some. The paired buckets are the two-part case.

Starts. A start at 0 is one full bucket whose parts are history parts and ahead parts, of any types. History and what is ahead are in the same bucket and together make 1, and a history may have any number of parts. The meeting at each prime tick, and all of them in order, act on a start by one rule, on history parts and ahead parts alike. Two starts meet at 0,0 into one full bucket, and each start's history and ahead parts are carried in at their shares.

## Files

`ViscousTimeReversalDefinitions.lean` holds the definitions. `ViscousTimeReversalChallenge.lean` freezes the 37 statements, and through `ViscousTimeReversalBucketChallenge.lean` the 104 statements on starts and the bucket rule; it is excluded from the solution's imports. `ViscousTimeReversalProofs.lean` holds the proofs, with those for starts and the bucket rule in `ViscousTimeReversalBucketProofs.lean` (definitions in `ViscousTimeReversalBucketDefinitions.lean`). `MentorStudentModel.lean` and `FullModel.lean` are copies with unchanged definitions; only comments differ from the sources, as recorded in [source-provenance.json](source-provenance.json). Definitions, statements, solution, copied models and dependency pins are hashed in `verification-inputs.json`.

From this directory, `lake build` builds the proofs. The repository's **Lean verification** workflow also compares the frozen statements, runs both kernels and checks the dependency lists of all 37 theorems. Its `proof-viscous-time-reversal-lean-1` artifact is saved unchanged in `evidence-linux/`.

## Scope

These statements concern the time change, the wall value and a single scalar ripple. They do not certify the full coupled Hug evolution, its numerical solver, threshold-1 histories, energy residuals, or Yang–Mills/readJet claims.

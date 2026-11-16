# Viscosity under time reversal

**Verification: PASS** for Comparator, Lean’s kernel, nanoda and the default build, for all 200 configured statements, in a local run on this package (not yet a GitHub run); every statement depends only on `propext`, `Classical.choice` and `Quot.sound`. The first 37 also passed in [GitHub run 43703185290](https://github.com/NousVolition/hug-sims-lean-proofs/actions/runs/43703185290). The [report](verification-report.json), [logs and axiom lists](evidence-linux/) and [input hashes](evidence-linux/source.json) are saved in this package.

## At a glance

The sign flip of viscosity under time reversal is proved, not assumed: it follows from the chain rule on real functions. Forward, a ripple is only damped; backward, it is only amplified; finer ripples are amplified at least as much as coarser ones; the forward and backward factors multiply to exactly 1. The damping, amplification and factor statements also hold at the wall `1/50 + (1/25)(gAB + gBA)`, with time counted from the 0,0 split.

| Question | Answer |
| --- | --- |
| Viscosity breaks time reversal | Yes |
| Why | Proved, not assumed |
| Effect on the flow | Yes |
| Stated at the wall and the 0,0 split | Yes |

## Model

Time is counted from the 0,0 split at tick 2: 0 holds the past and the future together, and forward and back are both counted from it. The wall is the single-system viscosity `1/50 + (1/25)(gAB + gBA)`; the thin wall (both guards down) is `1/50` and the thick wall (both guards up) is `1/10`.

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

## The meter, the guards and reversal (24)

These statements import the time-reversal results and the bucket rule above, and the guards `gAB` and `gBA` from `FullModel.lean`.

The meter. A meter reads from 0 to 5/5. A fill stops at 5/5 and an empty stops at 0, and any run of fills and empties stays in the meter. As in the penne diagram, there are two windows, A and B: when A hops, B stays fixed, and when B hops, A stays fixed. Both start full at the marked piece. Two full meters, 5/5 and 5/5, make 2 before the meeting at 0,0 and one full 5/5 bucket after it, for every placement; whatever the two meters read, the bucket they make stays in the meter. One round, A empties and fills and then B does, ends full again, and so does any number of rounds. There is no last round: after any run of hops, both windows fill back to 5/5 and more rounds follow.

The guards. When the two guard readings at a point are meter levels, the wall there, `HugNavierSingle.viscosity`, lies between the thin wall 1/50 and the thick wall 1/10, by `wall_between_thin_and_thick`. With both guards full the wall is the thick wall. Contact passes through the guards: the part of A's reaction that comes from B is `weightAB * gAB * (xB - xA)`, and B's is `weightBA * gBA * (xA - xB)`; with a guard at 0 that part is 0. Run backward around the split, both guards are read at the same reversed time, and so is the wall made from them.

Reversal on a whole. Run backward around the split, a bucket of any number of parts is still full, a start's history and what is ahead still make 1 together, the meters and their 0,0 bucket stay in the meter, and reversing twice gives each of them back.

Back ticks, 0 and the count through 0. For every prime tick in the schedule, the back tick at the same index is the same tick placed at `-p`; the forward tick is at time `i/10` and the back tick at the reversed time `-(i/10)`. At 0 a start holds its history and what is ahead together and reversal leaves it in place, and the forward and back ticks at index 0 are the same instant. One count runs over all whole numbers, back places below 0 and ahead places above 0, each step 1/10 with no break at 0. Reversal sends place `n` to place `-n`; at every place the forward and backward factors multiply to 1, the backward factor at `n` is the forward factor at `-n`, and the forward factor has its derivative there. Place `i` is the forward tick at index `i` and place `-i` is its back tick.

There is no reversal of the mentor alone; reversal acts on both sides together.

## The write, the remainder and the filter loop (15)

These statements show that a write conserves the overlap exactly, that the user's bucket never leaves the meter, that the filter loop settles geometrically at the chain's own rate, and that all of it is symmetric under reversal around the 0,0 split. At a write, the overlap is counted into the user's bucket as far as it fits (`keptOverlap`). What does not fit is the remainder. Bucket gain plus remainder is always the whole overlap, so nothing is lost. An overlap that fits leaves no remainder. An overlap bigger than the room fills the bucket: what goes in is `partnerSupply`, the bucket is at `afterWrite`, which is 1, and the rest is the remainder. The remainder goes out to be filtered and comes back to the user. What passes goes into the user's bucket, as far as it fits, and what is still not settled goes back to be filtered again. Each pass keeps the remainder plus what has passed the same. The bucket gains exactly what passes and stays between 0 and 5/5 through any number of passes, also with a fill or an empty on the meter before each pass. A filter that passes a fixed share each pass leaves that share's complement, to the power of the number of passes, times the start. With the chain's own rate as the share, `loss` 1/5 passed and `keep` 4/5 left, that is `held n`, so `(4/5)^n`, times the start. This holds while the bucket has room for the whole remainder. The remainder then goes to 0 and the total passed goes to everything that went out, so the loop settles. Run backward around the split, the loop has the same totals and stays in the meter, and reversing twice returns it.

The writes are at ticks 11, 23 and 41. The first write is tick 11, at time 0.4. The freeze follows it at tick 23, time 0.8, after 200 mentor steps and 256 student steps. Closing the gap at the freeze, the mentor moves 4/5 of it and the student 1/5. These are the same proportions as the chain's `keep` of 4/5 and `loss` of 1/5. The shared total is kept, and 2/25 of the squared gap is given off. Sources: `MentorStudentModel.lean`, `ViscousTimeReversalBucketDefinitions.lean`, `../HugWallPush/HugWallPushDefinitions.lean`, `../HugWallPush/HugWallPushProofs.lean`.

## A discrete Poincaré–Wirtinger inequality on a path (5)

**Statement.** For `f : ℕ → ℝ` and a path of `n` points with `∑_{i<n} f i = 0`, `2 * ∑_{i<n} f(i)^2 ≤ n (n-1) * ∑_{k<n-1} (f(k+1) - f(k))^2`. Equivalently, the Dirichlet form of the path Laplacian is at least `2 / (n(n-1))` times the squared norm on mean-zero data. This gives a floor for mean-zero ripples on a path, in the setting of the forward and backward factors above. **The mean has no gap** (`mean_has_no_gap`): for every `n ≥ 1` and every constant `C`, the inequality `∑ f² ≤ C · Dirichlet(f)` fails for the constants. The proof uses `telescope` (a change is the sum of the steps between), `step_bound` (any squared difference on the path is at most `(n-1)` times the Dirichlet energy) and `pair_sum` (`∑_i ∑_j (f i - f j)^2 = 2n ∑ f^2 - 2(∑ f)^2`).

**Scope and limits.** *Not sharp:* the sharp constant is `1/λ₁` with `λ₁ = 4 sin²(π/(2n))`, about `n²/π²`. The proved constant `n(n-1)/2` is larger by roughly a factor `π²/2 ≈ 4.9` for large `n` (n = 64: 2016 versus 415). A sharp version needs the discrete Fourier transform. *Path, not cycle:* free (Neumann) ends; the periodic version is not included. *Use:* the inequality is the step that turns the energy identity of a discrete diffusion `u' = ν Δ_h u` into exponential decay of the mean-zero part, while the mean is conserved and does not decay; that step is not itself proved here. Source: `discrete-poincare-lean/Poincare.lean`.

## The sharp discrete Wirtinger inequality on a cycle (15)

**Theorem (`wirtinger`).** For `f : ZMod n → ℝ` with `∑ j, f j = 0`, `(2 - 2 cos (2π/n)) * ∑ j, f j ^ 2 ≤ ∑ j, (f (j + 1) - f j) ^ 2`.

**Sharpness (`wirtinger_sharp`).** For `n ≥ 3`, `f j = cos (2π j / n)` has mean zero and gives equality, so `2 - 2 cos (2π/n) = 4 sin²(π/n)` is the best constant: the smallest nonzero eigenvalue of the cycle Laplacian. (For `n = 2` every mean-zero `f` gives equality.) This is the classical discrete Wirtinger inequality (Fan, Taussky and Todd, 1955), here with a machine-checkable proof, by the discrete Fourier transform.

| Lemma | Content |
|---|---|
| `ortho` | `∑ₖ e(k m) = n` if `m = 0`, else `0` (from `AddChar.sum_mulShift` and `ZMod.isPrimitive_stdAddChar`) |
| `conj_e`, `fourier_neg` | `conj e(x) = e(-x)`; for real data `F(-k) = conj F(k)` |
| `parseval`, `parseval_real` | `∑ₖ |F k|² = n ∑ⱼ f j ²` |
| `fourier_step` | the step `j ↦ f(j+1) - f(j)` multiplies `F k` by `e(-k) - 1` |
| `normSq_e_sub_one`, `normSq_e_neg_sub_one` | `|e(±k) - 1|² = 2 - 2 cos(2π k/n)` |
| `cos_step`, `cos_le` | for `k ≠ 0`, `cos(2π k/n) ≤ cos(2π/n)` |
| `re_sq`, `sum_re_sq` | `∑ⱼ (Re (e(j) w))² = n |w|²/2` when `2 ≠ 0` in `ZMod n` (used for the equality case) |

Here `e = ZMod.stdAddChar`, `e(j) = exp(2πi j/n)`, and `F k = ∑ⱼ f j · e(j k)`.

Numerical check outside Lean: the inequality holds on random mean-zero data for `n = 1 … 59`, the cosine attains equality for `n ≥ 3`, and Parseval holds.

**Related.** `discrete-poincare-lean` proves an elementary, non-sharp inequality for the path (free ends) with constant `n(n-1)/2`. The sharp path constant `1/(4 sin²(π/(2n)))` needs the cosine transform and is not included.

Source: `cycle-wirtinger-lean/Wirtinger.lean`, with two proof-only repairs for this Mathlib (`ortho` and one type annotation in `wirtinger_sharp`), recorded in [source-provenance.json](source-provenance.json).

## Files

`ViscousTimeReversalDefinitions.lean` holds the definitions. `ViscousTimeReversalWirtingerChallenge.lean` freezes all 200 statements: through `ViscousTimeReversalPoincareChallenge.lean` the first 185, and the 15 on the sharp discrete Wirtinger inequality on a cycle (definitions in `ViscousTimeReversalWirtingerDefinitions.lean`, proofs in `ViscousTimeReversalWirtingerProofs.lean`, the solution). `ViscousTimeReversalPoincareChallenge.lean` holds, through `ViscousTimeReversalFilterChallenge.lean` the first 180, and the 5 on the discrete Poincaré–Wirtinger inequality (definition in `ViscousTimeReversalPoincareDefinitions.lean`, proofs in `ViscousTimeReversalPoincareProofs.lean`). `ViscousTimeReversalFilterChallenge.lean` holds, through `ViscousTimeReversalMeterChallenge.lean`, the first 165, of which `ViscousTimeReversalChallenge.lean` holds the first 141, and the 15 on the write, the remainder, the filter loop and the freeze. The 24 on the meter, the guards and reversal have definitions in `ViscousTimeReversalMeterDefinitions.lean` and proofs in `ViscousTimeReversalMeterProofs.lean`. The 15 on the filter loop and the freeze have definitions in `ViscousTimeReversalFilterDefinitions.lean` and proofs in `ViscousTimeReversalFilterProofs.lean`. `ViscousTimeReversalChallenge.lean` freezes the 37 statements, and through `ViscousTimeReversalBucketChallenge.lean` the 104 statements on starts and the bucket rule; it is excluded from the solution's imports. `ViscousTimeReversalProofs.lean` holds the proofs, with those for starts and the bucket rule in `ViscousTimeReversalBucketProofs.lean` (definitions in `ViscousTimeReversalBucketDefinitions.lean`). `MentorStudentModel.lean` and `FullModel.lean` are copies with unchanged definitions; only comments differ from the sources. `HugWallPushDefinitions.lean`, `HugWallPushProofs.lean` and the six `V3Source*.lean` files are byte-for-byte copies so the package builds on its own, as recorded in [source-provenance.json](source-provenance.json). Definitions, statements, solution, copied models and dependency pins are hashed in `verification-inputs.json`.

From this directory, `lake build` builds the proofs. The repository's **Lean verification** workflow also compares the frozen statements, runs both kernels and checks the dependency lists of all 200 theorems. `evidence-linux/` now holds the local run of those same steps; the GitHub artifact for the first 37 is in git history.

## Scope

These statements concern the time change, the wall value and a single scalar ripple. They do not certify the full coupled Hug evolution, its numerical solver, threshold-1 histories, energy residuals, or Yang–Mills/readJet claims.

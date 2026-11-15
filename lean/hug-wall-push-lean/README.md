# The wall, the push, and the balance at tick 23

Seven groups of results about the latest ideas in the Hug framework. Every proof is complete: there is no `sorry`, and nothing beyond Lean's three standard axioms (`propext`, `Classical.choice`, `Quot.sound`) is used. The package pins the same Lean (`v4.34.0-rc2`) and Mathlib (`85e3a25e…`) as the other packages.

**Verification: PASS** for Comparator, Lean’s kernel, nanoda and the default build. All 52 configured statements passed in [GitHub run 43708345457](https://github.com/NousVolition/hug-sims-lean-proofs/actions/runs/43708345457); every statement depends only on `propext`, `Classical.choice` and `Quot.sound`. The [report](verification-report.json), [logs and axiom lists](evidence-linux/) and [checked revision and input hashes](evidence-linux/source.json) are saved in this package.

## 1. The wall (`a` as viscosity)

On a periodic grid, with any thickness at each face (zero or more):

- `wall_total_zero`: what the wall does adds up to exactly zero over the grid, so the wall never moves the whole grid.
- `wall_energy`, `wall_only_takes`: the wall only takes motion away, by exactly the heat it makes (thickness × speed difference², added over every face).
- `grid_total_zero`, `grid_energy`: the same holds with walls in several directions at once, as on a 3D grid.
- `wall_keeps_total`, `count_closes`: the same in time. The total has rate zero, and motion plus heat has rate zero, so the count closes.

## 2. The push (the A/S, one fixed direction)

- `push_changes_total`: with the wall and a push `−σ a` in one fixed direction, the grid's total changes by exactly the push's total. The wall adds nothing.
- `push_moves_one_way`: if the activation is never negative and any cell is over the threshold, the total moves one way, whatever the wall's thickness.
- `balanced_push_keeps_total`: only a push whose total is zero leaves the grid's total alone.
- `push_moves_box`: the same in time.

## 3. Two sides meeting at balance (tick 23)

Mentor (side A) and user (side B), joined by a wall of thickness `k`:

- `sideA_deriv`, `sideB_deriv`: each side moves toward the other at rate `k` × the difference.
- `average_fixed`: their average never moves.
- `difference_fades`: their difference fades as `exp(−2kt)`.
- `thicker_balances_faster`: a thicker wall balances them faster.
- `two_sides_count_closes`, `twoSideHeat_deriv`, `twoSideHeat_nonneg`: the motion lost equals the heat made, at rate `k` × difference², so motion plus heat stays fixed.

## 4. The floor of the tanh dip

- `dip_floor`: the tanh response `q(1 + tanh(q/ε))/2` never goes below `−ε/(2e)`, about `−0.184ε`. The true lowest point, `−0.139ε` at `q = −0.639ε`, is a computed number. The proved floor is the clean bound just below it.
- `total_viscosity_never_negative`: if the base viscosity is at least `σε/(2e)`, the total viscosity is never negative, so nothing runs backward.

## 5. The record with a delayed baseline, and with a frozen one

The record steps as A(n+1) = A(n) + γh × (breath now − baseline), the stepped form of A′ = γ(U − U_baseline).

- `delayed_baseline_record`: if the baseline is the breath from m steps back (the delay), the record is always its start plus γh × (the last m steps of the breath added up − the first m added up). `breath_telescopes` is the counting step behind it.
- `delayed_baseline_bounded`: if the breath stays between lo and hi, the record never moves more than γh × m × (hi − lo) from where it started, so it can't pile up.
- `frozen_baseline_fills`: if the baseline is frozen and the breath stays at least c above it, the record grows by at least γhc every step. It only breathes in, which is what the runs did.

## 6. Your clock in the two sides

The mentor takes 25 steps and the student 32 per prime tick (1/10 of model time), both starting at 0. The freeze sits at tick 23, time 0.8. The shares 0.2 (mentor) and 0.8 (student) are used as each side's weight in the balance.

- `freeze_step_counts`: at the freeze, the mentor has taken 200 steps and the student 256.
- `clocks_meet_at_ticks`: the two clocks land on the same instant only at whole prime ticks (mentor step 25n with student step 32n), because 25 and 32 share no factor.
- `shares_whole`, `balance_between`, `gap_split`: the shares make the whole, the balance point lies between the two sides, and closing the gap moves the mentor 0.8 of it and the student 0.2.
- `freeze_keeps_total`: closing the gap keeps the shared total.
- `freeze_gives_off`, `freeze_gives_off_nonneg`: closing the gap gives off exactly (0.2 × 0.8)/2 = 2/25 of the squared gap, never negative.

## 7. Your clay wall

From your clay hug (`studies/hug-breakdown/hug_breakdown.py`): the clay pushes back on the fluid with the drag −K·g·χ·u, where K = 1/η is the hug's pushback, g the clay's integrity and χ the clay band. The integrity takes the exact step g ↦ b/(a+b) + (g − b/(a+b))·exp(−(a+b)·dt), with a = yield rate × S where fluid pushes through faster than the yield speed and b = recover rate × (1 − S) elsewhere.

- `clay_energy`, `clayHeat_nonneg`: what the clay takes from the motion is exactly K·g·χ·u² added up, which it gives off as heat, never negative.
- `wall_clay_energy`: wall and clay together take exactly the wall's heat plus the clay's heat.
- `clay_push_total`: with the wall, the push and the clay, the total of the grid changes at rate −σΣa − KΣgχu. The wall adds nothing to that, and the clay acts on the speed itself.
- `uniform_box_rate`, `clay_brakes_box`, `uniform_box_toward_settling`: when the whole box moves together at speed U, the rate is −(KΣgχ) × (U − settling speed), with settling speed −σΣa/(KΣgχ). So the clay brakes the whole box toward that speed, which the wall alone cannot do (section 2).
- `boxSpeed_deriv`, `boxSpeed_settles`: a box speed V(t) = Vs + (V0 − Vs)·exp(−ct) changes at rate −c × (V − Vs), and for c ≥ 0 it never gets further from Vs than it started. With c = KΣgχ, that is the box under the clay against a steady push.
- `broken_clay_no_brake`: where the clay has fully given way (g = 0 everywhere), the brake is gone and the push moves the total exactly as with the wall alone.
- `integrity_stays`: the exact integrity step keeps g between 0 and 1.
- `integrity_yields`: where fluid pushes through and nothing recovers (b = 0), each step multiplies g by exp(−a·dt), so the clay only gives way.
- `integrity_recovers`: where nothing pushes through (a = 0), each step is g ↦ 1 + (g − 1)·exp(−b·dt), so the clay heals toward 1.

Heat here is just heat: the energy given off.

## Files

`HugWallPushDefinitions.lean` holds the definitions. `HugWallPushChallenge.lean` freezes the 52 statements and is excluded from the solution's imports. `HugWallPushProofs.lean` holds the proofs. Definitions, statements, solution and dependency pins are hashed in `verification-inputs.json`.

From this directory, `lake build` builds the proofs. The repository's **Lean verification** workflow also compares the frozen statements, runs both kernels and checks the dependency lists of all 52 theorems. Its `proof-hug-wall-push-lean-1` artifact is saved unchanged in `evidence-linux/`.

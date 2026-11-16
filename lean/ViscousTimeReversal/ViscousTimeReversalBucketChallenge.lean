import Mathlib.Tactic
import MentorStudentModel
import HugWallPushProofs
import V3SourceSystem
import ViscousTimeReversalBucketDefinitions

/-! Statements for prime ticks counted ahead and back, the paired buckets and the general bucket rule. -/

section

/-! Prime ticks counted ahead and back.

Every rule used here comes from `MentorStudentModel.lean` in this package:
`sharedWhole` (l.26), `mentorOf` (l.31), `Placement` (l.35-41), `primeLabel` and `labels`
(l.51-54), `Tick` and `schedule` (l.56-64), `gap` (l.67), `keep`, `loss`, `held` (l.121-127),
`partnerSupply`, `afterWrite` (l.130-133), `writeTicks` (l.136), `beforeSplit` (l.151),
`splitEvent` (l.155), `Freeze` (l.159-160), `Direction` (l.163-165), `partnerGaps` (l.169),
`opening` (l.172-174), `primePartners` (l.177-179), `moveOverlap` (l.183),
`lastWrite`, `heldAt` (l.192-196). -/

namespace ViscousTimeReversal

open MentorStudent

/-! ## The prime ticks -/

theorem labels_eq : labels = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41] := by
  sorry

theorem two_le_of_primeLabel {p : Nat} (h : primeLabel p = true) : 2 ≤ p := by
  sorry

/-! ## Statement 4's dial: the step sizes -/

theorem scheduleWith_32_25 : scheduleWith 32 25 = schedule := by
  sorry

theorem scheduleWith_get (a b i : Nat) :
    (scheduleWith a b)[i]? = labels[i]?.map (fun p => (⟨p, a * i, b * i, 100000 * i⟩ : Tick)) := by
  sorry

/-! ## Statement 1: the past side runs on the same prime ticks -/

theorem pastSchedule_get (a b i : Nat) :
    (pastSchedule a b)[i]? = labels[i]?.map
      (fun p => ((⟨p, a * i, b * i, 100000 * i⟩ : Tick), place .past p)) := by
  sorry

/-- Same index, same tick: the past tick at index `i` is the forward tick at index `i`. -/
theorem past_same_ticks (a b i : Nat) :
    ((pastSchedule a b)[i]?).map (·.1) = (scheduleWith a b)[i]? := by
  sorry

/-- One to one: a past tick exists at index `i` exactly when a forward tick does. -/
theorem past_one_to_one (a b i : Nat) :
    ((pastSchedule a b)[i]?).isSome = ((scheduleWith a b)[i]?).isSome := by
  sorry

theorem past_length (a b : Nat) : (pastSchedule a b).length = (scheduleWith a b).length := by
  sorry

/-- Every tick counted back has a place below 0. -/
theorem past_place_negative (a b i : Nat) (x : Tick × ℤ) (h : (pastSchedule a b)[i]? = some x) :
    x.2 < 0 := by
  sorry

/-- Counted back from 0: a later index has a lower place. -/
theorem past_counts_back (a b i j : Nat) (x y : Tick × ℤ)
    (hx : (pastSchedule a b)[i]? = some x) (hy : (pastSchedule a b)[j]? = some y) (hij : i < j) :
    y.2 < x.2 := by
  sorry

/-! ## Statement 2: partners match ahead and back -/

/-- `q` is a back partner of `p` at gap `k` exactly when `p` is a forward partner of `q` at
    gap `k` (both prime ticks). -/
theorem partners_match (p q k : Nat) (hp : primeLabel p = true) (hq : primeLabel q = true) :
    (k, Direction.back, q) ∈ primePartners p ↔ (k, Direction.forward, p) ∈ primePartners q := by
  sorry

/-! ## Statement 3: mentor + student = 1 at every past prime tick -/

theorem past_shares_one (a b i : Nat) (x : Tick × ℤ) (_h : (pastSchedule a b)[i]? = some x)
    (pl : Placement) : pl.mentor + pl.student = 1 := by
  sorry

/-- Two starts make 2 before they meet (`beforeSplit`); met at 0,0 they make 1 (`splitEvent`). -/
theorem shares_across_split : beforeSplit = 2 ∧ ∀ s : ℚ, splitEvent s = 1 := by
  sorry

/-! ## Statement 4: past steps use the same dial -/

/-- Past travellers step the same way: the past gap equals the forward gap, for any dial. -/
theorem past_gap_same (a b i : Nat) : pastGapAt a b i = gapAt a b i := by
  sorry

theorem past_gap_value (a b i g : Nat) (h : pastGapAt a b i = some g) : g = (a - b) * i := by
  sorry

/-- The past gap grows with the index, as the forward one does (no sign flip). -/
theorem past_gap_grows (a b i j gi gj : Nat) (hi : pastGapAt a b i = some gi)
    (hj : pastGapAt a b j = some gj) (hij : i ≤ j) : gi ≤ gj := by
  sorry

theorem gapZ_value (a b i : Nat) : gapZ a b i = ((a : ℤ) - b) * i := by
  sorry

theorem past_gapZ_same (a b i g : Nat) (h : pastGapAt a b i = some g) (hba : b ≤ a) :
    (g : ℤ) = gapZ a b i := by
  sorry

/-! ## Statement 5: the past record is fixed -/

theorem past_record_fixed (n : Nat) (s : TwoSides) :
    (forwardTick^[n] s).pastRecord = s.pastRecord := by
  sorry

theorem forward_runs_held (n : Nat) (r : Nat → ℚ) :
    (forwardTick^[n] ⟨1, r⟩).forwardHeld = held n := by
  sorry

/-! ## Statement 6: the loss is a dial -/

theorem heldDial_one (n : Nat) : heldDial 1 n = held n := by
  sorry

theorem heldDial_formula (k : Fin 6) (n : Nat) : heldDial k n = (1 - lossDial k) ^ n := by
  sorry

theorem heldDial_pos (k : Fin 6) (hk : k.val < 5) (n : Nat) : 0 < heldDial k n := by
  sorry

theorem heldDial_five_zero (n : Nat) : heldDial 5 (n + 1) = 0 := by
  sorry

theorem own_dial_forward (d : Dials) (k : Fin 6) (n : Nat) :
    sideHeld { d with past := k } .forward n = sideHeld d .forward n := by
  sorry

theorem own_dial_past (d : Dials) (k : Fin 6) (n : Nat) :
    sideHeld { d with forward := k } .past n = sideHeld d .past n := by
  sorry

/-- One side at 5/5 is at 0 after one tick; the other side, on a dial below 5, stays above 0. -/
theorem past_five_forward_pos (d : Dials) (hp : d.past = 5) (hf : d.forward.val < 5) (n : Nat) :
    sideHeld d .past (n + 1) = 0 ∧ 0 < sideHeld d .forward (n + 1) := by
  sorry

theorem forward_five_past_pos (d : Dials) (hf : d.forward = 5) (hp : d.past.val < 5) (n : Nat) :
    sideHeld d .forward (n + 1) = 0 ∧ 0 < sideHeld d .past (n + 1) := by
  sorry

/-! ## Statement 7: no loss at a write tick (the rule chosen for this check) -/

theorem afterWrite_one (h : ℚ) : afterWrite h = 1 := by
  sorry

/-- The imported `heldAt` is 1 at every write tick. -/
theorem heldAt_write (i : Nat) (hw : isWrite i = true) : heldAt i = 1 := by
  sorry

theorem runHeld_bounds (k : Fin 6) (i : Nat) : 0 ≤ runHeld k i ∧ runHeld k i ≤ 1 := by
  sorry

/-- At a write tick held does not lose: it becomes 1, never below what it was. -/
theorem write_no_loss (k : Fin 6) (i : Nat) (hw : isWrite (i + 1) = true) :
    runHeld k (i + 1) = 1 ∧ runHeld k i ≤ runHeld k (i + 1) := by
  sorry

/-! ## Statement 8: freeze ticks 41, 23 and 11 -/

theorem freezeAt_23 (pl : Placement) (i : Nat) : FreezeAt pl i 23 ↔ Freeze pl i := by
  sorry

theorem freezePartners_are_writes (t : Nat) : t ∈ freezePartners ↔ t ∈ writeTicks := by
  sorry

/-- Each freeze partner is a freeze, and the same tick counted back sits at the same index, at
    place `-t`, with mentor + student = 1 there. -/
theorem freeze_partners (pl : Placement) (t : Nat) (ht : t ∈ freezePartners) :
    ∃ i, FreezeAt pl i t ∧
      ((pastSchedule 32 25)[i]?).map (fun (x : Tick × ℤ) => (x.1.label, x.2)) = some (t, place .past t) ∧
      pl.mentor + pl.student = 1 := by
  sorry

/-! ## Back openings counted below 0 -/

theorem backStep_eq_opening (p k : Nat) (h : k ≤ p) :
    backStep p k = (opening p k .back : ℤ) := by
  sorry

theorem backStep_below_zero (p k : Nat) (h : p < k) : backStep p k = place .past (k - p) := by
  sorry

/-- A back partner of a prime tick is both: a step back along the prime ticks (`q < p`, with no
    flooring), and a prime tick counted back at the same index as the forward tick `q`. -/
theorem back_partner_both (a b p k q : Nat) (hp : p ∈ labels)
    (h : (k, Direction.back, q) ∈ primePartners p) :
    q < p ∧ backStep p k = q ∧ ∃ i : Nat, labels[i]? = some q ∧
      ((pastSchedule a b)[i]?).map (fun (x : Tick × ℤ) => (x.1.label, x.2)) = some (q, place .past q) ∧
      ((scheduleWith a b)[i]?).map Tick.label = some q := by
  sorry

/-! ## Shares after an overlap move, from `mentorOf`, `splitEvent` and `moveOverlap` -/

/-- `s` and `mentorOf s` add to 1. -/
theorem shares_in_out (s : ℚ) : s + mentorOf s = 1 := by
  sorry

theorem shares_split (s : ℚ) : splitEvent s = 1 := by
  sorry

theorem shares_both_sides (_ : Side) (pl : Placement) : pl.student + pl.mentor = 1 := by
  sorry

theorem shares_after_move (s d : ℚ) : (moveOverlap s d).1 + (moveOverlap s d).2 = 1 := by
  sorry

/-- After any run of overlaps, the shares still add to 1. -/
theorem shares_returns (s : ℚ) (ds : List ℚ) :
    (ds.foldl (fun (x : ℚ × ℚ) d => moveOverlap x.1 d) (s, mentorOf s)).1 +
    (ds.foldl (fun (x : ℚ × ℚ) d => moveOverlap x.1 d) (s, mentorOf s)).2 = 1 := by
  sorry

end ViscousTimeReversal

end

section

/-! Paired buckets, partners past tick 41, the breath, and the one-start lead. -/

namespace ViscousTimeReversal

open MentorStudent

/-! ## Paired buckets -/

theorem dialPair_total (k : Fin 6) : (dialPair k).1 + (dialPair k).2 = 1 := by
  sorry

theorem triageMove_total (k : Fin 6) (x : ℚ × ℚ) :
    (triageMove k x).1 + (triageMove k x).2 = x.1 + x.2 := by
  sorry

/-- A partner step never fills the first bucket. -/
theorem triageMove_no_fill (k : Fin 6) (x : ℚ × ℚ) (h : 0 ≤ x.1) : (triageMove k x).1 ≤ x.1 := by
  sorry

/-- With no writes, the first bucket follows `heldDial` and the partner holds the rest. -/
theorem triageMove_runs (k : Fin 6) (n : Nat) :
    (triageMove k)^[n] (1, 0) = (heldDial k n, 1 - heldDial k n) := by
  sorry

theorem writeMove_total (x : ℚ × ℚ) : (writeMove x).1 + (writeMove x).2 = x.1 + x.2 := by
  sorry

/-- What the first bucket gains is exactly what the partner loses, never more than it had. -/
theorem writeMove_from_partner (x : ℚ × ℚ) :
    (writeMove x).1 - x.1 = x.2 - (writeMove x).2 ∧ (writeMove x).1 - x.1 ≤ x.2 ∧
      0 ≤ (writeMove x).2 := by
  sorry

/-- A partner at 0 gives nothing: the bucket does not fill from nothing. -/
theorem writeMove_empty_partner (x : ℚ) (h : x ≤ 1) : writeMove (x, 0) = (x, 0) := by
  sorry

/-- On a pair adding to 1, the write gives the imported `afterWrite` value and empties the partner. -/
theorem writeMove_afterWrite (h : ℚ) : writeMove (h, 1 - h) = (afterWrite h, 0) := by
  sorry

/-- The first bucket is `runHeld`, the partner holds the rest. -/
theorem runPair_eq (k : Fin 6) (i : Nat) : runPair k i = (runHeld k i, 1 - runHeld k i) := by
  sorry

theorem runPair_total (k : Fin 6) (i : Nat) : (runPair k i).1 + (runPair k i).2 = 1 := by
  sorry

theorem runPair_bounds (k : Fin 6) (i : Nat) :
    0 ≤ (runPair k i).1 ∧ (runPair k i).1 ≤ 1 ∧ 0 ≤ (runPair k i).2 ∧ (runPair k i).2 ≤ 1 := by
  sorry

theorem runPair_write (k : Fin 6) (i : Nat) (hw : isWrite (i + 1) = true) :
    runPair k (i + 1) = (1, 0) := by
  sorry

theorem sidePair_own_forward (d : Dials) (k : Fin 6) (i : Nat) :
    sidePair { d with past := k } .forward i = sidePair d .forward i := by
  sorry

theorem sidePair_own_past (d : Dials) (k : Fin 6) (i : Nat) :
    sidePair { d with forward := k } .past i = sidePair d .past i := by
  sorry

/-! ## Partners past tick 41 -/

theorem resolve_keeps (p : Nat) (x : Nat × Direction × Nat) (h : x.2.2 ∈ labels) :
    resolve p x = some x := by
  sorry

/-- Every partner of every labelled tick resolves to a partner on a labelled tick. -/
theorem resolve_lands : ∀ p ∈ labels, ∀ x ∈ primePartners p,
    (resolve p x).any (fun y => decide (y.2.2 ∈ labels) && decide (y ∈ primePartners p)) = true := by
  sorry

/-- Continuing from the forward tick or from the back tick carries the same: same two ticks,
    same gap, same overlap, and the same shares after the overlap moves. -/
theorem same_either_way (p q k : Nat) (hp : primeLabel p = true) (hq : primeLabel q = true)
    (h : (k, Direction.back, q) ∈ primePartners p) (s d : ℚ) :
    (k, Direction.forward, p) ∈ primePartners q ∧
      carried p (k, .back, q) d = carried q (k, .forward, p) d ∧
      moveOverlap s d = moveOverlap s d := by
  sorry

/-! ## Statement 10: the breath -/

theorem moveWithin_shares (p : Placement) (d : ℚ) :
    (moveWithin p d).mentor + (moveWithin p d).student = 1 := by
  sorry

theorem moveWithin_mentor (p : Placement) (d : ℚ) :
    (moveWithin p d).mentor = (moveOverlap p.student (keptOverlap p.student d)).2 ∧
      0 ≤ (moveWithin p d).mentor := by
  sorry

theorem moveWithin_fits (p : Placement) (d : ℚ) (h0 : 0 ≤ p.student + d)
    (h1 : p.student + d ≤ 1) : (moveWithin p d).student = (moveOverlap p.student d).1 := by
  sorry

/-- Heat given off when the gap closes with the student's share `s` and the mentor's
    `mentorOf s` as the weights. -/
theorem breath_heat (s : ℚ) (xM xS : ℝ) :
    ((mentorOf s : ℝ) * xM ^ 2 + (s : ℝ) * xS ^ 2) / 2
      - ((mentorOf s : ℝ) + s) * ((mentorOf s : ℝ) * xM + s * xS) ^ 2 / 2
      = (s : ℝ) * (mentorOf s : ℝ) / 2 * (xS - xM) ^ 2 := by
  sorry

/-- At the freeze shares (student 4/5, mentor 1/5) this is the imported `freeze_gives_off`: 2/25 of the
    squared gap. -/
theorem breath_heat_freeze (xM xS : ℝ) :
    ((mentorOf (4 / 5) : ℝ) * xM ^ 2 + ((4 / 5 : ℚ) : ℝ) * xS ^ 2) / 2
      - ((mentorOf (4 / 5) : ℝ) + ((4 / 5 : ℚ) : ℝ)) *
        ((mentorOf (4 / 5) : ℝ) * xM + ((4 / 5 : ℚ) : ℝ) * xS) ^ 2 / 2
      = (1 / 5 * xM ^ 2 + 4 / 5 * xS ^ 2) / 2 - (1 / 5 + 4 / 5) * HugWallPush.balance xM xS ^ 2 / 2
      ∧ (1 / 5 * xM ^ 2 + 4 / 5 * xS ^ 2) / 2 - (1 / 5 + 4 / 5) * HugWallPush.balance xM xS ^ 2 / 2
      = 2 / 25 * (xS - xM) ^ 2 := by
  sorry

/-- For every placement the heat is never negative. -/
theorem breath_heat_nonneg (p : Placement) (xM xS : ℝ) :
    0 ≤ (p.student : ℝ) * (p.mentor : ℝ) / 2 * (xS - xM) ^ 2 := by
  sorry

/-- The clay: what it does to the motion is minus the heat it makes, and the heat is never
    negative (the imported `clay_energy`, `clayHeat_nonneg`). -/
theorem breath_clay {G : Type*} [AddCommGroup G] [Fintype G] (K : ℝ) (g χ u : G → ℝ)
    (hK : 0 ≤ K) (hg : ∀ i, 0 ≤ g i) (hχ : ∀ i, 0 ≤ χ i) :
    ∑ i, u i * HugWallPush.clayDrag K g χ u i = -HugWallPush.clayHeat K g χ u ∧
      0 ≤ HugWallPush.clayHeat K g χ u := by
  sorry

/-- The write ticks 11, 23, 41 sit at tick times 0.4, 0.8, 1.2: the write times `time 2`,
    `time 3`, `time 4`. -/
theorem write_times :
    writeTicks.map (fun t => ((labels.idxOf t : ℕ) : ℝ) / 10) =
      [HugV3.Source.time 2, HugV3.Source.time 3, HugV3.Source.time 4] := by
  sorry

/-- The write at 0.8 in the imported record adds heat. -/
theorem write_08_heat : ((secondWrite.time : ℚ) : ℝ) = HugV3.Source.time 3 ∧
    0 < secondWrite.heat ∧ beforeWrite23.heat < afterWrite23.heat := by
  sorry

/-! ## One full start ahead, found from the overlap -/

theorem lead_from_overlap (s d : ℚ) :
    (lead s d = 1 ↔ 0 < d) ∧ (lead s d = -1 ↔ d < 0) ∧ (lead s d = 0 ↔ d = 0) := by
  sorry

/-- The steps between ticks match: 32 student steps and 25 mentor steps both make 1/10. -/
theorem steps_between_match :
    (32 : ℚ) * HugWallPush.studentStep = 1 / 10 ∧ (25 : ℚ) * HugWallPush.mentorStep = 1 / 10 := by
  sorry

theorem lead_values (s d : ℚ) : lead s d = 1 ∨ lead s d = -1 ∨ lead s d = 0 := by
  sorry

/-- The time gap at every tick is the lead over 10, whatever the shares and overlaps. -/
theorem time_gap (shares overlaps : ℕ → ℚ) (i : ℕ) :
    studentTime shares overlaps i - mentorTime shares overlaps i =
      (lead (shares i) (overlaps i) : ℚ) / 10 := by
  sorry

/-- At every tick either one is at most one full start (1/10) ahead. -/
theorem one_full_start (shares overlaps : ℕ → ℚ) (i : ℕ) :
    |studentTime shares overlaps i - mentorTime shares overlaps i| ≤ 1 / 10 := by
  sorry

/-- Between ticks each side moves one tick (1/10) plus the change in its own start. -/
theorem steps_per_tick (shares overlaps : ℕ → ℚ) (i : ℕ) :
    studentTime shares overlaps (i + 1) - studentTime shares overlaps i =
      1 / 10 + ((studentStart (shares (i + 1)) (overlaps (i + 1)) : ℚ) -
        studentStart (shares i) (overlaps i)) / 10 ∧
    mentorTime shares overlaps (i + 1) - mentorTime shares overlaps i =
      1 / 10 + ((mentorStart (shares (i + 1)) (overlaps (i + 1)) : ℚ) -
        mentorStart (shares i) (overlaps i)) / 10 := by
  sorry

end ViscousTimeReversal

end

section

/-! The general bucket rule. -/

namespace ViscousTimeReversal

open MentorStudent

open scoped BigOperators

/-! ## Buckets -/

variable {ι : Type*} [Fintype ι]

theorem Bucket.share_sum (b : Bucket ι) : ∑ i, b.share i = 1 := by
  sorry

theorem Bucket.share_nonneg (b : Bucket ι) (i : ι) : 0 ≤ b.share i := by
  sorry

/-! ## Parts made of smaller parts -/

theorem Bucket.gather_share {κ : Type*} [Fintype κ] [DecidableEq κ] (f : ι → κ) (b : Bucket ι)
    (k : κ) : (b.gather f).share k = ∑ i ∈ Finset.univ.filter (fun i => f i = k), b.share i := by
  sorry

/-! ## Meetings -/

theorem Bucket.meet_share (b : Bucket ι) (m : Meeting ι) (i : ι) :
    (b.meet m).share i = b.share i := by
  sorry

theorem Bucket.meet_clean_le (b : Bucket ι) (m : Meeting ι) (i : ι) :
    b.clean i ≤ (b.meet m).clean i := by
  sorry

theorem Bucket.meet_dirty_le (b : Bucket ι) (m : Meeting ι) (i : ι) :
    (b.meet m).dirty i ≤ b.dirty i := by
  sorry

/-- The amount swapped in at part `i` is exactly the amount of dirty taken out. -/
theorem Bucket.meet_swap (b : Bucket ι) (m : Meeting ι) (i : ι) :
    (b.meet m).clean i - b.clean i = b.dirty i - (b.meet m).dirty i := by
  sorry

/-- Gradual filtering: if a part has dirt and the meeting swaps some of it, that part keeps its
    share, gets strictly cleaner, and the bucket's dirt total strictly drops. -/
theorem Bucket.meet_gradual (b : Bucket ι) (m : Meeting ι) (i : ι)
    (hd : 0 < b.dirty i) (hr : 0 < m.r i) :
    (b.meet m).share i = b.share i ∧ b.clean i < (b.meet m).clean i ∧
      (b.meet m).dirtTotal < b.dirtTotal := by
  sorry

theorem Bucket.meetAll_share (b : Bucket ι) (ms : List (Meeting ι)) (i : ι) :
    (b.meetAll ms).share i = b.share i := by
  sorry

theorem Bucket.meetAll_full (b : Bucket ι) (ms : List (Meeting ι)) :
    ∑ i, (b.meetAll ms).share i = 1 := by
  sorry

theorem Bucket.meetAll_clean_le (b : Bucket ι) (ms : List (Meeting ι)) (i : ι) :
    b.clean i ≤ (b.meetAll ms).clean i := by
  sorry

theorem Bucket.meetAll_dirty_le (b : Bucket ι) (ms : List (Meeting ι)) (i : ι) :
    (b.meetAll ms).dirty i ≤ b.dirty i := by
  sorry

/-- After any meetings, the dirt left at part `i` is its start times `1 - r` of each meeting. -/
theorem Bucket.meetAll_dirty (b : Bucket ι) (ms : List (Meeting ι)) (i : ι) :
    (b.meetAll ms).dirty i = (ms.map (fun m => 1 - m.r i)).prod * b.dirty i := by
  sorry

/-! ## Two buckets meeting at the split -/

/-- Before the split the two full buckets make 2 (the imported `beforeSplit`); the shared bucket makes 1
    (the imported `splitEvent`). -/
theorem collide_totals {κ : Type*} [Fintype κ] (p : Placement) (u : Bucket ι) (v : Bucket κ) :
    ∑ i, u.share i + ∑ k, v.share k = beforeSplit ∧
      ∑ x, (collide p u v).share x = splitEvent p.student := by
  sorry

/-- No side leads: meeting `u` with `v` is meeting `v` with `u` with the shares swapped and the
    parts relabelled. -/
theorem collide_swap {κ : Type*} [Fintype κ] (p : Placement) (u : Bucket ι) (v : Bucket κ)
    (x : ι ⊕ κ) :
    (collide p u v).clean x = (collide (swapPlacement p) v u).clean x.swap ∧
      (collide p u v).dirty x = (collide (swapPlacement p) v u).dirty x.swap := by
  sorry

/-! ## Separating after the meetings -/

/-- Meetings never move anything between the sides: each side keeps its total. -/
theorem meetAll_sides {κ : Type*} [Fintype κ] (b : Bucket (ι ⊕ κ)) (ms : List (Meeting (ι ⊕ κ))) :
    leftTotal (b.meetAll ms) = leftTotal b ∧ rightTotal (b.meetAll ms) = rightTotal b := by
  sorry

theorem leftTotal_collide {κ : Type*} [Fintype κ] (p : Placement) (u : Bucket ι)
    (v : Bucket κ) : leftTotal (collide p u v) = p.student := by
  sorry

theorem rightTotal_collide {κ : Type*} [Fintype κ] (p : Placement) (u : Bucket ι)
    (v : Bucket κ) : rightTotal (collide p u v) = p.mentor := by
  sorry

/-- The whole run: meet at the split with placement `p`, then any meetings `ms`, then separate.
    Both sides leave full; the second side leaves with each of its own parts' dirt no higher than
    it came with and holds only its own parts; the first side's dirt at each part is no higher
    than it came with. -/
theorem run_result {κ : Type*} [Fintype κ] (p : Placement) (hs : 0 < p.student)
    (hm : 0 < p.mentor) (u : Bucket ι) (v : Bucket κ) (ms : List (Meeting (ι ⊕ κ))) :
    let b := (collide p u v).meetAll ms
    ∃ (hl : 0 < leftTotal b) (hr : 0 < rightTotal b),
      ∑ i, (takeLeft b hl).share i = 1 ∧ ∑ k, (takeRight b hr).share k = 1 ∧
      (∀ i, (takeLeft b hl).dirty i ≤ u.dirty i) ∧
      (∀ k, (takeRight b hr).dirty k ≤ v.dirty k) ∧
      leftTotal b = p.student ∧ rightTotal b = p.mentor := by
  sorry

/-- If some meeting swaps part of the first side's dirt at part `i` (where it has some), the first
    side leaves with strictly less dirt there than it came with. -/
theorem run_left_cleaner {κ : Type*} [Fintype κ] (p : Placement) (hs : 0 < p.student)
    (u : Bucket ι) (v : Bucket κ) (m : Meeting (ι ⊕ κ)) (ms : List (Meeting (ι ⊕ κ))) (i : ι)
    (hd : 0 < u.dirty i) (hr : 0 < m.r (Sum.inl i)) :
    ((collide p u v).meetAll (m :: ms)).dirty (Sum.inl i) < p.student * u.dirty i := by
  sorry

/-! ## The paired rule as a two-part bucket -/

/-- `dialPair k` is a two-part bucket. -/
theorem dialPair_bucket (k : Fin 6) :
    ∃ b : Bucket Bool, b.share true = (dialPair k).1 ∧ b.share false = (dialPair k).2 := by
  sorry

/-- `writeMove` on a pair adding to 1 is a transfer from part `false` to part `true`. -/
theorem writeMove_is_transfer (x : ℚ) (hx : 0 ≤ x) (hx1 : x ≤ 1) :
    let b := pairBucket x (1 - x) hx (by linarith) (by ring)
    ∃ (ha : 0 ≤ min (1 - x) (1 - x)) (haj : min (1 - x) (1 - x) ≤ b.clean false),
      (b.transfer true false (by decide) _ ha haj).clean true = (writeMove (x, 1 - x)).1 ∧
      (b.transfer true false (by decide) _ ha haj).clean false = (writeMove (x, 1 - x)).2 := by
  sorry

/-- `triageMove k` on a pair adding to 1 is a transfer from part `true` to part `false`. -/
theorem triageMove_is_transfer (k : Fin 6) (x : ℚ) (hx : 0 ≤ x) (hx1 : x ≤ 1) :
    let b := pairBucket x (1 - x) hx (by linarith) (by ring)
    ∃ (ha : 0 ≤ lossDial k * x) (haj : lossDial k * x ≤ b.clean true),
      (b.transfer false true (by decide) _ ha haj).clean true = (triageMove k (x, 1 - x)).1 ∧
      (b.transfer false true (by decide) _ ha haj).clean false = (triageMove k (x, 1 - x)).2 := by
  sorry

/-! ## Concrete check -/

/-! ## A start holds its history and what is ahead in one bucket -/

variable {η φ : Type*} [Fintype η] [Fintype φ]

/-- History and what is ahead are held in the same bucket at 0: together they make 1. -/
theorem start_holds_both (s : Start η φ) : leftTotal s + rightTotal s = 1 := by
  sorry

/-- History of any length: for every `n` there is a full start with `n + 1` history parts, each
    with a share above 0. -/
theorem history_any_length (n : Nat) :
    ∃ s : Start (Fin (n + 1)) Unit, ∀ i, 0 < s.share (Sum.inl i) := by
  sorry

/-- The meeting at each prime tick acts on a start by one rule, on its history parts and its ahead
    parts alike: each share kept, clean never falls, dirt never rises, history total and ahead
    total kept, still full. -/
theorem past_meetings_same_rule (f : Nat → Meeting (η ⊕ φ)) (s : Start η φ) (i p : Nat)
    (_h : labels[i]? = some p) :
    let t := s.meet (f p)
    (∀ x, t.share x = s.share x ∧ s.clean x ≤ t.clean x ∧ t.dirty x ≤ s.dirty x) ∧
      leftTotal t = leftTotal s ∧ rightTotal t = rightTotal s ∧ leftTotal t + rightTotal t = 1 := by
  sorry

/-- All the prime-tick meetings in order act on a start by the same rule. -/
theorem start_run_same_rule (f : Nat → Meeting (η ⊕ φ)) (s : Start η φ) :
    let t := s.meetAll (tickMeetings f)
    (∀ x, t.share x = s.share x ∧ s.clean x ≤ t.clean x ∧ t.dirty x ≤ s.dirty x) ∧
      leftTotal t = leftTotal s ∧ rightTotal t = rightTotal s ∧ leftTotal t + rightTotal t = 1 := by
  sorry

/-- Two starts meet at 0,0: each is full (2 together, `beforeSplit`), the shared bucket is full
    (`splitEvent`), and every part of each start, history and ahead, is carried in at its share
    times the placement weight. -/
theorem starts_meet {η' φ' : Type*} [Fintype η'] [Fintype φ'] (pl : Placement) (s₁ : Start η φ)
    (s₂ : Start η' φ') :
    ∑ x, s₁.share x + ∑ y, s₂.share y = beforeSplit ∧
      ∑ z, (collide pl s₁ s₂).share z = splitEvent pl.student ∧
      (∀ x, (collide pl s₁ s₂).share (Sum.inl x) = pl.student * s₁.share x) ∧
      (∀ y, (collide pl s₁ s₂).share (Sum.inr y) = pl.mentor * s₂.share y) := by
  sorry

/-! ## Break attempts -/

/-- Any move of share between the two sides changes a side total, so it cannot be hidden. -/
theorem transfer_changes_side {κ : Type*} [Fintype κ] [DecidableEq ι] [DecidableEq κ]
    (b : Bucket (ι ⊕ κ)) (i : ι) (k : κ) (a : ℚ) (ha : 0 ≤ a) (hak : a ≤ b.clean (Sum.inr k)) :
    rightTotal (b.transfer (Sum.inl i) (Sum.inr k) Sum.inl_ne_inr a ha hak) = rightTotal b - a := by
  sorry

end ViscousTimeReversal

end

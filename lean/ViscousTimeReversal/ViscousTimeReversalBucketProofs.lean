import Mathlib.Tactic
import MentorStudentModel
import HugWallPushProofs
import V3SourceSystem
import ViscousTimeReversalBucketDefinitions

/-! Proofs for prime ticks counted ahead and back, the paired buckets and the general bucket rule. -/

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

theorem labels_eq : labels = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41] := by decide

theorem two_le_of_primeLabel {p : Nat} (h : primeLabel p = true) : 2 ≤ p := by
  simp [primeLabel] at h
  exact h.1

/-! ## Statement 4's dial: the step sizes -/

theorem scheduleWith_32_25 : scheduleWith 32 25 = schedule := rfl

theorem scheduleWith_get (a b i : Nat) :
    (scheduleWith a b)[i]? = labels[i]?.map (fun p => (⟨p, a * i, b * i, 100000 * i⟩ : Tick)) := by
  simp [scheduleWith, List.getElem?_zipIdx, Option.map_map, Function.comp_def]

/-! ## Statement 1: the past side runs on the same prime ticks -/

theorem pastSchedule_get (a b i : Nat) :
    (pastSchedule a b)[i]? = labels[i]?.map
      (fun p => ((⟨p, a * i, b * i, 100000 * i⟩ : Tick), place .past p)) := by
  simp [pastSchedule, scheduleWith_get, Option.map_map, Function.comp_def]

/-- Same index, same tick: the past tick at index `i` is the forward tick at index `i`. -/
theorem past_same_ticks (a b i : Nat) :
    ((pastSchedule a b)[i]?).map (·.1) = (scheduleWith a b)[i]? := by
  simp [pastSchedule_get, scheduleWith_get, Option.map_map, Function.comp_def]

/-- One to one: a past tick exists at index `i` exactly when a forward tick does. -/
theorem past_one_to_one (a b i : Nat) :
    ((pastSchedule a b)[i]?).isSome = ((scheduleWith a b)[i]?).isSome := by
  simp [pastSchedule_get, scheduleWith_get]

theorem past_length (a b : Nat) : (pastSchedule a b).length = (scheduleWith a b).length := by
  simp [pastSchedule]

/-- Every tick counted back has a place below 0. -/
theorem past_place_negative (a b i : Nat) (x : Tick × ℤ) (h : (pastSchedule a b)[i]? = some x) :
    x.2 < 0 := by
  rw [pastSchedule_get] at h
  obtain ⟨p, hp, rfl⟩ := Option.map_eq_some_iff.mp h
  have h2 : 2 ≤ p := by
    have hm : p ∈ labels := List.mem_of_getElem? hp
    simp [labels, List.mem_filter] at hm
    exact two_le_of_primeLabel hm.2
  simp [place]
  omega

/-- Counted back from 0: a later index has a lower place. -/
theorem past_counts_back (a b i j : Nat) (x y : Tick × ℤ)
    (hx : (pastSchedule a b)[i]? = some x) (hy : (pastSchedule a b)[j]? = some y) (hij : i < j) :
    y.2 < x.2 := by
  rw [pastSchedule_get] at hx hy
  obtain ⟨p, hp, rfl⟩ := Option.map_eq_some_iff.mp hx
  obtain ⟨q, hq, rfl⟩ := Option.map_eq_some_iff.mp hy
  have hs : labels.Pairwise (· < ·) := by rw [labels_eq]; decide
  have hj : j < labels.length := by
    rcases List.getElem?_eq_some_iff.mp hq with ⟨hj, _⟩; exact hj
  have hi : i < labels.length := lt_trans hij hj
  have hpq : labels[i] < labels[j] := List.pairwise_iff_getElem.mp hs i j hi hj hij
  rw [List.getElem?_eq_getElem hi] at hp
  rw [List.getElem?_eq_getElem hj] at hq
  simp at hp hq
  subst hp hq
  simp [place]
  exact_mod_cast hpq

example : (pastSchedule 32 25).map (fun (x : Tick × ℤ) => (x.1.label, x.2)) =
    [(2, -2), (3, -3), (5, -5), (7, -7), (11, -11), (13, -13), (17, -17), (19, -19),
     (23, -23), (29, -29), (31, -31), (37, -37), (41, -41)] := by decide

/-! ## Statement 2: partners match ahead and back -/

/-- `q` is a back partner of `p` at gap `k` exactly when `p` is a forward partner of `q` at
    gap `k` (both prime ticks). -/
theorem partners_match (p q k : Nat) (hp : primeLabel p = true) (hq : primeLabel q = true) :
    (k, Direction.back, q) ∈ primePartners p ↔ (k, Direction.forward, p) ∈ primePartners q := by
  have h2p := two_le_of_primeLabel hp
  have h2q := two_le_of_primeLabel hq
  simp only [primePartners, partnerGaps, opening, List.mem_filter, List.mem_flatMap,
    List.mem_map, List.mem_cons, List.not_mem_nil, or_false]
  constructor
  · rintro ⟨⟨k', hk', d, hd, he⟩, _⟩
    simp only [Prod.mk.injEq] at he
    obtain ⟨rfl, rfl, rfl⟩ := he
    refine ⟨⟨k', hk', Direction.forward, by simp, ?_⟩, ?_⟩
    · simp only [Prod.mk.injEq, true_and]
      rcases hk' with rfl | rfl | rfl <;> simp at * <;> omega
    · have : p - k' + k' = p := by rcases hk' with rfl | rfl | rfl <;> simp at * <;> omega
      simpa [this] using hp
  · rintro ⟨⟨k', hk', d, hd, he⟩, _⟩
    simp only [Prod.mk.injEq] at he
    obtain ⟨rfl, rfl, rfl⟩ := he
    refine ⟨⟨k', hk', Direction.back, by simp, ?_⟩, ?_⟩
    · simp
    · simpa using hq

/-- Break attempt: drop the "both prime" condition. `9` is not a prime tick, `11` is a forward
    partner of `9` at gap 2, but `9` is not a back partner of `11`. -/
example : (2, Direction.forward, 11) ∈ primePartners 9 ∧
    (2, Direction.back, 9) ∉ primePartners 11 := by decide

/-! ## Statement 3: mentor + student = 1 at every past prime tick -/

theorem past_shares_one (a b i : Nat) (x : Tick × ℤ) (_h : (pastSchedule a b)[i]? = some x)
    (pl : Placement) : pl.mentor + pl.student = 1 := by
  simp [Placement.mentor, mentorOf, sharedWhole]

/-- Two starts make 2 before they meet (`beforeSplit`); met at 0,0 they make 1 (`splitEvent`). -/
theorem shares_across_split : beforeSplit = 2 ∧ ∀ s : ℚ, splitEvent s = 1 := by
  refine ⟨by norm_num [beforeSplit, startMentor, startStudent], fun s => ?_⟩
  simp [splitEvent, mentorOf, sharedWhole]

/-! ## Statement 4: past steps use the same dial -/

/-- Past travellers step the same way: the past gap equals the forward gap, for any dial. -/
theorem past_gap_same (a b i : Nat) : pastGapAt a b i = gapAt a b i := by
  simp [pastGapAt, gapAt, pastSchedule_get, scheduleWith_get, Option.map_map, Function.comp_def]

theorem past_gap_value (a b i g : Nat) (h : pastGapAt a b i = some g) : g = (a - b) * i := by
  simp only [pastGapAt, pastSchedule_get, Option.map_map] at h
  obtain ⟨p, _, rfl⟩ := Option.map_eq_some_iff.mp h
  simp [gap, Nat.sub_mul]

/-- The past gap grows with the index, as the forward one does (no sign flip). -/
theorem past_gap_grows (a b i j gi gj : Nat) (hi : pastGapAt a b i = some gi)
    (hj : pastGapAt a b j = some gj) (hij : i ≤ j) : gi ≤ gj := by
  rw [past_gap_value a b i gi hi, past_gap_value a b j gj hj]
  exact Nat.mul_le_mul_left _ hij

example : (List.range 13).map (pastGapAt 32 25) =
    [some 0, some 7, some 14, some 21, some 28, some 35, some 42, some 49, some 56, some 63,
     some 70, some 77, some 84] := by decide

example : (List.range 13).map (pastGapAt 32 25) = (List.range 13).map (gapAt 32 25) := by decide

/-- The imported `gap` counts in whole numbers: with the mentor dial above the student dial it reads 0.
    `gapZ` below keeps the sign. -/
example : pastGapAt 25 32 3 = some 0 ∧ gapAt 25 32 3 = some 0 := by decide

theorem gapZ_value (a b i : Nat) : gapZ a b i = ((a : ℤ) - b) * i := by
  simp [gapZ]; ring

theorem past_gapZ_same (a b i g : Nat) (h : pastGapAt a b i = some g) (hba : b ≤ a) :
    (g : ℤ) = gapZ a b i := by
  rw [past_gap_value a b i g h, gapZ_value]; push_cast [Nat.cast_sub hba]; ring

example : gapZ 32 25 3 = 21 ∧ gapZ 25 32 3 = -21 := by decide

/-! ## Statement 5: the past record is fixed -/

theorem past_record_fixed (n : Nat) (s : TwoSides) :
    (forwardTick^[n] s).pastRecord = s.pastRecord := by
  induction n with
  | zero => rfl
  | succ n ih => rw [Function.iterate_succ_apply']; exact ih

theorem forward_runs_held (n : Nat) (r : Nat → ℚ) :
    (forwardTick^[n] ⟨1, r⟩).forwardHeld = held n := by
  induction n with
  | zero => rfl
  | succ n ih => rw [Function.iterate_succ_apply']; simp [forwardTick, ih, held]

/-- Concrete: the past record is the imported `heldAt`; after 7 forward ticks it still reads 64/125 at
    index 3. -/
example : (forwardTick^[7] ⟨1, heldAt⟩).pastRecord 3 = 64 / 125 := by
  rw [past_record_fixed]
  have h : lastWrite 3 = 0 := by decide
  simp only [heldAt, h]; norm_num [held, loss]

/-! ## Statement 6: the loss is a dial -/

theorem heldDial_one (n : Nat) : heldDial 1 n = held n := by
  induction n with
  | zero => rfl
  | succ n ih => simp [heldDial, held, ih, lossDial, loss]

theorem heldDial_formula (k : Fin 6) (n : Nat) : heldDial k n = (1 - lossDial k) ^ n := by
  induction n with
  | zero => simp [heldDial]
  | succ n ih => rw [heldDial, ih, pow_succ]; ring

theorem heldDial_pos (k : Fin 6) (hk : k.val < 5) (n : Nat) : 0 < heldDial k n := by
  rw [heldDial_formula]
  apply pow_pos
  have : (k.val : ℚ) ≤ 4 := by exact_mod_cast (by omega : k.val ≤ 4)
  simp [lossDial]; linarith

theorem heldDial_five_zero (n : Nat) : heldDial 5 (n + 1) = 0 := by
  rw [heldDial_formula]; simp [lossDial]

theorem own_dial_forward (d : Dials) (k : Fin 6) (n : Nat) :
    sideHeld { d with past := k } .forward n = sideHeld d .forward n := rfl

theorem own_dial_past (d : Dials) (k : Fin 6) (n : Nat) :
    sideHeld { d with forward := k } .past n = sideHeld d .past n := rfl

/-- One side at 5/5 is at 0 after one tick; the other side, on a dial below 5, stays above 0. -/
theorem past_five_forward_pos (d : Dials) (hp : d.past = 5) (hf : d.forward.val < 5) (n : Nat) :
    sideHeld d .past (n + 1) = 0 ∧ 0 < sideHeld d .forward (n + 1) := by
  refine ⟨?_, heldDial_pos _ hf _⟩
  simp only [sideHeld, hp]; exact heldDial_five_zero n

theorem forward_five_past_pos (d : Dials) (hf : d.forward = 5) (hp : d.past.val < 5) (n : Nat) :
    sideHeld d .forward (n + 1) = 0 ∧ 0 < sideHeld d .past (n + 1) := by
  refine ⟨?_, heldDial_pos _ hp _⟩
  simp only [sideHeld, hf]; exact heldDial_five_zero n

example : sideHeld ⟨1, 5⟩ .past 1 = 0 ∧ sideHeld ⟨1, 5⟩ .forward 1 = 4 / 5 := by
  simp [sideHeld, heldDial, lossDial]; norm_num

/-! ## Statement 7: no loss at a write tick (the rule chosen for this check) -/

theorem afterWrite_one (h : ℚ) : afterWrite h = 1 := by
  simp [afterWrite, partnerSupply]

/-- The imported `heldAt` is 1 at every write tick. -/
theorem heldAt_write (i : Nat) (hw : isWrite i = true) : heldAt i = 1 := by
  have hl : lastWrite i = i := by
    unfold lastWrite
    rw [List.range_succ, List.filter_append]
    have : (List.filter (fun j => (labels[j]?).any (· ∈ writeTicks)) [i]) = [i] := by
      simp only [isWrite] at hw; simp [hw]
    rw [this, List.getLast?_append]; simp
  simp [heldAt, hl, held]

theorem runHeld_bounds (k : Fin 6) (i : Nat) : 0 ≤ runHeld k i ∧ runHeld k i ≤ 1 := by
  induction i with
  | zero => simp [runHeld]
  | succ i ih =>
    have hk0 : (0 : ℚ) ≤ lossDial k := by simp [lossDial]; positivity
    have hk1 : lossDial k ≤ 1 := by
      have : (k.val : ℚ) ≤ 5 := by exact_mod_cast (by omega : k.val ≤ 5)
      simp [lossDial]; linarith
    unfold runHeld
    split
    · simp [afterWrite_one]
    · constructor <;> nlinarith [ih.1, ih.2]

/-- At a write tick held does not lose: it becomes 1, never below what it was. -/
theorem write_no_loss (k : Fin 6) (i : Nat) (hw : isWrite (i + 1) = true) :
    runHeld k (i + 1) = 1 ∧ runHeld k i ≤ runHeld k (i + 1) := by
  have h1 : runHeld k (i + 1) = 1 := by simp [runHeld, hw, afterWrite_one]
  exact ⟨h1, h1 ▸ (runHeld_bounds k i).2⟩

/-- At dial 1/5 the tick-by-tick run gives the imported `heldAt` on all 13 prime ticks. -/
example : (List.range 13).map (runHeld 1) = (List.range 13).map heldAt := by
  have hw : (List.range 13).map isWrite =
      [false, false, false, false, true, false, false, false, true, false, false, false, true] := by
    decide
  have hl : (List.range 13).map lastWrite = [0, 0, 0, 0, 4, 4, 4, 4, 8, 8, 8, 8, 12] := by decide
  simp [List.range_succ] at hw hl
  simp [List.range_succ, runHeld, heldAt, hw, hl, held, lossDial, loss, afterWrite_one]

/-- The imported `afterWrite` alone, dial 5/5: at 0 after one tick, back to 1 at index 4 with nothing
    taken from anywhere. `runPair` takes the refill from the partner bucket. -/
example : runHeld 5 1 = 0 ∧ runHeld 5 3 = 0 ∧ runHeld 5 4 = 1 := by
  have h1 : isWrite 1 = false := by decide
  have h2 : isWrite 2 = false := by decide
  have h3 : isWrite 3 = false := by decide
  have h4 : isWrite 4 = true := by decide
  simp [runHeld, h1, h2, h3, h4, lossDial, afterWrite_one]

/-! ## Statement 8: freeze ticks 41, 23 and 11 -/

theorem freezeAt_23 (pl : Placement) (i : Nat) : FreezeAt pl i 23 ↔ Freeze pl i := Iff.rfl

theorem freezePartners_are_writes (t : Nat) : t ∈ freezePartners ↔ t ∈ writeTicks := by
  simp [freezePartners, writeTicks]; tauto

/-- Each freeze partner is a freeze, and the same tick counted back sits at the same index, at
    place `-t`, with mentor + student = 1 there. -/
theorem freeze_partners (pl : Placement) (t : Nat) (ht : t ∈ freezePartners) :
    ∃ i, FreezeAt pl i t ∧
      ((pastSchedule 32 25)[i]?).map (fun (x : Tick × ℤ) => (x.1.label, x.2)) = some (t, place .past t) ∧
      pl.mentor + pl.student = 1 := by
  have hs : pl.mentor + pl.student = 1 := by simp [Placement.mentor, mentorOf, sharedWhole]
  simp only [freezePartners, List.mem_cons, List.not_mem_nil, or_false] at ht
  rcases ht with rfl | rfl | rfl
  · exact ⟨12, ⟨by decide, hs, by decide⟩, by decide, hs⟩
  · exact ⟨8, ⟨by decide, hs, by decide⟩, by decide, hs⟩
  · exact ⟨4, ⟨by decide, hs, by decide⟩, by decide, hs⟩

/-- Break attempt: the partners the imported `primePartners` keeps for 41, 23 and 11. -/
example : primePartners 41 =
    [(4, .back, 37), (2, .forward, 43), (6, .forward, 47)] := by decide

example : primePartners 23 =
    [(4, .back, 19), (6, .forward, 29), (6, .back, 17)] := by decide

example : primePartners 11 =
    [(4, .back, 7), (2, .forward, 13), (6, .forward, 17), (6, .back, 5)] := by decide

/-- 43 and 47 are prime but lie beyond the last tick 41. -/
example : 43 ∉ labels ∧ 47 ∉ labels := by decide

/-! ## Back openings counted below 0 -/

theorem backStep_eq_opening (p k : Nat) (h : k ≤ p) :
    backStep p k = (opening p k .back : ℤ) := by
  simp [backStep, opening]; omega

theorem backStep_below_zero (p k : Nat) (h : p < k) : backStep p k = place .past (k - p) := by
  simp [backStep, place]; omega

/-- 2 back by 2 is 0. The imported `opening` floors at 0; `backStep` does not. -/
example : opening 2 2 .back = 0 ∧ backStep 2 2 = 0 := by decide

example : opening 2 4 .back = 0 ∧ backStep 2 4 = place .past 2 := by decide

example : opening 3 6 .back = 0 ∧ backStep 3 6 = place .past 3 := by decide

example : opening 5 6 .back = 0 ∧ backStep 5 6 = place .past 1 ∧ primeLabel 1 = false := by
  decide

/-- A back partner of a prime tick is both: a step back along the prime ticks (`q < p`, with no
    flooring), and a prime tick counted back at the same index as the forward tick `q`. -/
theorem back_partner_both (a b p k q : Nat) (hp : p ∈ labels)
    (h : (k, Direction.back, q) ∈ primePartners p) :
    q < p ∧ backStep p k = q ∧ ∃ i : Nat, labels[i]? = some q ∧
      ((pastSchedule a b)[i]?).map (fun (x : Tick × ℤ) => (x.1.label, x.2)) = some (q, place .past q) ∧
      ((scheduleWith a b)[i]?).map Tick.label = some q := by
  simp only [primePartners, partnerGaps, opening, List.mem_filter, List.mem_flatMap,
    List.mem_map, List.mem_cons, List.not_mem_nil, or_false] at h
  obtain ⟨⟨k', hk', d, hd, he⟩, hq⟩ := h
  simp only [Prod.mk.injEq] at he
  obtain ⟨rfl, hdb, rfl⟩ := he
  rcases hd with rfl | rfl
  · cases hdb
  simp only at hq
  have h2 := two_le_of_primeLabel hq
  have hp41 : p ≤ 41 := by rw [labels_eq] at hp; simp at hp; omega
  have hk0 : 0 < k' := by rcases hk' with rfl | rfl | rfl <;> omega
  have hlt : p - k' < p := by omega
  have hmem : p - k' ∈ labels := by
    simp only [labels, List.mem_filter, List.mem_range]; exact ⟨by omega, hq⟩
  obtain ⟨i, hi⟩ := List.mem_iff_getElem?.mp hmem
  refine ⟨hlt, ?_, i, hi, ?_, ?_⟩
  · simp [backStep]; omega
  · simp [pastSchedule_get, hi]
  · simp [scheduleWith_get, hi]

/-- The back partners of the freeze ticks 41, 23, 11, each a tick counted back, matched with
    the tick counted ahead at the same index. -/
example : ((primePartners 41 ++ primePartners 23 ++ primePartners 11).filter
      (fun x => x.2.1 == .back)).map (fun x => (x.2.2, labels.idxOf x.2.2)) =
    [(37, 11), (19, 7), (17, 6), (7, 3), (5, 2)] := by decide

example : [11, 7, 6, 3, 2].map (fun i => ((pastSchedule 32 25)[i]?).map (fun (x : Tick × ℤ) => (x.1.label, x.2))) =
    [some (37, -37), some (19, -19), some (17, -17), some (7, -7), some (5, -5)] := by decide

/-! ## Shares after an overlap move, from `mentorOf`, `splitEvent` and `moveOverlap` -/

/-- `s` and `mentorOf s` add to 1. -/
theorem shares_in_out (s : ℚ) : s + mentorOf s = 1 := by simp [mentorOf, sharedWhole]

theorem shares_split (s : ℚ) : splitEvent s = 1 := shares_in_out s

theorem shares_both_sides (_ : Side) (pl : Placement) : pl.student + pl.mentor = 1 :=
  shares_in_out pl.student

theorem shares_after_move (s d : ℚ) : (moveOverlap s d).1 + (moveOverlap s d).2 = 1 :=
  shares_in_out (s + d)

/-- After any run of overlaps, the shares still add to 1. -/
theorem shares_returns (s : ℚ) (ds : List ℚ) :
    (ds.foldl (fun (x : ℚ × ℚ) d => moveOverlap x.1 d) (s, mentorOf s)).1 +
    (ds.foldl (fun (x : ℚ × ℚ) d => moveOverlap x.1 d) (s, mentorOf s)).2 = 1 := by
  suffices ∀ x : ℚ × ℚ, x.1 + x.2 = 1 →
      (ds.foldl (fun (x : ℚ × ℚ) d => moveOverlap x.1 d) x).1 +
      (ds.foldl (fun (x : ℚ × ℚ) d => moveOverlap x.1 d) x).2 = 1 from this _ (shares_in_out s)
  induction ds with
  | nil => intro x hx; simpa using hx
  | cons d ds ih => intro x _; exact ih _ (shares_after_move x.1 d)

/-- Break attempt: a large overlap. The shares still make 1, but the student goes above 1 and
    the mentor below 0, outside a `Placement`. -/
example : moveOverlap (9 / 10) (1 / 2) = (7 / 5, -2 / 5) := by
  simp [moveOverlap, mentorOf, sharedWhole]; norm_num

end ViscousTimeReversal

end

section

/-! Paired buckets, partners past tick 41, the breath, and the one-start lead. -/

namespace ViscousTimeReversal

open MentorStudent

/-! ## Paired buckets -/

theorem dialPair_total (k : Fin 6) : (dialPair k).1 + (dialPair k).2 = 1 := by
  simp [dialPair]; ring

example : dialPair 1 = (1 / 5, 4 / 5) ∧ dialPair 5 = (1, 0) ∧ dialPair 0 = (0, 1) := by
  simp [dialPair]; norm_num

theorem triageMove_total (k : Fin 6) (x : ℚ × ℚ) :
    (triageMove k x).1 + (triageMove k x).2 = x.1 + x.2 := by
  simp only [triageMove]; ring

/-- A partner step never fills the first bucket. -/
theorem triageMove_no_fill (k : Fin 6) (x : ℚ × ℚ) (h : 0 ≤ x.1) : (triageMove k x).1 ≤ x.1 := by
  have : 0 ≤ lossDial k := by simp [lossDial]; positivity
  simp only [triageMove]; nlinarith

/-- With no writes, the first bucket follows `heldDial` and the partner holds the rest. -/
theorem triageMove_runs (k : Fin 6) (n : Nat) :
    (triageMove k)^[n] (1, 0) = (heldDial k n, 1 - heldDial k n) := by
  induction n with
  | zero => simp [heldDial]
  | succ n ih =>
    rw [Function.iterate_succ_apply', ih]
    simp only [triageMove, heldDial, Prod.mk.injEq]
    exact ⟨trivial, by ring⟩

theorem writeMove_total (x : ℚ × ℚ) : (writeMove x).1 + (writeMove x).2 = x.1 + x.2 := by
  simp [writeMove]

/-- What the first bucket gains is exactly what the partner loses, never more than it had. -/
theorem writeMove_from_partner (x : ℚ × ℚ) :
    (writeMove x).1 - x.1 = x.2 - (writeMove x).2 ∧ (writeMove x).1 - x.1 ≤ x.2 ∧
      0 ≤ (writeMove x).2 := by
  simp only [writeMove]
  refine ⟨by ring, by simp, by linarith [min_le_right (1 - x.1) x.2]⟩

/-- A partner at 0 gives nothing: the bucket does not fill from nothing. -/
theorem writeMove_empty_partner (x : ℚ) (h : x ≤ 1) : writeMove (x, 0) = (x, 0) := by
  have : min (1 - x) 0 = 0 := min_eq_right (by linarith)
  simp [writeMove, this]

/-- On a pair adding to 1, the write gives the imported `afterWrite` value and empties the partner. -/
theorem writeMove_afterWrite (h : ℚ) : writeMove (h, 1 - h) = (afterWrite h, 0) := by
  simp [writeMove, afterWrite, partnerSupply]

/-- The first bucket is `runHeld`, the partner holds the rest. -/
theorem runPair_eq (k : Fin 6) (i : Nat) : runPair k i = (runHeld k i, 1 - runHeld k i) := by
  induction i with
  | zero => simp [runPair, runHeld]
  | succ i ih =>
    unfold runPair runHeld
    split
    · rw [ih, writeMove_afterWrite, afterWrite_one]; simp
    · rw [ih]; simp only [triageMove, Prod.mk.injEq]; exact ⟨trivial, by ring⟩

theorem runPair_total (k : Fin 6) (i : Nat) : (runPair k i).1 + (runPair k i).2 = 1 := by
  rw [runPair_eq]; ring

theorem runPair_bounds (k : Fin 6) (i : Nat) :
    0 ≤ (runPair k i).1 ∧ (runPair k i).1 ≤ 1 ∧ 0 ≤ (runPair k i).2 ∧ (runPair k i).2 ≤ 1 := by
  rw [runPair_eq]
  have := runHeld_bounds k i
  simp only
  refine ⟨this.1, this.2, by linarith, by linarith⟩

theorem runPair_write (k : Fin 6) (i : Nat) (hw : isWrite (i + 1) = true) :
    runPair k (i + 1) = (1, 0) := by
  rw [runPair_eq, (write_no_loss k i hw).1]; norm_num

/-- Dial 5/5: after one tick the bucket is at 0/5 and its partner at 5/5; the write at index 4
    moves the partner's 5/5 back, leaving the partner at 0/5. -/
example : runPair 5 1 = (0, 1) ∧ runPair 5 3 = (0, 1) ∧ runPair 5 4 = (1, 0) := by
  have h1 : isWrite 1 = false := by decide
  have h2 : isWrite 2 = false := by decide
  have h3 : isWrite 3 = false := by decide
  have h4 : isWrite 4 = true := by decide
  simp [runPair, h1, h2, h3, h4, triageMove, writeMove, lossDial]

/-- Both buckets at 0: the write moves nothing. -/
example : writeMove (0, 0) = (0, 0) := writeMove_empty_partner 0 (by norm_num)

theorem sidePair_own_forward (d : Dials) (k : Fin 6) (i : Nat) :
    sidePair { d with past := k } .forward i = sidePair d .forward i := rfl

theorem sidePair_own_past (d : Dials) (k : Fin 6) (i : Nat) :
    sidePair { d with forward := k } .past i = sidePair d .past i := rfl

example : sidePair ⟨1, 5⟩ .past 1 = (0, 1) ∧ sidePair ⟨1, 5⟩ .forward 1 = (4 / 5, 1 / 5) := by
  have h1 : isWrite 1 = false := by decide
  simp [sidePair, runPair, h1, triageMove, lossDial]; norm_num

/-! ## Partners past tick 41 -/

theorem resolve_keeps (p : Nat) (x : Nat × Direction × Nat) (h : x.2.2 ∈ labels) :
    resolve p x = some x := by simp [resolve, h]

/-- Every partner of every labelled tick resolves to a partner on a labelled tick. -/
theorem resolve_lands : ∀ p ∈ labels, ∀ x ∈ primePartners p,
    (resolve p x).any (fun y => decide (y.2.2 ∈ labels) && decide (y ∈ primePartners p)) = true := by
  decide

example : resolve 41 (2, .forward, 43) = some (4, .back, 37) ∧
    resolve 41 (6, .forward, 47) = some (4, .back, 37) := by decide

/-- Which labelled ticks have a partner off the labelled ticks. -/
example : labels.filter (fun p => (primePartners p).any (fun x => !decide (x.2.2 ∈ labels))) =
    [37, 41] := by decide

example : resolve 37 (6, .forward, 43) = some (4, .forward, 41) := by decide

/-- Continuing from the forward tick or from the back tick carries the same: same two ticks,
    same gap, same overlap, and the same shares after the overlap moves. -/
theorem same_either_way (p q k : Nat) (hp : primeLabel p = true) (hq : primeLabel q = true)
    (h : (k, Direction.back, q) ∈ primePartners p) (s d : ℚ) :
    (k, Direction.forward, p) ∈ primePartners q ∧
      carried p (k, .back, q) d = carried q (k, .forward, p) d ∧
      moveOverlap s d = moveOverlap s d := by
  refine ⟨(partners_match p q k hp hq).mp h, ?_, rfl⟩
  simp [carried, min_comm, max_comm]

example (d : ℚ) : carried 41 (4, .back, 37) d = carried 37 (4, .forward, 41) d ∧
    carried 41 (4, .back, 37) d = (37, 41, 4, d) := by
  simp [carried]

/-! ## Statement 10: the breath -/

theorem moveWithin_shares (p : Placement) (d : ℚ) :
    (moveWithin p d).mentor + (moveWithin p d).student = 1 := by
  simp [moveWithin, Placement.mentor, mentorOf, sharedWhole]

theorem moveWithin_mentor (p : Placement) (d : ℚ) :
    (moveWithin p d).mentor = (moveOverlap p.student (keptOverlap p.student d)).2 ∧
      0 ≤ (moveWithin p d).mentor := by
  refine ⟨rfl, ?_⟩
  have := (moveWithin p d).atMostOne
  simp only [Placement.mentor, mentorOf, sharedWhole]; linarith

theorem moveWithin_fits (p : Placement) (d : ℚ) (h0 : 0 ≤ p.student + d)
    (h1 : p.student + d ≤ 1) : (moveWithin p d).student = (moveOverlap p.student d).1 := by
  have : keptOverlap p.student d = d := by
    unfold keptOverlap
    rw [min_eq_left (by linarith), max_eq_right (by linarith)]
  simp [moveWithin, this]

example : (moveWithin ⟨9 / 10, by norm_num, by norm_num⟩ (1 / 2)).student = 1 ∧
    (moveWithin ⟨9 / 10, by norm_num, by norm_num⟩ (1 / 2)).mentor = 0 := by
  simp [moveWithin, keptOverlap, moveOverlap, Placement.mentor, mentorOf, sharedWhole]
  norm_num

/-- Heat given off when the gap closes with the student's share `s` and the mentor's
    `mentorOf s` as the weights. -/
theorem breath_heat (s : ℚ) (xM xS : ℝ) :
    ((mentorOf s : ℝ) * xM ^ 2 + (s : ℝ) * xS ^ 2) / 2
      - ((mentorOf s : ℝ) + s) * ((mentorOf s : ℝ) * xM + s * xS) ^ 2 / 2
      = (s : ℝ) * (mentorOf s : ℝ) / 2 * (xS - xM) ^ 2 := by
  simp only [mentorOf, sharedWhole]; push_cast; ring

/-- At the freeze shares (student 4/5, mentor 1/5) this is the imported `freeze_gives_off`: 2/25 of the
    squared gap. -/
theorem breath_heat_freeze (xM xS : ℝ) :
    ((mentorOf (4 / 5) : ℝ) * xM ^ 2 + ((4 / 5 : ℚ) : ℝ) * xS ^ 2) / 2
      - ((mentorOf (4 / 5) : ℝ) + ((4 / 5 : ℚ) : ℝ)) *
        ((mentorOf (4 / 5) : ℝ) * xM + ((4 / 5 : ℚ) : ℝ) * xS) ^ 2 / 2
      = (1 / 5 * xM ^ 2 + 4 / 5 * xS ^ 2) / 2 - (1 / 5 + 4 / 5) * HugWallPush.balance xM xS ^ 2 / 2
      ∧ (1 / 5 * xM ^ 2 + 4 / 5 * xS ^ 2) / 2 - (1 / 5 + 4 / 5) * HugWallPush.balance xM xS ^ 2 / 2
      = 2 / 25 * (xS - xM) ^ 2 := by
  refine ⟨?_, HugWallPush.freeze_gives_off xM xS⟩
  simp only [mentorOf, sharedWhole, HugWallPush.balance]; push_cast; ring

/-- For every placement the heat is never negative. -/
theorem breath_heat_nonneg (p : Placement) (xM xS : ℝ) :
    0 ≤ (p.student : ℝ) * (p.mentor : ℝ) / 2 * (xS - xM) ^ 2 := by
  have h0 : (0 : ℝ) ≤ p.student := by exact_mod_cast p.atLeastZero
  have h1 : (0 : ℝ) ≤ p.mentor := by
    have := p.atMostOne
    simp only [Placement.mentor, mentorOf, sharedWhole]; push_cast
    have : (p.student : ℝ) ≤ 1 := by exact_mod_cast this
    linarith
  positivity

/-- Outside a placement (student 7/5, mentor -2/5) the heat is below 0. -/
example : (((7 / 5 : ℚ) : ℝ) * (mentorOf (7 / 5) : ℝ) / 2 * (1 - 0) ^ 2) = -7 / 25 := by
  simp only [mentorOf, sharedWhole]; push_cast; norm_num

/-- The clay: what it does to the motion is minus the heat it makes, and the heat is never
    negative (the imported `clay_energy`, `clayHeat_nonneg`). -/
theorem breath_clay {G : Type*} [AddCommGroup G] [Fintype G] (K : ℝ) (g χ u : G → ℝ)
    (hK : 0 ≤ K) (hg : ∀ i, 0 ≤ g i) (hχ : ∀ i, 0 ≤ χ i) :
    ∑ i, u i * HugWallPush.clayDrag K g χ u i = -HugWallPush.clayHeat K g χ u ∧
      0 ≤ HugWallPush.clayHeat K g χ u :=
  ⟨HugWallPush.clay_energy K g χ u, HugWallPush.clayHeat_nonneg K g χ u hK hg hχ⟩

/-- The write ticks 11, 23, 41 sit at tick times 0.4, 0.8, 1.2: the write times `time 2`,
    `time 3`, `time 4`. -/
theorem write_times :
    writeTicks.map (fun t => ((labels.idxOf t : ℕ) : ℝ) / 10) =
      [HugV3.Source.time 2, HugV3.Source.time 3, HugV3.Source.time 4] := by
  have h11 : labels.idxOf 11 = 4 := by decide
  have h23 : labels.idxOf 23 = 8 := by decide
  have h41 : labels.idxOf 41 = 12 := by decide
  simp only [writeTicks, List.map_cons, List.map_nil, h11, h23, h41, HugV3.Source.time]
  norm_num

/-- The write at 0.8 in the imported record adds heat. -/
theorem write_08_heat : ((secondWrite.time : ℚ) : ℝ) = HugV3.Source.time 3 ∧
    0 < secondWrite.heat ∧ beforeWrite23.heat < afterWrite23.heat := by
  refine ⟨?_, ?_, ?_⟩
  · simp [secondWrite, HugV3.Source.time]; norm_num
  · simp [secondWrite]
  · simp [beforeWrite23, afterWrite23]; norm_num

/-! ## One full start ahead, found from the overlap -/

theorem lead_from_overlap (s d : ℚ) :
    (lead s d = 1 ↔ 0 < d) ∧ (lead s d = -1 ↔ d < 0) ∧ (lead s d = 0 ↔ d = 0) := by
  rcases lt_trichotomy d 0 with h | h | h
  · have e : lead s d = -1 := by
      have h1 : ¬ s < s + d := by linarith
      have h2 : s + d < s := by linarith
      simp [lead, moveOverlap, h1, h2]
    rw [e]
    exact ⟨⟨fun e => by norm_num at e, fun e => by linarith⟩, ⟨fun _ => h, fun _ => rfl⟩,
      ⟨fun e => by norm_num at e, fun e => by linarith⟩⟩
  · subst h; simp [lead, moveOverlap]
  · have e : lead s d = 1 := by
      have h1 : s < s + d := by linarith
      simp [lead, moveOverlap, h1]
    rw [e]
    exact ⟨⟨fun _ => h, fun _ => rfl⟩, ⟨fun e => by norm_num at e, fun e => by linarith⟩,
      ⟨fun e => by norm_num at e, fun e => by linarith⟩⟩

/-- The steps between ticks match: 32 student steps and 25 mentor steps both make 1/10. -/
theorem steps_between_match :
    (32 : ℚ) * HugWallPush.studentStep = 1 / 10 ∧ (25 : ℚ) * HugWallPush.mentorStep = 1 / 10 := by
  constructor <;> norm_num [HugWallPush.studentStep, HugWallPush.mentorStep]

theorem lead_values (s d : ℚ) : lead s d = 1 ∨ lead s d = -1 ∨ lead s d = 0 := by
  unfold lead; split_ifs <;> simp

/-- The time gap at every tick is the lead over 10, whatever the shares and overlaps. -/
theorem time_gap (shares overlaps : ℕ → ℚ) (i : ℕ) :
    studentTime shares overlaps i - mentorTime shares overlaps i =
      (lead (shares i) (overlaps i) : ℚ) / 10 := by
  unfold studentTime mentorTime studentStart mentorStart
  rcases lead_values (shares i) (overlaps i) with h | h | h <;>
    simp [h, HugWallPush.studentStep, HugWallPush.mentorStep] <;> ring

/-- At every tick either one is at most one full start (1/10) ahead. -/
theorem one_full_start (shares overlaps : ℕ → ℚ) (i : ℕ) :
    |studentTime shares overlaps i - mentorTime shares overlaps i| ≤ 1 / 10 := by
  rw [time_gap]
  rcases lead_values (shares i) (overlaps i) with h | h | h <;> rw [h] <;> norm_num

/-- Between ticks each side moves one tick (1/10) plus the change in its own start. -/
theorem steps_per_tick (shares overlaps : ℕ → ℚ) (i : ℕ) :
    studentTime shares overlaps (i + 1) - studentTime shares overlaps i =
      1 / 10 + ((studentStart (shares (i + 1)) (overlaps (i + 1)) : ℚ) -
        studentStart (shares i) (overlaps i)) / 10 ∧
    mentorTime shares overlaps (i + 1) - mentorTime shares overlaps i =
      1 / 10 + ((mentorStart (shares (i + 1)) (overlaps (i + 1)) : ℚ) -
        mentorStart (shares i) (overlaps i)) / 10 := by
  unfold studentTime mentorTime
  constructor <;> push_cast <;> simp [HugWallPush.studentStep, HugWallPush.mentorStep] <;> ring

/-- The lead swaps when the overlap changes sign: student ahead at tick 0, mentor at tick 1,
    and the gap goes below 0. -/
example : lead (1 / 2) (1 / 10) = 1 ∧ lead (1 / 2) (-1 / 10) = -1 ∧
    studentTime (fun _ => 1 / 2) (fun i => if i = 0 then 1 / 10 else -1 / 10) 0 -
      mentorTime (fun _ => 1 / 2) (fun i => if i = 0 then 1 / 10 else -1 / 10) 0 = 1 / 10 ∧
    studentTime (fun _ => 1 / 2) (fun i => if i = 0 then 1 / 10 else -1 / 10) 1 -
      mentorTime (fun _ => 1 / 2) (fun i => if i = 0 then 1 / 10 else -1 / 10) 1 = -1 / 10 := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · rw [(lead_from_overlap _ _).1]; norm_num
  · rw [(lead_from_overlap _ _).2.1]; norm_num
  · rw [time_gap]; simp only [ite_true]; rw [(lead_from_overlap _ _).1.mpr (by norm_num)]; norm_num
  · rw [time_gap]; simp only [one_ne_zero, ite_false]
    rw [(lead_from_overlap _ _).2.1.mpr (by norm_num)]; norm_num

/-- With the student at 1, an overlap of 1/10 is kept as 0, while `lead` (from the overlap
    itself) still reads 1. -/
example : keptOverlap 1 (1 / 10) = 0 ∧ lead 1 (1 / 10) = 1 := by
  refine ⟨by norm_num [keptOverlap], (lead_from_overlap _ _).1.mpr (by norm_num)⟩

end ViscousTimeReversal

end

section

/-! The general bucket rule. -/

namespace ViscousTimeReversal

open MentorStudent

open scoped BigOperators

/-! ## Buckets -/

variable {ι : Type*} [Fintype ι]

theorem Bucket.share_sum (b : Bucket ι) : ∑ i, b.share i = 1 := b.full

theorem Bucket.share_nonneg (b : Bucket ι) (i : ι) : 0 ≤ b.share i :=
  add_nonneg (b.clean_nonneg i) (b.dirty_nonneg i)

/-! ## Parts made of smaller parts -/

theorem Bucket.gather_share {κ : Type*} [Fintype κ] [DecidableEq κ] (f : ι → κ) (b : Bucket ι)
    (k : κ) : (b.gather f).share k = ∑ i ∈ Finset.univ.filter (fun i => f i = k), b.share i := by
  simp [Bucket.share, Bucket.gather, Finset.sum_add_distrib]

/-! ## Meetings -/

theorem Bucket.meet_share (b : Bucket ι) (m : Meeting ι) (i : ι) :
    (b.meet m).share i = b.share i := by
  simp only [Bucket.share, Bucket.meet]; ring

theorem Bucket.meet_clean_le (b : Bucket ι) (m : Meeting ι) (i : ι) :
    b.clean i ≤ (b.meet m).clean i := by
  simp only [Bucket.meet]
  linarith [mul_nonneg (m.r_nonneg i) (b.dirty_nonneg i)]

theorem Bucket.meet_dirty_le (b : Bucket ι) (m : Meeting ι) (i : ι) :
    (b.meet m).dirty i ≤ b.dirty i := by
  simp only [Bucket.meet]
  linarith [mul_nonneg (m.r_nonneg i) (b.dirty_nonneg i)]

/-- The amount swapped in at part `i` is exactly the amount of dirty taken out. -/
theorem Bucket.meet_swap (b : Bucket ι) (m : Meeting ι) (i : ι) :
    (b.meet m).clean i - b.clean i = b.dirty i - (b.meet m).dirty i := by
  simp only [Bucket.meet]; ring

/-- Gradual filtering: if a part has dirt and the meeting swaps some of it, that part keeps its
    share, gets strictly cleaner, and the bucket's dirt total strictly drops. -/
theorem Bucket.meet_gradual (b : Bucket ι) (m : Meeting ι) (i : ι)
    (hd : 0 < b.dirty i) (hr : 0 < m.r i) :
    (b.meet m).share i = b.share i ∧ b.clean i < (b.meet m).clean i ∧
      (b.meet m).dirtTotal < b.dirtTotal := by
  refine ⟨b.meet_share m i, ?_, ?_⟩
  · simp only [Bucket.meet]; nlinarith
  · unfold Bucket.dirtTotal
    apply Finset.sum_lt_sum (fun j _ => b.meet_dirty_le m j)
    exact ⟨i, Finset.mem_univ _, by simp only [Bucket.meet]; nlinarith⟩

theorem Bucket.meetAll_share (b : Bucket ι) (ms : List (Meeting ι)) (i : ι) :
    (b.meetAll ms).share i = b.share i := by
  induction ms generalizing b with
  | nil => rfl
  | cons m ms ih => simp only [Bucket.meetAll, List.foldl_cons] at ih ⊢; rw [ih, b.meet_share]

theorem Bucket.meetAll_full (b : Bucket ι) (ms : List (Meeting ι)) :
    ∑ i, (b.meetAll ms).share i = 1 := (b.meetAll ms).full

theorem Bucket.meetAll_clean_le (b : Bucket ι) (ms : List (Meeting ι)) (i : ι) :
    b.clean i ≤ (b.meetAll ms).clean i := by
  induction ms generalizing b with
  | nil => exact le_rfl
  | cons m ms ih =>
    simp only [Bucket.meetAll, List.foldl_cons] at ih ⊢
    exact le_trans (b.meet_clean_le m i) (ih _)

theorem Bucket.meetAll_dirty_le (b : Bucket ι) (ms : List (Meeting ι)) (i : ι) :
    (b.meetAll ms).dirty i ≤ b.dirty i := by
  induction ms generalizing b with
  | nil => exact le_rfl
  | cons m ms ih =>
    simp only [Bucket.meetAll, List.foldl_cons] at ih ⊢
    exact le_trans (ih _) (b.meet_dirty_le m i)

/-- After any meetings, the dirt left at part `i` is its start times `1 - r` of each meeting. -/
theorem Bucket.meetAll_dirty (b : Bucket ι) (ms : List (Meeting ι)) (i : ι) :
    (b.meetAll ms).dirty i = (ms.map (fun m => 1 - m.r i)).prod * b.dirty i := by
  induction ms generalizing b with
  | nil => simp [Bucket.meetAll]
  | cons m ms ih =>
    simp only [Bucket.meetAll, List.foldl_cons] at ih ⊢
    rw [ih]; simp only [Bucket.meet, List.map_cons, List.prod_cons]; ring

/-! ## Two buckets meeting at the split -/

/-- Before the split the two full buckets make 2 (the imported `beforeSplit`); the shared bucket makes 1
    (the imported `splitEvent`). -/
theorem collide_totals {κ : Type*} [Fintype κ] (p : Placement) (u : Bucket ι) (v : Bucket κ) :
    ∑ i, u.share i + ∑ k, v.share k = beforeSplit ∧
      ∑ x, (collide p u v).share x = splitEvent p.student := by
  refine ⟨?_, ?_⟩
  · rw [u.share_sum, v.share_sum]; norm_num [beforeSplit, startMentor, startStudent]
  · rw [(collide p u v).share_sum, shares_split]

/-- No side leads: meeting `u` with `v` is meeting `v` with `u` with the shares swapped and the
    parts relabelled. -/
theorem collide_swap {κ : Type*} [Fintype κ] (p : Placement) (u : Bucket ι) (v : Bucket κ)
    (x : ι ⊕ κ) :
    (collide p u v).clean x = (collide (swapPlacement p) v u).clean x.swap ∧
      (collide p u v).dirty x = (collide (swapPlacement p) v u).dirty x.swap := by
  rcases x with i | k
  · simp [collide, swapPlacement, Placement.mentor, mentorOf, sharedWhole]
  · simp [collide, swapPlacement, Placement.mentor]

/-! ## Separating after the meetings -/

/-- Meetings never move anything between the sides: each side keeps its total. -/
theorem meetAll_sides {κ : Type*} [Fintype κ] (b : Bucket (ι ⊕ κ)) (ms : List (Meeting (ι ⊕ κ))) :
    leftTotal (b.meetAll ms) = leftTotal b ∧ rightTotal (b.meetAll ms) = rightTotal b := by
  constructor <;> simp [leftTotal, rightTotal, Bucket.meetAll_share]

theorem leftTotal_collide {κ : Type*} [Fintype κ] (p : Placement) (u : Bucket ι)
    (v : Bucket κ) : leftTotal (collide p u v) = p.student := by
  simp only [leftTotal, Bucket.share, collide, Sum.elim_inl, ← mul_add, ← Finset.mul_sum]
  rw [u.full, mul_one]

theorem rightTotal_collide {κ : Type*} [Fintype κ] (p : Placement) (u : Bucket ι)
    (v : Bucket κ) : rightTotal (collide p u v) = p.mentor := by
  simp only [rightTotal, Bucket.share, collide, Sum.elim_inr, ← mul_add, ← Finset.mul_sum]
  rw [v.full, mul_one]

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
  intro b
  have hL : leftTotal b = p.student := by
    rw [(meetAll_sides _ ms).1, leftTotal_collide]
  have hR : rightTotal b = p.mentor := by
    rw [(meetAll_sides _ ms).2, rightTotal_collide]
  refine ⟨hL ▸ hs, hR ▸ hm, (takeLeft b _).full, (takeRight b _).full, ?_, ?_, hL, hR⟩
  · intro i
    have h1 : b.dirty (Sum.inl i) ≤ p.student * u.dirty i :=
      (collide p u v).meetAll_dirty_le ms (Sum.inl i)
    show b.dirty (Sum.inl i) / leftTotal b ≤ u.dirty i
    rw [hL, div_le_iff₀ hs]; linarith
  · intro k
    have h1 : b.dirty (Sum.inr k) ≤ p.mentor * v.dirty k :=
      (collide p u v).meetAll_dirty_le ms (Sum.inr k)
    show b.dirty (Sum.inr k) / rightTotal b ≤ v.dirty k
    rw [hR, div_le_iff₀ hm]; linarith

/-- If some meeting swaps part of the first side's dirt at part `i` (where it has some), the first
    side leaves with strictly less dirt there than it came with. -/
theorem run_left_cleaner {κ : Type*} [Fintype κ] (p : Placement) (hs : 0 < p.student)
    (u : Bucket ι) (v : Bucket κ) (m : Meeting (ι ⊕ κ)) (ms : List (Meeting (ι ⊕ κ))) (i : ι)
    (hd : 0 < u.dirty i) (hr : 0 < m.r (Sum.inl i)) :
    ((collide p u v).meetAll (m :: ms)).dirty (Sum.inl i) < p.student * u.dirty i := by
  have h1 := ((collide p u v).meet m).meetAll_dirty_le ms (Sum.inl i)
  have h2 : ((collide p u v).meet m).dirty (Sum.inl i) < p.student * u.dirty i := by
    simp only [Bucket.meet, collide, Sum.elim_inl]
    have : 0 < p.student * u.dirty i := mul_pos hs hd
    nlinarith
  simp only [Bucket.meetAll, List.foldl_cons] at h1 ⊢
  exact lt_of_le_of_lt h1 h2

/-! ## The paired rule as a two-part bucket -/

/-- `dialPair k` is a two-part bucket. -/
theorem dialPair_bucket (k : Fin 6) :
    ∃ b : Bucket Bool, b.share true = (dialPair k).1 ∧ b.share false = (dialPair k).2 := by
  have h5 : (k.val : ℚ) ≤ 5 := by exact_mod_cast (by omega : k.val ≤ 5)
  refine ⟨pairBucket _ _ (by simp [dialPair]; positivity) (by simp [dialPair]; linarith)
    (dialPair_total k), ?_, ?_⟩ <;> simp [Bucket.share, pairBucket]

/-- `writeMove` on a pair adding to 1 is a transfer from part `false` to part `true`. -/
theorem writeMove_is_transfer (x : ℚ) (hx : 0 ≤ x) (hx1 : x ≤ 1) :
    let b := pairBucket x (1 - x) hx (by linarith) (by ring)
    ∃ (ha : 0 ≤ min (1 - x) (1 - x)) (haj : min (1 - x) (1 - x) ≤ b.clean false),
      (b.transfer true false (by decide) _ ha haj).clean true = (writeMove (x, 1 - x)).1 ∧
      (b.transfer true false (by decide) _ ha haj).clean false = (writeMove (x, 1 - x)).2 := by
  intro b
  refine ⟨by simp; linarith, by simp [b, pairBucket], ?_, ?_⟩ <;>
    simp [Bucket.transfer, b, pairBucket, writeMove]

/-- `triageMove k` on a pair adding to 1 is a transfer from part `true` to part `false`. -/
theorem triageMove_is_transfer (k : Fin 6) (x : ℚ) (hx : 0 ≤ x) (hx1 : x ≤ 1) :
    let b := pairBucket x (1 - x) hx (by linarith) (by ring)
    ∃ (ha : 0 ≤ lossDial k * x) (haj : lossDial k * x ≤ b.clean true),
      (b.transfer false true (by decide) _ ha haj).clean true = (triageMove k (x, 1 - x)).1 ∧
      (b.transfer false true (by decide) _ ha haj).clean false = (triageMove k (x, 1 - x)).2 := by
  intro b
  have h0 : 0 ≤ lossDial k := by simp [lossDial]; positivity
  have h1 : lossDial k ≤ 1 := by
    have : (k.val : ℚ) ≤ 5 := by exact_mod_cast (by omega : k.val ≤ 5)
    simp [lossDial]; linarith
  refine ⟨mul_nonneg h0 hx, by simp [b, pairBucket]; nlinarith, ?_, ?_⟩ <;>
    simp [Bucket.transfer, b, pairBucket, triageMove]

/-! ## Concrete check -/

example : (threeParts.meet halfMeeting).clean 0 = 3/8 ∧ (threeParts.meet halfMeeting).dirty 0 = 1/8 ∧
    (threeParts.meet halfMeeting).share 0 = 1/2 ∧ (threeParts.meet halfMeeting).dirtTotal = 5/24 ∧
    threeParts.dirtTotal = 5/12 := by
  simp [Bucket.meet, threeParts, halfMeeting, Bucket.share, Bucket.dirtTotal, Fin.sum_univ_three]
  norm_num

/-! ## A start holds its history and what is ahead in one bucket -/

variable {η φ : Type*} [Fintype η] [Fintype φ]

/-- History and what is ahead are held in the same bucket at 0: together they make 1. -/
theorem start_holds_both (s : Start η φ) : leftTotal s + rightTotal s = 1 := by
  rw [leftTotal, rightTotal, ← Fintype.sum_sum_type]; exact s.full

/-- History of any length: for every `n` there is a full start with `n + 1` history parts, each
    with a share above 0. -/
theorem history_any_length (n : Nat) :
    ∃ s : Start (Fin (n + 1)) Unit, ∀ i, 0 < s.share (Sum.inl i) :=
  ⟨historyStart n, fun i => by simp [historyStart, Bucket.share]; positivity⟩

/-- The meeting at each prime tick acts on a start by one rule, on its history parts and its ahead
    parts alike: each share kept, clean never falls, dirt never rises, history total and ahead
    total kept, still full. -/
theorem past_meetings_same_rule (f : Nat → Meeting (η ⊕ φ)) (s : Start η φ) (i p : Nat)
    (_h : labels[i]? = some p) :
    let t := s.meet (f p)
    (∀ x, t.share x = s.share x ∧ s.clean x ≤ t.clean x ∧ t.dirty x ≤ s.dirty x) ∧
      leftTotal t = leftTotal s ∧ rightTotal t = rightTotal s ∧ leftTotal t + rightTotal t = 1 := by
  intro t
  have hs := meetAll_sides s [f p]
  simp only [Bucket.meetAll, List.foldl_cons, List.foldl_nil] at hs
  exact ⟨fun x => ⟨s.meet_share (f p) x, s.meet_clean_le (f p) x, s.meet_dirty_le (f p) x⟩,
    hs.1, hs.2, start_holds_both t⟩

/-- All the prime-tick meetings in order act on a start by the same rule. -/
theorem start_run_same_rule (f : Nat → Meeting (η ⊕ φ)) (s : Start η φ) :
    let t := s.meetAll (tickMeetings f)
    (∀ x, t.share x = s.share x ∧ s.clean x ≤ t.clean x ∧ t.dirty x ≤ s.dirty x) ∧
      leftTotal t = leftTotal s ∧ rightTotal t = rightTotal s ∧ leftTotal t + rightTotal t = 1 := by
  intro t
  have hs := meetAll_sides s (tickMeetings f)
  exact ⟨fun x => ⟨s.meetAll_share _ x, s.meetAll_clean_le _ x, s.meetAll_dirty_le _ x⟩,
    hs.1, hs.2, start_holds_both t⟩

/-- Two starts meet at 0,0: each is full (2 together, `beforeSplit`), the shared bucket is full
    (`splitEvent`), and every part of each start, history and ahead, is carried in at its share
    times the placement weight. -/
theorem starts_meet {η' φ' : Type*} [Fintype η'] [Fintype φ'] (pl : Placement) (s₁ : Start η φ)
    (s₂ : Start η' φ') :
    ∑ x, s₁.share x + ∑ y, s₂.share y = beforeSplit ∧
      ∑ z, (collide pl s₁ s₂).share z = splitEvent pl.student ∧
      (∀ x, (collide pl s₁ s₂).share (Sum.inl x) = pl.student * s₁.share x) ∧
      (∀ y, (collide pl s₁ s₂).share (Sum.inr y) = pl.mentor * s₂.share y) := by
  refine ⟨(collide_totals pl s₁ s₂).1, (collide_totals pl s₁ s₂).2, fun x => ?_, fun y => ?_⟩
  · simp [collide, Bucket.share, mul_add]
  · simp [collide, Bucket.share, mul_add]

/-- Concrete: a start with 13 history parts (one per prime tick) and half the dirt swapped at
    each of the 13 prime ticks: history part 0 keeps `(1/2)^13` of its dirt `1/26`; the history
    total stays `1/2`. -/
example : ((historyStart 12).meetAll (tickMeetings (fun _ => ⟨fun _ => 1/2, fun _ => by norm_num,
      fun _ => by norm_num⟩))).dirty (Sum.inl 0) = (1/2)^13 * (1/26) ∧
    leftTotal (historyStart 12) = 1/2 := by
  refine ⟨?_, ?_⟩
  · rw [Bucket.meetAll_dirty]
    simp [tickMeetings, labels_eq, historyStart]
    norm_num
  · simp [leftTotal, historyStart, Bucket.share]
    norm_num

/-! ## Break attempts -/

/-- A swap fraction above 1 would push dirt below 0: the `r_le_one` bound is needed. -/
example : (1/4 : ℚ) - 3/2 * (1/4) < 0 := by norm_num

/-- Any move of share between the two sides changes a side total, so it cannot be hidden. -/
theorem transfer_changes_side {κ : Type*} [Fintype κ] [DecidableEq ι] [DecidableEq κ]
    (b : Bucket (ι ⊕ κ)) (i : ι) (k : κ) (a : ℚ) (ha : 0 ≤ a) (hak : a ≤ b.clean (Sum.inr k)) :
    rightTotal (b.transfer (Sum.inl i) (Sum.inr k) Sum.inl_ne_inr a ha hak) = rightTotal b - a := by
  unfold rightTotal Bucket.share Bucket.transfer
  simp only [Sum.inr.injEq, reduceCtorEq, if_false]
  have key : ∀ x, ((if x = k then b.clean (Sum.inr x) - a else b.clean (Sum.inr x)) +
      b.dirty (Sum.inr x)) = (b.clean (Sum.inr x) + b.dirty (Sum.inr x)) - (if x = k then a else 0) := by
    intro x; split_ifs <;> ring
  simp only [key, Finset.sum_sub_distrib, Finset.sum_ite_eq', Finset.mem_univ, ite_true]

end ViscousTimeReversal

end

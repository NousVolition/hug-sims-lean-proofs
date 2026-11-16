import ViscousTimeReversalProofs
import ViscousTimeReversalMeterDefinitions

/-! Proofs for the meter, the two windows taking turns, the 0,0 bucket, reversal on a whole,
the back ticks and the count through 0. -/

namespace ViscousTimeReversal

open MentorStudent

open scoped BigOperators

/-! ## The meter -/

/-- One fill or one empty keeps a meter between 0 and 5/5. -/
theorem move_stays_in_meter (m : Move) {x : ℚ} (hx : InMeter x) : InMeter (m.apply x) := by
  obtain ⟨h0, h1⟩ := hx
  cases m with
  | fill a =>
    simp only [Move.apply, InMeter]
    constructor
    · exact le_min (by norm_num) (by linarith [le_max_right a 0])
    · exact min_le_left _ _
  | empty a =>
    simp only [Move.apply, InMeter]
    constructor
    · exact le_max_left _ _
    · exact max_le (by norm_num) (by linarith [le_max_right a 0])

/-- Any finite run of fills and empties, of any length, keeps a meter between 0 and 5/5. -/
theorem meter_stays_in_meter (ms : List Move) {x : ℚ} (hx : InMeter x) :
    InMeter (runMeter x ms) := by
  induction ms generalizing x with
  | nil => simpa [runMeter] using hx
  | cons m ms ih =>
    simp only [runMeter, List.foldl_cons]
    exact ih (move_stays_in_meter m hx)

/-- The marked piece: both meters start full at 5/5. -/
theorem meter_starts_full :
    markedPiece.a = 5 / 5 ∧ markedPiece.b = 5 / 5 ∧ markedPiece.InMeter := by
  refine ⟨rfl, rfl, ?_, ?_⟩ <;> norm_num [markedPiece, InMeter]

/-! ## Two windows taking turns -/

/-- When window A hops, window B stays fixed; when window B hops, window A stays fixed. -/
theorem windows_take_turns (m : Move) (c : Couple) :
    ((Hop.A m).apply c).b = c.b ∧ ((Hop.A m).apply c).a = m.apply c.a ∧
      ((Hop.B m).apply c).a = c.a ∧ ((Hop.B m).apply c).b = m.apply c.b :=
  ⟨rfl, rfl, rfl, rfl⟩

theorem hop_stays_in_meter (h : Hop) {c : Couple} (hc : c.InMeter) : (h.apply c).InMeter := by
  cases h with
  | A m => exact ⟨move_stays_in_meter m hc.1, hc.2⟩
  | B m => exact ⟨hc.1, move_stays_in_meter m hc.2⟩

/-- Any finite run of hops, of any length, keeps both meters between 0 and 5/5. -/
theorem leapfrog_stays_in_meter (hs : List Hop) {c : Couple} (hc : c.InMeter) :
    (leapfrog c hs).InMeter := by
  induction hs generalizing c with
  | nil => simpa [leapfrog] using hc
  | cons h hs ih =>
    simp only [leapfrog, List.foldl_cons]
    exact ih (hop_stays_in_meter h hc)

/-! ## The 0,0 meeting -/

/-- Two full meters meet at 0,0: 5/5 and 5/5 make 2 before the meeting (`beforeSplit`), and
    one full 5/5 bucket after it (`splitEvent`), for every placement. -/
theorem two_full_meters_one_bucket (pl : Placement) :
    markedPiece.a + markedPiece.b = beforeSplit ∧ meetAtZero pl markedPiece = 5 / 5 ∧
      meetAtZero pl markedPiece = splitEvent pl.student := by
  refine ⟨?_, ?_, ?_⟩
  · norm_num [markedPiece, beforeSplit, startMentor, startStudent]
  · simp only [meetAtZero, markedPiece, Placement.mentor, mentorOf, sharedWhole]; ring
  · simp only [meetAtZero, markedPiece, Placement.mentor, splitEvent, mentorOf, sharedWhole]
    ring

/-- The bucket made at the 0,0 meeting stays between 0 and 5/5 whatever the two meters read. -/
theorem meeting_stays_in_meter (pl : Placement) {c : Couple} (hc : c.InMeter) :
    InMeter (meetAtZero pl c) := by
  obtain ⟨⟨a0, a1⟩, ⟨b0, b1⟩⟩ := hc
  have s0 := pl.atLeastZero
  have s1 := pl.atMostOne
  simp only [meetAtZero, Placement.mentor, mentorOf, sharedWhole, InMeter] at *
  constructor
  · nlinarith [mul_nonneg s0 a0, mul_nonneg (sub_nonneg.mpr s1) b0]
  · nlinarith [mul_nonneg s0 (sub_nonneg.mpr a1), mul_nonneg (sub_nonneg.mpr s1) (sub_nonneg.mpr b1)]

/-! ## The bucket fills and empties without end -/

theorem empty_then_fill_from_full (x : ℚ) :
    (Move.fill x).apply ((Move.empty x).apply (5 / 5)) = 5 / 5 := by
  simp only [Move.apply]
  rcases le_total x 0 with hx | hx
  · simp [max_eq_right hx]
  · rw [max_eq_left hx]
    rcases le_total x 1 with h1 | h1
    · rw [max_eq_right (by linarith : (0 : ℚ) ≤ 5 / 5 - x)]
      exact min_eq_left (by linarith)
    · rw [max_eq_left (by linarith : (5 / 5 : ℚ) - x ≤ 0)]
      exact min_eq_left (by linarith)

/-- One round, A then B, starting full ends full again. -/
theorem round_returns_full (x : ℚ) : leapfrog markedPiece (round x) = markedPiece := by
  simp only [leapfrog, round, List.foldl_cons, List.foldl_nil, Hop.apply, markedPiece,
    empty_then_fill_from_full]

/-- Any number of rounds, each of any amount: the bucket is back at 5/5 and 5/5 after every one. -/
theorem infinity_bucket (xs : List ℚ) : leapfrog markedPiece (rounds xs) = markedPiece := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    simp only [rounds, List.flatMap_cons, leapfrog, List.foldl_append] at ih ⊢
    rw [show List.foldl (fun d h => Hop.apply h d) markedPiece (round x) = markedPiece from
      round_returns_full x]
    exact ih

/-- There is no last round: after any run of hops, both windows fill back to 5/5 and any number
    of further rounds follow. -/
theorem no_last_round {c : Couple} (hc : c.InMeter) (hs : List Hop) (xs : List ℚ) :
    leapfrog c (hs ++ refill ++ rounds xs) = markedPiece := by
  have hd := leapfrog_stays_in_meter hs hc
  have hr : leapfrog (leapfrog c hs) refill = markedPiece := by
    obtain ⟨⟨a0, _⟩, ⟨b0, _⟩⟩ := hd
    simp only [leapfrog, refill, List.foldl_cons, List.foldl_nil, Hop.apply, Move.apply,
      markedPiece] at *
    congr 1 <;> exact min_eq_left (by norm_num; linarith)
  have hsplit : leapfrog c (hs ++ refill ++ rounds xs) =
      leapfrog (leapfrog (leapfrog c hs) refill) (rounds xs) := by
    simp only [leapfrog, List.foldl_append]
  rw [hsplit, hr, infinity_bucket]

/-- Reversal keeps the meters whole: run backward around the split, both meters and the 0,0
    bucket stay between 0 and 5/5, and reversing twice gives back the meters. -/
theorem reversal_keeps_meter (m : ℝ → Couple) (h : ∀ t, (m t).InMeter) (pl : Placement)
    (t : ℝ) :
    (reverseAroundSplit m t).InMeter ∧ InMeter (meetAtZero pl (reverseAroundSplit m t)) ∧
      reverseAroundSplit (reverseAroundSplit m) t = m t :=
  ⟨h _, meeting_stays_in_meter pl (h _), reverse_twice m t⟩

/-! ## The guards in `FullModel.lean` -/

/-- When the two guard readings at a point are meter levels, the wall there, which is
    `HugNavierSingle.viscosity`, is between the thin wall 1/50 and the thick wall 1/10. -/
theorem guard_meters_set_the_wall (z : HugNavierSingle.Fields) (r : HugNavierSingle.Point)
    {c : Couple} (hc : c.InMeter) (hA : z.gAB r = (c.a : ℝ)) (hB : z.gBA r = (c.b : ℝ)) :
    HugNavierSingle.viscosity z r ∈ Set.Icc (1 / 50 : ℝ) (1 / 10) := by
  obtain ⟨⟨a0, a1⟩, ⟨b0, b1⟩⟩ := hc
  norm_num at a1 b1
  rw [wall_is_single_system_viscosity, hA, hB]
  exact wall_between_thin_and_thick _ _ ⟨by exact_mod_cast a0, by exact_mod_cast a1⟩
    ⟨by exact_mod_cast b0, by exact_mod_cast b1⟩

/-- Guard meters run through any finite sequence of hops keep the wall between thin and thick;
    at the marked piece, both guards full, the wall is the thick wall. -/
theorem leapfrog_keeps_the_wall {c : Couple} (hc : c.InMeter) (hs : List Hop) :
    wall ((leapfrog c hs).a : ℝ) ((leapfrog c hs).b : ℝ) ∈ Set.Icc (1 / 50 : ℝ) (1 / 10) ∧
      wall (markedPiece.a : ℝ) (markedPiece.b : ℝ) = thickWall := by
  obtain ⟨⟨a0, a1⟩, ⟨b0, b1⟩⟩ := leapfrog_stays_in_meter hs hc
  norm_num at a1 b1
  refine ⟨wall_between_thin_and_thick _ _ ⟨by exact_mod_cast a0, by exact_mod_cast a1⟩
    ⟨by exact_mod_cast b0, by exact_mod_cast b1⟩, ?_⟩
  norm_num [markedPiece, thickWall]

/-- Contact passes through the guards: the part of A's reaction that comes from B is
    `weightAB * gAB * (xB - xA)`, and B's is `weightBA * gBA * (xA - xB)`; with a guard at 0
    that part is 0. -/
theorem contact_through_guards (i : HugNavierSingle.FieldInputs) (t : ℝ)
    (z : HugNavierSingle.Fields) (r : HugNavierSingle.Point) :
    HugNavierSingle.reactionA i t z r - (-11 / 20 - z.xA r + i.sourceA t r) =
        i.weightAB * z.gAB r * (z.xB r - z.xA r) ∧
      HugNavierSingle.reactionB i t z r - (7 / 20 - z.xB r + i.sourceB t r) =
        i.weightBA * z.gBA r * (z.xA r - z.xB r) ∧
      (z.gAB r = 0 → HugNavierSingle.reactionA i t z r = -11 / 20 - z.xA r + i.sourceA t r) ∧
      (z.gBA r = 0 → HugNavierSingle.reactionB i t z r = 7 / 20 - z.xB r + i.sourceB t r) := by
  refine ⟨?_, ?_, fun h => ?_, fun h => ?_⟩
  · simp only [HugNavierSingle.reactionA]; ring
  · simp only [HugNavierSingle.reactionB]; ring
  · simp only [HugNavierSingle.reactionA, h]; ring
  · simp only [HugNavierSingle.reactionB, h]; ring

/-- Reversal acts on both guards together: run backward around the split, both guards are read
    at the same reversed time, and so is the wall built from them. -/
theorem reversal_moves_both_guards (z : ℝ → HugNavierSingle.Fields) (t : ℝ)
    (r : HugNavierSingle.Point) :
    (reverseAroundSplit z t).gAB r = (z (aroundSplit t)).gAB r ∧
      (reverseAroundSplit z t).gBA r = (z (aroundSplit t)).gBA r ∧
      HugNavierSingle.viscosity (reverseAroundSplit z t) r =
        wall ((z (aroundSplit t)).gAB r) ((z (aroundSplit t)).gBA r) :=
  ⟨rfl, rfl, wall_is_single_system_viscosity _ _⟩

/-! ## Reversal on a whole -/

variable {ι : Type} [Fintype ι]

/-- Reversal on a bucket of any number of parts: run backward around the split it is still
    full, and reversing twice gives back the bucket. -/
theorem reversal_keeps_bucket_full (b : ℝ → Bucket ι) (t : ℝ) :
    ∑ i, (reverseAroundSplit b t).share i = 1 ∧
      reverseAroundSplit (reverseAroundSplit b) t = b t :=
  ⟨Bucket.share_sum _, reverse_twice b t⟩

variable {η φ : Type} [Fintype η] [Fintype φ]

/-- Reversal on a start: run backward, its history and what is ahead still make 1 together,
    and reversing twice gives back the start. -/
theorem reversal_keeps_start (s : ℝ → Start η φ) (t : ℝ) :
    leftTotal (reverseAroundSplit s t) + rightTotal (reverseAroundSplit s t) = 1 ∧
      reverseAroundSplit (reverseAroundSplit s) t = s t :=
  ⟨start_holds_both _, reverse_twice s t⟩

/-! ## Back ticks at the reversed time -/

theorem schedule_get_some {i : Nat} {k : Tick} (h : schedule[i]? = some k) :
    ∃ p, labels[i]? = some p ∧ k = ⟨p, 32 * i, 25 * i, 100000 * i⟩ := by
  rw [← scheduleWith_32_25, scheduleWith_get] at h
  obtain ⟨p, hp, hk⟩ := Option.map_eq_some_iff.mp h
  exact ⟨p, hp, hk.symm⟩

/-- Every prime tick in the schedule: the back tick at the same index is the same tick, placed
    at `-p`; the forward tick sits at time `i/10`, the back tick at the reversed time `-(i/10)`,
    and reversing twice returns it. -/
theorem back_ticks_at_reversed_time (i : Nat) (k : Tick) (h : schedule[i]? = some k) :
    (pastSchedule 32 25)[i]? = some (k, place .past k.label) ∧ tickTime k = (i : ℝ) / 10 ∧
      aroundSplit (tickTime k) = -((i : ℝ) / 10) ∧
      aroundSplit (aroundSplit (tickTime k)) = tickTime k := by
  obtain ⟨p, hp, rfl⟩ := schedule_get_some h
  have ht : tickTime ⟨p, 32 * i, 25 * i, 100000 * i⟩ = (i : ℝ) / 10 := by
    simp only [tickTime]; push_cast; ring
  refine ⟨?_, ht, ?_, ?_⟩
  · rw [pastSchedule_get, hp]; rfl
  · rw [ht]; rfl
  · simp [aroundSplit]

/-! ## 0 holds the past and the future together -/

/-- At 0 a start holds its history and what is ahead together, and reversal leaves it in place;
    the forward tick and the back tick at index 0 are the same instant, time 0. -/
theorem zero_holds_past_and_future (s : ℝ → Start η φ) :
    aroundSplit 0 = 0 ∧ reverseAroundSplit s 0 = s 0 ∧
      leftTotal (s 0) + rightTotal (s 0) = 1 ∧
      (schedule[0]?).map tickTime = some 0 ∧
      ((pastSchedule 32 25)[0]?).map (fun x => tickTime x.1) = some 0 := by
  refine ⟨by simp [aroundSplit], by simp [reverseAroundSplit, aroundSplit],
    start_holds_both _, ?_, ?_⟩
  · rw [show schedule[0]? = some ⟨2, 0, 0, 0⟩ by decide]; simp [tickTime]
  · rw [pastSchedule_get]
    rw [show labels[0]? = some 2 by decide]; simp [tickTime]

/-! ## 0 is not the limit -/

/-- The count through 0: one count over all whole numbers, back places below 0 and ahead places
    above 0, each step 1/10 with no break at 0. Reversal sends place `n` to place `-n`, and at
    every place the forward and backward factors multiply to 1, the backward factor at `n` is
    the forward factor at `-n`, and the forward factor has its derivative there. -/
theorem count_through_zero (n : ℤ) (ν q : ℝ) :
    countTime 0 = 0 ∧ countTime (n + 1) - countTime n = 1 / 10 ∧
      aroundSplit (countTime n) = countTime (-n) ∧
      forwardFactor ν q (countTime n) * backwardFactor ν q (countTime n) = 1 ∧
      forwardFactor ν q (countTime (-n)) = backwardFactor ν q (countTime n) ∧
      HasDerivAt (forwardFactor ν q) (-(ν * q) * forwardFactor ν q (countTime n))
        (countTime n) := by
  refine ⟨by simp [countTime], ?_, ?_, factor_cancellation _ _ _, ?_,
    forwardFactor_derivative _ _ _⟩
  · simp only [countTime]; push_cast; ring
  · simp only [aroundSplit, countTime]; push_cast; ring
  · simp only [forwardFactor, backwardFactor, countTime]; push_cast; ring_nf

/-- The count meets the prime ticks: place `i` is the forward tick at index `i`, and place `-i`
    is its back tick, at the reversed time. -/
theorem count_meets_ticks (i : Nat) (k : Tick) (h : schedule[i]? = some k) :
    countTime i = tickTime k ∧ countTime (-(i : ℤ)) = aroundSplit (tickTime k) := by
  obtain ⟨_, ht, hrev, _⟩ := back_ticks_at_reversed_time i k h
  refine ⟨?_, ?_⟩
  · rw [ht]; simp [countTime]
  · rw [hrev]; simp [countTime]; ring

end ViscousTimeReversal

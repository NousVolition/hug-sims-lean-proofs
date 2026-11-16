import ViscousTimeReversalMeterChallenge
import ViscousTimeReversalFilterDefinitions

/-! Statements for the write, the remainder and the filter loop.

Four results about the model: a write conserves the overlap exactly (bucket gain plus remainder
is the whole overlap); the user's bucket never leaves the meter, 0 to 5/5, however many filter
passes run; a filter with a fixed share settles geometrically, at the same rate `keep` at which
the chain loses what it holds between writes; and all of this is symmetric under reversal around
the 0,0 split. Sources: `MentorStudentModel.lean`, `ViscousTimeReversalBucketDefinitions.lean`,
`HugWallPush/HugWallPushDefinitions.lean`, `HugWallPush/HugWallPushProofs.lean`. -/

namespace ViscousTimeReversal

open MentorStudent Filter Topology

/-! ## The write -/

/-- An overlap that fits is counted whole. -/
theorem keptOverlap_fits (s d : ℚ) (h0 : 0 ≤ s + d) (h1 : s + d ≤ 1) : keptOverlap s d = d := by
  sorry

/-- At a write, what goes into the user's bucket plus the remainder is the whole overlap, and the
    bucket after the write, which is the student's part of `moveOverlap`, stays in the meter. -/
theorem write_counts_whole (s d : ℚ) :
    keptOverlap s d + remainder s d = d ∧ InMeter (s + keptOverlap s d) ∧
      (moveOverlap s (keptOverlap s d)).1 = s + keptOverlap s d := by
  sorry

/-- An overlap that fits leaves no remainder. -/
theorem write_fits_no_remainder (s d : ℚ) (h0 : 0 ≤ s + d) (h1 : s + d ≤ 1) :
    remainder s d = 0 := by
  sorry

/-- An overlap bigger than the room fills the bucket: what goes in is `partnerSupply`, the bucket
    is at `afterWrite`, which is 1, and the remainder is the overlap less `partnerSupply`. -/
theorem write_fills_bucket (s d : ℚ) (h : 1 - s ≤ d) :
    keptOverlap s d = partnerSupply s ∧ s + keptOverlap s d = afterWrite s ∧
      afterWrite s = 1 ∧ remainder s d = d - partnerSupply s := by
  sorry

/-! ## The filter loop keeps the count and the meter -/

/-- One pass loses nothing: the remainder plus what has passed is the same, and the bucket
    gains exactly what passes. -/
theorem filter_pass_counts_whole (q : ℚ) (x : FilterLoop) :
    (filterPass q x).rest + (filterPass q x).passed = x.rest + x.passed ∧
      (filterPass q x).bucket - (filterPass q x).passed = x.bucket - x.passed := by
  sorry

/-- After a pass the user's bucket is in the meter, from 0 to 5/5. -/
theorem filter_pass_in_meter (q : ℚ) (x : FilterLoop) : InMeter (filterPass q x).bucket := by
  sorry

/-- Any number of passes loses nothing and keeps the user's bucket in the meter. -/
theorem filter_loop_counts_whole (q : ℚ) (x : FilterLoop) (hx : InMeter x.bucket) (n : Nat) :
    (filterLoop q x n).rest + (filterLoop q x n).passed = x.rest + x.passed ∧
      (filterLoop q x n).bucket - (filterLoop q x n).passed = x.bucket - x.passed ∧
      InMeter (filterLoop q x n).bucket := by
  sorry

/-- With a fill or an empty on the user's bucket before each pass, any number of passes still
    keeps the remainder plus what has passed the same, and the bucket in the meter. -/
theorem filter_loop_with_moves (q : ℚ) (ms : List Move) (x : FilterLoop) (hx : InMeter x.bucket) :
    (filterLoopWith q x ms).rest + (filterLoopWith q x ms).passed = x.rest + x.passed ∧
      InMeter (filterLoopWith q x ms).bucket := by
  sorry

/-! ## A filter with a fixed share settles -/

/-- A filter that passes the fixed share `q` each pass, with room in the bucket for the whole
    remainder: after `n` passes the remainder is `(1 - q)^n` times the start, and the rest of it
    has passed into the bucket. -/
theorem filter_share_settles (q : ℚ) (hq0 : 0 ≤ q) (hq1 : q ≤ 1) (x : FilterLoop)
    (hb : 0 ≤ x.bucket) (hr : 0 ≤ x.rest) (hroom : x.bucket + x.rest ≤ 1) (n : Nat) :
    (filterLoop q x n).rest = (1 - q) ^ n * x.rest ∧
      (filterLoop q x n).passed = x.passed + (1 - (1 - q) ^ n) * x.rest ∧
      (filterLoop q x n).bucket = x.bucket + (1 - (1 - q) ^ n) * x.rest := by
  sorry

/-- The chain's own rate as the filter share: passing `loss` (1/5) each pass and leaving `keep`
    (4/5), the remainder after `n` passes is `held n` times the start, that is `(4/5)^n` times the
    start. The loop decays at exactly the rate the chain loses what it holds between writes. -/
theorem A_filter_settles (x : FilterLoop) (hb : 0 ≤ x.bucket) (hr : 0 ≤ x.rest)
    (hroom : x.bucket + x.rest ≤ 1) (n : Nat) :
    (filterLoop loss x n).rest = held n * x.rest ∧ held n = keep ^ n ∧
      (filterLoop loss x n).passed = x.passed + (1 - held n) * x.rest := by
  sorry

/-- The loop settles: for a share `q` above 0, the remainder goes to 0 and the total passed into
    the bucket goes to everything that went out to be filtered. -/
theorem filter_loop_settles (q : ℚ) (hq0 : 0 < q) (hq1 : q ≤ 1) (x : FilterLoop)
    (hb : 0 ≤ x.bucket) (hr : 0 ≤ x.rest) (hroom : x.bucket + x.rest ≤ 1) :
    Tendsto (fun n => ((filterLoop q x n).rest : ℝ)) atTop (𝓝 0) ∧
      Tendsto (fun n => ((filterLoop q x n).passed : ℝ)) atTop (𝓝 ((x.passed : ℝ) + x.rest)) := by
  sorry

/-- At the chain's rate the loop settles: the remainder goes to 0 and the total passed goes to
    everything that went out to be filtered. -/
theorem A_filter_limit (x : FilterLoop) (hb : 0 ≤ x.bucket) (hr : 0 ≤ x.rest)
    (hroom : x.bucket + x.rest ≤ 1) :
    Tendsto (fun n => ((filterLoop loss x n).rest : ℝ)) atTop (𝓝 0) ∧
      Tendsto (fun n => ((filterLoop loss x n).passed : ℝ)) atTop (𝓝 ((x.passed : ℝ) + x.rest)) := by
  sorry

/-! ## Reversal keeps the count -/

/-- The loop run against time, any number of passes `f t` at each time `t`: run backward around
    the split it has the same totals, the bucket stays in the meter, and reversing twice returns
    it. -/
theorem filter_loop_reversal (q : ℚ) (x : FilterLoop) (hx : InMeter x.bucket) (f : ℝ → Nat)
    (t : ℝ) :
    (reverseAroundSplit (fun s => filterLoop q x (f s)) t).rest +
        (reverseAroundSplit (fun s => filterLoop q x (f s)) t).passed = x.rest + x.passed ∧
      (reverseAroundSplit (fun s => filterLoop q x (f s)) t).bucket -
        (reverseAroundSplit (fun s => filterLoop q x (f s)) t).passed = x.bucket - x.passed ∧
      InMeter (reverseAroundSplit (fun s => filterLoop q x (f s)) t).bucket ∧
      reverseAroundSplit (reverseAroundSplit (fun s => filterLoop q x (f s))) t =
        filterLoop q x (f t) := by
  sorry

/-! ## The first write and the freeze -/

/-- The writes are at ticks 11, 23 and 41. The first write is tick 11 at time 4/10; the freeze
    follows it at tick 23, time 8/10, after 200 mentor steps and 256 student steps, for every
    placement. Sources: `MentorStudentModel.lean` (`writeTicks`, `schedule`, `Freeze`),
    `HugWallPush/HugWallPushProofs.lean` (`freeze_step_counts`). -/
theorem first_write_then_freeze (p : Placement) :
    writeTicks = [11, 23, 41] ∧ labels[4]? = some 11 ∧ labels[8]? = some 23 ∧
      (schedule[4]?).map tickTime = some (4 / 10) ∧ (schedule[8]?).map tickTime = some (8 / 10) ∧
      Freeze p 8 ∧ (200 : ℚ) * HugWallPush.mentorStep = 8 / 10 ∧
      (256 : ℚ) * HugWallPush.studentStep = 8 / 10 := by
  sorry

/-- The balance at the freeze closes the gap in the same proportions as the chain's `keep` and
    `loss`: the mentor moves `keep` (4/5) of the gap and the student `loss` (1/5), the shared total
    is kept, and 2/25 of the squared gap is given off. Sources:
    `HugWallPush/HugWallPushDefinitions.lean` section 6, `HugWallPush/HugWallPushProofs.lean`
    (`gap_split`, `freeze_keeps_total`, `freeze_gives_off`), `MentorStudentModel.lean`. -/
theorem freeze_shares_match_keep_and_loss (xM xS : ℝ) :
    ((loss : ℚ) : ℝ) = 1 / 5 ∧ ((keep : ℚ) : ℝ) = 4 / 5 ∧
      HugWallPush.balance xM xS - xM = (keep : ℝ) * (xS - xM) ∧
      xS - HugWallPush.balance xM xS = (loss : ℝ) * (xS - xM) ∧
      1 / 5 * HugWallPush.balance xM xS + 4 / 5 * HugWallPush.balance xM xS =
        1 / 5 * xM + 4 / 5 * xS ∧
      (1 / 5 * xM ^ 2 + 4 / 5 * xS ^ 2) / 2 - (1 / 5 + 4 / 5) * HugWallPush.balance xM xS ^ 2 / 2
        = 2 / 25 * (xS - xM) ^ 2 := by
  sorry

end ViscousTimeReversal

import ViscousTimeReversalMeterChallenge
import ViscousTimeReversalFilterDefinitions

/-! Statements for the write, the remainder and the filter loop. -/

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

/-- A's filter: passing the let-go of 1/5 each pass and keeping 4/5 unsettled, the remainder
    after `n` passes is `held n` times the start, which is `(4/5)^n` times the start. -/
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

/-- A's filter settles: the remainder goes to 0 and the total passed goes to everything that went
    out to be filtered. -/
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

end ViscousTimeReversal

import ViscousTimeReversalMeterProofs
import ViscousTimeReversalFilterDefinitions

/-! Proofs for the write, the remainder and the filter loop. -/

namespace ViscousTimeReversal

open MentorStudent Filter Topology

/-! ## The write -/

/-- An overlap that fits is counted whole. -/
theorem keptOverlap_fits (s d : ℚ) (h0 : 0 ≤ s + d) (h1 : s + d ≤ 1) : keptOverlap s d = d := by
  unfold keptOverlap
  rw [min_eq_left (by linarith), max_eq_right (by linarith)]

/-- At a write, what goes into the user's bucket plus the remainder is the whole overlap, and the
    bucket after the write, which is the student's part of `moveOverlap`, stays in the meter. -/
theorem write_counts_whole (s d : ℚ) :
    keptOverlap s d + remainder s d = d ∧ InMeter (s + keptOverlap s d) ∧
      (moveOverlap s (keptOverlap s d)).1 = s + keptOverlap s d := by
  refine ⟨by simp [remainder], ?_, rfl⟩
  obtain ⟨h0, h1⟩ := keptOverlap_bounds s d
  exact ⟨h0, by norm_num; exact h1⟩

/-- An overlap that fits leaves no remainder. -/
theorem write_fits_no_remainder (s d : ℚ) (h0 : 0 ≤ s + d) (h1 : s + d ≤ 1) :
    remainder s d = 0 := by
  simp [remainder, keptOverlap_fits s d h0 h1]

/-- An overlap bigger than the room fills the bucket: what goes in is `partnerSupply`, the bucket
    is at `afterWrite`, which is 1, and the remainder is the overlap less `partnerSupply`. -/
theorem write_fills_bucket (s d : ℚ) (h : 1 - s ≤ d) :
    keptOverlap s d = partnerSupply s ∧ s + keptOverlap s d = afterWrite s ∧
      afterWrite s = 1 ∧ remainder s d = d - partnerSupply s := by
  have hk : keptOverlap s d = partnerSupply s := by
    unfold keptOverlap partnerSupply
    rw [min_eq_right h, max_eq_right (by linarith)]
  refine ⟨hk, by rw [hk]; rfl, by simp [afterWrite, partnerSupply], by simp [remainder, hk]⟩

/-! ## The filter loop keeps the count and the meter -/

/-- One pass loses nothing: the remainder plus what has passed is the same, and the bucket
    gains exactly what passes. -/
theorem filter_pass_counts_whole (q : ℚ) (x : FilterLoop) :
    (filterPass q x).rest + (filterPass q x).passed = x.rest + x.passed ∧
      (filterPass q x).bucket - (filterPass q x).passed = x.bucket - x.passed := by
  constructor <;> simp only [filterPass] <;> ring

/-- After a pass the user's bucket is in the meter, from 0 to 5/5. -/
theorem filter_pass_in_meter (q : ℚ) (x : FilterLoop) : InMeter (filterPass q x).bucket := by
  obtain ⟨h0, h1⟩ := keptOverlap_bounds x.bucket (q * x.rest)
  exact ⟨h0, by norm_num; exact h1⟩

/-- Any number of passes loses nothing and keeps the user's bucket in the meter. -/
theorem filter_loop_counts_whole (q : ℚ) (x : FilterLoop) (hx : InMeter x.bucket) (n : Nat) :
    (filterLoop q x n).rest + (filterLoop q x n).passed = x.rest + x.passed ∧
      (filterLoop q x n).bucket - (filterLoop q x n).passed = x.bucket - x.passed ∧
      InMeter (filterLoop q x n).bucket := by
  induction n with
  | zero => exact ⟨rfl, rfl, hx⟩
  | succ n ih =>
    obtain ⟨a, b⟩ := filter_pass_counts_whole q (filterLoop q x n)
    exact ⟨a.trans ih.1, b.trans ih.2.1, filter_pass_in_meter q _⟩

/-- With a fill or an empty on the user's bucket before each pass, any number of passes still
    keeps the remainder plus what has passed the same, and the bucket in the meter. -/
theorem filter_loop_with_moves (q : ℚ) (ms : List Move) (x : FilterLoop) (hx : InMeter x.bucket) :
    (filterLoopWith q x ms).rest + (filterLoopWith q x ms).passed = x.rest + x.passed ∧
      InMeter (filterLoopWith q x ms).bucket := by
  induction ms generalizing x with
  | nil => exact ⟨rfl, hx⟩
  | cons m ms ih =>
    simp only [filterLoopWith, List.foldl_cons] at ih ⊢
    obtain ⟨a, _⟩ := filter_pass_counts_whole q ⟨m.apply x.bucket, x.rest, x.passed⟩
    obtain ⟨c, d⟩ := ih _ (filter_pass_in_meter q ⟨m.apply x.bucket, x.rest, x.passed⟩)
    exact ⟨c.trans a, d⟩

/-! ## A filter with a fixed share settles -/

/-- A filter that passes the fixed share `q` each pass, with room in the bucket for the whole
    remainder: after `n` passes the remainder is `(1 - q)^n` times the start, and the rest of it
    has passed into the bucket. -/
theorem filter_share_settles (q : ℚ) (hq0 : 0 ≤ q) (hq1 : q ≤ 1) (x : FilterLoop)
    (hb : 0 ≤ x.bucket) (hr : 0 ≤ x.rest) (hroom : x.bucket + x.rest ≤ 1) (n : Nat) :
    (filterLoop q x n).rest = (1 - q) ^ n * x.rest ∧
      (filterLoop q x n).passed = x.passed + (1 - (1 - q) ^ n) * x.rest ∧
      (filterLoop q x n).bucket = x.bucket + (1 - (1 - q) ^ n) * x.rest := by
  induction n with
  | zero => simp [filterLoop]
  | succ n ih =>
    obtain ⟨hr', hp', hb'⟩ := ih
    have p0 : 0 ≤ (1 - q) ^ n := pow_nonneg (by linarith) n
    have p1 : (1 - q) ^ n ≤ 1 := pow_le_one₀ (by linarith) (by linarith)
    have hfit : keptOverlap (filterLoop q x n).bucket (q * (filterLoop q x n).rest) =
        q * (filterLoop q x n).rest := by
      apply keptOverlap_fits <;> rw [hr', hb']
      · nlinarith [mul_nonneg hq0 (mul_nonneg p0 hr), mul_nonneg (sub_nonneg.mpr p1) hr]
      · nlinarith [mul_nonneg (by linarith : (0:ℚ) ≤ 1 - q) (mul_nonneg p0 hr)]
    simp only [filterLoop, filterPass]
    rw [hfit, hr', hp', hb', pow_succ]
    refine ⟨by ring, by ring, by ring⟩

/-- A's filter: passing the let-go of 1/5 each pass and keeping 4/5 unsettled, the remainder
    after `n` passes is `held n` times the start, which is `(4/5)^n` times the start. -/
theorem A_filter_settles (x : FilterLoop) (hb : 0 ≤ x.bucket) (hr : 0 ≤ x.rest)
    (hroom : x.bucket + x.rest ≤ 1) (n : Nat) :
    (filterLoop loss x n).rest = held n * x.rest ∧ held n = keep ^ n ∧
      (filterLoop loss x n).passed = x.passed + (1 - held n) * x.rest := by
  have hh : held n = keep ^ n := by
    rw [← heldDial_one, heldDial_formula]; norm_num [lossDial, keep]
  have hk : (1 - loss) = keep := by norm_num [loss, keep]
  obtain ⟨a, b, _⟩ := filter_share_settles loss (by norm_num [loss]) (by norm_num [loss]) x hb hr
    hroom n
  rw [hk] at a b
  exact ⟨by rw [a, hh], hh, by rw [b, hh]⟩

/-- The loop settles: for a share `q` above 0, the remainder goes to 0 and the total passed into
    the bucket goes to everything that went out to be filtered. -/
theorem filter_loop_settles (q : ℚ) (hq0 : 0 < q) (hq1 : q ≤ 1) (x : FilterLoop)
    (hb : 0 ≤ x.bucket) (hr : 0 ≤ x.rest) (hroom : x.bucket + x.rest ≤ 1) :
    Tendsto (fun n => ((filterLoop q x n).rest : ℝ)) atTop (𝓝 0) ∧
      Tendsto (fun n => ((filterLoop q x n).passed : ℝ)) atTop (𝓝 ((x.passed : ℝ) + x.rest)) := by
  have hq1' : (q : ℝ) ≤ 1 := by exact_mod_cast hq1
  have hq0' : (0 : ℝ) < q := by exact_mod_cast hq0
  have hp : Tendsto (fun n : Nat => ((1 : ℝ) - q) ^ n) atTop (𝓝 0) :=
    tendsto_pow_atTop_nhds_zero_of_lt_one (by linarith) (by linarith)
  have hrest : (fun n => ((filterLoop q x n).rest : ℝ)) = fun n => ((1 : ℝ) - q) ^ n * x.rest := by
    funext n; rw [(filter_share_settles q hq0.le hq1 x hb hr hroom n).1]; push_cast; ring
  have hpass : (fun n => ((filterLoop q x n).passed : ℝ)) =
      fun n => (x.passed : ℝ) + (1 - ((1 : ℝ) - q) ^ n) * x.rest := by
    funext n; rw [(filter_share_settles q hq0.le hq1 x hb hr hroom n).2.1]; push_cast; ring
  refine ⟨?_, ?_⟩
  · rw [hrest]; simpa using hp.mul_const (x.rest : ℝ)
  · rw [hpass]
    have := ((tendsto_const_nhds (x := (1 : ℝ))).sub hp).mul_const (x.rest : ℝ)
    simpa using (tendsto_const_nhds (x := (x.passed : ℝ))).add this

/-- A's filter settles: the remainder goes to 0 and the total passed goes to everything that went
    out to be filtered. -/
theorem A_filter_limit (x : FilterLoop) (hb : 0 ≤ x.bucket) (hr : 0 ≤ x.rest)
    (hroom : x.bucket + x.rest ≤ 1) :
    Tendsto (fun n => ((filterLoop loss x n).rest : ℝ)) atTop (𝓝 0) ∧
      Tendsto (fun n => ((filterLoop loss x n).passed : ℝ)) atTop (𝓝 ((x.passed : ℝ) + x.rest)) :=
  filter_loop_settles loss (by norm_num [loss]) (by norm_num [loss]) x hb hr hroom

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
        filterLoop q x (f t) :=
  ⟨(filter_loop_counts_whole q x hx _).1, (filter_loop_counts_whole q x hx _).2.1,
    (filter_loop_counts_whole q x hx _).2.2, reverse_twice _ t⟩

end ViscousTimeReversal

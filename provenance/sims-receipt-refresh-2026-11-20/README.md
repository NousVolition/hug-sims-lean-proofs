# Current receipts for three SIMS studies

The saved GitHub evidence now matches the current proof inputs and target lists. This is a receipt refresh: the conversations, grades, recorded results and Lean proofs are unchanged.

| Study | What Lean checked | Saved GitHub evidence |
| --- | --- | --- |
| [Mentor and first thought](../../lean/SimsMentorFirstThought/README.md) | 20 statements about clocks, sampling order and coded reports, including the limits of a finite unsettled window | [Run 43829710687, attempt 2](https://github.com/NousVolition/hug-sims-lean-proofs/actions/runs/43829710687/attempts/2), Lean kernel, nanoda, Comparator and build; [source receipt](../../lean/SimsMentorFirstThought/evidence-linux/source.json) |
| [Continuing Traveller B](../../research/sims-continuing-evidence/README.md) | 10 observation rules and explicit two-world statements, plus 8 statements about recorded reports and clocks | [Run 43831166765](https://github.com/NousVolition/hug-sims-lean-proofs/actions/runs/43831166765), Lean kernel and build; [source receipt](../../research/sims-continuing-evidence/evidence-linux/source.json) |
| [Fixed tremble](../../research/sims-fixed-tremble/README.md) | 11 general or explicit-model statements, plus 16 statements about the 18 listeners' recorded reports | [Run 43831166725](https://github.com/NousVolition/hug-sims-lean-proofs/actions/runs/43831166725), Lean kernel and build; [source receipt](../../research/sims-fixed-tremble/evidence-linux/source.json) |

Lean checks the stated rules and the numbers encoded from these records. The record checkers separately reconstruct the supplied inputs and check the transcript chains. Neither step judges the meaning of a reply or establishes the witness's truth or a listener's private experience. No new interview or fluid simulation was run for this refresh.

## What was matched

The review compared the downloaded artifact bytes, archive checksums, proof inputs and named targets with main at [`51c27a5`](https://github.com/NousVolition/hug-sims-lean-proofs/tree/51c27a5f5d26a47ac370524c1c162f88cd207fb3). The [machine-readable review](review.json) lists every target, input hash and preserved receipt.

- **Mentor:** all 30 inputs and 20 targets match. The current input-manifest fingerprint is `71445414f75360734f7dd4c786f2cb9518f7c7e69c51f04820ac9d2d36c0e17e`. The GitHub job checked merge revision `9a020f72c11640a9d4adae088570e6f30d650b0b`; its PR head was `5fa3da7ee3b72ec274fd9284f5fe9a46c28a5b34`. The checkout's manifest also matches current main.
- **Continuing:** all 12 receipt inputs and 18 targets match. Its run checked main revision `fb7b1a023ef8c47070e91c16dd5389d301709768`.
- **Fixed tremble:** all 14 receipt inputs and 27 targets match at the same main revision. The missing GitHub artifact is now saved alongside the earlier local receipt.

The proof runs took place before this review. Their inputs still match; publishing their evidence does not turn them into new proof runs. The continuing and fixed-tremble workflows use native Lean checks, without Comparator or nanoda. The audited target lists use only standard Lean axioms where required.

The fresh [read-only record checks](local-record-checks.json) also passed: the mentor's original inputs, fresh-listener sweep and continuing session; four later conversations and seven altered-record fixtures; eighteen fixed-tremble listeners and eight altered-record fixtures; and the mentor source gate. These checks reconstructed saved records and made no new actor calls.

## Earlier evidence stays available

The previous mentor receipt and its logs are archived under [mentor PR 13](../../lean/SimsMentorFirstThought/evidence-history/pr-13/source.json), alongside the already preserved PR 10 and PR 12 evidence. The previous continuing receipt and logs are archived under [continuing PR 58](../../research/sims-continuing-evidence/evidence-history/pr-58/source.json). These files are preserved byte for byte. The earlier local receipts remain in their original locations, including the [fixed-tremble local receipt](../../research/sims-fixed-tremble/evidence-local/receipt.json).

For a separate mathematical connection, see [Wirtinger: neighboring differences and overall spread](../../docs/wirtinger/README.md). Its proof evidence comes from the discrete-inequalities repository and is not part of the three SIMS receipts above.

AI-generated; dictated and directed by NousVolition. Receipt matching and explanatory wording prepared by this Codex chat.

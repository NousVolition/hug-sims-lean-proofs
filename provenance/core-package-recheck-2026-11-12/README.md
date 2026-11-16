# Fresh verification of the 19 core Lean packages

**Result: all 19 packages passed on GitHub.** This recheck covers **306 configured declarations across packages**, with overlap; this is not a count of independent discoveries. [Workflow run](https://github.com/NousVolition/hug-sims-lean-proofs/actions/runs/43185187598) · [Machine-readable collection](manifest.json).

Each package started with a fresh local build directory and its pinned dependencies. Comparator compared the frozen challenge statements with the solution, Lean's default kernel and nanoda accepted the exported solution, Lake built the declared targets, and every configured theorem's axiom list passed the existing allow-list. The toolchain was **Lean 4.34.0-rc2**. Exact compiler and checker hashes are in each source receipt.

The checked pull-request head is `5fc0fe45b6f6aea982eed3c4484e6d77da46a986`, based on `c54f47b9eca41413c1172839f4e5d2fff2a8d8e6`. The actual test-merge checkout, run attempt, completion time, original package tree, input hashes and target list are recorded separately for each package. The proof inputs are unchanged from that base.

## Results and evidence

PASS in this table means the four verification stages and the axiom audit all passed for the configured declarations.

| Package | Configured declarations | Result | Evidence |
| --- | ---: | --- | --- |
| [AS](../../lean/AS/) | 30 | PASS | [fresh report](AS/verification-report.json) · [axioms](AS/axioms.json) · [inputs and run](AS/source.json) · [earlier report](../../lean/AS/verification-report.json) |
| [ASExistence](../../lean/ASExistence/) | 1 | PASS | [fresh report](ASExistence/verification-report.json) · [axioms](ASExistence/axioms.json) · [inputs and run](ASExistence/source.json) · [earlier report](../../lean/ASExistence/verification-report.json) |
| [ASInvariance](../../lean/ASInvariance/) | 1 | PASS | [fresh report](ASInvariance/verification-report.json) · [axioms](ASInvariance/axioms.json) · [inputs and run](ASInvariance/source.json) · [earlier report](../../lean/ASInvariance/verification-report.json) |
| [HugSqueeze](../../lean/HugSqueeze/) | 51 | PASS | [fresh report](HugSqueeze/verification-report.json) · [axioms](HugSqueeze/axioms.json) · [inputs and run](HugSqueeze/source.json) · [earlier report](../../lean/HugSqueeze/verification-report.json) |
| [HugExistence](../../lean/HugExistence/) | 1 | PASS | [fresh report](HugExistence/verification-report.json) · [axioms](HugExistence/axioms.json) · [inputs and run](HugExistence/source.json) · [earlier report](../../lean/HugExistence/verification-report.json) |
| [HugNavierBridge](../../lean/HugNavierBridge/) | 14 | PASS | [fresh report](HugNavierBridge/verification-report.json) · [axioms](HugNavierBridge/axioms.json) · [inputs and run](HugNavierBridge/source.json) · [earlier report](../../lean/HugNavierBridge/verification-report.json) |
| [HugNavierFullAudit](../../lean/HugNavierFullAudit/) | 7 | PASS | [fresh report](HugNavierFullAudit/verification-report.json) · [axioms](HugNavierFullAudit/axioms.json) · [inputs and run](HugNavierFullAudit/source.json) · [earlier report](../../lean/HugNavierFullAudit/verification-report.json) |
| [HugNavierSingleSystem](../../lean/HugNavierSingleSystem/) | 10 | PASS | [fresh report](HugNavierSingleSystem/verification-report.json) · [axioms](HugNavierSingleSystem/axioms.json) · [inputs and run](HugNavierSingleSystem/source.json) · [earlier report](../../lean/HugNavierSingleSystem/verification-report.json) |
| [HugNavierWellposedness](../../lean/HugNavierWellposedness/) | 4 | PASS | [fresh report](HugNavierWellposedness/verification-report.json) · [axioms](HugNavierWellposedness/axioms.json) · [inputs and run](HugNavierWellposedness/source.json) · [earlier report](../../lean/HugNavierWellposedness/verification-report.json) |
| [HugV3ProofAttempt](../../lean/HugV3ProofAttempt/) | 6 | PASS | [fresh report](HugV3ProofAttempt/verification-report.json) · [axioms](HugV3ProofAttempt/axioms.json) · [inputs and run](HugV3ProofAttempt/source.json) · [earlier report](../../lean/HugV3ProofAttempt/verification-report.json) |
| [HugV3Hybrid](../../lean/HugV3Hybrid/) | 9 | PASS | [fresh report](HugV3Hybrid/verification-report.json) · [axioms](HugV3Hybrid/axioms.json) · [inputs and run](HugV3Hybrid/source.json) · [earlier report](../../lean/HugV3Hybrid/verification-report.json) |
| [HugV3Source](../../lean/HugV3Source/) | 9 | PASS | [fresh report](HugV3Source/verification-report.json) · [axioms](HugV3Source/axioms.json) · [inputs and run](HugV3Source/source.json) · [earlier report](../../lean/HugV3Source/verification-report.json) |
| [HugV3Transfer](../../lean/HugV3Transfer/) | 14 | PASS | [fresh report](HugV3Transfer/verification-report.json) · [axioms](HugV3Transfer/axioms.json) · [inputs and run](HugV3Transfer/source.json) · [earlier report](../../lean/HugV3Transfer/verification-report.json) |
| [HugV3Delay](../../lean/HugV3Delay/) | 9 | PASS | [fresh report](HugV3Delay/verification-report.json) · [axioms](HugV3Delay/axioms.json) · [inputs and run](HugV3Delay/source.json) · [earlier report](../../lean/HugV3Delay/verification-report.json) |
| [HugV3FullDelayProof](../../lean/HugV3FullDelayProof/) | 14 | PASS | [fresh report](HugV3FullDelayProof/verification-report.json) · [axioms](HugV3FullDelayProof/axioms.json) · [inputs and run](HugV3FullDelayProof/source.json) · [earlier report](../../lean/HugV3FullDelayProof/verification-report.json) |
| [HugV3MemoryRules](../../lean/HugV3MemoryRules/) | 17 | PASS | [fresh report](HugV3MemoryRules/verification-report.json) · [axioms](HugV3MemoryRules/axioms.json) · [inputs and run](HugV3MemoryRules/source.json) · [earlier report](../../lean/HugV3MemoryRules/verification-report.json) |
| [HugV3ClayBoundary](../../lean/HugV3ClayBoundary/) | 12 | PASS | [fresh report](HugV3ClayBoundary/verification-report.json) · [axioms](HugV3ClayBoundary/axioms.json) · [inputs and run](HugV3ClayBoundary/source.json) · [earlier report](../../lean/HugV3ClayBoundary/verification-report.json) |
| [HugV3YangMillsAudit](../../lean/HugV3YangMillsAudit/) | 20 | PASS | [fresh report](HugV3YangMillsAudit/verification-report.json) · [axioms](HugV3YangMillsAudit/axioms.json) · [inputs and run](HugV3YangMillsAudit/source.json) · [earlier report](../../lean/HugV3YangMillsAudit/verification-report.json) |
| [HugV3GeminiReview](../../lean/HugV3GeminiReview/) | 77 | PASS | [fresh report](HugV3GeminiReview/verification-report.json) · [axioms](HugV3GeminiReview/axioms.json) · [inputs and run](HugV3GeminiReview/source.json) · [earlier report](../../lean/HugV3GeminiReview/verification-report.json) |

## What remains unfinished

Each fresh report preserves its original `scope` and `open_items` exactly. In particular, the full single-system Hug–Navier PDE existence/uniqueness target and full Hug v3 hybrid/delayed continuation targets remain open. The A/S and reduced eight-state Hug existence theorems retain their own stated assumptions.

Challenge files may contain placeholders for frozen reference statements. Those are not completed proofs; the checked solution modules supply the proofs for the listed declarations. A passing build does not promote a separate unfinished target.

The 20-statement Hug v3 strain/frame audit is separate from both the real-valued `readJet` example and the explicit abelian field-equation comparison in the [observation package](../../research/ambiguous-observation-lean/README.md). Their [credits and scopes](../../research/ambiguous-observation-lean/CREDITS.md) remain attached to that package.

## Preservation and publication

The original proof sources, target lists, hypotheses, package credits and historical reports remain unchanged. The package index links these fresh reports alongside the earlier reports.

Every package directory here includes the complete fresh report, axiom lists, compiler/Comparator logs, exit codes and source receipt. The artifact ZIP checksums and public-file hashes are listed in `manifest.json` and each package's `publication.json`. Public log copies replace only CI home-directory prefixes with `$CI_HOME`; the mapping retains the original artifact hashes. Reports, axiom lists and source receipts are unchanged. The GitHub run retains the original artifacts and job transcripts subject to GitHub's retention policy.

**Credits:** AI-generated; dictated and directed by NousVolition. Original model, proof and review authorship remains with the package credits. The fresh workflow, evidence collection and publication integration were performed by Codex (OpenAI), directed by NousVolition.

## Reproduce

Open [Core 19 package verification](https://github.com/NousVolition/hug-sims-lean-proofs/actions/workflows/core-package-recheck.yml) and use **Run workflow** on the desired revision. The explicit [19-package selection](../../.github/core-packages.json) and [workflow](../../.github/workflows/core-package-recheck.yml) use the existing pinned verification scripts. Each replay produces its own run-bound artifacts; it does not overwrite these historical receipts.

# `thick_wall_damps_most`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem thick_wall_damps_most (gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    forwardFactor thickWall q t ≤ forwardFactor (wall gAB gBA) q t ∧
    forwardFactor (wall gAB gBA) q t ≤ forwardFactor thinWall q t
```

- Proof: [ViscousTimeReversalProofs.lean line 288](../ViscousTimeReversalProofs.lean#L288)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 166](../ViscousTimeReversalChallenge.lean#L166)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

Forward, the thick wall damps most and the thin wall least.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Hacia adelante, el wall grueso amortigua más y el wall delgado menos.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Vers l'avant, le wall épais amortit le plus et le wall mince le moins.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Vorwärts dämpft die dicke wall am meisten und die dünne wall am wenigsten.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

向前时，厚 wall 衰减得最多，薄 wall 衰减得最少。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

前向きには、厚い wall が最も減衰させ、薄い wall が最も減衰させない。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

إلى الأمام، الـ wall السميك يُخمِد أكثر والـ wall الرقيق أقل.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

आगे की ओर मोटा wall सबसे अधिक मंद करता है और पतला wall सबसे कम।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Para a frente, o wall grosso amortece mais e o wall fino menos.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem thick_wall_damps_most (gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    forwardFactor thickWall q t ≤ forwardFactor (wall gAB gBA) q t ∧
    forwardFactor (wall gAB gBA) q t ≤ forwardFactor thinWall q t
```
</details>

<details><summary>ASCII</summary>

```text
theorem thick_wall_damps_most (gAB gBA q t : Real)
    (ha : gAB in Set.Icc (0:Real) 1) (hb : gBA in Set.Icc (0:Real) 1) (hq : 0 <= q) (ht : 0 <= t) :
    forwardFactor thickWall q t <= forwardFactor (wall gAB gBA) q t /\
    forwardFactor (wall gAB gBA) q t <= forwardFactor thinWall q t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
g_{AB},g_{BA}\in[0,1],\ q,t\ge0\ \Longrightarrow\ e^{-\frac{1}{10} q t}\le e^{-w q t}\le e^{-\frac{1}{50} q t}
$$

```latex
g_{AB},g_{BA}\in[0,1],\ q,t\ge0\ \Longrightarrow\ e^{-\frac{1}{10} q t}\le e^{-w q t}\le e^{-\frac{1}{50} q t}
```
</details>

Comes from: [forward_wall_only_damps](forward_wall_only_damps.md)

[Back to the tree](../TREE.md)

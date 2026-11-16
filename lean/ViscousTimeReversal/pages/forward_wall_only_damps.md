# `forward_wall_only_damps`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem forward_wall_only_damps (gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    forwardFactor (wall gAB gBA) q t ≤ 1
```

- Proof: [ViscousTimeReversalProofs.lean line 237](../ViscousTimeReversalProofs.lean#L237)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 144](../ViscousTimeReversalChallenge.lean#L144)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

Forward, the wall only damps: the forward factor is at most 1.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Hacia adelante, el wall solo amortigua: el factor hacia adelante es como máximo 1.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Vers l'avant, le wall ne fait qu'amortir : le facteur vers l'avant vaut au plus 1.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Vorwärts dämpft die wall nur: der Vorwärtsfaktor ist höchstens 1.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

向前时，wall 只会衰减：正向因子至多为 1。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

前向きには、wall は減衰させるだけである：前向きの因子は 1 以下である。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

إلى الأمام، الـ wall يُخمِد فقط: العامل الأمامي 1 على الأكثر.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

आगे की ओर wall केवल मंद करता है: आगे का गुणक अधिक से अधिक 1 है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Para a frente, o wall só amortece: o fator para a frente é no máximo 1.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem forward_wall_only_damps (gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    forwardFactor (wall gAB gBA) q t ≤ 1
```
</details>

<details><summary>ASCII</summary>

```text
theorem forward_wall_only_damps (gAB gBA q t : Real)
    (ha : gAB in Set.Icc (0:Real) 1) (hb : gBA in Set.Icc (0:Real) 1) (hq : 0 <= q) (ht : 0 <= t) :
    forwardFactor (wall gAB gBA) q t <= 1
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
g_{AB},g_{BA}\in[0,1],\ q,t\ge0\ \Longrightarrow\ e^{-w q t}\le 1
$$

```latex
g_{AB},g_{BA}\in[0,1],\ q,t\ge0\ \Longrightarrow\ e^{-w q t}\le 1
```
</details>

Comes from: [wall_between_thin_and_thick](wall_between_thin_and_thick.md), [forward_damping](forward_damping.md)

Leads to: [thick_wall_damps_most](thick_wall_damps_most.md), [wall_takes_forward_from_split](wall_takes_forward_from_split.md)

[Back to the tree](../TREE.md)

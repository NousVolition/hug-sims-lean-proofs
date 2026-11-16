# `backward_wall_only_amplifies`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem backward_wall_only_amplifies (gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    1 ≤ backwardFactor (wall gAB gBA) q t
```

- Proof: [ViscousTimeReversalProofs.lean line 248](../ViscousTimeReversalProofs.lean#L248)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 149](../ViscousTimeReversalChallenge.lean#L149)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

Backward, the wall only amplifies: the backward factor is at least 1.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Hacia atrás, el wall solo amplifica: el factor hacia atrás es al menos 1.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Vers l'arrière, le wall ne fait qu'amplifier : le facteur vers l'arrière vaut au moins 1.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Rückwärts verstärkt die wall nur: der Rückwärtsfaktor ist mindestens 1.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

向后时，wall 只会放大：反向因子至少为 1。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

後ろ向きには、wall は増幅するだけである：後ろ向きの因子は 1 以上である。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

إلى الخلف، الـ wall يُضخِّم فقط: العامل الخلفي 1 على الأقل.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

पीछे की ओर wall केवल बढ़ाता है: पीछे का गुणक कम से कम 1 है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Para trás, o wall só amplifica: o fator para trás é pelo menos 1.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem backward_wall_only_amplifies (gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    1 ≤ backwardFactor (wall gAB gBA) q t
```
</details>

<details><summary>ASCII</summary>

```text
theorem backward_wall_only_amplifies (gAB gBA q t : Real)
    (ha : gAB in Set.Icc (0:Real) 1) (hb : gBA in Set.Icc (0:Real) 1) (hq : 0 <= q) (ht : 0 <= t) :
    1 <= backwardFactor (wall gAB gBA) q t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
g_{AB},g_{BA}\in[0,1],\ q,t\ge0\ \Longrightarrow\ 1\le e^{w q t}
$$

```latex
g_{AB},g_{BA}\in[0,1],\ q,t\ge0\ \Longrightarrow\ 1\le e^{w q t}
```
</details>

Comes from: [wall_between_thin_and_thick](wall_between_thin_and_thick.md), [backward_amplification](backward_amplification.md)

Leads to: [thick_wall_amplifies_most](thick_wall_amplifies_most.md), [wall_gives_backward_from_split](wall_gives_backward_from_split.md)

[Back to the tree](../TREE.md)

# `factor_cancellation`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem factor_cancellation (ν q t : ℝ) :
    forwardFactor ν q t * backwardFactor ν q t = 1
```

- Proof: [ViscousTimeReversalProofs.lean line 88](../ViscousTimeReversalProofs.lean#L88)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 57](../ViscousTimeReversalChallenge.lean#L57)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

The forward and backward factors multiply to exactly 1.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Los factores hacia adelante y hacia atrás multiplicados dan exactamente 1.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Le produit des facteurs vers l'avant et vers l'arrière vaut exactement 1.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Vorwärts- und Rückwärtsfaktor ergeben miteinander multipliziert genau 1.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

正向因子与反向因子相乘恰好等于 1。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

前向きの因子と後ろ向きの因子の積はちょうど 1 である。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

حاصل ضرب العاملين الأمامي والخلفي يساوي 1 تمامًا.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

आगे और पीछे के गुणकों का गुणनफल ठीक 1 है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Os fatores para a frente e para trás multiplicados dão exatamente 1.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem factor_cancellation (ν q t : ℝ) :
    forwardFactor ν q t * backwardFactor ν q t = 1
```
</details>

<details><summary>ASCII</summary>

```text
theorem factor_cancellation (nu q t : Real) :
    forwardFactor nu q t * backwardFactor nu q t = 1
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
e^{-\nu q t}\cdot e^{\nu q t}=1
$$

```latex
e^{-\nu q t}\cdot e^{\nu q t}=1
```
</details>

Comes from: [forward_damping](forward_damping.md), [backward_amplification](backward_amplification.md)

Leads to: [wall_factors_multiply_to_one](wall_factors_multiply_to_one.md)

[Back to the tree](../TREE.md)

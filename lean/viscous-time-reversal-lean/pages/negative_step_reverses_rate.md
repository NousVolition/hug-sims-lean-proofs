# `negative_step_reverses_rate`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem negative_step_reverses_rate (h ν q a : ℝ) :
    eulerIncrement (-h) (viscousRate ν q a) = h * ((ν * q) * a)
```

- Proof: [ViscousTimeReversalProofs.lean line 96](../ViscousTimeReversalProofs.lean#L96)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 61](../ViscousTimeReversalChallenge.lean#L61)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

A negative time step −h applied to the viscous rate gives h·(νq)·a: the step reverses the rate.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Un paso de tiempo negativo −h aplicado a la tasa viscosa da h·(νq)·a: el paso invierte la tasa.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Un pas de temps négatif −h appliqué au taux visqueux donne h·(νq)·a : le pas inverse le taux.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Ein negativer Zeitschritt −h auf die viskose Rate ergibt h·(νq)·a: der Schritt kehrt die Rate um.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

对黏性变化率取负时间步 −h，得到 h·(νq)·a：这一步使变化率反向。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

粘性の変化率に負の時間刻み −h を当てると h·(νq)·a になる：この刻みは変化率を反転させる。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

خطوة زمنية سالبة −h على المعدل اللزج تعطي h·(νq)·a: الخطوة تعكس المعدل.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

श्यान दर पर ऋणात्मक समय-कदम −h लगाने से h·(νq)·a मिलता है: यह कदम दर को उलट देता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Um passo de tempo negativo −h aplicado à taxa viscosa dá h·(νq)·a: o passo inverte a taxa.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem negative_step_reverses_rate (h ν q a : ℝ) :
    eulerIncrement (-h) (viscousRate ν q a) = h * ((ν * q) * a)
```
</details>

<details><summary>ASCII</summary>

```text
theorem negative_step_reverses_rate (h nu q a : Real) :
    eulerIncrement (-h) (viscousRate nu q a) = h * ((nu * q) * a)
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
(-h)\cdot\bigl(-(\nu q)\,a\bigr)=h\,(\nu q)\,a
$$

```latex
(-h)\cdot\bigl(-(\nu q)\,a\bigr)=h\,(\nu q)\,a
```
</details>

Leads to: [double_sign_flip_restores_forward](double_sign_flip_restores_forward.md)

[Back to the tree](../TREE.md)

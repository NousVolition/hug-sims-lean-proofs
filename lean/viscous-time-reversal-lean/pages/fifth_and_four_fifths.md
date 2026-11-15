# `fifth_and_four_fifths`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem fifth_and_four_fifths (share : ℝ → Placement) (t : ℝ) :
    ((share (aroundSplit t)).student = 1/5 → (reverseAroundSplit share t).mentor = 4/5) ∧
    ((share (aroundSplit t)).student = 4/5 → (reverseAroundSplit share t).mentor = 1/5)
```

- Proof: [ViscousTimeReversalProofs.lean line 131](../ViscousTimeReversalProofs.lean#L131)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 85](../ViscousTimeReversalChallenge.lean#L85)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

Run backward, a student at 0.2 has a mentor at 0.8, and a student at 0.8 has a mentor at 0.2.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Hacia atrás, un student en 0,2 tiene un mentor en 0,8, y un student en 0,8 tiene un mentor en 0,2.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

En sens inverse, un student à 0,2 a un mentor à 0,8, et un student à 0,8 a un mentor à 0,2.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Rückwärts hat ein student bei 0,2 einen mentor bei 0,8, und ein student bei 0,8 einen mentor bei 0,2.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

向后运行时，处于 0.2 的 student 对应处于 0.8 的 mentor，处于 0.8 的 student 对应处于 0.2 的 mentor。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

後ろ向きに進めると、0.2 の student には 0.8 の mentor が、0.8 の student には 0.2 の mentor が対応する。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

عند السير إلى الخلف، الـ student عند 0.2 له mentor عند 0.8، والـ student عند 0.8 له mentor عند 0.2.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

पीछे की ओर चलाने पर 0.2 वाले student का mentor 0.8 पर है, और 0.8 वाले student का mentor 0.2 पर है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Para trás, um student em 0,2 tem um mentor em 0,8, e um student em 0,8 tem um mentor em 0,2.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem fifth_and_four_fifths (share : ℝ → Placement) (t : ℝ) :
    ((share (aroundSplit t)).student = 1/5 → (reverseAroundSplit share t).mentor = 4/5) ∧
    ((share (aroundSplit t)).student = 4/5 → (reverseAroundSplit share t).mentor = 1/5)
```
</details>

<details><summary>ASCII</summary>

```text
theorem fifth_and_four_fifths (share : Real -> Placement) (t : Real) :
    ((share (aroundSplit t)).student = 1/5 -> (reverseAroundSplit share t).mentor = 4/5) /\
    ((share (aroundSplit t)).student = 4/5 -> (reverseAroundSplit share t).mentor = 1/5)
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
\mathrm{student}(-t)=\tfrac15\Rightarrow \mathrm{mentor}(-t)=\tfrac45,\qquad \mathrm{student}(-t)=\tfrac45\Rightarrow \mathrm{mentor}(-t)=\tfrac15
$$

```latex
\mathrm{student}(-t)=\tfrac15\Rightarrow \mathrm{mentor}(-t)=\tfrac45,\qquad \mathrm{student}(-t)=\tfrac45\Rightarrow \mathrm{mentor}(-t)=\tfrac15
```
</details>

Comes from: [reversal_keeps_one](reversal_keeps_one.md)

[Back to the tree](../TREE.md)

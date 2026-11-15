# `reversal_keeps_one`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem reversal_keeps_one (share : ℝ → Placement) (t : ℝ) :
    (reverseAroundSplit share t).mentor + (reverseAroundSplit share t).student = 1
```

- Proof: [ViscousTimeReversalProofs.lean line 125](../ViscousTimeReversalProofs.lean#L125)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 80](../ViscousTimeReversalChallenge.lean#L80)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

Run backward, mentor + student still make 1 at every time.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Hacia atrás, mentor + student siguen sumando 1 en todo momento.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

En sens inverse, mentor + student font toujours 1 à tout instant.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Rückwärts ergeben mentor + student weiterhin zu jeder Zeit 1.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

向后运行时，mentor + student 在每个时刻仍然等于 1。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

後ろ向きに進めても、mentor + student はどの時刻でも 1 のままである。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

عند السير إلى الخلف، يبقى mentor + student مساويًا 1 في كل لحظة.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

पीछे की ओर चलाने पर भी हर समय mentor + student का योग 1 रहता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Para trás, mentor + student continuam somando 1 em todo momento.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem reversal_keeps_one (share : ℝ → Placement) (t : ℝ) :
    (reverseAroundSplit share t).mentor + (reverseAroundSplit share t).student = 1
```
</details>

<details><summary>ASCII</summary>

```text
theorem reversal_keeps_one (share : Real -> Placement) (t : Real) :
    (reverseAroundSplit share t).mentor + (reverseAroundSplit share t).student = 1
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
\mathrm{mentor}(-t)+\mathrm{student}(-t)=1
$$

```latex
\mathrm{mentor}(-t)+\mathrm{student}(-t)=1
```
</details>

Comes from: [reverse_twice](reverse_twice.md)

Leads to: [share_change_undone](share_change_undone.md)

[Back to the tree](../TREE.md)

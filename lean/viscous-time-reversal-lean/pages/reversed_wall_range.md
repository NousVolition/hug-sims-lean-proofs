# `reversed_wall_range`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem reversed_wall_range (gAB gBA : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) :
    reversedWall gAB gBA ∈ Set.Icc (-1/10 : ℝ) (-1/50)
```

- Proof: [ViscousTimeReversalProofs.lean line 231](../ViscousTimeReversalProofs.lean#L231)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 140](../ViscousTimeReversalChallenge.lean#L140)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

Run backward, the wall changes sign and lies between −1/10 and −1/50.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Hacia atrás, el wall cambia de signo y queda entre −1/10 y −1/50.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

En sens inverse, le wall change de signe et se situe entre −1/10 et −1/50.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Rückwärts wechselt die wall das Vorzeichen und liegt zwischen −1/10 und −1/50.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

向后运行时，wall 变号，位于 −1/10 和 −1/50 之间。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

後ろ向きには、wall は符号が変わり、−1/10 と −1/50 の間にある。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

عند السير إلى الخلف، تنقلب إشارة الـ wall ويقع بين −1/10 و−1/50.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

पीछे की ओर wall का चिह्न बदल जाता है और वह −1/10 और −1/50 के बीच होता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Para trás, o wall troca de sinal e fica entre −1/10 e −1/50.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem reversed_wall_range (gAB gBA : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) :
    reversedWall gAB gBA ∈ Set.Icc (-1/10 : ℝ) (-1/50)
```
</details>

<details><summary>ASCII</summary>

```text
theorem reversed_wall_range (gAB gBA : Real)
    (ha : gAB in Set.Icc (0:Real) 1) (hb : gBA in Set.Icc (0:Real) 1) :
    reversedWall gAB gBA in Set.Icc (-1/10 : Real) (-1/50)
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
g_{AB},g_{BA}\in[0,1]\ \Longrightarrow\ -\tfrac1{10}\le -w(g_{AB},g_{BA})\le-\tfrac1{50}
$$

```latex
g_{AB},g_{BA}\in[0,1]\ \Longrightarrow\ -\tfrac1{10}\le -w(g_{AB},g_{BA})\le-\tfrac1{50}
```
</details>

Comes from: [wall_between_thin_and_thick](wall_between_thin_and_thick.md)

Leads to: [wall_flips_under_reversal](wall_flips_under_reversal.md)

[Back to the tree](../TREE.md)

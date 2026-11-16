# `forward_gap_becomes_backward_overlap`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem forward_gap_becomes_backward_overlap (b e : ℝ) (h : contact b e = .gap) :
    contact (reflect b) (reflect e) = .overlap ∧
    overlapSize (reflect b) (reflect e) = margin b e
```

- Proof: [ViscousTimeReversalProofs.lean line 136](../ViscousTimeReversalProofs.lean#L136)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 89](../ViscousTimeReversalChallenge.lean#L89)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

A forward gap becomes a backward overlap, and the overlap is exactly the size of the gap.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Un gap hacia adelante se convierte en un solapamiento hacia atrás, y el solapamiento tiene exactamente el tamaño del gap.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Un gap vers l'avant devient un chevauchement vers l'arrière, et le chevauchement a exactement la taille du gap.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Ein gap vorwärts wird rückwärts zu einer Überlappung, und die Überlappung ist genau so groß wie der gap.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

向前的 gap 变成向后的重叠，重叠的大小恰好等于 gap 的大小。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

前向きの gap は後ろ向きの重なりになり、重なりの大きさは gap の大きさにちょうど等しい。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

الـ gap إلى الأمام يصبح تداخلًا إلى الخلف، والتداخل بحجم الـ gap تمامًا.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

आगे का gap पीछे की ओर अतिव्यापन बन जाता है, और अतिव्यापन ठीक gap के आकार का होता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Um gap para a frente vira uma sobreposição para trás, e a sobreposição tem exatamente o tamanho do gap.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem forward_gap_becomes_backward_overlap (b e : ℝ) (h : contact b e = .gap) :
    contact (reflect b) (reflect e) = .overlap ∧
    overlapSize (reflect b) (reflect e) = margin b e
```
</details>

<details><summary>ASCII</summary>

```text
theorem forward_gap_becomes_backward_overlap (b e : Real) (h : contact b e = .gap) :
    contact (reflect b) (reflect e) = .overlap /\
    overlapSize (reflect b) (reflect e) = margin b e
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
m(b,e)>0\ \Longrightarrow\ m(-b,-e)<0\ \wedge\ (-e)-(-b)=m(b,e)
$$

```latex
m(b,e)>0\ \Longrightarrow\ m(-b,-e)<0\ \wedge\ (-e)-(-b)=m(b,e)
```
</details>

Comes from: [reflect_flips_margin](reflect_flips_margin.md)

Leads to: [tick23_gap_reverses_to_overlap](tick23_gap_reverses_to_overlap.md)

[Back to the tree](../TREE.md)

# `wall_takes_forward_from_split`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem wall_takes_forward_from_split (a gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    0 ≤ takenForward a (wall gAB gBA) q t
```

- Proof: [ViscousTimeReversalProofs.lean line 323](../ViscousTimeReversalProofs.lean#L323)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 181](../ViscousTimeReversalChallenge.lean#L181)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

Counted forward from the split, what the wall takes from a ripple's kinetic energy is never negative.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Contado hacia adelante desde el split, lo que el wall toma de la energía cinética de una onda nunca es negativo.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Compté vers l'avant depuis le split, ce que le wall prend à l'énergie cinétique d'une onde n'est jamais négatif.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Vom split aus vorwärts gezählt, ist das, was die wall der kinetischen Energie einer Welle nimmt, nie negativ.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

从 split 向前计算，wall 从波纹动能中取走的量从不为负。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

split から前向きに数えると、wall が波の運動エネルギーから取る量は決して負にならない。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

بالعدّ إلى الأمام من الـ split، ما يأخذه الـ wall من الطاقة الحركية للموجة ليس سالبًا أبدًا.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

split से आगे की ओर गिनने पर, wall तरंग की गतिज ऊर्जा से जो लेता है वह कभी ऋणात्मक नहीं होता।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Contado para a frente a partir do split, o que o wall tira da energia cinética de uma onda nunca é negativo.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem wall_takes_forward_from_split (a gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    0 ≤ takenForward a (wall gAB gBA) q t
```
</details>

<details><summary>ASCII</summary>

```text
theorem wall_takes_forward_from_split (a gAB gBA q t : Real)
    (ha : gAB in Set.Icc (0:Real) 1) (hb : gBA in Set.Icc (0:Real) 1) (hq : 0 <= q) (ht : 0 <= t) :
    0 <= takenForward a (wall gAB gBA) q t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
g_{AB},g_{BA}\in[0,1],\ q,t\ge0\ \Longrightarrow\ 0\le \tfrac{a^2}{2}-\tfrac{(a\,e^{-w q t})^2}{2}
$$

```latex
g_{AB},g_{BA}\in[0,1],\ q,t\ge0\ \Longrightarrow\ 0\le \tfrac{a^2}{2}-\tfrac{(a\,e^{-w q t})^2}{2}
```
</details>

Comes from: [forward_wall_only_damps](forward_wall_only_damps.md)

Leads to: [both_directions_add](both_directions_add.md)

[Back to the tree](../TREE.md)

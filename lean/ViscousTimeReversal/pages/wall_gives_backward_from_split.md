# `wall_gives_backward_from_split`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem wall_gives_backward_from_split (a gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    0 ≤ givenBackward a (wall gAB gBA) q t
```

- Proof: [ViscousTimeReversalProofs.lean line 323](../ViscousTimeReversalProofs.lean#L323)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 180](../ViscousTimeReversalChallenge.lean#L180)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

Counted backward from the split, what the reversed wall gives to a ripple's kinetic energy is never negative.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Contado hacia atrás desde el split, lo que el wall invertido da a la energía cinética de una onda nunca es negativo.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Compté vers l'arrière depuis le split, ce que le wall inversé donne à l'énergie cinétique d'une onde n'est jamais négatif.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Vom split aus rückwärts gezählt, ist das, was die umgekehrte wall der kinetischen Energie einer Welle gibt, nie negativ.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

从 split 向后计算，反向 wall 给予波纹动能的量从不为负。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

split から後ろ向きに数えると、反転した wall が波の運動エネルギーに与える量は決して負にならない。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

بالعدّ إلى الخلف من الـ split، ما يعطيه الـ wall المعكوس للطاقة الحركية للموجة ليس سالبًا أبدًا.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

split से पीछे की ओर गिनने पर, उलटा wall तरंग की गतिज ऊर्जा को जो देता है वह कभी ऋणात्मक नहीं होता।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Contado para trás a partir do split, o que o wall invertido dá à energia cinética de uma onda nunca é negativo.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem wall_gives_backward_from_split (a gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    0 ≤ givenBackward a (wall gAB gBA) q t
```
</details>

<details><summary>ASCII</summary>

```text
theorem wall_gives_backward_from_split (a gAB gBA q t : Real)
    (ha : gAB in Set.Icc (0:Real) 1) (hb : gBA in Set.Icc (0:Real) 1) (hq : 0 <= q) (ht : 0 <= t) :
    0 <= givenBackward a (wall gAB gBA) q t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
g_{AB},g_{BA}\in[0,1],\ q,t\ge0\ \Longrightarrow\ 0\le \tfrac{(a\,e^{w q t})^2}{2}-\tfrac{a^2}{2}
$$

```latex
g_{AB},g_{BA}\in[0,1],\ q,t\ge0\ \Longrightarrow\ 0\le \tfrac{(a\,e^{w q t})^2}{2}-\tfrac{a^2}{2}
```
</details>

Comes from: [backward_wall_only_amplifies](backward_wall_only_amplifies.md)

Leads to: [both_directions_add](both_directions_add.md)

[Back to the tree](../TREE.md)

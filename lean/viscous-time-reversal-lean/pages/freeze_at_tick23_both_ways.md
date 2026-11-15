# `freeze_at_tick23_both_ways`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem freeze_at_tick23_both_ways (p : Placement) :
    Freeze p 8 ∧
    (schedule[8]?).map (fun k => (k.label, k.offsetUs)) = some (23, 800000) ∧
    aroundSplit ((800000 : ℝ) / 1000000) = -(4/5) ∧
    aroundSplit (aroundSplit (4/5)) = 4/5
```

- Proof: [ViscousTimeReversalProofs.lean line 189](../ViscousTimeReversalProofs.lean#L189)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 113](../ViscousTimeReversalChallenge.lean#L113)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

The tick 23 freeze holds for every placement. It sits at clock offset 800000 µs, 0.8 after the split; run backward it sits 0.8 before the split, and reversing twice returns it to 0.8.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

El freeze del tick 23 se cumple para toda colocación. Está en el desfase de reloj 800000 µs, 0,8 después del split; hacia atrás está 0,8 antes del split, e invertir dos veces lo devuelve a 0,8.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Le freeze du tick 23 vaut pour tout placement. Il se trouve au décalage d'horloge 800000 µs, 0,8 après le split ; en sens inverse il est 0,8 avant le split, et inverser deux fois le ramène à 0,8.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Der freeze bei tick 23 gilt für jede Aufteilung. Er liegt beim Uhrversatz 800000 µs, 0,8 nach dem split; rückwärts liegt er 0,8 vor dem split, und zweimaliges Umkehren bringt ihn zurück auf 0,8.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

tick 23 的 freeze 对每一种分配都成立。它位于时钟偏移 800000 微秒处，即 split 之后 0.8；向后运行时它位于 split 之前 0.8，反转两次又回到 0.8。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

tick 23 の freeze はどの配分でも成り立つ。それは時計のずれ 800000 マイクロ秒、つまり split の 0.8 後にある；後ろ向きには split の 0.8 前にあり、二回反転すると 0.8 に戻る。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

الـ freeze عند tick 23 يتحقق لكل توزيع. يقع عند إزاحة الساعة 800000 ميكروثانية، أي 0.8 بعد الـ split؛ وعند السير إلى الخلف يقع 0.8 قبل الـ split، والعكس مرتين يعيده إلى 0.8.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

tick 23 का freeze हर बँटवारे के लिए सही है। यह घड़ी के अंतर 800000 माइक्रोसेकंड पर, यानी split के 0.8 बाद है; पीछे की ओर यह split से 0.8 पहले है, और दो बार उलटने पर फिर 0.8 पर लौटता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

O freeze do tick 23 vale para toda divisão. Ele fica no deslocamento de relógio 800000 µs, 0,8 depois do split; para trás fica 0,8 antes do split, e inverter duas vezes o devolve a 0,8.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem freeze_at_tick23_both_ways (p : Placement) :
    Freeze p 8 ∧
    (schedule[8]?).map (fun k => (k.label, k.offsetUs)) = some (23, 800000) ∧
    aroundSplit ((800000 : ℝ) / 1000000) = -(4/5) ∧
    aroundSplit (aroundSplit (4/5)) = 4/5
```
</details>

<details><summary>ASCII</summary>

```text
theorem freeze_at_tick23_both_ways (p : Placement) :
    Freeze p 8 /\
    (schedule[8]?).map (fun k => (k.label, k.offsetUs)) = some (23, 800000) /\
    aroundSplit ((800000 : Real) / 1000000) = -(4/5) /\
    aroundSplit (aroundSplit (4/5)) = 4/5
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
\mathrm{Freeze}(p,8),\quad \mathrm{tick}_8=(23,\,800000\,\mu s),\quad -\tfrac{800000}{10^6}=-\tfrac45,\quad -(-\tfrac45)=\tfrac45
$$

```latex
\mathrm{Freeze}(p,8),\quad \mathrm{tick}_8=(23,\,800000\,\mu s),\quad -\tfrac{800000}{10^6}=-\tfrac45,\quad -(-\tfrac45)=\tfrac45
```
</details>

Comes from: [split_at_tick_two](split_at_tick_two.md)

Leads to: [tick23_gap_reverses_to_overlap](tick23_gap_reverses_to_overlap.md)

[Back to the tree](../TREE.md)

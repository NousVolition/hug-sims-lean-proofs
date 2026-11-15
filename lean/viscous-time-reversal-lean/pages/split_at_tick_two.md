# `split_at_tick_two`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem split_at_tick_two :
    beforeSplit = 2 ∧ (∀ s : ℚ, splitEvent s = 1) ∧
    (schedule[0]?).map (fun k => (k.label, k.mentor, k.listener, k.offsetUs)) = some (2, 0, 0, 0) ∧
    aroundSplit 0 = 0
```

- Proof: [ViscousTimeReversalProofs.lean line 111](../ViscousTimeReversalProofs.lean#L111)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 70](../ViscousTimeReversalChallenge.lean#L70)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

The 0,0 split: before it, mentor 1 + student 1 = 2; after it, student s plus mentor 1 − s is 1 for every s; it sits at tick 2 with mentor step 0, student step 0 and clock offset 0; and reversing time leaves the split where it is.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

El split 0,0: antes de él, mentor 1 + student 1 = 2; después de él, student s más mentor 1 − s es 1 para todo s; está en el tick 2 con paso del mentor 0, paso del student 0 y desfase de reloj 0; e invertir el tiempo deja el split donde está.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Le split 0,0 : avant lui, mentor 1 + student 1 = 2 ; après lui, student s plus mentor 1 − s vaut 1 pour tout s ; il se trouve au tick 2 avec pas du mentor 0, pas du student 0 et décalage d'horloge 0 ; et inverser le temps laisse le split à sa place.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Der 0,0-split: davor gilt mentor 1 + student 1 = 2; danach ergibt student s plus mentor 1 − s für jedes s genau 1; er liegt bei tick 2 mit mentor-Schritt 0, student-Schritt 0 und Uhrversatz 0; und Zeitumkehr lässt den split an seiner Stelle.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

0,0 split：在它之前，mentor 1 + student 1 = 2；在它之后，对每个 s，student s 加 mentor 1 − s 等于 1；它位于 tick 2，mentor 步长 0，student 步长 0，时钟偏移 0；时间反转不改变 split 的位置。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

0,0 split：その前では mentor 1 + student 1 = 2；その後では、すべての s について student s と mentor 1 − s の和が 1；split は tick 2 にあり、mentor の歩み 0、student の歩み 0、時計のずれ 0；時間反転しても split の位置は変わらない。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

الـ split عند 0,0: قبله mentor 1 + student 1 = 2؛ وبعده student s زائد mentor 1 − s يساوي 1 لكل s؛ ويقع عند tick 2 حيث خطوة الـ mentor 0 وخطوة الـ student 0 وإزاحة الساعة 0؛ وعكس الزمن يترك الـ split في مكانه.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

0,0 split: उससे पहले mentor 1 + student 1 = 2; उसके बाद हर s के लिए student s और mentor 1 − s का योग 1 है; यह tick 2 पर है, जहाँ mentor का कदम 0, student का कदम 0 और घड़ी का अंतर 0 है; और समय उलटने पर split अपनी जगह रहता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

O split 0,0: antes dele, mentor 1 + student 1 = 2; depois dele, student s mais mentor 1 − s é 1 para todo s; ele fica no tick 2 com passo do mentor 0, passo do student 0 e deslocamento de relógio 0; e inverter o tempo deixa o split onde está.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem split_at_tick_two :
    beforeSplit = 2 ∧ (∀ s : ℚ, splitEvent s = 1) ∧
    (schedule[0]?).map (fun k => (k.label, k.mentor, k.listener, k.offsetUs)) = some (2, 0, 0, 0) ∧
    aroundSplit 0 = 0
```
</details>

<details><summary>ASCII</summary>

```text
theorem split_at_tick_two :
    beforeSplit = 2 /\ (forall s : Rat, splitEvent s = 1) /\
    (schedule[0]?).map (fun k => (k.label, k.mentor, k.listener, k.offsetUs)) = some (2, 0, 0, 0) /\
    aroundSplit 0 = 0
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
1+1=2,\quad \forall s\in\mathbb{Q}:\ s+(1-s)=1,\quad \mathrm{tick}_0=(2,0,0,0),\quad -0=0
$$

```latex
1+1=2,\quad \forall s\in\mathbb{Q}:\ s+(1-s)=1,\quad \mathrm{tick}_0=(2,0,0,0),\quad -0=0
```
</details>

Leads to: [reverse_twice](reverse_twice.md), [freeze_at_tick23_both_ways](freeze_at_tick23_both_ways.md)

[Back to the tree](../TREE.md)

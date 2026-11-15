# `tick23_gap_reverses_to_overlap`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem tick23_gap_reverses_to_overlap :
    (schedule[8]?).map (fun k => (k.label, k.listener, k.mentor)) = some (23, 256, 200) ∧
    contact (256 : ℝ) 200 = .gap ∧ margin (256 : ℝ) 200 = 56 ∧
    contact (reflect 256) (reflect 200) = .overlap ∧
    overlapSize (reflect 256) (reflect 200) = 56
```

- Proof: [ViscousTimeReversalProofs.lean line 177](../ViscousTimeReversalProofs.lean#L177)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 105](../ViscousTimeReversalChallenge.lean#L105)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

At tick 23 the student is at 256 and the mentor at 200: a gap of 56. Read backward, it is an overlap of 56. Here the student's position is read as where mine begins and the mentor's as where yours ends.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

En el tick 23 el student está en 256 y el mentor en 200: un gap de 56. Leído hacia atrás, es un solapamiento de 56. Aquí la posición del student se lee como donde empieza lo mío y la del mentor como donde termina lo tuyo.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Au tick 23, le student est à 256 et le mentor à 200 : un gap de 56. Lu en sens inverse, c'est un chevauchement de 56. Ici la position du student est lue comme là où le mien commence et celle du mentor comme là où le tien finit.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Bei tick 23 steht der student bei 256 und der mentor bei 200: ein gap von 56. Rückwärts gelesen ist es eine Überlappung von 56. Hier wird die Position des student als „wo meins beginnt“ und die des mentor als „wo deins endet“ gelesen.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

在 tick 23，student 在 256，mentor 在 200：gap 为 56。向后读，它是 56 的重叠。这里把 student 的位置读作“我的开始处”，把 mentor 的位置读作“你的结束处”。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

tick 23 では student が 256、mentor が 200 にあり、gap は 56 である。後ろ向きに読むと 56 の重なりになる。ここでは student の位置を「私のものが始まる位置」、mentor の位置を「あなたのものが終わる位置」として読む。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

عند tick 23 يكون الـ student عند 256 والـ mentor عند 200: gap مقداره 56. عند القراءة إلى الخلف، يصبح تداخلًا مقداره 56. هنا يُقرأ موضع الـ student على أنه حيث يبدأ ما لي، وموضع الـ mentor على أنه حيث ينتهي ما لك.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

tick 23 पर student 256 पर और mentor 200 पर है: 56 का gap। पीछे की ओर पढ़ने पर यह 56 का अतिव्यापन है। यहाँ student की स्थिति को 'जहाँ मेरा शुरू होता है' और mentor की स्थिति को 'जहाँ तुम्हारा खत्म होता है' के रूप में पढ़ा गया है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

No tick 23 o student está em 256 e o mentor em 200: um gap de 56. Lido para trás, é uma sobreposição de 56. Aqui a posição do student é lida como onde o meu começa e a do mentor como onde o seu termina.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem tick23_gap_reverses_to_overlap :
    (schedule[8]?).map (fun k => (k.label, k.listener, k.mentor)) = some (23, 256, 200) ∧
    contact (256 : ℝ) 200 = .gap ∧ margin (256 : ℝ) 200 = 56 ∧
    contact (reflect 256) (reflect 200) = .overlap ∧
    overlapSize (reflect 256) (reflect 200) = 56
```
</details>

<details><summary>ASCII</summary>

```text
theorem tick23_gap_reverses_to_overlap :
    (schedule[8]?).map (fun k => (k.label, k.listener, k.mentor)) = some (23, 256, 200) /\
    contact (256 : Real) 200 = .gap /\ margin (256 : Real) 200 = 56 /\
    contact (reflect 256) (reflect 200) = .overlap /\
    overlapSize (reflect 256) (reflect 200) = 56
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
\mathrm{tick}_8=(23,256,200),\quad m(256,200)=56>0,\quad m(-256,-200)<0,\quad (-200)-(-256)=56
$$

```latex
\mathrm{tick}_8=(23,256,200),\quad m(256,200)=56>0,\quad m(-256,-200)<0,\quad (-200)-(-256)=56
```
</details>

Comes from: [forward_gap_becomes_backward_overlap](forward_gap_becomes_backward_overlap.md), [freeze_at_tick23_both_ways](freeze_at_tick23_both_ways.md)

[Back to the tree](../TREE.md)

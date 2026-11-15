# `reflect_flips_margin`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem reflect_flips_margin (b e : ℝ) :
    margin (reflect b) (reflect e) = -(margin b e)
```

- Proof: [ViscousTimeReversalProofs.lean line 142](../ViscousTimeReversalProofs.lean#L142)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 91](../ViscousTimeReversalChallenge.lean#L91)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

Read from the other side of the split, the margin (where mine begins minus where yours ends) changes sign and keeps its size.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Leído desde el otro lado del split, el margen (donde empieza lo mío menos donde termina lo tuyo) cambia de signo y conserva su tamaño.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Lue depuis l'autre côté du split, la marge (là où le mien commence moins là où le tien finit) change de signe et garde sa taille.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Von der anderen Seite des split gelesen, wechselt der Abstand (wo meins beginnt minus wo deins endet) das Vorzeichen und behält seine Größe.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

从 split 的另一侧读，间距（我的开始处减去你的结束处）改变符号，大小不变。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

split の反対側から読むと、余白（私のものが始まる位置から、あなたのものが終わる位置を引いたもの）は符号が変わり、大きさは保たれる。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

عند القراءة من الجهة الأخرى للـ split، يتغيّر الهامش (حيث يبدأ ما لي ناقص حيث ينتهي ما لك) في الإشارة ويحتفظ بحجمه.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

split की दूसरी ओर से पढ़ने पर अंतराल (जहाँ मेरा शुरू होता है, उसमें से जहाँ तुम्हारा खत्म होता है, घटाकर) का चिह्न बदल जाता है और आकार वही रहता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Lida do outro lado do split, a margem (onde o meu começa menos onde o seu termina) troca de sinal e mantém o tamanho.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem reflect_flips_margin (b e : ℝ) :
    margin (reflect b) (reflect e) = -(margin b e)
```
</details>

<details><summary>ASCII</summary>

```text
theorem reflect_flips_margin (b e : Real) :
    margin (reflect b) (reflect e) = -(margin b e)
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
m(-b,-e)=-m(b,e),\qquad m(b,e):=b-e
$$

```latex
m(-b,-e)=-m(b,e),\qquad m(b,e):=b-e
```
</details>

Comes from: [reverse_twice](reverse_twice.md)

Leads to: [forward_gap_becomes_backward_overlap](forward_gap_becomes_backward_overlap.md), [touch_stays_touch](touch_stays_touch.md)

[Back to the tree](../TREE.md)

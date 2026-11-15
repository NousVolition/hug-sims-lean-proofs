# `touch_stays_touch`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem touch_stays_touch (b e : ℝ) (h : contact b e = .touch) :
    contact (reflect b) (reflect e) = .touch
```

- Proof: [ViscousTimeReversalProofs.lean line 163](../ViscousTimeReversalProofs.lean#L163)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 100](../ViscousTimeReversalChallenge.lean#L100)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

A touch (margin 0) stays a touch in both directions.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Un contacto (margen 0) sigue siendo un contacto en ambas direcciones.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Un contact (marge 0) reste un contact dans les deux sens.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Eine Berührung (Abstand 0) bleibt in beide Richtungen eine Berührung.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

接触（间距为 0）在两个方向上都仍是接触。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

接触（余白 0）はどちらの向きでも接触のままである。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

التلامس (هامش 0) يبقى تلامسًا في الاتجاهين.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

स्पर्श (अंतराल 0) दोनों दिशाओं में स्पर्श ही रहता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Um toque (margem 0) continua um toque nos dois sentidos.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem touch_stays_touch (b e : ℝ) (h : contact b e = .touch) :
    contact (reflect b) (reflect e) = .touch
```
</details>

<details><summary>ASCII</summary>

```text
theorem touch_stays_touch (b e : Real) (h : contact b e = .touch) :
    contact (reflect b) (reflect e) = .touch
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
m(b,e)=0\ \Longrightarrow\ m(-b,-e)=0
$$

```latex
m(b,e)=0\ \Longrightarrow\ m(-b,-e)=0
```
</details>

Comes from: [reflect_flips_margin](reflect_flips_margin.md)

[Back to the tree](../TREE.md)

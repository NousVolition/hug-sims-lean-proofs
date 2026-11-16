# `share_change_undone`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem share_change_undone (s d : ℚ) (b e : ℝ) :
    moveBegin (moveBegin b d) (-d) = b ∧
    margin (moveBegin (moveBegin b d) (-d)) e = margin b e ∧
    mentorOf (s + d + -d) = mentorOf s ∧
    (s + d + -d) + mentorOf (s + d + -d) = 1
```

- Proof: [ViscousTimeReversalProofs.lean line 190](../ViscousTimeReversalProofs.lean#L190)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 115](../ViscousTimeReversalChallenge.lean#L115)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

If the student's share changes by d, the student's start moves by d. Run backward, the change is −d: the start and the margin return to where they were, and the shares still make 1.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Si la parte del student cambia en d, el inicio del student se mueve d. Hacia atrás, el cambio es −d: el inicio y el margen vuelven a donde estaban, y las partes siguen sumando 1.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Si la part du student change de d, le début du student se déplace de d. En sens inverse, le changement est −d : le début et la marge reviennent à leur place, et les parts font toujours 1.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Ändert sich der Anteil des student um d, verschiebt sich der Beginn des student um d. Rückwärts ist die Änderung −d: Beginn und Abstand kehren an ihren Platz zurück, und die Anteile ergeben weiterhin 1.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

如果 student 的份额改变 d，student 的起点移动 d。向后运行时改变量是 −d：起点和间距回到原处，份额之和仍为 1。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

student の取り分が d だけ変わると、student の始まりは d だけ動く。後ろ向きには変化は −d で、始まりと余白は元の位置に戻り、取り分の和は 1 のままである。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

إذا تغيّرت حصة الـ student بمقدار d، تحرّكت بدايته بمقدار d. عند السير إلى الخلف يكون التغيّر −d: تعود البداية والهامش إلى مكانهما، وتبقى الحصتان مساويتين 1.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

यदि student का हिस्सा d से बदलता है, तो student की शुरुआत d से खिसकती है। पीछे की ओर बदलाव −d है: शुरुआत और अंतराल अपनी जगह लौट आते हैं, और हिस्सों का योग 1 ही रहता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Se a parte do student muda em d, o início do student se move d. Para trás, a mudança é −d: o início e a margem voltam para onde estavam, e as partes continuam somando 1.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem share_change_undone (s d : ℚ) (b e : ℝ) :
    moveBegin (moveBegin b d) (-d) = b ∧
    margin (moveBegin (moveBegin b d) (-d)) e = margin b e ∧
    mentorOf (s + d + -d) = mentorOf s ∧
    (s + d + -d) + mentorOf (s + d + -d) = 1
```
</details>

<details><summary>ASCII</summary>

```text
theorem share_change_undone (s d : Rat) (b e : Real) :
    moveBegin (moveBegin b d) (-d) = b /\
    margin (moveBegin (moveBegin b d) (-d)) e = margin b e /\
    mentorOf (s + d + -d) = mentorOf s /\
    (s + d + -d) + mentorOf (s + d + -d) = 1
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
(b+d)+(-d)=b,\quad m\bigl((b+d)-d,\,e\bigr)=m(b,e),\quad 1-(s+d-d)=1-s,\quad (s+d-d)+(1-(s+d-d))=1
$$

```latex
(b+d)+(-d)=b,\quad m\bigl((b+d)-d,\,e\bigr)=m(b,e),\quad 1-(s+d-d)=1-s,\quad (s+d-d)+(1-(s+d-d))=1
```
</details>

Comes from: [reversal_keeps_one](reversal_keeps_one.md)

[Back to the tree](../TREE.md)

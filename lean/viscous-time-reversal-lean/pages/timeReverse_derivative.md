# `timeReverse_derivative`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem timeReverse_derivative (f : ℝ → ℝ) (T t d : ℝ)
    (h : HasDerivAt f d (T - t)) :
    HasDerivAt (reverseTime T f) (-d) t
```

- Proof: [ViscousTimeReversalProofs.lean line 15](../ViscousTimeReversalProofs.lean#L15)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 12](../ViscousTimeReversalChallenge.lean#L12)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

If a trace has rate d at time T − t, the time-reversed trace has rate −d at time t.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Si una traza tiene tasa d en el instante T − t, la traza con el tiempo invertido tiene tasa −d en el instante t.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Si une trace a le taux d à l'instant T − t, la trace au temps inversé a le taux −d à l'instant t.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Hat ein Verlauf zur Zeit T − t die Rate d, so hat der zeitumgekehrte Verlauf zur Zeit t die Rate −d.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

如果一条轨迹在时刻 T − t 的变化率是 d，那么时间反转后的轨迹在时刻 t 的变化率是 −d。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

軌跡が時刻 T − t で変化率 d をもつなら、時間反転した軌跡は時刻 t で変化率 −d をもつ。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

إذا كان للمسار معدل d عند اللحظة T − t، فللمسار المعكوس زمنيًا معدل −d عند اللحظة t.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

यदि किसी पथ की दर समय T − t पर d है, तो समय-उलटे पथ की दर समय t पर −d है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Se um traço tem taxa d no instante T − t, o traço com o tempo invertido tem taxa −d no instante t.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem timeReverse_derivative (f : ℝ → ℝ) (T t d : ℝ)
    (h : HasDerivAt f d (T - t)) :
    HasDerivAt (reverseTime T f) (-d) t
```
</details>

<details><summary>ASCII</summary>

```text
theorem timeReverse_derivative (f : Real -> Real) (T t d : Real)
    (h : HasDerivAt f d (T - t)) :
    HasDerivAt (reverseTime T f) (-d) t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
f'(T-t)=d\ \Longrightarrow\ (R_T f)'(t)=-d
$$

```latex
f'(T-t)=d\ \Longrightarrow\ (R_T f)'(t)=-d
```
</details>

Comes from: [reverseTime_twice](reverseTime_twice.md)

Leads to: [viscosity_reversal](viscosity_reversal.md), [whole_rhs_reversal](whole_rhs_reversal.md)

[Back to the tree](../TREE.md)

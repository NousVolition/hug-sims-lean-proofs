# `double_sign_flip_restores_forward`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem double_sign_flip_restores_forward (h ν q a : ℝ) :
    eulerIncrement (-h) (viscousRate (-ν) q a) = eulerIncrement h (viscousRate ν q a)
```

- Proof: [ViscousTimeReversalProofs.lean line 102](../ViscousTimeReversalProofs.lean#L102)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 65](../ViscousTimeReversalChallenge.lean#L65)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

A negative time step with negated viscosity gives the same increment as the forward step.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Un paso de tiempo negativo con la viscosidad negada da el mismo incremento que el paso hacia adelante.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Un pas de temps négatif avec la viscosité changée de signe donne le même incrément que le pas vers l'avant.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Ein negativer Zeitschritt mit negierter Viskosität ergibt denselben Zuwachs wie der Vorwärtsschritt.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

负时间步配上取负的黏性，得到与正向一步相同的增量。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

負の時間刻みに符号を反転した粘性を組み合わせると、前向きの一刻みと同じ増分になる。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

خطوة زمنية سالبة مع لزوجة مقلوبة الإشارة تعطي الزيادة نفسها التي تعطيها الخطوة الأمامية.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

ऋणात्मक समय-कदम और उलटी श्यानता साथ में वही वृद्धि देते हैं जो आगे का कदम देता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Um passo de tempo negativo com a viscosidade negada dá o mesmo incremento que o passo para a frente.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem double_sign_flip_restores_forward (h ν q a : ℝ) :
    eulerIncrement (-h) (viscousRate (-ν) q a) = eulerIncrement h (viscousRate ν q a)
```
</details>

<details><summary>ASCII</summary>

```text
theorem double_sign_flip_restores_forward (h nu q a : Real) :
    eulerIncrement (-h) (viscousRate (-nu) q a) = eulerIncrement h (viscousRate nu q a)
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
(-h)\cdot\bigl(-((-\nu) q)\,a\bigr)=h\cdot\bigl(-(\nu q)\,a\bigr)
$$

```latex
(-h)\cdot\bigl(-((-\nu) q)\,a\bigr)=h\cdot\bigl(-(\nu q)\,a\bigr)
```
</details>

Comes from: [negative_step_reverses_rate](negative_step_reverses_rate.md)

Leads to: [backward_step_is_reversed_wall](backward_step_is_reversed_wall.md)

[Back to the tree](../TREE.md)

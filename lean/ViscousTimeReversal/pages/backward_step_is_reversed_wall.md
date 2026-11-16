# `backward_step_is_reversed_wall`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem backward_step_is_reversed_wall (h gAB gBA q a : ℝ) :
    eulerIncrement (-h) (viscousRate (wall gAB gBA) q a) =
      eulerIncrement h (viscousRate (reversedWall gAB gBA) q a)
```

- Proof: [ViscousTimeReversalProofs.lean line 303](../ViscousTimeReversalProofs.lean#L303)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 170](../ViscousTimeReversalChallenge.lean#L170)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

One backward time step through the wall is the same as one forward step through the reversed wall.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Un paso de tiempo hacia atrás a través del wall es lo mismo que un paso hacia adelante a través del wall invertido.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Un pas de temps vers l'arrière à travers le wall revient au même qu'un pas vers l'avant à travers le wall inversé.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Ein Zeitschritt rückwärts durch die wall ist dasselbe wie ein Schritt vorwärts durch die umgekehrte wall.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

穿过 wall 向后走一个时间步，等同于穿过反向 wall 向前走一步。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

wall を通って後ろ向きに一刻み進むことは、反転した wall を通って前向きに一刻み進むことと同じである。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

خطوة زمنية واحدة إلى الخلف عبر الـ wall هي نفسها خطوة واحدة إلى الأمام عبر الـ wall المعكوس.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

wall से होकर पीछे की ओर एक समय-कदम, उलटे wall से होकर आगे के एक कदम के समान है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Um passo de tempo para trás através do wall é o mesmo que um passo para a frente através do wall invertido.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem backward_step_is_reversed_wall (h gAB gBA q a : ℝ) :
    eulerIncrement (-h) (viscousRate (wall gAB gBA) q a) =
      eulerIncrement h (viscousRate (reversedWall gAB gBA) q a)
```
</details>

<details><summary>ASCII</summary>

```text
theorem backward_step_is_reversed_wall (h gAB gBA q a : Real) :
    eulerIncrement (-h) (viscousRate (wall gAB gBA) q a) =
      eulerIncrement h (viscousRate (reversedWall gAB gBA) q a)
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
(-h)\cdot\bigl(-(w q)\,a\bigr)=h\cdot\bigl(-((-w) q)\,a\bigr)
$$

```latex
(-h)\cdot\bigl(-(w q)\,a\bigr)=h\cdot\bigl(-((-w) q)\,a\bigr)
```
</details>

Comes from: [wall_flips_under_reversal](wall_flips_under_reversal.md), [double_sign_flip_restores_forward](double_sign_flip_restores_forward.md)

[Back to the tree](../TREE.md)

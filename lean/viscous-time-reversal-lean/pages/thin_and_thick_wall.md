# `thin_and_thick_wall`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem thin_and_thick_wall : thinWall = 1/50 ∧ thickWall = 1/10
```

- Proof: [ViscousTimeReversalProofs.lean line 219](../ViscousTimeReversalProofs.lean#L219)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 132](../ViscousTimeReversalChallenge.lean#L132)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

The thin wall (both guards down) is 1/50 and the thick wall (both guards up) is 1/10.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

El wall delgado (ambas guardas abajo) es 1/50 y el wall grueso (ambas guardas arriba) es 1/10.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Le wall mince (les deux gardes baissées) vaut 1/50 et le wall épais (les deux gardes levées) vaut 1/10.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Die dünne wall (beide Wächter unten) ist 1/50, die dicke wall (beide Wächter oben) ist 1/10.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

薄 wall（两个守卫都放下）是 1/50，厚 wall（两个守卫都升起）是 1/10。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

薄い wall（両方のガードが下がっている）は 1/50、厚い wall（両方のガードが上がっている）は 1/10 である。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

الـ wall الرقيق (الحارسان منخفضان) يساوي 1/50، والـ wall السميك (الحارسان مرتفعان) يساوي 1/10.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

पतला wall (दोनों रक्षक नीचे) 1/50 है और मोटा wall (दोनों रक्षक ऊपर) 1/10 है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

O wall fino (as duas guardas abaixadas) é 1/50 e o wall grosso (as duas guardas levantadas) é 1/10.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem thin_and_thick_wall : thinWall = 1/50 ∧ thickWall = 1/10
```
</details>

<details><summary>ASCII</summary>

```text
theorem thin_and_thick_wall : thinWall = 1/50 /\ thickWall = 1/10
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
w(0,0)=\tfrac1{50},\qquad w(1,1)=\tfrac1{10}
$$

```latex
w(0,0)=\tfrac1{50},\qquad w(1,1)=\tfrac1{10}
```
</details>

Comes from: [wall_is_single_system_viscosity](wall_is_single_system_viscosity.md)

Leads to: [wall_between_thin_and_thick](wall_between_thin_and_thick.md)

[Back to the tree](../TREE.md)

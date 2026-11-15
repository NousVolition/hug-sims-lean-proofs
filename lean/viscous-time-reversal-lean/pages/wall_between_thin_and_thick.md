# `wall_between_thin_and_thick`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem wall_between_thin_and_thick (gAB gBA : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) :
    wall gAB gBA ∈ Set.Icc (1/50 : ℝ) (1/10)
```

- Proof: [ViscousTimeReversalProofs.lean line 223](../ViscousTimeReversalProofs.lean#L223)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 135](../ViscousTimeReversalChallenge.lean#L135)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

With both guards between 0 and 1, the wall is between the thin wall 1/50 and the thick wall 1/10.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Con ambas guardas entre 0 y 1, el wall está entre el wall delgado 1/50 y el wall grueso 1/10.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Avec les deux gardes entre 0 et 1, le wall est entre le wall mince 1/50 et le wall épais 1/10.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Liegen beide Wächter zwischen 0 und 1, so liegt die wall zwischen der dünnen wall 1/50 und der dicken wall 1/10.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

当两个守卫都在 0 和 1 之间时，wall 介于薄 wall 1/50 和厚 wall 1/10 之间。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

両方のガードが 0 と 1 の間にあるとき、wall は薄い wall 1/50 と厚い wall 1/10 の間にある。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

عندما يكون الحارسان بين 0 و1، يقع الـ wall بين الـ wall الرقيق 1/50 والـ wall السميك 1/10.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

जब दोनों रक्षक 0 और 1 के बीच हों, तो wall पतले wall 1/50 और मोटे wall 1/10 के बीच होता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Com as duas guardas entre 0 e 1, o wall fica entre o wall fino 1/50 e o wall grosso 1/10.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem wall_between_thin_and_thick (gAB gBA : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1) :
    wall gAB gBA ∈ Set.Icc (1/50 : ℝ) (1/10)
```
</details>

<details><summary>ASCII</summary>

```text
theorem wall_between_thin_and_thick (gAB gBA : Real)
    (ha : gAB in Set.Icc (0:Real) 1) (hb : gBA in Set.Icc (0:Real) 1) :
    wall gAB gBA in Set.Icc (1/50 : Real) (1/10)
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
g_{AB},g_{BA}\in[0,1]\ \Longrightarrow\ \tfrac1{50}\le w(g_{AB},g_{BA})\le\tfrac1{10}
$$

```latex
g_{AB},g_{BA}\in[0,1]\ \Longrightarrow\ \tfrac1{50}\le w(g_{AB},g_{BA})\le\tfrac1{10}
```
</details>

Comes from: [thin_and_thick_wall](thin_and_thick_wall.md)

Leads to: [reversed_wall_range](reversed_wall_range.md), [forward_wall_only_damps](forward_wall_only_damps.md), [backward_wall_only_amplifies](backward_wall_only_amplifies.md)

[Back to the tree](../TREE.md)

# `wall_flips_under_reversal`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem wall_flips_under_reversal (f lap : ℝ → ℝ) (gAB gBA t : ℝ)
    (h : HasDerivAt f (wall gAB gBA * lap (aroundSplit t)) (aroundSplit t)) :
    HasDerivAt (reverseAroundSplit f) (reversedWall gAB gBA * lap (aroundSplit t)) t
```

- Proof: [ViscousTimeReversalProofs.lean line 227](../ViscousTimeReversalProofs.lean#L227)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 139](../ViscousTimeReversalChallenge.lean#L139)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

Reversing time around the split turns the wall term (wall × Laplacian) into the reversed wall term (−wall × Laplacian).

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Invertir el tiempo alrededor del split convierte el término del wall (wall × laplaciano) en el término del wall invertido (−wall × laplaciano).

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Inverser le temps autour du split transforme le terme du wall (wall × laplacien) en terme du wall inversé (−wall × laplacien).

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Zeitumkehr um den split macht aus dem wall-Term (wall × Laplace) den umgekehrten wall-Term (−wall × Laplace).

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

围绕 split 反转时间，把 wall 项（wall × 拉普拉斯）变成反向 wall 项（−wall × 拉普拉斯）。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

split のまわりで時間を反転すると、wall の項（wall × ラプラシアン）は反転した wall の項（−wall × ラプラシアン）になる。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

عكس الزمن حول الـ split يحوّل حد الـ wall (wall × لابلاسيان) إلى حد الـ wall المعكوس (−wall × لابلاسيان).

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

split के चारों ओर समय उलटने से wall पद (wall × लाप्लासियन) उलटे wall पद (−wall × लाप्लासियन) में बदल जाता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Inverter o tempo em torno do split transforma o termo do wall (wall × laplaciano) no termo do wall invertido (−wall × laplaciano).

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem wall_flips_under_reversal (f lap : ℝ → ℝ) (gAB gBA t : ℝ)
    (h : HasDerivAt f (wall gAB gBA * lap (aroundSplit t)) (aroundSplit t)) :
    HasDerivAt (reverseAroundSplit f) (reversedWall gAB gBA * lap (aroundSplit t)) t
```
</details>

<details><summary>ASCII</summary>

```text
theorem wall_flips_under_reversal (f lap : Real -> Real) (gAB gBA t : Real)
    (h : HasDerivAt f (wall gAB gBA * lap (aroundSplit t)) (aroundSplit t)) :
    HasDerivAt (reverseAroundSplit f) (reversedWall gAB gBA * lap (aroundSplit t)) t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
f'(-t)=w\,\mathrm{lap}(-t)\ \Longrightarrow\ (\mathcal{R}f)'(t)=(-w)\,\mathrm{lap}(-t)
$$

```latex
f'(-t)=w\,\mathrm{lap}(-t)\ \Longrightarrow\ (\mathcal{R}f)'(t)=(-w)\,\mathrm{lap}(-t)
```
</details>

Comes from: [viscosity_reversal](viscosity_reversal.md), [reverse_twice](reverse_twice.md), [reversed_wall_range](reversed_wall_range.md)

Leads to: [backward_step_is_reversed_wall](backward_step_is_reversed_wall.md)

[Back to the tree](../TREE.md)

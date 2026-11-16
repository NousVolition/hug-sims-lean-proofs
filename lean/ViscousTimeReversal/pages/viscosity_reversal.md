# `viscosity_reversal`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem viscosity_reversal (f lap : ℝ → ℝ) (T t ν : ℝ)
    (h : HasDerivAt f (ν * lap (T - t)) (T - t)) :
    HasDerivAt (reverseTime T f) ((-ν) * lap (T - t)) t
```

- Proof: [ViscousTimeReversalProofs.lean line 22](../ViscousTimeReversalProofs.lean#L22)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 17](../ViscousTimeReversalChallenge.lean#L17)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

If a trace changes at the viscous rate ν·lap, the time-reversed trace changes at the rate (−ν)·lap: reversing time flips the sign of the viscosity.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Si una traza cambia con la tasa viscosa ν·lap, la traza con el tiempo invertido cambia con la tasa (−ν)·lap: invertir el tiempo cambia el signo de la viscosidad.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Si une trace varie au taux visqueux ν·lap, la trace au temps inversé varie au taux (−ν)·lap : inverser le temps change le signe de la viscosité.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Ändert sich ein Verlauf mit der viskosen Rate ν·lap, so ändert sich der zeitumgekehrte Verlauf mit der Rate (−ν)·lap: Zeitumkehr kehrt das Vorzeichen der Viskosität um.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

如果一条轨迹按黏性变化率 ν·lap 变化，那么时间反转后的轨迹按 (−ν)·lap 变化：时间反转使黏性变号。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

軌跡が粘性の変化率 ν·lap で変化するなら、時間反転した軌跡は (−ν)·lap で変化する：時間反転は粘性の符号を反転させる。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

إذا تغيّر مسار بالمعدل اللزج ν·lap، فإن المسار المعكوس زمنيًا يتغيّر بالمعدل (−ν)·lap: عكس الزمن يقلب إشارة اللزوجة.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

यदि कोई पथ श्यान दर ν·lap से बदलता है, तो समय-उलटा पथ दर (−ν)·lap से बदलता है: समय उलटने से श्यानता का चिह्न पलट जाता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Se um traço muda com a taxa viscosa ν·lap, o traço com o tempo invertido muda com a taxa (−ν)·lap: inverter o tempo troca o sinal da viscosidade.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem viscosity_reversal (f lap : ℝ → ℝ) (T t ν : ℝ)
    (h : HasDerivAt f (ν * lap (T - t)) (T - t)) :
    HasDerivAt (reverseTime T f) ((-ν) * lap (T - t)) t
```
</details>

<details><summary>ASCII</summary>

```text
theorem viscosity_reversal (f lap : Real -> Real) (T t nu : Real)
    (h : HasDerivAt f (nu * lap (T - t)) (T - t)) :
    HasDerivAt (reverseTime T f) ((-nu) * lap (T - t)) t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
f'(T-t)=\nu\,\mathrm{lap}(T-t)\ \Longrightarrow\ (R_T f)'(t)=(-\nu)\,\mathrm{lap}(T-t)
$$

```latex
f'(T-t)=\nu\,\mathrm{lap}(T-t)\ \Longrightarrow\ (R_T f)'(t)=(-\nu)\,\mathrm{lap}(T-t)
```
</details>

Comes from: [timeReverse_derivative](timeReverse_derivative.md)

Leads to: [wall_flips_under_reversal](wall_flips_under_reversal.md)

[Back to the tree](../TREE.md)

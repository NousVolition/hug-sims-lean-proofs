# `whole_rhs_reversal`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem whole_rhs_reversal (f transport lap coupling : ℝ → ℝ) (T t ν : ℝ)
    (h : HasDerivAt f (transport (T - t) + ν * lap (T - t) + coupling (T - t))
      (T - t)) :
    HasDerivAt (reverseTime T f)
      (-transport (T - t) - ν * lap (T - t) - coupling (T - t)) t
```

- Proof: [ViscousTimeReversalProofs.lean line 28](../ViscousTimeReversalProofs.lean#L28)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 22](../ViscousTimeReversalChallenge.lean#L22)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

Reversing time flips the sign of the whole right-hand side: the transport, viscous and coupling terms together.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Invertir el tiempo cambia el signo de todo el lado derecho: los términos de transporte, viscoso y de acoplamiento juntos.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Inverser le temps change le signe de tout le membre de droite : les termes de transport, visqueux et de couplage ensemble.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Zeitumkehr kehrt das Vorzeichen der ganzen rechten Seite um: Transport-, Viskositäts- und Kopplungsterm zusammen.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

时间反转使整个右端变号：输运项、黏性项和耦合项一起变号。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

時間反転は右辺全体の符号を反転させる：輸送項、粘性項、結合項がまとめて反転する。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

عكس الزمن يقلب إشارة الطرف الأيمن كله: حدود النقل واللزوجة والاقتران معًا.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

समय उलटने से पूरे दाएँ पक्ष का चिह्न पलट जाता है: परिवहन, श्यान और युग्मन पद एक साथ।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Inverter o tempo troca o sinal de todo o lado direito: os termos de transporte, viscoso e de acoplamento juntos.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem whole_rhs_reversal (f transport lap coupling : ℝ → ℝ) (T t ν : ℝ)
    (h : HasDerivAt f (transport (T - t) + ν * lap (T - t) + coupling (T - t))
      (T - t)) :
    HasDerivAt (reverseTime T f)
      (-transport (T - t) - ν * lap (T - t) - coupling (T - t)) t
```
</details>

<details><summary>ASCII</summary>

```text
theorem whole_rhs_reversal (f transport lap coupling : Real -> Real) (T t nu : Real)
    (h : HasDerivAt f (transport (T - t) + nu * lap (T - t) + coupling (T - t))
      (T - t)) :
    HasDerivAt (reverseTime T f)
      (-transport (T - t) - nu * lap (T - t) - coupling (T - t)) t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
f'(T-t)=\mathrm{tr}(T-t)+\nu\,\mathrm{lap}(T-t)+c(T-t)\ \Longrightarrow\ (R_T f)'(t)=-\mathrm{tr}(T-t)-\nu\,\mathrm{lap}(T-t)-c(T-t)
$$

```latex
f'(T-t)=\mathrm{tr}(T-t)+\nu\,\mathrm{lap}(T-t)+c(T-t)\ \Longrightarrow\ (R_T f)'(t)=-\mathrm{tr}(T-t)-\nu\,\mathrm{lap}(T-t)-c(T-t)
```
</details>

Comes from: [timeReverse_derivative](timeReverse_derivative.md)

[Back to the tree](../TREE.md)

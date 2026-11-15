# `backward_strict_amplification`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem backward_strict_amplification (ν q t : ℝ) (hν : 0 < ν) (hq : 0 < q) (ht : 0 < t) :
    1 < backwardFactor ν q t
```

- Proof: [ViscousTimeReversalProofs.lean line 75](../ViscousTimeReversalProofs.lean#L75)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 49](../ViscousTimeReversalChallenge.lean#L49)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

With viscosity, squared wave number and time all above 0, the backward factor is above 1.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Con viscosidad, número de onda al cuadrado y tiempo todos mayores que 0, el factor hacia atrás es mayor que 1.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Avec viscosité, nombre d'onde au carré et temps tous supérieurs à 0, le facteur vers l'arrière est supérieur à 1.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Sind Viskosität, quadrierte Wellenzahl und Zeit alle größer als 0, so ist der Rückwärtsfaktor größer als 1.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

当黏性、波数平方和时间都大于 0 时，反向因子大于 1。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

粘性、波数の二乗、時間がすべて 0 より大きいとき、後ろ向きの因子は 1 より大きい。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

عندما تكون اللزوجة ومربع العدد الموجي والزمن كلها أكبر من 0، يكون العامل الخلفي أكبر من 1.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

जब श्यानता, तरंग संख्या का वर्ग और समय सभी 0 से अधिक हों, तो पीछे का गुणक 1 से अधिक है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Com viscosidade, número de onda ao quadrado e tempo todos acima de 0, o fator para trás é maior que 1.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem backward_strict_amplification (ν q t : ℝ) (hν : 0 < ν) (hq : 0 < q) (ht : 0 < t) :
    1 < backwardFactor ν q t
```
</details>

<details><summary>ASCII</summary>

```text
theorem backward_strict_amplification (nu q t : Real) (hnu : 0 < nu) (hq : 0 < q) (ht : 0 < t) :
    1 < backwardFactor nu q t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
\nu,q,t>0\ \Longrightarrow\ 1<e^{\nu q t}
$$

```latex
\nu,q,t>0\ \Longrightarrow\ 1<e^{\nu q t}
```
</details>

Comes from: [backward_amplification](backward_amplification.md)

[Back to the tree](../TREE.md)

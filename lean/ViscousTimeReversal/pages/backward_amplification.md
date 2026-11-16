# `backward_amplification`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem backward_amplification (ν q t : ℝ) (hν : 0 ≤ ν) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    1 ≤ backwardFactor ν q t
```

- Proof: [ViscousTimeReversalProofs.lean line 60](../ViscousTimeReversalProofs.lean#L60)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 41](../ViscousTimeReversalChallenge.lean#L41)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

With viscosity, squared wave number and time all at least 0, the backward factor is at least 1: backward, a ripple is only amplified.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Con viscosidad, número de onda al cuadrado y tiempo todos mayores o iguales que 0, el factor hacia atrás es al menos 1: hacia atrás, una onda solo se amplifica.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Avec viscosité, nombre d'onde au carré et temps tous au moins égaux à 0, le facteur vers l'arrière vaut au moins 1 : vers l'arrière, une onde est seulement amplifiée.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Sind Viskosität, quadrierte Wellenzahl und Zeit alle mindestens 0, so ist der Rückwärtsfaktor mindestens 1: rückwärts wird eine Welle nur verstärkt.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

当黏性、波数平方和时间都不小于 0 时，反向因子至少为 1：向后，波纹只会放大。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

粘性、波数の二乗、時間がすべて 0 以上のとき、後ろ向きの因子は 1 以上である：後ろ向きには、波は増幅されるだけである。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

عندما تكون اللزوجة ومربع العدد الموجي والزمن كلها لا تقل عن 0، يكون العامل الخلفي 1 على الأقل: إلى الخلف، الموجة تُضخَّم فقط.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

जब श्यानता, तरंग संख्या का वर्ग और समय सभी कम से कम 0 हों, तो पीछे का गुणक कम से कम 1 है: पीछे की ओर तरंग केवल बढ़ती है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Com viscosidade, número de onda ao quadrado e tempo todos pelo menos 0, o fator para trás é pelo menos 1: para trás, uma onda só é amplificada.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem backward_amplification (ν q t : ℝ) (hν : 0 ≤ ν) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    1 ≤ backwardFactor ν q t
```
</details>

<details><summary>ASCII</summary>

```text
theorem backward_amplification (nu q t : Real) (hnu : 0 <= nu) (hq : 0 <= q) (ht : 0 <= t) :
    1 <= backwardFactor nu q t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
\nu,q,t\ge 0\ \Longrightarrow\ 1\le e^{\nu q t}
$$

```latex
\nu,q,t\ge 0\ \Longrightarrow\ 1\le e^{\nu q t}
```
</details>

Comes from: [backwardFactor_derivative](backwardFactor_derivative.md)

Leads to: [backward_strict_amplification](backward_strict_amplification.md), [higher_frequency_amplification](higher_frequency_amplification.md), [factor_cancellation](factor_cancellation.md), [backward_wall_only_amplifies](backward_wall_only_amplifies.md)

[Back to the tree](../TREE.md)

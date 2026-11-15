# `forward_damping`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem forward_damping (ν q t : ℝ) (hν : 0 ≤ ν) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    forwardFactor ν q t ≤ 1
```

- Proof: [ViscousTimeReversalProofs.lean line 52](../ViscousTimeReversalProofs.lean#L52)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 37](../ViscousTimeReversalChallenge.lean#L37)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

With viscosity, squared wave number and time all at least 0, the forward factor is at most 1: forward, a ripple is only damped.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Con viscosidad, número de onda al cuadrado y tiempo todos mayores o iguales que 0, el factor hacia adelante es como máximo 1: hacia adelante, una onda solo se amortigua.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Avec viscosité, nombre d'onde au carré et temps tous au moins égaux à 0, le facteur vers l'avant vaut au plus 1 : vers l'avant, une onde est seulement amortie.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Sind Viskosität, quadrierte Wellenzahl und Zeit alle mindestens 0, so ist der Vorwärtsfaktor höchstens 1: vorwärts wird eine Welle nur gedämpft.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

当黏性、波数平方和时间都不小于 0 时，正向因子至多为 1：向前，波纹只会衰减。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

粘性、波数の二乗、時間がすべて 0 以上のとき、前向きの因子は 1 以下である：前向きには、波は減衰するだけである。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

عندما تكون اللزوجة ومربع العدد الموجي والزمن كلها لا تقل عن 0، يكون العامل الأمامي 1 على الأكثر: إلى الأمام، الموجة تُخمَد فقط.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

जब श्यानता, तरंग संख्या का वर्ग और समय सभी कम से कम 0 हों, तो आगे का गुणक अधिक से अधिक 1 है: आगे की ओर तरंग केवल मंद होती है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Com viscosidade, número de onda ao quadrado e tempo todos pelo menos 0, o fator para a frente é no máximo 1: para a frente, uma onda só é amortecida.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem forward_damping (ν q t : ℝ) (hν : 0 ≤ ν) (hq : 0 ≤ q) (ht : 0 ≤ t) :
    forwardFactor ν q t ≤ 1
```
</details>

<details><summary>ASCII</summary>

```text
theorem forward_damping (nu q t : Real) (hnu : 0 <= nu) (hq : 0 <= q) (ht : 0 <= t) :
    forwardFactor nu q t <= 1
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
\nu,q,t\ge 0\ \Longrightarrow\ e^{-\nu q t}\le 1
$$

```latex
\nu,q,t\ge 0\ \Longrightarrow\ e^{-\nu q t}\le 1
```
</details>

Comes from: [forwardFactor_derivative](forwardFactor_derivative.md)

Leads to: [forward_strict_damping](forward_strict_damping.md), [factor_cancellation](factor_cancellation.md), [forward_wall_only_damps](forward_wall_only_damps.md)

[Back to the tree](../TREE.md)

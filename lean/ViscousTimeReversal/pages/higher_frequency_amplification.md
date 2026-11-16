# `higher_frequency_amplification`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem higher_frequency_amplification (ν q₁ q₂ t : ℝ) (hν : 0 ≤ ν) (ht : 0 ≤ t) (hq : q₁ ≤ q₂) :
    backwardFactor ν q₁ t ≤ backwardFactor ν q₂ t
```

- Proof: [ViscousTimeReversalProofs.lean line 82](../ViscousTimeReversalProofs.lean#L82)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 53](../ViscousTimeReversalChallenge.lean#L53)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

Backward, a finer ripple (larger q) is amplified at least as much as a coarser one.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Hacia atrás, una onda más fina (q mayor) se amplifica al menos tanto como una más gruesa.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Vers l'arrière, une onde plus fine (q plus grand) est amplifiée au moins autant qu'une onde plus grossière.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Rückwärts wird eine feinere Welle (größeres q) mindestens so stark verstärkt wie eine gröbere.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

向后时，更细的波纹（q 更大）被放大得至少和更粗的一样多。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

後ろ向きには、より細かい波（q が大きい）は、より粗い波と少なくとも同じだけ増幅される。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

إلى الخلف، الموجة الأدق (q أكبر) تُضخَّم على الأقل بقدر الموجة الأخشن.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

पीछे की ओर, महीन तरंग (बड़ा q) कम से कम उतनी ही बढ़ती है जितनी मोटी तरंग।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Para trás, uma onda mais fina (q maior) é amplificada pelo menos tanto quanto uma mais grossa.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem higher_frequency_amplification (ν q₁ q₂ t : ℝ) (hν : 0 ≤ ν) (ht : 0 ≤ t) (hq : q₁ ≤ q₂) :
    backwardFactor ν q₁ t ≤ backwardFactor ν q₂ t
```
</details>

<details><summary>ASCII</summary>

```text
theorem higher_frequency_amplification (nu q1 q2 t : Real) (hnu : 0 <= nu) (ht : 0 <= t) (hq : q1 <= q2) :
    backwardFactor nu q1 t <= backwardFactor nu q2 t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
\nu,t\ge 0,\ q_1\le q_2\ \Longrightarrow\ e^{\nu q_1 t}\le e^{\nu q_2 t}
$$

```latex
\nu,t\ge 0,\ q_1\le q_2\ \Longrightarrow\ e^{\nu q_1 t}\le e^{\nu q_2 t}
```
</details>

Comes from: [backward_amplification](backward_amplification.md)

[Back to the tree](../TREE.md)

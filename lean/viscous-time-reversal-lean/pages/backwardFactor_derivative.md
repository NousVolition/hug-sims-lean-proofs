# `backwardFactor_derivative`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem backwardFactor_derivative (ν q t : ℝ) :
    HasDerivAt (backwardFactor ν q) ((ν * q) * backwardFactor ν q t) t
```

- Proof: [ViscousTimeReversalProofs.lean line 45](../ViscousTimeReversalProofs.lean#L45)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 33](../ViscousTimeReversalChallenge.lean#L33)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

The backward factor exp(νqt) changes at the rate νq times itself.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

El factor hacia atrás exp(νqt) cambia con la tasa νq por sí mismo.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Le facteur vers l'arrière exp(νqt) varie au taux νq fois lui-même.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Der Rückwärtsfaktor exp(νqt) ändert sich mit der Rate νq mal sich selbst.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

反向因子 exp(νqt) 的变化率是 νq 乘以它自己。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

後ろ向きの因子 exp(νqt) は、自分自身の νq 倍の変化率で変化する。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

العامل الخلفي exp(νqt) يتغيّر بمعدل يساوي νq مضروبًا في نفسه.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

पीछे का गुणक exp(νqt) अपने आप के νq गुना की दर से बदलता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

O fator para trás exp(νqt) muda com a taxa νq vezes ele mesmo.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem backwardFactor_derivative (ν q t : ℝ) :
    HasDerivAt (backwardFactor ν q) ((ν * q) * backwardFactor ν q t) t
```
</details>

<details><summary>ASCII</summary>

```text
theorem backwardFactor_derivative (nu q t : Real) :
    HasDerivAt (backwardFactor nu q) ((nu * q) * backwardFactor nu q t) t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
\frac{d}{dt}e^{\nu q t}=\nu q\,e^{\nu q t}
$$

```latex
\frac{d}{dt}e^{\nu q t}=\nu q\,e^{\nu q t}
```
</details>

Leads to: [backward_amplification](backward_amplification.md)

[Back to the tree](../TREE.md)

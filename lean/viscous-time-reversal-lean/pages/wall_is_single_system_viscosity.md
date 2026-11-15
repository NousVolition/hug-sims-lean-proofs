# `wall_is_single_system_viscosity`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem wall_is_single_system_viscosity (z : HugNavierSingle.Fields) (r : HugNavierSingle.Point) :
    HugNavierSingle.viscosity z r = wall (z.gAB r) (z.gBA r)
```

- Proof: [ViscousTimeReversalProofs.lean line 215](../ViscousTimeReversalProofs.lean#L215)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 128](../ViscousTimeReversalChallenge.lean#L128)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

The wall is exactly the single-system viscosity 1/50 + (1/25)(gAB + gBA), point by point.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

El wall es exactamente la viscosidad del sistema único 1/50 + (1/25)(gAB + gBA), punto por punto.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Le wall est exactement la viscosité du système unique 1/50 + (1/25)(gAB + gBA), point par point.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Die wall ist genau die Viskosität des Einzelsystems 1/50 + (1/25)(gAB + gBA), Punkt für Punkt.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

wall 逐点恰好等于单一系统的黏性 1/50 + (1/25)(gAB + gBA)。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

wall は各点で単一システムの粘性 1/50 + (1/25)(gAB + gBA) にちょうど等しい。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

الـ wall يساوي تمامًا لزوجة النظام الواحد 1/50 + (1/25)(gAB + gBA)، نقطةً بنقطة.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

wall हर बिंदु पर ठीक एकल-प्रणाली की श्यानता 1/50 + (1/25)(gAB + gBA) है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

O wall é exatamente a viscosidade do sistema único 1/50 + (1/25)(gAB + gBA), ponto a ponto.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem wall_is_single_system_viscosity (z : HugNavierSingle.Fields) (r : HugNavierSingle.Point) :
    HugNavierSingle.viscosity z r = wall (z.gAB r) (z.gBA r)
```
</details>

<details><summary>ASCII</summary>

```text
theorem wall_is_single_system_viscosity (z : HugNavierSingle.Fields) (r : HugNavierSingle.Point) :
    HugNavierSingle.viscosity z r = wall (z.gAB r) (z.gBA r)
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
\nu(z,r)=w(g_{AB}(r),g_{BA}(r)),\qquad w(a,b):=\tfrac1{50}+\tfrac1{25}(a+b)
$$

```latex
\nu(z,r)=w(g_{AB}(r),g_{BA}(r)),\qquad w(a,b):=\tfrac1{50}+\tfrac1{25}(a+b)
```
</details>

Leads to: [thin_and_thick_wall](thin_and_thick_wall.md)

[Back to the tree](../TREE.md)

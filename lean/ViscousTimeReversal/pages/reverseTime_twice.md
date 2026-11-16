# `reverseTime_twice`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem reverseTime_twice (T t : ℝ) (f : ℝ → ℝ) :
    reverseTime T (reverseTime T f) t = f t
```

- Proof: [ViscousTimeReversalProofs.lean line 10](../ViscousTimeReversalProofs.lean#L10)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 8](../ViscousTimeReversalChallenge.lean#L8)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

Reversing time about a moment T twice gives back the original trace at every time t.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Invertir el tiempo dos veces alrededor de un instante T devuelve la traza original en todo instante t.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Inverser deux fois le temps autour d'un instant T redonne la trace d'origine à tout instant t.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Die Zeit zweimal um einen Zeitpunkt T umzukehren, ergibt zu jeder Zeit t wieder den ursprünglichen Verlauf.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

围绕时刻 T 把时间反转两次，在每个时刻 t 都得回原来的轨迹。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

時刻 T のまわりで時間を二回反転すると、すべての時刻 t で元の軌跡に戻る。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

عكس الزمن مرتين حول لحظة T يعيد المسار الأصلي في كل لحظة t.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

किसी क्षण T के चारों ओर समय को दो बार उलटने पर हर समय t पर मूल पथ वापस मिलता है।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Inverter o tempo duas vezes em torno de um instante T devolve o traço original em todo instante t.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem reverseTime_twice (T t : ℝ) (f : ℝ → ℝ) :
    reverseTime T (reverseTime T f) t = f t
```
</details>

<details><summary>ASCII</summary>

```text
theorem reverseTime_twice (T t : Real) (f : Real -> Real) :
    reverseTime T (reverseTime T f) t = f t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
\forall T,t\in\mathbb{R},\ f:\mathbb{R}\to\mathbb{R}:\quad (R_T R_T f)(t)=f(t),\qquad (R_T f)(t):=f(T-t)
$$

```latex
\forall T,t\in\mathbb{R},\ f:\mathbb{R}\to\mathbb{R}:\quad (R_T R_T f)(t)=f(t),\qquad (R_T f)(t):=f(T-t)
```
</details>

Leads to: [timeReverse_derivative](timeReverse_derivative.md), [reverse_twice](reverse_twice.md)

[Back to the tree](../TREE.md)

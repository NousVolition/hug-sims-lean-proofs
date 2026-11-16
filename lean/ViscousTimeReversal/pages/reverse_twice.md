# `reverse_twice`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem reverse_twice {α : Type} (f : ℝ → α) (t : ℝ) :
    reverseAroundSplit (reverseAroundSplit f) t = f t
```

- Proof: [ViscousTimeReversalProofs.lean line 120](../ViscousTimeReversalProofs.lean#L120)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 76](../ViscousTimeReversalChallenge.lean#L76)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

Reversing time around the 0,0 split twice gives back exactly what was there.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Invertir el tiempo dos veces alrededor del split 0,0 devuelve exactamente lo que había.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Inverser deux fois le temps autour du split 0,0 redonne exactement ce qui était là.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Die Zeit zweimal um den 0,0-split umzukehren, ergibt genau das, was vorher da war.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

围绕 0,0 split 把时间反转两次，恰好得回原来的内容。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

0,0 split のまわりで時間を二回反転すると、元にあったものがそのまま戻る。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

عكس الزمن مرتين حول الـ split عند 0,0 يعيد بالضبط ما كان موجودًا.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

0,0 split के चारों ओर समय को दो बार उलटने पर ठीक वही वापस मिलता है जो पहले था।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Inverter o tempo duas vezes em torno do split 0,0 devolve exatamente o que havia.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem reverse_twice {α : Type} (f : ℝ → α) (t : ℝ) :
    reverseAroundSplit (reverseAroundSplit f) t = f t
```
</details>

<details><summary>ASCII</summary>

```text
theorem reverse_twice {alpha : Type} (f : Real -> alpha) (t : Real) :
    reverseAroundSplit (reverseAroundSplit f) t = f t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
(\mathcal{R}\mathcal{R}f)(t)=f(t),\qquad (\mathcal{R}f)(t):=f(-t)
$$

```latex
(\mathcal{R}\mathcal{R}f)(t)=f(t),\qquad (\mathcal{R}f)(t):=f(-t)
```
</details>

Comes from: [split_at_tick_two](split_at_tick_two.md), [reverseTime_twice](reverseTime_twice.md)

Leads to: [reversal_keeps_one](reversal_keeps_one.md), [reflect_flips_margin](reflect_flips_margin.md), [wall_flips_under_reversal](wall_flips_under_reversal.md)

[Back to the tree](../TREE.md)

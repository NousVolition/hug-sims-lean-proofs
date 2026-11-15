# `both_directions_add`

Only the Lean statement below is checked (by Lean, Comparator, the Lean kernel and nanoda). The plain-words versions and the ASCII and LaTeX forms are reading aids.

## Lean statement (checked text)

```lean
theorem both_directions_add (a gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1)
    (ha0 : a ≠ 0) (hq : 0 < q) (ht : 0 < t) :
    0 < takenForward a (wall gAB gBA) q t ∧ 0 < givenBackward a (wall gAB gBA) q t ∧
    takenForward a (wall gAB gBA) q t <
      takenForward a (wall gAB gBA) q t + givenBackward a (wall gAB gBA) q t ∧
    givenBackward a (wall gAB gBA) q t <
      takenForward a (wall gAB gBA) q t + givenBackward a (wall gAB gBA) q t
```

- Proof: [ViscousTimeReversalProofs.lean line 334](../ViscousTimeReversalProofs.lean#L334)
- Frozen statement: [ViscousTimeReversalChallenge.lean line 186](../ViscousTimeReversalChallenge.lean#L186)
- Definitions: [ViscousTimeReversalDefinitions.lean](../ViscousTimeReversalDefinitions.lean), [MentorStudentModel.lean](../MentorStudentModel.lean), [FullModel.lean](../FullModel.lean)

## Plain words

<details open><summary>English</summary>

<div lang="en">

For a ripple that is there (size not 0, q above 0) at any time away from the split, both amounts counted from the split are above 0, so together they are more than either alone: the two directions add and never cancel.

<em>Only the Lean text is checked; this version is a reading aid.</em>

</div>
</details>

<details><summary>Español</summary>

<div lang="es">

Para una onda presente (tamaño distinto de 0, q mayor que 0), en cualquier momento fuera del split, las dos cantidades contadas desde el split son mayores que 0, así que juntas son más que cada una sola: las dos direcciones se suman y nunca se cancelan.

<em>Solo el texto Lean está comprobado; esta versión es una ayuda de lectura.</em>

</div>
</details>

<details><summary>Français</summary>

<div lang="fr">

Pour une onde présente (taille non nulle, q supérieur à 0), à tout instant hors du split, les deux quantités comptées depuis le split sont supérieures à 0, donc ensemble elles dépassent chacune seule : les deux sens s'ajoutent et ne s'annulent jamais.

<em>Seul le texte Lean est vérifié ; cette version est une aide à la lecture.</em>

</div>
</details>

<details><summary>Deutsch</summary>

<div lang="de">

Für eine vorhandene Welle (Größe nicht 0, q größer als 0) sind zu jeder Zeit außerhalb des split beide vom split aus gezählten Beträge größer als 0; zusammen sind sie also mehr als jeder allein: die beiden Richtungen addieren sich und heben sich nie auf.

<em>Nur der Lean-Text ist geprüft; diese Fassung ist eine Lesehilfe.</em>

</div>
</details>

<details><summary>中文</summary>

<div lang="zh">

对一个存在的波纹（大小不为 0，q 大于 0），在 split 之外的任何时刻，从 split 计起的两个量都大于 0，因此两者之和大于其中任何一个：两个方向相加，永不抵消。

<em>只有 Lean 文本经过检查；此版本仅为阅读辅助。</em>

</div>
</details>

<details><summary>日本語</summary>

<div lang="ja">

存在する波（大きさが 0 でなく、q が 0 より大きい）について、split 以外のどの時刻でも、split から数えた二つの量はどちらも 0 より大きいので、合わせるとどちらか一方だけより大きい：二つの向きは足し合わされ、打ち消し合うことはない。

<em>検査されているのは Lean のテキストだけです。この版は読むための補助です。</em>

</div>
</details>

<details><summary>العربية</summary>

<div lang="ar" dir="rtl">

لموجة موجودة (حجمها ليس 0 وq أكبر من 0)، في أي لحظة خارج الـ split، يكون المقداران المعدودان من الـ split أكبر من 0، فمجموعهما أكبر من كل منهما وحده: الاتجاهان يتجمّعان ولا يلغي أحدهما الآخر أبدًا.

<em>نص Lean وحده هو المُتحقَّق منه؛ هذه النسخة مساعدة على القراءة.</em>

</div>
</details>

<details><summary>हिन्दी</summary>

<div lang="hi">

किसी मौजूद तरंग (आकार 0 नहीं, q 0 से अधिक) के लिए, split से बाहर किसी भी समय, split से गिनी गई दोनों मात्राएँ 0 से अधिक हैं, इसलिए दोनों मिलकर किसी एक से अधिक हैं: दोनों दिशाएँ जुड़ती हैं और कभी एक-दूसरे को रद्द नहीं करतीं।

<em>केवल Lean पाठ की जाँच हुई है; यह संस्करण पढ़ने में सहायता के लिए है।</em>

</div>
</details>

<details><summary>Português</summary>

<div lang="pt">

Para uma onda presente (tamanho diferente de 0, q acima de 0), em qualquer momento fora do split, as duas quantidades contadas a partir do split são maiores que 0, então juntas são mais do que cada uma sozinha: os dois sentidos se somam e nunca se cancelam.

<em>Só o texto Lean é verificado; esta versão é uma ajuda de leitura.</em>

</div>
</details>

## Symbols

<details open><summary>Lean / Unicode (as written)</summary>

```lean
theorem both_directions_add (a gAB gBA q t : ℝ)
    (ha : gAB ∈ Set.Icc (0:ℝ) 1) (hb : gBA ∈ Set.Icc (0:ℝ) 1)
    (ha0 : a ≠ 0) (hq : 0 < q) (ht : 0 < t) :
    0 < takenForward a (wall gAB gBA) q t ∧ 0 < givenBackward a (wall gAB gBA) q t ∧
    takenForward a (wall gAB gBA) q t <
      takenForward a (wall gAB gBA) q t + givenBackward a (wall gAB gBA) q t ∧
    givenBackward a (wall gAB gBA) q t <
      takenForward a (wall gAB gBA) q t + givenBackward a (wall gAB gBA) q t
```
</details>

<details><summary>ASCII</summary>

```text
theorem both_directions_add (a gAB gBA q t : Real)
    (ha : gAB in Set.Icc (0:Real) 1) (hb : gBA in Set.Icc (0:Real) 1)
    (ha0 : a != 0) (hq : 0 < q) (ht : 0 < t) :
    0 < takenForward a (wall gAB gBA) q t /\ 0 < givenBackward a (wall gAB gBA) q t /\
    takenForward a (wall gAB gBA) q t <
      takenForward a (wall gAB gBA) q t + givenBackward a (wall gAB gBA) q t /\
    givenBackward a (wall gAB gBA) q t <
      takenForward a (wall gAB gBA) q t + givenBackward a (wall gAB gBA) q t
```
</details>

<details><summary>Standard math notation (LaTeX)</summary>

$$
g_{AB},g_{BA}\in[0,1],\ a\ne0,\ q,t>0:\quad 0<T_f,\ 0<G_b,\ T_f<T_f+G_b,\ G_b<T_f+G_b,\quad T_f:=\tfrac{a^2}{2}-\tfrac{(a e^{-wqt})^2}{2},\ G_b:=\tfrac{(a e^{wqt})^2}{2}-\tfrac{a^2}{2}
$$

```latex
g_{AB},g_{BA}\in[0,1],\ a\ne0,\ q,t>0:\quad 0<T_f,\ 0<G_b,\ T_f<T_f+G_b,\ G_b<T_f+G_b,\quad T_f:=\tfrac{a^2}{2}-\tfrac{(a e^{-wqt})^2}{2},\ G_b:=\tfrac{(a e^{wqt})^2}{2}-\tfrac{a^2}{2}
```
</details>

Comes from: [wall_takes_forward_from_split](wall_takes_forward_from_split.md), [wall_gives_backward_from_split](wall_gives_backward_from_split.md)

[Back to the tree](../TREE.md)

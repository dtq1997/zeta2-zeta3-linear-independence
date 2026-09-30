# Mathlib definitions used by the statements

Challenge.lean imports only Mathlib, pinned in `lake-manifest.json` at commit `c55e6e786f49471c72fbddbec5415808896aec1e`. This file quotes verbatim the definitions and lemma statements from that commit that fix the meaning of the two compared theorems. Each excerpt links to its lines in the Mathlib repository.

How they fix the meaning:

- For `s = 2, 3` the hypothesis `1 < re s` holds, so `riemannZeta s = ∑' n : ℕ, 1 / (n + 1 : ℂ) ^ s`, and `(n + 1 : ℂ) ^ s` is the ordinary power `(n + 1) ^ 2` or `(n + 1) ^ 3`. Thus `riemannZeta 2` and `riemannZeta 3` are the complex numbers `∑_{n ≥ 1} 1/n²` and `∑_{n ≥ 1} 1/n³`.
- By `Fintype.linearIndependent_iff` and `Rat.smul_def`, `LinearIndependent ℚ ![x, y, z]` says: for all `g : Fin 3 → ℚ`, `g 0 * x + g 1 * y + g 2 * z = 0` implies `g = 0`.
- The series `∑' k : ℕ, 1 / ((k : ℝ) + 1) ^ p` for `p = 2, 3` is summable (p-series with `1 < p`, shifted by one), so `∑'` is its actual sum and not the default value `0`.
- In this repository, `Zeta32/LinearIndependence.lean` proves `riemannZeta_two_eq_ofReal_tsum` and `riemannZeta_three_eq_ofReal_tsum` (the two zeta values as real series) and `tsum_two_eq` (`∑' n : ℕ, 1 / ((n : ℝ) + 1) ^ 2 = π ^ 2 / 6`); all three are checked by Lean as part of the proof.

## `riemannZeta`

[`Mathlib/NumberTheory/LSeries/RiemannZeta.lean`, lines 119–121](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/NumberTheory/LSeries/RiemannZeta.lean#L119-L121)

```lean
/-- The Riemann zeta function `ζ(s)`. -/
@[wikidata Q187235]
def riemannZeta := hurwitzZetaEven 0
```

## Its value as a series for `re s > 1`

[`Mathlib/NumberTheory/LSeries/RiemannZeta.lean`, lines 212–215](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/NumberTheory/LSeries/RiemannZeta.lean#L212-L215)

```lean
/-- Alternate formulation of `zeta_eq_tsum_one_div_nat_cpow` with a `+ 1` (to avoid relying
on mathlib's conventions for `0 ^ s`). -/
theorem zeta_eq_tsum_one_div_nat_add_one_cpow {s : ℂ} (hs : 1 < re s) :
    riemannZeta s = ∑' n : ℕ, 1 / (n + 1 : ℂ) ^ s
```

## Complex powers with a natural exponent

[`Mathlib/Analysis/SpecialFunctions/Pow/Complex.lean`, lines 125–131](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Analysis/SpecialFunctions/Pow/Complex.lean#L125-L131)

```lean

@[simp, norm_cast]
theorem cpow_natCast (x : ℂ) (n : ℕ) : x ^ (n : ℂ) = x ^ n := by simpa using cpow_nat_mul x n 1

@[simp]
lemma cpow_ofNat (x : ℂ) (n : ℕ) [n.AtLeastTwo] :
    x ^ (ofNat(n) : ℂ) = x ^ ofNat(n)
```

## `LinearIndependent`

[`Mathlib/LinearAlgebra/LinearIndependent/Defs.lean`, lines 97–99](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/LinearAlgebra/LinearIndependent/Defs.lean#L97-L99)

```lean
/-- `LinearIndependent R v` states the family of vectors `v` is linearly independent over `R`. -/
def LinearIndependent : Prop :=
  Injective (Finsupp.linearCombination R v)
```

## `LinearIndependent` for a finite family

[`Mathlib/LinearAlgebra/LinearIndependent/Defs.lean`, lines 770–771](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/LinearAlgebra/LinearIndependent/Defs.lean#L770-L771)

```lean
theorem Fintype.linearIndependent_iff [Fintype ι] :
    LinearIndependent R v ↔ ∀ g : ι → R, ∑ i, g i • v i = 0 → ∀ i, g i = 0
```

## Scalar multiplication by a rational number (namespace `Rat`)

[`Mathlib/Algebra/Field/Defs.lean`, lines 209–209](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Algebra/Field/Defs.lean#L209-L209)

```lean
theorem smul_def (a : ℚ) (x : K) : a • x = ↑a * x := DivisionRing.qsmul_def a x
```

## The notation `![a, b, c]`

[`Mathlib/Data/Fin/VecNotation.lean`, lines 52–77](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Data/Fin/VecNotation.lean#L52-L77)

```lean
/-- `![]` is the vector with no entries. -/
def vecEmpty : Fin 0 → α :=
  Fin.elim0

/-- `vecCons h t` prepends an entry `h` to a vector `t`.

The inverse functions are `vecHead` and `vecTail`.
The notation `![a, b, ...]` expands to `vecCons a (vecCons b ...)`.
-/
def vecCons {n : ℕ} (h : α) (t : Fin n → α) : Fin n.succ → α :=
  Fin.cons h t

/-- `![...]` notation is used to construct a vector `Fin n → α` using `Matrix.vecEmpty` and
`Matrix.vecCons`.

For instance, `![a, b, c] : Fin 3` is syntax for `vecCons a (vecCons b (vecCons c vecEmpty))`.

Note that this should not be used as syntax for `Matrix` as it generates a term with the wrong type.
The `!![a, b; c, d]` syntax (provided by `Matrix.matrixNotation`) should be used instead.
-/
syntax (name := vecNotation) "![" term,* "]" : term

macro_rules
  | `(![$term:term, $terms:term,*]) => `(vecCons $term ![$terms,*])
  | `(![$term:term]) => `(vecCons $term ![])
  | `(![]) => `(vecEmpty)
```

## `∑'` (unconditional sum)

[`Mathlib/Topology/Algebra/InfiniteSum/Defs.lean`, lines 132–160](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Topology/Algebra/InfiniteSum/Defs.lean#L132-L160)

```lean
@[to_additive /-- `∑' i, f i` is the unconditional sum of `f` if it exists, or 0 otherwise.

More generally, if `L` is a `SummationFilter`, `∑'[L] i, f i` is the sum of `f` with respect to
`L` if it exists, and `0` otherwise.

(Note that even if the unconditional sum exists, it might not be unique if the topology is not
separated. When the support of `f` is finite, we make the most reasonable choice, to use the sum
over the support. Otherwise, we choose arbitrarily an `a` satisfying `HasSum f a`. Similar remarks
apply to more general summation filters.)
-/]
noncomputable irreducible_def tprod (f : β → α) (L := unconditional β) :=
  if h : Multipliable f L then
    if L.HasSupport ∧ (mulSupport f ∩ L.support).Finite then finprod (L.support.mulIndicator f)
    else if HasProd f 1 L then 1
    else h.choose
  else 1

variable {L : SummationFilter β}

@[inherit_doc tprod]
notation3 "∏'[" L "]" (...)", "r:67:(scoped f => tprod f L) => r
@[inherit_doc tsum]
notation3 "∑'[" L "]" (...)", "r:67:(scoped f => tsum f L) => r

-- see note [operator precedence of big operators]
@[inherit_doc tprod]
notation3 "∏' "(...)", "r:67:(scoped f => tprod f (unconditional _)) => r
@[inherit_doc tsum]
notation3 "∑' "(...)", "r:67:(scoped f => tsum f (unconditional _)) => r
```

## Convergence of the p-series

[`Mathlib/Analysis/PSeries.lean`, lines 328–331](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Analysis/PSeries.lean#L328-L331)

```lean
/-- Test for convergence of the `p`-series: the real-valued series `∑' n : ℕ, 1 / n ^ p` converges
if and only if `1 < p`. -/
theorem summable_one_div_nat_pow {p : ℕ} :
    Summable (fun n => 1 / (n : ℝ) ^ p : ℕ → ℝ) ↔ 1 < p
```

## Shifting the index does not change summability (`summable_nat_add_iff` is the additive version)

[`Mathlib/Topology/Algebra/InfiniteSum/NatInt.lean`, lines 221–223](https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/Mathlib/Topology/Algebra/InfiniteSum/NatInt.lean#L221-L223)

```lean
@[to_additive]
theorem multipliable_nat_add_iff {f : ℕ → G} (k : ℕ) :
    (Multipliable fun n ↦ f (n + k)) ↔ Multipliable f
```

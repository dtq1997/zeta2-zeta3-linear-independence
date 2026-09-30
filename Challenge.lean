module

public import Mathlib.NumberTheory.LSeries.RiemannZeta
public import Mathlib.LinearAlgebra.LinearIndependent.Defs
public import Mathlib.Data.Fin.VecNotation

/-!
# Linear independence of `1`, `ζ(2)`, `ζ(3)` over `ℚ`

The first statement uses only Mathlib's `riemannZeta` and `LinearIndependent`. For an integer
`k ≥ 2`, `riemannZeta k` is `∑_{n ≥ 1} n^{-k}` (Mathlib's `zeta_eq_tsum_one_div_nat_add_one_cpow`);
`![x, y, z]` is the family `(x, y, z)`, and `LinearIndependent ℚ ![x, y, z]` means that
`a x + b y + c z = 0` with `a, b, c ∈ ℚ` forces `a = b = c = 0` (Mathlib's
`Fintype.linearIndependent_iff`). The second statement is the same result with the two series
written out, so that reading it needs no definition beyond real infinite sums.
Equivalently: for every rational `r`, `ζ(3) − r ζ(2)` is irrational (together with the
irrationality of `ζ(2)`).
This file specifies the statements for Comparator; their proof holes are replaced by `Solution.lean`.
-/

@[expose] public section

/-- `1`, `ζ(2)`, `ζ(3)` are linearly independent over `ℚ`. -/
public theorem one_zeta_two_zeta_three_linearIndependent :
    LinearIndependent ℚ ![(1 : ℂ), riemannZeta 2, riemannZeta 3] := by
  sorry

/-- The same result with the series written out: if `a, b, c ∈ ℚ` and
`a + b ∑_{n ≥ 1} 1/n² + c ∑_{n ≥ 1} 1/n³ = 0`, then `a = b = c = 0`. Both series are written
with index `k = n − 1`. -/
public theorem one_zeta_two_zeta_three_linearIndependent_series (a b c : ℚ)
    (h : (a : ℝ) + b * (∑' k : ℕ, 1 / ((k : ℝ) + 1) ^ 2)
      + c * (∑' k : ℕ, 1 / ((k : ℝ) + 1) ^ 3) = 0) :
    a = 0 ∧ b = 0 ∧ c = 0 := by
  sorry

end

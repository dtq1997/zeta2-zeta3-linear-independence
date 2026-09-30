module

public import Mathlib.NumberTheory.LSeries.RiemannZeta
public import Mathlib.LinearAlgebra.LinearIndependent.Defs
public import Mathlib.Data.Fin.VecNotation

/-!
# Linear independence of `1`, `ζ(2)`, `ζ(3)` over `ℚ`

The statement uses only Mathlib's `riemannZeta` and `LinearIndependent`. Equivalently: for every rational `r`,
`ζ(3) − r ζ(2)` is irrational (together with the irrationality of `ζ(2)`).
This file specifies the statement for Comparator; its proof hole is replaced by `Solution.lean`.
-/

@[expose] public section

/-- `1`, `ζ(2)`, `ζ(3)` are linearly independent over `ℚ`. -/
public theorem one_zeta_two_zeta_three_linearIndependent :
    LinearIndependent ℚ ![(1 : ℂ), riemannZeta 2, riemannZeta 3] := by
  sorry

end

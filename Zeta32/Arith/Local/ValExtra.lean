module
public import Mathlib.NumberTheory.Padics.PadicVal.Basic
public import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
public import Mathlib.Algebra.Polynomial.BigOperators
public import Mathlib.Algebra.Polynomial.Div
public import Mathlib.Data.Nat.Log
public import Mathlib.Tactic.Linarith
public import Mathlib.Tactic.NormNum
public import Zeta32.Arith.Local.Val

@[expose] public section

/-! `VG.ratDen`, formerly only in the duplicate `Arith/Small/Val.lean`
(adapted from dtq1997/li2-half-irrationality@d5d8206:Li2Unified/Modular/Base/Valuation.lean). -/

open Finset Polynomial

namespace Zeta32.Arith.Local

variable {p : ℕ}

namespace VG

/-- `v_p(r) ≥ -v_p(den r)` for every rational `r`. -/
lemma ratDen (r : ℚ) : VG p r (-(padicValNat p r.den : ℚ)) := by
  by_cases hr : r = 0
  · exact Or.inl hr
  right
  have h : padicValRat p r = (padicValInt p r.num : ℤ) - (padicValNat p r.den : ℤ) := rfl
  rw [h, Int.cast_sub, Int.cast_natCast, Int.cast_natCast]
  have : (0 : ℚ) ≤ (padicValInt p r.num : ℚ) := Nat.cast_nonneg _
  linarith

end VG

end Zeta32.Arith.Local

end

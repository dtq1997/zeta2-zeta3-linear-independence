module
public import Zeta32.Family
public import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
public import Mathlib.LinearAlgebra.Matrix.Notation
public import Mathlib.Tactic.NormNum
public import Mathlib.Tactic.FinCases

@[expose] public section
namespace Zeta32.PrimeEdge

/-! the informal proof, §6: fixed local matrices and exact determinant identities.
`M_L = [V⁰(u^{i+k} r_L)]`, `M_H = [V⁰(u^{i+k} r_H)]`, `M₀ = [V⁰(u^{i+k} r_0)]` with
`V⁰(u^e) = e B_{e-1}`, `V⁰((u+m)^{-1}) = 2 H_m^{(3)}` and
`r_L = u³/((u+1)(u+2)(u+3)(u+4))`, `r_H = u³/((u+1)(u+2)(u+3))`, `r_0 = u/((u+1)(u+2)(u+3)(u+4))`
(exact rationals of code/local_blocks_453.py and the FIX table of code/prime_edge_crt453.py).
The Hankel entries depend only on `i+k`; the moment sequences are recorded separately. -/

/-- `V⁰(u^e r_L)`, `e = 0, …, 4`. -/
def lowMoment : Fin 5 → ℚ := ![1565/648, -15575/648, 101261/648, -545255/648, 2649929/648]
/-- `V⁰(u^e r_H)`, `e = 0, …, 2`. -/
def highMoment : Fin 3 → ℚ := ![-115/8, 481/8, -1731/8]
/-- `V⁰(u^e r_0)`, `e = 0, …, 6`. -/
def zeroMoment : Fin 7 → ℚ :=
  ![1/1296, 7/648, 1565/648, -15575/648, 101261/648, -545255/648, 2649929/648]

def M_L : Matrix (Fin 3) (Fin 3) ℚ := fun i k => lowMoment ⟨i.val + k.val, by omega⟩
def M_H : Matrix (Fin 2) (Fin 2) ℚ := fun i k => highMoment ⟨i.val + k.val, by omega⟩
def M₀ : Matrix (Fin 4) (Fin 4) ℚ := fun i k => zeroMoment ⟨i.val + k.val, by omega⟩

theorem M_L_eq : M_L = !![1565/648, -15575/648, 101261/648;
    -15575/648, 101261/648, -545255/648; 101261/648, -545255/648, 2649929/648] := by
  ext i k; fin_cases i <;> fin_cases k <;> rfl

theorem M_H_eq : M_H = !![-115/8, 481/8; 481/8, -1731/8] := by
  ext i k; fin_cases i <;> fin_cases k <;> rfl

theorem M₀_eq : M₀ = !![1/1296, 7/648, 1565/648, -15575/648;
    7/648, 1565/648, -15575/648, 101261/648;
    1565/648, -15575/648, 101261/648, -545255/648;
    -15575/648, 101261/648, -545255/648, 2649929/648] := by
  ext i k; fin_cases i <;> fin_cases k <;> rfl

theorem det_M_L : Matrix.det M_L = -31336873/1296 := by
  rw [M_L_eq, Matrix.det_fin_three]
  simp
  norm_num

theorem det_M_H : Matrix.det M_H = -4037/8 := by
  rw [M_H_eq, Matrix.det_fin_two_of]
  norm_num

theorem det_M₀ : Matrix.det M₀ = -12931/324 := by
  rw [M₀_eq, Matrix.det_succ_row_zero]
  simp [Fin.sum_univ_succ, Matrix.det_fin_three, Fin.succAbove]
  norm_num

end Zeta32.PrimeEdge
end

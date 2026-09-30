module
public import Zeta32.Family
public import Zeta32.Arith.Local.Binom

@[expose] public section

/-! the informal proof, §1, Lemma 1 and Corollary 2.

Route change: the Tate-algebra distribution formula is not
formalized. The local bounds it served (the informal proof, Lemma 3, Lemma 4) are proved directly by
class-wise partial fractions: `Zeta32.Arith.Local.VG_polynomialMoment` (Local/Binom.lean,
the polynomial part of `U_r`), `Zeta32.Arith.Local.VG_res`, `VG_polyPart_eval`
(Local/PoleFun.lean) and `Zeta32.Arith.Local.Lfun_GV` (Local/Entry.lean). The two draft
statements `distribution_formula` and `U_distribution_formula` (vacuous existentials,
proved by `sorry`) were removed; nothing referenced them. -/

end

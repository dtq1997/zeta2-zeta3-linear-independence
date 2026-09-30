module
public import Zeta32.Arith.Sum.PNT.DecayPNTConsequences
-- adapted from dtq1997/li2-half-irrationality@d5d8206:Li2Unified/Modular/Base/DecayPNTInterface.lean (namespace Li2 -> Zeta32.ArithSum, imports renamed; no other change)

set_option backward.privateInPublic true

@[expose] public section

/-! the prime number theorem in Chebyshev form, stated with the fully
qualified Mathlib function (no local notation), so the ported proof cannot have replaced θ. -/
theorem Zeta32.ArithSum.PNT.theta_isEquivalent_id : Asymptotics.IsEquivalent Filter.atTop Chebyshev.theta id :=
  Zeta32.ArithSum.PNT.chebyshev_asymptotic

#print axioms Zeta32.ArithSum.PNT.theta_isEquivalent_id

end

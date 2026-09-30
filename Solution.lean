module
public import Zeta32

@[expose] public section

public theorem one_zeta_two_zeta_three_linearIndependent :
    LinearIndependent ℚ ![(1 : ℂ), riemannZeta 2, riemannZeta 3] :=
  Zeta32.one_zeta_two_zeta_three_linearIndependent

end

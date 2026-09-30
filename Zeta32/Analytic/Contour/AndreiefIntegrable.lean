-- adapted from dtq1997/li2-half-irrationality@d5d8206:Li2Unified/Modular/Base/AndreiefIntegrable.lean
-- (namespace changed from `Li2.Andreief` to `Zeta32.Analytic.Contour.Andreief`; otherwise verbatim)
module
public import Mathlib.MeasureTheory.Integral.Pi
public import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
public import Mathlib.Tactic.Ring

set_option backward.privateInPublic true

@[expose] public section

/-! Pairwise moments imply integrability of the full determinant product.
The measurable source is arbitrary so the same theorem serves all four instances. -/
open MeasureTheory Finset Equiv

namespace Zeta32.Analytic.Contour.Andreief

variable {α : Type*} [MeasurableSpace α]
variable {n : ℕ} {μ : Measure α} [SigmaFinite μ]
variable {𝕜 : Type*} [RCLike 𝕜]

end Zeta32.Analytic.Contour.Andreief

end

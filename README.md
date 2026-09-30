# zeta2-zeta3-linear-independence

English | [中文](README.zh-CN.md)

This project gives a Lean 4 proof that the following three numbers

$$1,\qquad \zeta(2)=\sum_{n\ge 1}\frac{1}{n^2},\qquad \zeta(3)=\sum_{n\ge 1}\frac{1}{n^3}$$

are linearly independent over $`\mathbb{Q}`$.

On 17 September 2026, Aabir Fauzan gave a proof that $`\zeta(5)`$ is irrational [1]. The proof was soon formalized in Lean [2, 3, 4], and the blog Persiflage [5] pointed out that, by changing Fauzan's choice of parameters, the same method handles $`\zeta(k)`$ for $`k=2,3,4,5`$. On 28 September 2026, I used Fauzan's method to prove that $`\mathrm{Li}_2(1/2)`$ is irrational [6], and Si-Qi Liu (GitHub: siqiliu-tsinghua) extended the method to $`\mathrm{Li}_2(r)`$ at many rational points $`r`$ [7]. This project makes some improvements in the details, which allow the method to be applied further to the numbers $`\zeta(3)-r\,\zeta(2)`$ with $`r`$ rational.

## Main result

$`1`$, $`\zeta(2)`$ and $`\zeta(3)`$ are linearly independent over $`\mathbb{Q}`$: if $`a,b,c\in\mathbb{Q}`$ and $`a+b\,\zeta(2)+c\,\zeta(3)=0`$, then $`a=b=c=0`$.

Equivalently, $`\zeta(2)`$ is irrational, and $`\zeta(3)-r\,\zeta(2)`$ is irrational for every rational number $`r`$.

For $`r=0`$ this is Apéry's theorem [8], which has been formalized in Lean [9]. The irrationality of $`\zeta(2)=\pi^2/6`$ is classical. Gutnik [10] proved that for every rational $`q`$ at least one of $`-3\zeta(3)+q\,\zeta(2)`$ and $`\zeta(2)-2q\log 2`$ is irrational. Calegari, Dimitrov and Tang [11] proved that $`1,\zeta(2),L(2,\chi_{-3})`$ are linearly independent over $`\mathbb{Q}`$. Dauguet and Zudilin [12] constructed simultaneous rational approximations to $`\zeta(2)`$ and $`\zeta(3)`$ and bounded from below certain linear forms in $`1,\zeta(2),\zeta(3)`$ with rational coefficients. We are not aware of an earlier proof of this statement: a search on 29 September 2026 (arXiv, zbMATH Open and general web search) found none, and its novelty beyond that search is unknown.

## Formalization and verification

- The result is the theorem `one_zeta_two_zeta_three_linearIndependent` in [`Solution.lean`](Solution.lean). Its statement, in [`Challenge.lean`](Challenge.lean), is

  ```lean
  theorem one_zeta_two_zeta_three_linearIndependent :
      LinearIndependent ℚ ![(1 : ℂ), riemannZeta 2, riemannZeta 3]
  ```

  The statement uses only Mathlib definitions (`riemannZeta` and `LinearIndependent`) and none of this project's own. The Mathlib definitions that fix its meaning are quoted in [`docs/mathlib-definitions.md`](docs/mathlib-definitions.md).

  A second theorem, `one_zeta_two_zeta_three_linearIndependent_series`, states the same result with the two series written out, so that reading it needs no definition beyond real infinite sums:

  ```lean
  theorem one_zeta_two_zeta_three_linearIndependent_series (a b c : ℚ)
      (h : (a : ℝ) + b * (∑' k : ℕ, 1 / ((k : ℝ) + 1) ^ 2)
        + c * (∑' k : ℕ, 1 / ((k : ℝ) + 1) ^ 3) = 0) :
      a = 0 ∧ b = 0 ∧ c = 0
  ```
- Both theorems depend only on Lean's three standard axioms `propext`, `Classical.choice` and `Quot.sound`.
- The proof was also checked independently with [comparator](https://github.com/leanprover/comparator): it compares the statements against the challenge file [`Challenge.lean`](Challenge.lean), and the whole proof is rechecked by two kernels, the Lean kernel and [nanoda](https://github.com/ammkrn/nanoda_lib). See below for how to reproduce this check.
- Toolchain: Lean `v4.35.0-rc3`, Mathlib `c55e6e78`. To build:

  ```sh
  lake exe cache get
  lake build
  ```

  A full build takes about 2 minutes on a laptop with 10 cores and 16 GB of memory.

### Reproducing the independent check with comparator

The comparator configuration is [`comparator.json`](comparator.json): challenge module `Challenge`, solution module `Solution`, theorems to check `one_zeta_two_zeta_three_linearIndependent` and `one_zeta_two_zeta_three_linearIndependent_series`, only the three standard axioms permitted, and nanoda enabled.

See [comparator's README](https://github.com/leanprover/comparator) for how to build comparator, lean4export, nanoda and landrun, and for the assumptions behind the check. landrun relies on the Linux Landlock sandbox, so the check runs only on Linux.

After the build above, run:

```sh
COMPARATOR_LANDRUN=/path/to/landrun \
COMPARATOR_LEAN4EXPORT=/path/to/lean4export \
COMPARATOR_NANODA=/path/to/nanoda_bin \
lake env /path/to/comparator comparator.json
```

On success the output contains the two lines `Nanoda kernel accepts the solution` and `Lean default kernel accepts the solution`, and its last line is `Your solution is okay!`.

Our own check used the verification scripts of the Palomar pipeline (PalomarRegistry/PalomarSubmission at `65f0154`), run on the laptop above without the Linux sandbox. These scripts run comparator and add a third kernel, con-ron. One check took about 6 to 7 minutes, with a peak memory use of about 3.4 GiB.

## Acknowledgements

I thank Si-Qi Liu (GitHub: siqiliu-tsinghua) for related discussions and for sharing code with me.

This project was completed with the assistance of Anthropic's Claude Opus 5.5 and OpenAI's GPT-6-Astra.

## License

This project is licensed under the Apache License 2.0; see [LICENSE](LICENSE). Code adapted from other projects and its sources are listed in [NOTICE](NOTICE), and each affected source file names its source in a comment.

## References

1. A. Fauzan, *ζ(5) is irrational*, preprint, Zenodo, 2026.
   [doi:10.5281/zenodo.22826419](https://doi.org/10.5281/zenodo.22826419)
2. M. Firsching, *mo271/Zeta5*: a Lean formalization of Fauzan's proof. <https://github.com/mo271/Zeta5>
3. C. Del Solar, *domino14/zeta5*: a Lean formalization of Fauzan's proof. <https://github.com/domino14/zeta5>
4. D. Romik, *danromik/zeta5-irrationality*: a Lean formalization of Fauzan's proof.
   <https://github.com/danromik/zeta5-irrationality>
5. Persiflage, *zeta(5) is irrational*, 2026-09-24.
   <https://galoisrepresentations.org/2026/09/24/zeta5-is-irrational/>
6. Qian Tang, *dtq1997/li2-half-irrationality*: a Lean proof of the irrationality of $`\mathrm{Li}_2(1/2)`$.
   <https://github.com/dtq1997/li2-half-irrationality>
7. Si-Qi Liu, *siqiliu-tsinghua/Li2Rational*: Lean 4 proofs of the irrationality of $`\mathrm{Li}_2(r)`$ at certain
   rational points $`r`$. <https://github.com/siqiliu-tsinghua/Li2Rational>
8. R. Apéry, *Irrationalité de ζ(2) et ζ(3)*, Astérisque 61 (1979), 11–13.
9. J. Liu, J. Zhang, L. Zhi, *A formal proof of the irrationality of ζ(3) in Lean 4*.
   [arXiv:2503.07625](https://arxiv.org/abs/2503.07625)
10. L. A. Gutnik, *On the irrationality of certain quantities containing ζ(3)*, Acta Arith. 42 (1983), 255–264.
    [doi:10.4064/aa-42-3-255-264](https://doi.org/10.4064/aa-42-3-255-264)
11. F. Calegari, V. Dimitrov, Y. Tang, *The linear independence of 1, ζ(2), and L(2,χ₋₃)*.
    [arXiv:2408.15403](https://arxiv.org/abs/2408.15403)
12. S. Dauguet, W. Zudilin, *On simultaneous diophantine approximations to ζ(2) and ζ(3)*, J. Number Theory 145 (2014), 362–387.
    [arXiv:1401.5322](https://arxiv.org/abs/1401.5322)

# zeta2-zeta3-linear-independence

[English](README.md) | 中文

本项目用 Lean 4 证明：三个数

$$1,\qquad \zeta(2)=\sum_{n\ge 1}\frac{1}{n^2},\qquad \zeta(3)=\sum_{n\ge 1}\frac{1}{n^3}$$

在 $`\mathbb{Q}`$ 上线性无关。

2026 年 9 月 17 日，Aabir Fauzan 给出了 $`\zeta(5)`$ 的无理性证明 [1]。这一证明很快有了 Lean 形式化 [2, 3, 4]；博客 Persiflage [5] 还指出，调整 Fauzan 的参数取法，可以用同一方法统一处理 $`\zeta(k)`$，$`k=2,3,4,5`$。2026 年 9 月 28 日，我用 Fauzan 的方法给出了 $`\mathrm{Li}_2(1/2)`$ 的无理性证明 [6]，刘思齐（GitHub：siqiliu-tsinghua）又把这一方法推广到 $`\mathrm{Li}_2(r)`$ 在许多有理点 $`r`$ 处的值 [7]。本项目把这一方法用于 $`\zeta(3)-r\,\zeta(2)`$，其中 $`r`$ 为有理数。

## 主要结果

$`1`$、$`\zeta(2)`$、$`\zeta(3)`$ 在 $`\mathbb{Q}`$ 上线性无关：若 $`a,b,c\in\mathbb{Q}`$ 满足 $`a+b\,\zeta(2)+c\,\zeta(3)=0`$，则 $`a=b=c=0`$。

等价地说：$`\zeta(2)`$ 是无理数，并且对每个有理数 $`r`$，$`\zeta(3)-r\,\zeta(2)`$ 都是无理数。

$`r=0`$ 时这就是 Apéry 定理 [8]，它已有 Lean 形式化 [9]；$`\zeta(2)=\pi^2/6`$ 的无理性是经典结果。据我们所知，$`1,\zeta(2),\zeta(3)`$ 在 $`\mathbb{Q}`$ 上的线性无关此前是公开问题，它可以由 $`\pi,\zeta(3),\zeta(5),\dots`$ 代数无关这一猜想推出。Gutnik [10] 证明了：对每个有理数 $`q`$，$`-3\zeta(3)+q\,\zeta(2)`$ 与 $`\zeta(2)-2q\log 2`$ 中至少有一个是无理数。Calegari、Dimitrov、Tang [11] 证明了 $`1,\zeta(2),L(2,\chi_{-3})`$ 在 $`\mathbb{Q}`$ 上线性无关。2026 年 9 月 29 日的文献检索（arXiv、zbMATH Open 与一般网络搜索）没有找到此前对有理数 $`r\ne 0`$ 证明 $`\zeta(3)-r\,\zeta(2)`$ 无理的工作。检索范围之外的新颖性未经确认。

## 形式化与验证

- 上述结论即 [`Solution.lean`](Solution.lean) 中的定理 `one_zeta_two_zeta_three_linearIndependent`。它的陈述写在 [`Challenge.lean`](Challenge.lean) 里：

  ```lean
  theorem one_zeta_two_zeta_three_linearIndependent :
      LinearIndependent ℚ ![(1 : ℂ), riemannZeta 2, riemannZeta 3]
  ```

  陈述只用到 Mathlib 的定义（`riemannZeta` 与 `LinearIndependent`），不含本项目自己的任何定义。
- 该定理只依赖 Lean 的三条标准公理 `propext`、`Classical.choice`、`Quot.sound`。
- 另用 [comparator](https://github.com/leanprover/comparator) 做了独立验收：以 [`Challenge.lean`](Challenge.lean) 为题面核对陈述，并用 Lean 内核与 [nanoda](https://github.com/ammkrn/nanoda_lib) 两个内核分别重新检查全部证明。复现方法见下文。
- 工具链：Lean `v4.35.0-rc3`，Mathlib `c55e6e78`。构建方法：

  ```sh
  lake exe cache get
  lake build
  ```

  在 10 核、16 GB 内存的笔记本电脑上，全量构建约需 2 分钟。

### 用 comparator 复现独立验收

comparator 的配置是 [`comparator.json`](comparator.json)：题面模块 `Challenge`，解答模块 `Solution`，要核对的定理 `one_zeta_two_zeta_three_linearIndependent`，只允许三条标准公理，并启用 nanoda。

各工具（comparator、lean4export、nanoda、landrun）的构建方法与安全前提见 [comparator 的 README](https://github.com/leanprover/comparator)。landrun 依赖 Linux 的 Landlock 沙箱，因此只能在 Linux 上运行。

先完成上面的构建，然后运行：

```sh
COMPARATOR_LANDRUN=/path/to/landrun \
COMPARATOR_LEAN4EXPORT=/path/to/lean4export \
COMPARATOR_NANODA=/path/to/nanoda_bin \
lake env /path/to/comparator comparator.json
```

通过时，输出中会分别有 `Nanoda kernel accepts the solution` 和 `Lean default kernel accepts the solution` 两行，最后一行是 `Your solution is okay!`。

我们自己的检查用的是 Palomar 流水线（PalomarRegistry/PalomarSubmission，提交 `65f0154`）的验证脚本，在上述笔记本电脑上运行，没有使用 Linux 沙箱。这些脚本调用 comparator，并加上第三个内核 con-ron。一次检查用时 134 秒，内存峰值约 4.3 GiB。

## 致谢

感谢刘思齐老师（GitHub：siqiliu-tsinghua）的有益讨论。

本项目在 Anthropic 的 Claude Opus 5.5 和 OpenAI 的 GPT-6-Astra 协助下完成。

## 许可

本项目采用 Apache License 2.0，见 [LICENSE](LICENSE)。项目中改编自其他项目的代码及其来源见 [NOTICE](NOTICE)，并在对应源文件的文件头中逐一注明。

## 参考文献

1. A. Fauzan, *ζ(5) is irrational*, preprint, Zenodo, 2026.
   [doi:10.5281/zenodo.22826419](https://doi.org/10.5281/zenodo.22826419)
2. M. Firsching, *mo271/Zeta5*：Fauzan 证明的 Lean 形式化。<https://github.com/mo271/Zeta5>
3. C. Del Solar, *domino14/zeta5*：Fauzan 证明的 Lean 形式化。<https://github.com/domino14/zeta5>
4. D. Romik, *danromik/zeta5-irrationality*：Fauzan 证明的 Lean 形式化。
   <https://github.com/danromik/zeta5-irrationality>
5. Persiflage, *zeta(5) is irrational*, 2026-09-24.
   <https://galoisrepresentations.org/2026/09/24/zeta5-is-irrational/>
6. 唐乾, *dtq1997/li2-half-irrationality*：$`\mathrm{Li}_2(1/2)`$ 无理性的 Lean 证明。
   <https://github.com/dtq1997/li2-half-irrationality>
7. 刘思齐, *siqiliu-tsinghua/Li2Rational*：$`\mathrm{Li}_2(r)`$ 在某些有理点处无理性的 Lean 4 证明。
   <https://github.com/siqiliu-tsinghua/Li2Rational>
8. R. Apéry, *Irrationalité de ζ(2) et ζ(3)*, Astérisque 61 (1979), 11–13.
9. J. Liu, J. Zhang, L. Zhi, *A formal proof of the irrationality of ζ(3) in Lean 4*.
   [arXiv:2503.07625](https://arxiv.org/abs/2503.07625)
10. L. A. Gutnik, *On the irrationality of certain quantities containing ζ(3)*, Acta Arith. 42 (1983), 255–264.
    [doi:10.4064/aa-42-3-255-264](https://doi.org/10.4064/aa-42-3-255-264)
11. F. Calegari, V. Dimitrov, Y. Tang, *The linear independence of 1, ζ(2), and L(2,χ₋₃)*.
    [arXiv:2408.15403](https://arxiv.org/abs/2408.15403)

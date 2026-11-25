# Fiscal Multipliers with Hand-to-Mouth Households

This project studies how the response to a government-spending shock changes
with the share of hand-to-mouth households. Ricardian households save and
invest, while hand-to-mouth households consume their after-tax labor income
each period.

## Requirements

- GNU Octave **11.3.0** (`aarch64-apple-darwin25.4.0`)
- Dynare **7.1**, installed and available to Octave

## Files

- `main.mod` — Dynare model, calibration, steady-state setup, and simulations
  for five hand-to-mouth household shares.
- `get_ss.m` — steady-state helper called by the model; uses `fsolve`.
- `plot_results.m` — plots the impulse responses across the five scenarios.

These files should remain together in the repository root.

## Running the model

In Octave, change to the repository root and run:

```octave
dynare main.mod
```

The model computes each scenario's steady state and first-order,
40-period impulse responses to a 1% government-spending shock. It checks
steady-state residuals and model diagnostics for the benchmark and checks
Blanchard-Kahn conditions for each scenario.

The five hand-to-mouth shares (`mu`) are 0, 0.192, 0.238, 0.340, and 0.99.
The model labels them as the benchmark, Australia, Italy, United States, and
an extreme theoretical test, respectively. These labels are scenario labels
in the model, not claims that the values are current empirical estimates.

## Outputs

- `results_all_mu.mat` — saved scenario impulse responses, steady states, and
  Dynare model structure.
- `figures/irfs_all_mu.png` — comparison chart for output (`Y`), consumption
  (`C`), labor (`L`), and investment (`I`) across all five scenarios, with
  responses expressed as a percentage of each scenario's steady state.
- Dynare also displays individual impulse-response plots and writes its
  standard generated files under the model-named output directory.

## Model outline

- **Firms:** Produce output with a Cobb-Douglas production function and hire
  labor and rent capital at competitive factor prices. Productivity `A_bar`
  is fixed.
- **Ricardian households:** Choose consumption, labor, and investment, and
  accumulate capital subject to their budget constraint and Euler equation.
- **Hand-to-mouth households:** Choose labor and consume wage income net of
  lump-sum taxes each period; they do not save.
- **Government:** Finances spending with lump-sum taxes (`T = G`). Spending
  follows a log AR(1) process with persistence `rho_g`.
- **Aggregation:** `mu` is the hand-to-mouth share. Aggregate consumption and
  labor are weighted averages across household types.

The calibration targets steady-state labor of one third and government
spending equal to 20% of steady-state output. Baseline parameters include
`beta = 0.96`, `alpha = 0.36`, `delta = 0.08`, `eta = 1`, `gy = 0.20`,
`rho_g = 0.90`, and `A_bar = 1`.

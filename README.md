# Fiscal Multipliers with Hand-to-Mouth Households

This project studies how the response to a government-spending shock changes
with the share of hand-to-mouth households. The model distinguishes Ricardian
households, who save and invest, from hand-to-mouth households, who consume
their after-tax labor income each period.

## Files

- `Main.mod` — Dynare model, calibration, steady-state
  setup, and impulse-response simulation.
- `get_ss.m` — required steady-state helper called by the model. This file is
  not currently included in this folder.
- 'plot_results.m' - loads the results from all 5 different mu tests and plots it

## Running the model

The model is intended for Dynare **7.1** and GNU Octave **11.3.0**
(`aarch64-apple-darwin25.4.0`). Dynare must be installed and available to
Octave.

From the Octave prompt, change to this folder and run the checked-in `.mod`
file:

```octave
cd('/path/to/computational macro/Presentation')
dynare main.mod
```


## Outputs

file computes the steady state and runs first-order stochastic simulation
with 40-period impulse responses to `eps_g`. It requests responses for output
(`Y`), aggregate and household consumption (`C`, `CR`, `CH`), aggregate and
household labor (`L`, `LR`, `LH`), investment (`I`), capital next period (`K`), wages
(`W`), and government spending (`G`).

Dynare displays the impulse-response plots and, by default, saves them in the
`graphs/` subfolder of the working directory.

## Model outline and calibration

- **Firms:** Produce output with a Cobb-Douglas production function and hire
  labor and rent capital at competitive factor prices. Productivity `A_bar`
  is fixed.
- **Ricardian households:** Choose consumption, labor, and investment, and
  accumulate capital subject to their budget constraint and Euler equation.
- **Hand-to-mouth households:** Choose labor and consume wage income net of
  lump-sum taxes each period; they do not save.
- **Government:** Finances spending with lump-sum taxes (`T = G`). Spending
  follows a log AR(1) process with persistence `rho_g` and shock `eps_g`.
- **Aggregation:** `mu` is the hand-to-mouth share. Aggregate consumption and
  labor are weighted averages across household types.

The calibration targets steady-state labor of one third and government
spending equal to 20% of steady-state output. The baseline sets `mu = 0`, so
there are no hand-to-mouth households; change `mu` to study other shares.

| Parameter | Baseline | Meaning |
|---|---:|---|
| `beta` | 0.96 | Household discount factor |
| `alpha` | 0.36 | Capital share in production |
| `delta` | 0.08 | Capital depreciation rate |
| `eta` | 1 | Curvature of labor disutility |
| `gy` | 0.20 | Steady-state government spending share of output |
| `rho_g` | 0.90 | Persistence of government spending |
| `A_bar` | 1 | Total factor productivity |
| `mu` | 0 | Hand-to-mouth household share |

`chi` is calibrated in the model to match the steady-state labor target.

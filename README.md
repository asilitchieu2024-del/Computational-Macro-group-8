# Computational Macroeconomic Presentation Refrence 

This folder contains a Dynare model where the program shows how fiscal multipliers changes with the share of hand-to-mouth households. The model has two household types: Ricardian households, which save and invest, and hand-to-mouth households, which consume their after-tax labor income each period.

## Files

- `Main.mod` — Dynare model set-up 
- `plot_results.m` - loads results saved by main.mod and plots Y, C, L, and I after 1% government spending shock for all 5 values of `mu`
- `get_ss.m` - program that computes steady state called by mod file

## Requirements

- access to group 8 zip file 
- MATLAB or GNU Octave version 11.3.0 with dynare
- Dynare 7.1, installed and available on MATLAB/Octave

## Running the model
1. extract folder from zip file; GROUP_8.zip
2. Open Octave/MATLAB
3. change current folder to the extracted folder
4. run `dynare main.mod` in terminal
5. Dynare computes the steady state, checks the model, opens graphs, and runs a first-order
stochastic simulation with 40-period responses. The reported
variables are output (`Y`), aggregate and household consumption (`C`, `CR`,
`CH`), aggregate and household labor (`L`, `LR`, `LH`), investment (`I`),
capital next period (`K`), wages (`W`), and government spending (`G`). 

## Model outline

- **Firms:** maximizes profit by choosing capital it rents from households and hiring labor, subject to a Cobb-Douglas production function. For simplicity, productivity is fixed at `A_bar` and treated as exogenous because the experiment will involve only a government spending shock.
- **Ricardian households:** maximises its expected discounted utility of consumption minus the disutility of working hours subject to its intertemporal budget constraint and capital accumulation. It chooses consumption `CR`, labor hours `LR` and capital next period `K` and can save by investing into capital intertemporally.
- **Hand-to-mouth households:** faces a static problem, as it maximizes its utility of consumption minus the disutility of labor each period. It cannot save or borrow, meaning that there is no intertemporality
- **Government:** Finances spending with lump-sum taxes (`T = G`). Spending
  follows a log process with persistence `rho_g` and changes with stochastic shocks
  `eps_g`.
- **Aggregation:** `mu` is the hand-to-mouth share. Aggregate consumption and
  labor are weighted averages of the two household types.

The calibration targets steady-state labor of one third and government
spending equal to 20% of steady-state output. The current baseline sets
`mu = 0`, so the economy starts with no hand-to-mouth households. To study
different household shares, `mu` changes to compare the resulting impulse
responses.

| Parameter | Baseline | Meaning |
|---|---:|---|
| `beta` | 0.96 | Household discount factor |
| `alpha` | 0.36 | Capital share in production |
| `delta` | 0.08 | Capital depreciation rate |
| `eta` | 1 | Inverse Frisch elasticity / curvature of labor disutility |
| `gy` | 0.20 | Steady-state government spending share of output |
| `rho_g` | 0.90 | Persistence of government spending |
| `A_bar` | 1 | Total factor productivity |
| `mu` | 0 | Hand-to-mouth household share |

`chi` is calibrated in the model to match the steady-state labor target.

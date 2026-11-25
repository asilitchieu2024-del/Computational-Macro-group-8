//Variable Declarations
var 
    CR //Consumption of Ricardian Household
    LR //Labor supply of Ricardian Household
    K //Capital
    I //Investment
    CH //Consumption of Hand to Mouth Household
    LH //Labor supply of Hand to Mouth Household
    Y //Firm Output
    W //Wage
    RK //Rental rate of capital
    C // Aggregate Consumption
    L // Aggregate Labor
    T // Lump sum tax
    G // Government spending
    lambdaR //Lagrange multiplier for Ricardian Household
    lambdaH //Lagrange multiplier for Hand to Mouth Household
;

//Exogenous Shocks
varexo
    eps_g //Government spending shock
;

//Parameters
parameters
    beta //Discount factor
    alpha //Capital share in production
    delta //depreciation rate of capital
    eta //curvature of labour disutility
    chi //weight of labor disutility
    A_bar //TFP
    gy //share of government spending in output
    G_bar // gov spending level, G_bar = gy * Y_bar
    rho_g //persistence of government spending shock
    mu // share of Hand to Mouth households in the economy
    sigma_g // std dev of government spending shock
;

//Calibration of parameters from class slides to keep a simple economy
beta = 0.96; 
alpha = 0.36; 
delta = 0.08; 
eta = 1; 
gy = 0.2; 
rho_g = 0.9; 
A_bar = 1; 
mu = 0; // share of hand to mouth households in the economy, mu = 0 means no hand to mouth households, start at 0 to test
sigma_g = 0.01; // std dev of government spending shock - 1% positive shock


// Calibration targets: L = 1/3, G = 0.2 of steady output
kap = (alpha/(1/beta-1+delta))^(1/(1-alpha));   // kap = K/L in steady state (helper for solving by hand)
Y_bar = A_bar*kap^alpha*(1/3);                   // output when L = 1/3 (helper)
G_bar = gy*Y_bar;                                  // declared parameter
chi   = (1-alpha)*A_bar*kap^alpha/((Y_bar-delta*kap*(1/3)-G_bar)*(1/3)^eta); // solved by hand if mu=0 chi=10.2267


// Model Equations
model;
// Ricardian Household
// FOC w.r.t CR
1/CR = lambdaR;

// FOC w.r.t LR
chi*LR^eta = lambdaR*W;

// FOC w.r.t K_{+1}
lambdaR = beta*lambdaR(+1)*(RK(+1) + 1 - delta);

//Ricardian Household Budget Constraint
CR + (I/(1-mu)) = W*LR + (RK*K(-1)/(1-mu)) - T;

// Hand to Mouth Household
// FOC w.r.t CH
1/CH = lambdaH;
// FOC w.r.t LH
chi*LH^eta = lambdaH*W;
// Budget constraint of Hand to Mouth Household
CH = W*LH-T;

// Firm
// FOC w.r.t L
W = (1-alpha)*A_bar*K(-1)^alpha*L^(-alpha);
// FOC w.r.t K
RK = alpha*A_bar*K(-1)^(alpha-1)*L^(1-alpha);

// Output
Y = A_bar*K(-1)^alpha*L^(1-alpha);

// Government
T = G;

// Spending shock 
log(G/G_bar) = rho_g*log(G(-1)/G_bar) + eps_g;

// Aggregation
C = (1-mu)*CR + mu*CH;
L = (1-mu)*LR + mu*LH;
K = (1-delta)*K(-1) + I;

end;

// Compute the steady state
steady_state_model;
[CR,LR,K,I,CH,LH,Y,W,RK,C,L,T,G,lambdaR,lambdaH] = get_ss(beta,alpha,delta,eta,chi,A_bar,G_bar,rho_g,mu);
end;

//AI USE: used ai to make the loop for the different mu values for the 5 different scenarios and label. 
// Set the government spending shock variance once 
shocks;
    var eps_g; stderr sigma_g;
end;

// Set the benchmark share
mu = 0;

// Solve the benchmark steady state
steady;

// Check benchmark equation residuals
resid;

// Check benchmark Blanchard-Kahn conditions
check;

// Check the benchmark model diagnostics
model_diagnostics;

// Initialize storage for the five scenarios
verbatim;
results = repmat(struct('mu', [], 'label', '', 'irfs', struct(), 'steady_state', []), 1, 5);
end;

// Store the benchmark share and label
verbatim;
results(1).mu = mu;
results(1).label = 'Benchmark (standard RBC)';
results(1).steady_state = oo_.steady_state;
end;

// Compute and display benchmark impulse responses
stoch_simul(order=1, irf=40) Y C CR CH L LR LH I K W G;

// Store benchmark impulse responses
verbatim;
results(1).irfs = oo_.irfs;
end;

// Define the other scenario shares as text for the Dynare macro processor
@#define MU_TEXT = ["0", "0.192", "0.238", "0.340", "0.99"]

// Define the scenario labels
@#define LABELS = ["Benchmark (standard RBC)", "Australia", "Italy", "United States", "Extreme theoretical test"]

// Run the four non-benchmark scenarios
@#for i in 2:5
    // Set this scenario's share
    mu = @{MU_TEXT[i]};

    // Solve this scenario's steady state
    steady;

    // Check this scenario's Blanchard-Kahn conditions
    check;

    // Store this scenario's results and steady state
    verbatim;
    results(@{i}).mu = mu;
    results(@{i}).label = '@{LABELS[i]}';
    results(@{i}).steady_state = oo_.steady_state;
    end;

    // Compute and display this scenario's impulse responses
    stoch_simul(order=1, irf=40) Y C CR CH L LR LH I K W G;

    // Store this scenario's impulse responses
    verbatim;
    results(@{i}).irfs = oo_.irfs;
    end;
@#endfor

// Save all scenarios and the Dynare model structure
verbatim;
save('results_all_mu.mat','results','M_','-v7');
plot_results;
end;
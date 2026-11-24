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
    lambda //Lagrange multiplier
    q //multiplier on capital accumulation NEED TO CHECK
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
    eta //ellasticity of marginal disutility of work
    chi //weight of labor disutility
    A_bar //TFP
    gy //share of government spending in output
    G_bar // gov spending level, G_bar = gy * Y_bar
    rho_g //persistence of government spending shock
    mu // share of Hand to Mouth households in the economy
;

//Calibration of parameters NEED TO CHECK THE VALUES
beta = 0.96; // why
alpha = 0.36; // why
delta = 0.08; // why
eta = 1; // why
gy = 0.2; // why
rho_g = 0.9; // 
A_bar = 1; // 
mu = 0.5; // NEED TO CHECK: share of Hand to Mouth households in the economy
// ALSO CHECK chi calibrated so L = 1/3 at mu = 0 (should equal 10.225681)
chi   = (1-alpha)*Abar*kappa^alpha / ((Ybar - delta*kappa*(1/3) - Gbar)*(1/3)^(1+eta));

// Model Equations
model;
// Ricardian Household
// FOC w.r.t CR
1/CR = lambda;

// FOC w.r.t LR
chi*LR^eta = lambda*W;

// FOC w.r.t I
q=lambda;

// FOC w.r.t K(+1)
q=beta*(lambda(+1)*RK(+1)+(1-delta)*q(+1));

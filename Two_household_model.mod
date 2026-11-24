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
    G_bar //
    rho_g
    gy
function [CR,LR,K,I,CH,LH,Y,W,RK,C,L,T,G,lambdaR,lambdaH] = get_ss(beta,alpha,delta,eta,chi,A_bar,G_bar,rho_g,mu)
% GET_SS  Numerical steady state for Two_household_model.mod (MATLAB and GNU Octave).
% The output order matches the existing call in Two_household_model.mod exactly.

% Parameter sanity check
if ~(0<beta && beta<1 && 0<alpha && alpha<1 && 0<delta && delta<1 && chi>0 && eta>0 && A_bar>0 && G_bar>0 && rho_g<1 && 0<=mu && mu<1)
    error('get_ss:badParameters','Parameters must satisfy the steady-state restrictions.');
end

% Starting values from the closed-form steady state at mu=0
RK0=1/beta-1+delta;
kappa0=(alpha*A_bar/RK0)^(1/(1-alpha));
L0=1/3;
LR0=1/3;
LH0=1/3;
K0=kappa0*L0;
Y0=A_bar*K0^alpha*L0^(1-alpha);
I0=delta*K0;
G0=G_bar;
T0=G0;
W0=(1-alpha)*Y0/L0;
CR0=Y0-I0-G0;
C0=CR0;
CH0=W0*LH0-T0;
lambdaR0=1/CR0;
lambdaH0=1/CH0;
if CR0<=0 || CH0<=0
    error('get_ss:badGuess','The closed-form starting values imply non-positive consumption.');
end

% Starting vector in output order
x0=[CR0;LR0;K0;I0;CH0;LH0;Y0;W0;RK0;C0;L0;T0;G0;lambdaR0;lambdaH0];

% Solve the steady-state equations
options=optimset('Display','off','TolFun',1e-12,'TolX',1e-12,'MaxIter',500,'MaxFunEvals',5000);
[x,residuals,exitflag]=fsolve(@(x) ss_equations(x,beta,alpha,delta,eta,chi,A_bar,G_bar,rho_g,mu),x0,options);

% Admissibility check
if exitflag<=0 || any(~isfinite(x)) || any(~isfinite(residuals)) || max(abs(residuals))>1e-8 || any(x<=0) || x(2)>=1 || x(6)>=1
    error('get_ss:noConvergence','fsolve failed: exitflag=%d, max residual=%g.',exitflag,max(abs(residuals)));
end

% Unpack the steady state
CR=x(1);
LR=x(2);
K=x(3);
I=x(4);
CH=x(5);
LH=x(6);
Y=x(7);
W=x(8);
RK=x(9);
C=x(10);
L=x(11);
T=x(12);
G=x(13);
lambdaR=x(14);
lambdaH=x(15);
end

function F=ss_equations(x,beta,alpha,delta,eta,chi,A_bar,G_bar,rho_g,mu)
% Guard against inadmissible solver trial values
if any(~isfinite(x)) || any(x<=0) || x(2)>=1 || x(6)>=1
    F=1e6*ones(15,1);
    return;
end

% Unpack the trial steady state
CR=x(1);
LR=x(2);
K=x(3);
I=x(4);
CH=x(5);
LH=x(6);
Y=x(7);
W=x(8);
RK=x(9);
C=x(10);
L=x(11);
T=x(12);
G=x(13);
lambdaR=x(14);
lambdaH=x(15);

% Steady-state equation residuals
F=[
    1/CR-lambdaR % Ricardian FOC w.r.t. CR
    chi*LR^eta-lambdaR*W % Ricardian FOC w.r.t. LR
    lambdaR-beta*lambdaR*(RK+1-delta) % Ricardian FOC w.r.t. K(+1)
    CR+I/(1-mu)-(W*LR+RK*K/(1-mu)-T) % Ricardian budget
    1/CH-lambdaH % Hand-to-mouth FOC w.r.t. CH
    chi*LH^eta-lambdaH*W % Hand-to-mouth FOC w.r.t. LH
    CH-(W*LH-T) % Hand-to-mouth budget
    W-(1-alpha)*A_bar*K^alpha*L^(-alpha) % Firm FOC w.r.t. L
    RK-alpha*A_bar*K^(alpha-1)*L^(1-alpha) % Firm FOC w.r.t. K
    Y-A_bar*K^alpha*L^(1-alpha) % Production
    T-G % Government budget
    log(G/G_bar)-rho_g*log(G/G_bar) % Government spending AR(1)
    C-((1-mu)*CR+mu*CH) % Consumption aggregation
    L-((1-mu)*LR+mu*LH) % Labor aggregation
    K-((1-delta)*K+I) % Capital accumulation
];
end
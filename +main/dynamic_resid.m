function [residual, T_order, T] = dynamic_resid(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(4, 1);
end
[T_order, T] = main.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
residual = NaN(15, 1);
    residual(1) = (1/y(16)) - (y(29));
    residual(2) = (params(5)*y(17)^params(4)) - (y(29)*y(23));
    residual(3) = (y(29)) - (params(1)*y(44)*(1+y(39)-params(3)));
    residual(4) = (y(16)+y(19)/(1-params(10))) - (y(17)*y(23)+y(24)*y(3)/(1-params(10))-y(27));
    residual(5) = (1/y(20)) - (y(30));
    residual(6) = (params(5)*y(21)^params(4)) - (y(23)*y(30));
    residual(7) = (y(20)) - (y(23)*y(21)-y(27));
    residual(8) = (y(23)) - ((1-params(2))*params(6)*T(1)*T(2));
    residual(9) = (y(24)) - (T(3)*T(4));
    residual(10) = (y(22)) - (T(4)*params(6)*T(1));
    residual(11) = (y(27)) - (y(28));
    residual(12) = (log(y(28)/params(8))) - (params(9)*log(y(13)/params(8))+x(1));
    residual(13) = (y(25)) - (y(16)*(1-params(10))+params(10)*y(20));
    residual(14) = (y(26)) - (y(17)*(1-params(10))+params(10)*y(21));
    residual(15) = (y(18)) - (y(19)+y(3)*(1-params(3)));
end

function [residual, T_order, T] = static_resid(y, x, params, T_order, T)
if nargin < 5
    T_order = -1;
    T = NaN(4, 1);
end
[T_order, T] = Two_household_model.static_resid_tt(y, x, params, T_order, T);
residual = NaN(15, 1);
    residual(1) = (1/y(1)) - (y(14));
    residual(2) = (params(5)*y(2)^params(4)) - (y(14)*y(8));
    residual(3) = (y(14)) - (y(14)*params(1)*(1+y(9)-params(3)));
    residual(4) = (y(1)+y(4)/(1-params(10))) - (y(2)*y(8)+y(9)*y(3)/(1-params(10))-y(12));
    residual(5) = (1/y(5)) - (y(15));
    residual(6) = (params(5)*y(6)^params(4)) - (y(8)*y(15));
    residual(7) = (y(5)) - (y(8)*y(6)-y(12));
    residual(8) = (y(8)) - ((1-params(2))*params(6)*T(1)*T(2));
    residual(9) = (y(9)) - (T(3)*T(4));
    residual(10) = (y(7)) - (T(4)*params(6)*T(1));
    residual(11) = (y(12)) - (y(13));
    residual(12) = (log(y(13)/params(8))) - (log(y(13)/params(8))*params(9)+x(1));
    residual(13) = (y(10)) - (y(1)*(1-params(10))+params(10)*y(5));
    residual(14) = (y(11)) - (y(2)*(1-params(10))+params(10)*y(6));
    residual(15) = (y(3)) - (y(4)+y(3)*(1-params(3)));
end

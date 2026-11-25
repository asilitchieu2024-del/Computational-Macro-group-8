function [T_order, T] = static_g1_tt(y, x, params, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = main.static_resid_tt(y, x, params, T_order, T);
T_order = 1;
if size(T, 1) < 7
    T = [T; NaN(7 - size(T, 1), 1)];
end
T(5) = getPowerDeriv(y(3),params(2),1);
T(6) = getPowerDeriv(y(11),1-params(2),1);
T(7) = 1/params(8)/(y(13)/params(8));
end

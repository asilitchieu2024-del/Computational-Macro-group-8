function [T_order, T] = dynamic_resid_tt(y, x, params, steady_state, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 4
    T = [T; NaN(4 - size(T, 1), 1)];
end
T(1) = y(3)^params(2);
T(2) = y(26)^(-params(2));
T(3) = params(2)*params(6)*y(3)^(params(2)-1);
T(4) = y(26)^(1-params(2));
end

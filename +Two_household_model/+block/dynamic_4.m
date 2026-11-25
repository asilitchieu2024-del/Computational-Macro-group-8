function [y, T] = dynamic_4(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(25)=y(16)*(1-params(10))+params(10)*y(20);
  y(22)=T(5)*params(6)*T(1);
end

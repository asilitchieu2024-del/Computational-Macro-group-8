function [y, T] = static_4(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(10)=y(1)*(1-params(10))+params(10)*y(5);
  y(7)=T(6)*params(6)*T(2);
end

function diagm = tdiag(data)
% TDIAG tensor diagnal operator to get the diagnal vectors for each slice
% (p*p*n) into a matrix (diagm) p*n
% Input
%         data p*p*n
% Output
%         diagm p*n
% Andy Hu, Sept. 17, 2019

[p, ~, n] = size(data);

idx = bsxfun(@plus,(1:p+1:p*p)',(0:n-1)*p*p);

diagm = data(idx);
end
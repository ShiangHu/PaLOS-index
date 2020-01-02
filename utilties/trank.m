function r = trank(T)
% Rank operator for all the slices of a tensor

n = size(T,3);

r = zeros(n,1);
for i=1:n   
    r(i) = rank(T(:,:,i));
end

end
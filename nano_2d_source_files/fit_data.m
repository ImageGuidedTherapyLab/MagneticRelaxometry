
% fits input decay curves and returns fit equations and associated R^2
% values. can optionally choose the fitting method.
% note: the default method is exp2.
%
% inputs:
% decays - matrix of decays, with row i = i milliseconds and column j =
% decay for sensor j
%
% outputs:
% fits - a cell array of function handles
% rsquare - a vector with associated R^2 values

function [fits, rsquare] = fit_data(decays)

[m,n] = size(decays);

for i = 1:n
    
    % fit each decay with exp2 curve
    [f_exp2,gof] = fit([1:m]', decays(:,i),'exp2');
    fits{i} = f_exp2;
    rsquare(i,1) = gof.rsquare;
    
end

return
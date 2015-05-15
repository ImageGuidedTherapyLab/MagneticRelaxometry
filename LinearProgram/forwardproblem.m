% Forward problem
function B = forwardproblem(mu,r_mu,rdet)
% Solves the forward problem to give you B at each point in rdet from a
% source of strength mu (1x3 vector) at r_mu.  
% B is a n_detector x 3 matrix [Bx By Bz].
% mu is a n_sources x 3 matrix [mux muy muz]
% r_mu is the position vectors of the sources in mu
% r_det is the position vectors of the detectors
% Currently only supports one source.  Future version to include multi
% sources.
%
% Update 5/15/15: Added multiple source capability

B = zeros(size(rdet,1),3);
for ii = 1:size(rdet,1)
    for jj = 1:size(mu,1)
        B(ii,:) = B(ii,:)+BiotVector(mu(jj,:), rdet(ii,:)-r_mu(jj,:));
    end
end

% A macro that is self-contained to explicitly solve the forward magnetic
% inverse problem for the field at the detector locations from a magnetic
% moment source anywhere in the dimxdimxdim field of view.

% Define the FOV and detector geometry
dim = 10; d=1;
rdet = [ 0, 0, d; -1/4, 1/6, d; 0, 1/4, d; 1/4, 1/6, d; 1/4, -1/6,d; 0, -1/4, d; -1/4, -1/6, d;]*dim;

% Plotting the FOV
% figure;
% scatter3(rdet(:,1),rdet(:,2), rdet(:,3),'markerfacecolor','r','markeredgecolor','r'); hold on;
% xlim([-dim/2, dim/2]); ylim([-dim/2, dim/2]); zlim([-dim/2,d*dim]);
% for ii = 1:dim % Loop through z "slices"
%     z = ii-dim/2-1;
%     for jj = 1:dim % Loop through y values
%         y = jj-dim/2-1;
%         for kk = 1:dim %Loop through x values
%             x = kk-dim/2-1;
%             % Plot the FOV grid
%             scatter3(x,y,z,'markerfacecolor','k','markeredgecolor','k'); hold on;
%         end
%     end
% end
% hold off;

% Find true B values for a given source
B = forwardproblem([0 0 9.825528e+005], [0 0 0], rdet)

% Solve the linear program for [x y z muz]
out = linearprogram(B(:,3), dim, rdet);

% Plug in result to forward problem
r_mu = out(:,1:3);
mu=zeros(size(out,1),3);
mu(:,3) = out(:,4);
B_new = forwardproblem(mu,r_mu, rdet)


% % This is just plotting the result via slices through the xy plane
% figure;
% for ii = 1:10
%     start = (ii-1)*100+1;
%     stop = (ii*100);
%     tri = delaunay(out(start:stop,1),out(start:stop,2));
%     subplot(2,5,ii); 
% %     scatter3(out(start:stop,1),out(start:stop,2), out(start:stop,4));
%      trisurf(tri,out(start:stop,1),out(start:stop,2), out(start:stop,4));
%     title(sprintf('z= %d', out(start,3)));
%      zlim([0,1400]);
% end
% 
% %Zoom in on last slice
% figure;
% scatter3(out(start:stop,1),out(start:stop,2), out(start:stop,4));
% % start = (ii-1)*100+1;
% % stop = (ii*100);
% % tri = delaunay(out(start:stop,1),out(start:stop,2));
% % trisurf(tri,out(start:stop,1),out(start:stop,2), out(start:stop,4));
% title(sprintf('z= %d', out(start,3)));
% 
% 
% % The original source
% 
% % [x, y] = meshgrid(-5:5,-5:5);
% % z = zeros(121,1);
% % z(61,1) = 9.825528e+005;
% % z = reshape(z,11,11);
% % surf(x,y,z);

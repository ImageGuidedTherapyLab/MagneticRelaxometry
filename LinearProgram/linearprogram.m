%linprog attempt

% out = linearprogram(B) returns a 10^3 x 4 array with columns [x y z muz]
% for detectors at a default location with respect to the FOV
% B is a n_detector length array of B values for detectors 1-7
%
% out = linearprogram(B, dim, rdet) returns a p dim^3 x 4 predicted source 
%array with columns [x y z muz] for a detected B field at detectors at rdet
% 
% Update 5/15/15: added n_det to account for a variable number of
% detectors.

function out = linearprogram(B, varargin)
close all;

% varargin is an option to input dim and rdet otherwise default will be
% used
% dim is number of pixels in one dimension (assuming dim^3 FOV)
% d is the height of the detectors relative to the size of the FOV
% Detector geometry is scaled with the size of the FOV, so that making
% voxels smaller does not increase the FOV.
if isempty(varargin)
    dim = 10; d=1; 
    rdet = [ 0, 0, d; -1/4, 1/6, d; 0, 1/4, d; 1/4, 1/6, d; 1/4, -1/6,d; 0, -1/4, d; -1/4, -1/6, d;]*dim;
    n_det = 7;
else
    dim = varargin{1};
    rdet = varargin{2};
    n_det = size(rdet,1);
end

% ===================plotting the FOV=================
% scatter3(rdet(:,1),rdet(:,2), rdet(:,3),'markerfacecolor','r','markeredgecolor','r'); hold on;
% xlim([-dim/2, dim/2]); ylim([-dim/2, dim/2]); zlim([-dim/2,d*dim]); hold on;
%========================================================

% ================Real data==============================
% B = [2.71022e+003     4.57652e+002     1.53821e+003     3.19654e+003     2.00135e+003     -5.79848e+001     2.09578e+002]';
% =======================================================

%============Construct geometry matrix================
A = zeros(n_det,dim^3);
% A is 3rz/|r|^5/2 - 1/|r|^3/2
for det= 1:n_det %Loop through detectors
    ll =1; %Column number iterator
    
    for ii = 1:dim % Loop through z "slices"
        z = ii-dim/2-1;
        
        for jj = 1:dim % Loop through y values
            y = jj-dim/2-1;
            
            for kk = 1:dim %Loop through x values
                x = kk-dim/2-1;
                
                % Plot the FOV grid
                % scatter3(x,y,z,'markerfacecolor','k','markeredgecolor','k'); hold on;
                
                % r is the vector between the detector and the current
                % pixel location
                r=rdet(det,:)-[x,y,z];
                %magr is the magnitude of r
                magr = sqrt(r(1)^2+r(2)^2+r(3)^2);
                % A is the geometry matrix
                A(det,ll)=10E-7*(3*r(3)/magr^(5/2) - magr^(-3/2));
                % index is a matrix of x,y,z values because counting is
                % hard.
                index(ll,:)=[x, y, z];
                % increment column iterator
                ll = ll+1;
                
            end %end loop through x
        end %end loop through y
    end %end loop through z
end %end loop through detectors
%======================================================
%============Linear programing solve===================

% we want to min ||x||1 while Ax=B and x >=0

f= ones(dim^3,1); %one norm vector: f'x = ||x||1
x1 = linprog(f,[],[],A,B, zeros(dim^3,1),[]);
% the output is one row per pixel [x y z mu]
out = [index, x1];
%======================================================
%==============end linearprogram()=====================


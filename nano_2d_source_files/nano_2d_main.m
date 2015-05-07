% nano_2d_main.m
% by Eric Groszman, Sun K Choi, Yunong Xu

% nano_2d_main is the main function for the 2d method

% instructions:
% 1. Choose N: the higher the N, the finer the grid is. We recommend using
%      N = 20 or N = 40 for the test cases
% 2. Choose a test case: this defines the true solution that the model will
%      attempt to solve for
% 3. Call the method (grid2d)
% 4. Visualize results (nanoDraw)

function nano_2d_main

close all

% define grid size
N = 20;

% construct true solution (see nano_2d_testcases.m for info on each case)
x_true = nano_2d_testcases(4,N);

% get predicted locations and intensities for noise level i
[x_sol, x_true, error] = grid2d(x_true, N, 80);

% visualize results
titlestr = 'test run'; % modify test description to liking
nanoDraw(x_sol, x_true, N, error, titlestr)


% weighed error and runtime tests are in the bottom of this file.
% if you wish to include them, copy the lines of interest to this 
% main function and uncomment the lines.
% (see % *)

return

% grid2d
% given true solution, N, and noise level, grid2d predicts location and
% intensity of sources from a noisy signal that is constructed from the
% true solution in x_true
%
% inputs:
% x_true = true source locations
% N = num of gridpoints
% noise = white gausian noise level
%         a number between 0 (most noise) and 100 (no noise)
%         reasonable noise is in range [60, 80]
%
% outputs:
% x_sol = predicted source location vector
%         x(i) is predicted intensity at gridpoint i, i = 1, 2, ... , N^2
% x_true = same x_true vector as input
% error = error between predicted and true; ||Ax - b||

function [x_sol, x_true, error] = grid2d(x_true, N, noise)

% sensor locations: hexagon + 1 in center
s_loc = [0.5000, 0.5000];

for i = 0:5
    s_loc = [s_loc; ...
        0.5000+0.3333*cos(pi/2+pi/3*i)...
        0.5000+0.3333*sin(pi/2+pi/3*i)];
end

% height of sensors relative to grid (z direction)
z_height = .4;

% make grid
xlim = linspace(0,1,N);
ylim = linspace(0,1,N);
[X, Y] = meshgrid(xlim, ylim);

% generate matrix A row by row
A = [];

% sensor 1 through 7
for i = 1:7
    
    % N x N inverse distance matrix
    row_matrix = 1./((X-s_loc(i,1)).^2 + (Y-s_loc(i,2)).^2 + z_height^2);
    
    % vectorized inverse distance matrix corresponding to sensor i
    A = [A; row_matrix(:)'];
    
end

% construct objective function constant f
f = ones(1,N^2);

% scaling matrix D
d = zeros(N^2,1);
for j = 1:N^2
    d(j) = norm(A(:,j));
end
A = A*diag(1./d);

% equality constraint: matrix [A 0] with dim 9 x N^2
Aeq = sparse(A);

% generate b from true data
beq = sparse(A*x_true);

% add noise to b
% test: 80 is some noise, 20 is drastic noise (ie - broken sensors)
beq = abs(awgn(beq,noise));

% for true data tests, b is created and pasted below, which overwrites the
% previously created b
% beq = [1.0000
%     0.2270
%     0.0513
%     0.0231
%          0
%          0
%     0];

% lower and upper bounds
lb = zeros(1,N^2);

% call linprog
x_sol = linprog(f,[],[],Aeq,beq,lb,[]);

% checks
error = norm(A*x_sol-beq)

return

% nanoDraw is used to visualize the outcome of grid2d
%
% inputs:
% x_true = true solution (1 x N^2)
% x_sol = predicted solution vector (1 x N^2)
% N = grid size (for plotting gridlines)
% error = error between predicted and true solutions 
% title_string = string containing test description or other information
function nanoDraw(x_sol, x_true, N, error, title_string)

% sensor locations: hexagon + 1 in center
s_loc = [0.5000, 0.5000];

for i = 0:5
    s_loc = [s_loc; ...
        0.5000+0.3333*cos(pi/2+pi/3*i)...
        0.5000+0.3333*sin(pi/2+pi/3*i)];
end

% predicted and true solution as matrices
x_sol = reshape(x_sol,N,N);
x_true = reshape(x_true,N,N);

% initialize grid plot
h = figure(1)

lim = linspace(0,1,N);
plot(lim,lim,'w');
set(gca,'XTick',linspace(0,1,N+1))
set(gca,'YTick',linspace(0,1,N+1))
set(gca,'xticklabel',[]) 
set(gca,'yticklabel',[]) 
grid on
hold on

% display true locations
[i,j,v] = find(x_true);
scatter(i/N,j/N,v*300,'r','filled')

% display predicted locations
[i,j,v] = find(x_sol);
scatter(i/N,j/N,v*200,'b','filled')

% display sensors
scatter(s_loc(:,1),s_loc(:,2),1000,'k','LineWidth',1.5)

% option: display error in title with scientific notation
% [mant, expnt] = mantexpnt(error);
% expnt= num2str(expnt);
% mant = num2str(mant);
% expstring = '10^{ ';
% expstring(end:end+numel(expnt)-1) = expnt;
% expstring(numel(expstring)+1:numel(expstring)+2) = '}$';
% title with title_string, N, and solution error
% TitleH = title([title_string ',  N = ' ...
%     num2str(N) ',   $\|Ax-b\|$=' mant '$\times' expstring], ...
%     'FontSize', 30 , 'Interpreter', 'LaTeX');

% title with title_string, N, and solution error
TitleH = title([title_string ',  N = ' num2str(N)], ...
                'FontSize', 35,'Interpreter','LaTeX');

% make title more visible
set(TitleH, 'Position', [0.5, 1.095], ...
  'VerticalAlignment', 'top', ...
  'HorizontalAlignment', 'center')

% larger figure size
set(h, 'Position', [0, 0, 900, 800]);

return

% used to display error in nanoDraw figure titles
function [mant, expnt] = mantexpnt(arg)
% MANTEXPNT
% Returns the mantissa and exponent of a real base 10 argument.

% TEST DATA:
% arg = (0.5 - rand) * 10^fix(10*(0.5-rand))
% sprintf('\n\t%23.15E\n',arg)

sgn = sign(arg);
expnt = fix(log10(abs(arg)));
mant = sgn * 10^(log10(abs(arg))-expnt);
if abs(mant) < 1
    mant = mant * 10;
    expnt = expnt - 1;
end

return 



% *



% % ---------- weighed error graph test
% 
% noise = 100:-10:20;
% 
% for i = 1:9
% 
%     % get predicted locations and intensities for noise level i
%     [x_sol, x_true] = grid2d(x_true, N, noise(i));
% 
%     % visualize results
%     %nanoDraw(x_sol, x_true, N)
% 
%     % calculate error
%     weighedError(i) = nano_2d_weighedError(x_true, x_sol)
% 
% end
% 
% h = figure
% plot(noise, weighedError, '.-','LineWidth',2)
% 
% set(gca,'xdir','reverse')
% set(gca,'FontSize',35)
% xlabel('White Gaussian Noise (dBW): 100 = no noise, 20 = very noisy','FontSize',35,'Interpreter','LaTeX')
% ylabel('Weighed Error','FontSize',35,'Interpreter','LaTeX')
% TitleH = title('Noise test for 2 clusters, N = 40','FontSize',35,'Interpreter','LaTeX')
% 
% % make title more visible
% % set(TitleH, 'Position', [60, max(weighedError)], ...
% %   'VerticalAlignment', 'top', ...
% %   'HorizontalAlignment', 'center')
% 
% % larger figure size
% set(h, 'Position', [0, 0, 1600, 400]);
% 
% % set(gca,'FontSize',14)
% % ax = gca;
% % ax.XTickLabelRotation = -90;
%
% % ---------- end weighed error graph test


% % ---------- runtime test
%
% Nlist = [2 4 8 16 32 64 128 256];
% runtime=[];
%
% for i = 1:8
%
%     N = Nlist(i)
%     x_true = nano_2d_testcases(1, N);
%
%     tic
%
%     % get predicted locations and intensities for noise level i
%     [x_sol, x_true] = grid2d(x_true, N, 80);
%
%     % visualize results
%     %nanoDraw(x_sol, x_true, N)
%
%     % calculate error
%     runtime(i) = toc;
%
% end
%
% figure
% plot(Nlist, runtime, '.-','LineWidth',2)
% set(gca,'FontSize',14)
% xlabel('N','FontSize',16)
% ylabel('time (s)','FontSize',16)
% title('Runtime for 1 source as function of N','FontSize',16)
%
% % ---------- end runtime test



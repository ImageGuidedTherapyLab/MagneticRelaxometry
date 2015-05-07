% function nano_2d_testcases(i, N)

% test descriptions:
% 1: 1 source, random location
% 2: big cluster, small cluster
% 3: 1 random location cluster
% 4: 3 point sources on sides of grid
% 5: null grid
% 6: full grid
% 7: 3 cluse clusters
% 8: 4 random location and intensity clusters
% 9: 3 random location sources 
% 10: 3 point sources


% returns test case "i" for a given N
function x_true = nano_2d_testcases(i, N)

if i == 1
    % test 1
    x_true = zeros(N,N);
    index = floor(N/2);
    x_true(index,index) = 4;
    x_true = reshape(x_true,N^2,1);

% big cluster, small cluster    
elseif i == 2
    % test 2
    x_true = zeros(N,N);
    x_true(5,5) = 20;
    x_true(N-5,N-5) = 6;
    x_true = reshape(x_true,N^2,1);
    
% 1 randomly placed cluster    
elseif i == 3
    
    % test 3
    x_true = zeros(N,N);
    index = floor(.4*N);
    x_true(index, index) = 6;
    x_true = reshape(x_true,N^2,1);

% 3 sources on sides of grid
elseif i == 4
    
    % test 4
    x_true = zeros(N,N);
    x_true(ceil(N^2/2)) = 1; 
    x_true(ceil(N^2/2)-1) = 1;
    x_true(ceil(N^2/2)+1) = 1;
    x_true = reshape(x_true,N^2,1);
    
% null grid    
elseif i == 5
    
    % test 5
    x_true = zeros(N^2,1);
  
% full grid    
elseif i == 6
    
    % test 6
    x_true = ones(N^2,1);

% 3 close clusters    
elseif i == 7
    
    % test 7
    x_true = zeros(N,N);
    index = floor(.7*N);
    x_true(index, index) = 6;
    x_true(index+1, index+1) = 6;
    x_true(index-3, index-3) = 6;
    x_true = reshape(x_true,N^2,1);

%     
elseif i == 8
    
    % test 8
    x_true = zeros(N,N);
    factor = ceil(N/3);
    
    r = ceil(rand*5)-5;
    x_true(N-factor+r,N-factor+r) = 6;
    
    r = ceil(rand*5)-5;
    x_true(factor+r,N-factor+r) = 8; 
    
    r = ceil(rand*5)-5;
    x_true(N-factor-r,factor+r) = 10; 
    
    r = ceil(rand*5)-5;
    x_true(factor+r,factor+r) = 2; 
    
    x_true = reshape(x_true,N^2,1);
    
elseif i == 9
    
    % test 9
    
    x_true = zeros(N^2,1);
    
    % true location for 3 sources
    n_loc = [ceil(rand*N^2) ceil(rand*N^2) ceil(rand*N^2)];
    
    % add 3 sources at the random locations to X
    x_true(n_loc(1)) = 1; %ceil(rand*10)/2; % randomized intensity values
    x_true(n_loc(2)) = 1; %ceil(rand*10)/2;
    x_true(n_loc(3)) = 1; %ceil(rand*10)/2;
    
% 3 sources, suited for N = 20    
elseif i == 10
    
    x_true = zeros(N,N);
    x_true(3,8) = 1; 
    x_true(11,8) = 1;
    x_true(16,9) = 1;
    x_true = reshape(x_true,N^2,1);
    
end

return
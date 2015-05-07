% test script for source localization
% directions: choose appripriate run numbers to average 
% data description in bottom of this file

b = zeros(7,2);
background = b;

% background runs
for i = 1:5
    background(:,i) = sensor_strength(i,0);
end

% ---------- SPECIFY RUNS OF INTEREST HERE * 

% runs 98-100: (4,3) on 9x9 grid
% runs 6-7: (5,5) on 9x9 grid

run_range = 38:40; % <---------------------------- *

for i = 1:length(run_range)
    run = run_range(i);
    b(:,i) = sensor_strength(run,0);
end

% factor background
background = background/100

% factor signal
b = b/100

% averages
mean(b,2);
mean(background,2);

b = abs(mean(b,2) - mean(background,2));

%sensors 5 and 6 are broken
b(5,:) = 0;
b(6,:) = 0;

% normalized b vector
(b - min(b))./(max(b)-min(b))

% show original b vector
disp(b)

% ----------------
% Data:
% 
% Files 1-5 are background
% Files 6-7 are a point source in the center of the phantom.
% 
% From there, the files are in triplets, three runs at each peg position, 
% starting at the top left if you were looking down on the machine from in 
% front of it (it would be the corner between SQUIDs 2 and 3).  
% I called that 1,1 to be consistent with MATLAB.  From there, they are 
% numbered in a similar row,column fashion. I started at the top left, 
% moved to the right across the row, then skipped back to the 2,1 spot 
% and moved across that row, etc. doing three runs of 10 pulses (but you'll 
% only see one curve per run, which is an average of all 10 pulses) at each 
% position.
% 
% So, files 8-10 are the peg at 1,1
% files 11-13 are at 1,2
% files 14-16 are at 1,3
% ...
% files 32-34 are at 1,9
% files 35-37 are at 2,1
% files 38-40 are at 2,2
% ....
% until you get to
% files 89-91 at 4,1
% 
% Then the machine started acting funny so I took another background run, so
% files 92-94 are without a peg, just background again
% Then I picked up where I left off
% 
% files 95-97 are at 4,2
% files 98-100 are at 4,3
% ...
% files 251-253 are at 9,9
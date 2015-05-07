function b = sensor_strength(num, t)
% this function returns fitted signal strength values for each sensor

% input: 
%   num - an integer pertaining to file name
%   t - timepoint to take decay measurement for all sensors. t in [0,2200].
% output: vector b of signal strengths
% example usage: b = sensor_strength(7, 750)

% generate name of file
fileName = ['file' num2str(num) '.mat'];

% restructure dataset for easier usage
% column i of data_mat = signal strength of sensor i at all timepoints
% there are 7 sensors total
data_mat = build_datamat(fileName);

plot(data_mat,'LineWidth',2)
title('raw data for 1 pulse, single point source','FontSize',16)
legend('sensor 1','sensor 2','sensor 3','sensor 4','sensor 5','sensor 6','sensor 7')
xlim([0 2200])
set(gca, 'FontSize',14)
xlabel('Time (ms)')
ylabel('Field decay')


% visualize waves
% plot(data_mat)

% store signal strength for each sensor
strength = [];

% to store gof for each signal
%figure

colors = [0    0.4470    0.7410
    0.8500    0.3250    0.0980
    0.9290    0.6940    0.1250
    0.4940    0.1840    0.5560
    0.4660    0.6740    0.1880
    0.3010    0.7450    0.9330
    0.6350    0.0780    0.1840];

for i = 1:7
    
    % fit each wave
    [C, gof(i)] = fit_data(data_mat(:,i));

%     p = plot(C{1});
%     set(p,'Color',colors(i,:),'LineWidth',2)
%     hold on
    
    % calculate strength for sensor i
    a = C{:}.a;
    b = C{:}.b;
    c = C{:}.c;
    d = C{:}.d;
    
    % calculate strength based on the fit function
    strength(i) = a*exp(b*t) + c*exp(d*t);
    
end

% title('fits for 1 pulse, single point source','FontSize',16)
% legend('sensor 1','sensor 2','sensor 3','sensor 4','sensor 5','sensor 6','sensor 7')
% xlim([0 2200])
% set(gca, 'FontSize',14)
% xlabel('Time (ms)')
% ylabel('Field decay')

% display useful info on the fits
% fprintf('\ngoodness of fit = \n')
% disp(gof)
% fprintf('\n')

% return b vector
b = strength';
b = b([1 3 2 7 6 5 4]);

%      3 -->2
% 2-->3       4-->7
%        1 
% 7-->4       5-->6
%      6-->5 
%
% % normalized signals on range from 0 to 1
% b_norm = (b - min(b)) / (max(b) - min(b))

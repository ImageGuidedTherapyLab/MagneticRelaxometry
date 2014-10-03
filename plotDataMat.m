function varargout = plotDataMat(dataMat, varargin)
%plots data that's formatted into a nx8 matrix where n is the number of
%time points that data was taken at, and 8 is time; squids 1 thru 7.

if nargin >1
%if strcmp(varargin{1},'all') < for later update
% for now, if you want to plot each squid on its own, add a second argument
titles = {'', 'SQUID1', 'SQUID2', 'SQUID3', 'SQUID4', 'SQUID5'...
    'SQUID7', 'SQUID8'};
figure;
subplot(3,3,2);
plot(dataMat(:,1),dataMat(:,8));
title(titles{8});
subplot(3,3,3);
plot(dataMat(:,1),dataMat(:,7));
title(titles{7});
subplot(3,3,5);
plot(dataMat(:,1), dataMat(:,6));
title(titles{6});
subplot(3,3,6);
plot(dataMat(:,1),dataMat(:,5));
title(titles{5})
subplot(3,3,7);
plot(dataMat(:,1), dataMat(:,4));
title(titles{4});
subplot(3,3,8);
plot(dataMat(:,1), dataMat(:,3));
title(titles{3});
subplot(3,3,9);
plot(dataMat(:,1), dataMat(:,2));
title(titles{2});
suptitle('All the squids!');
end

figure;
h =plot(dataMat(:,1),dataMat(:,2:end));

xlabel('Time (s)');
ylabel('Field strength');
suptitle('Average of all pulses per squid');
legend('SQUID1', 'SQUID2', 'SQUID3', 'SQUID4', 'SQUID5',...
    'SQUID7', 'SQUID8', 'Location', 'northwest')
if nargout >0
    varargout{1} = h;
end

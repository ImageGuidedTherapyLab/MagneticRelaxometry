function out = averageBackground(numFiles, direct, varargin)
%   returns an array that is the average of the data in the first numFiles
%   files in direct (input as string) of converted from tdms .mat files
%   (ie. 'Data/outputFiles/matFiles/*.mat').
quiet = 0;
x = dir(direct);
filename = x(1).name;
load(filename);
A = ConvertedData;
titles = ChanNames{1,1};
for ii = 3:10
    dataMat(:,ii-2) = [A.Data.MeasuredData(1,ii).Data];
end

for jj = 2:numFiles
    filename = x(jj).name;
    load(filename);
    A=ConvertedData;
    for ii = 3:10
        dataMat(:,ii-2) = [dataMat(:,ii-2)+ A.Data.MeasuredData(1,ii).Data];
    end
end
out = dataMat./numFiles;

if nargin >2
    for ii = 1:length(varargin)
        switch varargin{ii}
            case 'quiet'
                quiet = 1;
            case 'save'
                current = pwd;
                saveFile = uigetdir;
                if ischar(saveFile) cd(saveFile); end
                AverageBackground =out;
                save AverageBackground;
                cd(current);
            case 'saveHere'
                AverageBackground = out;
                save AverageBackground;
            case 'plot'
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
                mesg= sprintf('Average background for first %i files', numFiles);
                suptitle(mesg);
        end
    end
     
end






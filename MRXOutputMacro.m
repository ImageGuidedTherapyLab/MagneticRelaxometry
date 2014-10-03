% This is a macro to read in raw data from the MRX Squids
% by Sara Loupot, 2014

clear all; close all;

%If you haven't imported data already, do so:
% A = importData();

% If you have already imported data, 
% hard code the file (Data) that you wish to analyze
dataFolder = (strcat(pwd,'/Data/10_01_14'));
currFolder = pwd;
matFiles = strcat(dataFolder, '/*.mat');

cd(dataFolder); f = dir(matFiles);
for ii = 1:length(f)
    A{ii}=load(f(ii).name);
end
cd(currFolder);

% Average Background
numBackground = countBackgroundFiles(matFiles);
bkgd = averageBackground(numBackground, matFiles);

% Pull out the actual data from the files for the run you want to see. 
runNumber = 11;
% dataMat is a nx8 where the first column is time and 2:8 are squids 1:8 
% (except 6, because six doesn't work)
dataFile = A{1,runNumber};
viewInfo(A{1,runNumber});
dataMat = constructDataMat(dataFile);

%Subtract background from your data
dataMat(:,2:end) = dataMat(:,2:end)-bkgd(:,2:end);

% Average the 10 pulses 
averagePulse = parsePulses(dataMat);

%Plot the result
h = plotDataMat(averagePulse);
title(f(2+numBackground).name);


% simplifies the contents of a MRXII tdms file by consolidating the
% signals into a matrix, data_mat
% input: the .mat filename (string)
% output: data_mat (matrix)
% example: data_mat = build_datamat('file9.mat');

function data_mat = build_datamat(matFileName)

% change path to data folder
cd data

% loads mat file
data = load(matFileName);

% store signals in matrix
data_mat = [];

% note: storing 7 sensors only
% SQUIDchannel0 = time, SQUIDchannel8 = broken
data_mat(:,1) = data.FilteredChannel1.Data;
data_mat(:,2) = data.FilteredChannel2.Data;
data_mat(:,3) = data.FilteredChannel3.Data;
data_mat(:,4) = data.FilteredChannel4.Data;
data_mat(:,5) = data.FilteredChannel5.Data;
data_mat(:,6) = data.FilteredChannel6.Data;
data_mat(:,7) = data.FilteredChannel7.Data;

% close mat file
clear data

% go back to original path
cd ..

return
%Macro to make a cell vector of .mat files and a .txt file with some
%description of them.

x = dir('Y:\Projects\NanoMRX\Codes\Data\06_12_14\matFiles\*.mat');
fileID = fopen('dataDescription.txt','w');

for ii = 1:length(x)
    A{ii} = load(x(ii).name);
end
for ii = 1:length(A)
    info = viewInfo(A{ii});
    file = A{ii}.ConvertedData.FileName;
    descript = info{8,2};
    descript2 = info{6,2};
    fprintf(fileID,'%s, %s, %s\n', file, descript2, descript);
end
fclose(fileID);
    
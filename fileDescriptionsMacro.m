A = importData();
fileID = fopen('dataDescription.txt','w');
for ii = 1:length(A)
    info = viewInfo(A{1,ii});
    file = A{1,ii}.FileName;
    descript = info{8,2};
    descript2 = info{6,2};
    fprintf(fileID,'%s, %s, %s\n', file, descript2, descript);
 end
% fprintf(fileID,'%s, %s, %s\n', file, descript2, descript);
fclose(fileID);
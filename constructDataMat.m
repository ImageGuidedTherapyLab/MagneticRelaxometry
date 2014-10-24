function dataMat = constructDataMat(matFile)
%this function converts imported data files into data matrices of nx8 where
%n is the number of time points and the first column is time and columns
%2:8 are the squids.  For now, it only reads .mat files, but the next
%update will read .tdms as well.

switch class(matFile)
    case 'char'
        load(matFile);
        if(isfield(matFile, 'ConvertedData'))
            A = matFile.ConvertedData.Data.MeasuredData;
        else
            A = matFile.Data.MeasuredData;
        end
    case 'cell'
        A = matFile{1,1}.ConvertedData.Data.MeasuredData;
    case 'struct'
        if(isfield(matFile, 'ConvertedData'))
            A = matFile.ConvertedData.Data.MeasuredData;
        else
            A = matFile.Data.MeasuredData;
        end
end

for ii =1:8
    dataMat(:,ii) = [A(:,ii+2).Data];
end
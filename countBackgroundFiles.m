function bkgd = countBackgroundFiles(foldername)
% foldername needs to be 'path/to/folder/*.filetype' or a cell array returned by 
% importData().  returns the number of background files in a directory, 
% according to the user-entered description.

if( iscell(foldername))
    x = foldername;
else
    x = dir(foldername);
end

numBackground = 0;
numDataFile = 0;

for ii = 1:length(x)
    
    if(iscell(x))
        A = x{1,ii};
    else filename = x(ii).name;
        if(~isempty(strfind(filename, '.mat')))
            load(filename);
            A = ConvertedData;
        elseif(~isempty(strfind(filename,'.tdms')))
            A = convertTDMS(0,filename);
        else
            disp('Not a supported file format');
            bkgd = 0;
            return;
        end
    end
    y = A.Data.Root.Property(1,6).Value;
    if(strcmp(y,'Background') || strcmp(y,'bkg'))
        numBackground =numBackground +1;
    else
        numDataFile = numDataFile+1;
    end
end
disp(sprintf('There are %d background files\n There are %d data files', ...
    numBackground, numDataFile));
bkgd = numBackground;

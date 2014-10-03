function varargout = importData(varargin)
%A = importData(); gives the user a prompt to select directories from which
%to pull data and to save it.  
%A = importData(dataFile); pulls data from dataFile and saves it in the
%current directory.
%A = importData(dataFile, saveFile); pulls data from dataFile and saves it
%in saveFile.
%A (optional) is a cell vector of the runs in the dataFile, saved as structs.
%if run without output arguments, .mat files of all of the runs in dataFile
%are saved in saveFile, and can be accessed by load(data.mat);
if nargout>0, varargout{1} = {}; end
if nargin ==1
    dataFile = varargin{1};
    saveFile = pwd;
elseif nargin==2
    dataFile = varargin{1};
    saveFile = varargin{2};
else
    dataFile = uigetdir('','Select Data Folder');
    if dataFile == 0, return; end
    saveFile = uigetdir('','Select location to save data');
    if saveFile == 0, return; end
end

x = dir(strcat(dataFile, '/*.tdms'));
newFolder = strcat(saveFile, '/matFiles');

cd(saveFile);
if(exist(newFolder, 'dir') ==0)
    mkdir(newFolder); 
end
addpath(newFolder);
cd(newFolder);
for jj = 1:length(x)
    filename =strcat(dataFile,'/', x(jj).name);
    A{jj} = convertTDMS(1,filename);
end
newMatFiles = strcat(dataFile,'/*.mat');
movefile(newMatFiles);
fileID = fopen('..\dataDescription.txt','w');
for ii = 1:length(A)
    info = viewInfo(A{1,ii});
    file = A{1,ii}.FileName;
    descript = info{8,2};
    descript2 = info{6,2};
    fprintf(fileID,'%s, %s, %s\n', file, descript2, descript);
end
 fclose(fileID);
if nargout >0
    varargout{1} = A;
end

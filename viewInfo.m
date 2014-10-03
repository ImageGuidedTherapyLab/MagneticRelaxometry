function varargout = viewInfo(filename)
%info = viewInfo(filename) returns a dataset containing the header
%information in filename.  filename can be a cell vector returned from
%importData, a struct (element from cell vector above), a .mat or .tdms
%file.  if run without supressed output, the dataset will be displayed, if
%run with an output argument, the dataset will be saved in info.

if(iscell(filename))
    if length(filename)>1
        A = filename{1,1};
    else
        A = filename;
    end
elseif(isstruct(filename))
    if length(filename)>1
       A = filename{1,1};
    else
        A = filename;
    end
elseif(~isempty(strfind(filename,'.mat')))
    load(filename);
    A = ConvertedData;
elseif(~isempty(strfind(filename,'.tdms')))
    A = convertTDMS(0,filename);
else
    disp('Not a supported file format');
    if(nargout)
        varargout{1} = 0;
    end
    return;
end

y = [A.Data.Root.Property(1,:)'];
info = cell(length(y)+1,2);
info{1,1}= 'Name';
info{1,2}= 'Value';
for ii= 1:length(y)
    name = y(ii,1).Name;
    val = y(ii,1).Value;

    info{ii+1,1}=name;
    info{ii+1,2}=val;
end
if(nargout)
    varargout{1} = cell2dataset(info);
end
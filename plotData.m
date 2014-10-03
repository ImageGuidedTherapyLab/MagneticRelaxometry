function varargout = plotData(filename)
% Plots the data in the .mat or .tdms file "filename"
% PlotData(filename) or h = PlotData(filename) will return 
% a figure handle to the plot.

h = figure;

if(isstruct(filename))
    A = filename;
elseif(~isempty(strfind(filename,'.mat')))
    load(filename);
    A = ConvertedData;
elseif(~isempty(strfind(filename,'.tdms')))
    A = convertTDMS(0,filename);
else
    disp('Not a supported file format');
    close h;
    if(nargout)
        varargout{1} = 0;
    end
    return;
end

if(nargout)
    if(nargout>1)
        disp('too many outputs');
    else
    varargout{1} = h;
    end
end

subplot(3,3,2);
plot(A.Data.MeasuredData(1,3).Data, A.Data.MeasuredData(1,10));
title(A.Data.MeasuredData(1,10).Name);
subplot(3,3,3);
plot(A.Data.MeasuredData(1,3).Data, A.Data.MeasuredData(1,9));
title(A.Data.MeasuredData(1,9).Name);
subplot(3,3,5);
plot(A.Data.MeasuredData(1,3).Data, A.Data.MeasuredData(1,8));
title(A.Data.MeasuredData(1,8).Name);
subplot(3,3,6);
plot(A.Data.MeasuredData(1,3).Data, A.Data.MeasuredData(1,7));
title(A.Data.MeasuredData(1,8).Name);
subplot(3,3,7);
plot(A.Data.MeasuredData(1,3).Data, A.Data.MeasuredData(1,6));
title(A.Data.MeasuredData(1,6).Name);
subplot(3,3,8);
plot(A.Data.MeasuredData(1,3).Data, A.Data.MeasuredData(1,5));
title(A.Data.MeasuredData(1,5).Name);
subplot(3,3,9);
plot(A.Data.MeasuredData(1,3).Data, A.Data.MeasuredData(1,4));
title(A.Data.MeasuredData(1,4).Name);

suptitle(A.Data.Root.Property(1,6).Value);


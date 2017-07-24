function [data,info] = read_mhd(filename)

% read mhd file with unsigned short from disk

fid = fopen(filename, 'r');
while ~feof(fid)
    line = fgets(fid);
    
    k = strfind(line, 'NDim');
    if(~isempty(k))
        info.NDim = sscanf(line(k(1)+length('NDim')+3:end), '%d');
    end
    
    k = strfind(line, 'TransformMatrix');
    if(~isempty(k))
        info.transformMatrix = sscanf(line(k(1)+length('TransformMatrix')+3:end), '%d', [3 3]);
    end
    
    k = strfind(line, 'Offset');
    if(~isempty(k))
        info.Offset = sscanf(line(k(1)+length('Offset')+3:end), '%d', [1 3]); 
    end
    
    k = strfind(line, 'ElementSpacing');
    if(~isempty(k))
        info.Spacing = sscanf(line(k(1)+length('ElementSpacing')+3:end), '%f', [1 3]); 
    end
    
    k = strfind(line, 'DimSize');
    if(~isempty(k))
        info.DimSize = sscanf(line(k(1)+length('DimSize')+3:end), '%d', [1 3]); 
    end
    
    k = strfind(line, 'ElementType');
    if(~isempty(k))
         info.ElementType = line(k(1)+length('ElementType')+3:end-1);
%          if isempty(strfind(info.ElementType, 'MET_USHORT'))
%              error('mhd file is not unsigned short datatype.\n');
%          end
    end
    
    k = strfind(line, 'ElementDataFile');
    if(~isempty(k))
        if line(end) ~= 'w' % remove new line \n character
            info.ElementDataFile = line(k(1)+length('ElementDataFile')+3:end-1);
        else
            info.ElementDataFile = line(k(1)+length('ElementDataFile')+3:end);
        end
    end
end
fclose(fid);

% [folder, ~, ~] = fileparts(filename);

% read data
temp=dir(filename);
temp=temp.name;
data_file =strrep(filename,temp,info.ElementDataFile);
fid = fopen(data_file, 'rb');



if ~isempty(strfind(info.ElementType, 'MET_USHORT'))
    data = fread(fid, prod(info.DimSize), 'uint16');
elseif ~isempty(strfind(info.ElementType, 'MET_FLOAT'))
    data = fread(fid, prod(info.DimSize), 'float');
else
    error(['type ' info.ElementType ' not supported!\n']);
end
        
data = reshape(data, int32(info.DimSize));

fclose(fid);

% transpose each slice
% data = permute(data, [2 1 3]);

end
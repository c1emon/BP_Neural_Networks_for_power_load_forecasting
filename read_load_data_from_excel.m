function [raw_out, raw_max, raw_min] = read_load_data_from_excel(path, mouth, day)

sheetP= 1;
xlRangeP = 'C3:C98';
xlsmaxP = 'C99';
xlsminP = 'C101';

if path(length(path)) ~= '\'
    path = strcat(path, '\');
end

full_path = [path, '2018Äê', num2str(mouth), 'ÔÂ\2018.', num2str(mouth), '.', num2str(day), '.xlsx'];

raw_out = xlsread(full_path, sheetP, xlRangeP);
raw_max = xlsread(full_path, sheetP, xlsmaxP);
raw_min = xlsread(full_path, sheetP, xlsminP);

end
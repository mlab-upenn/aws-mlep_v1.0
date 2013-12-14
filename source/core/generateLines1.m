function [data] = generateLines1(param)


% Allocate struct for lines
data = struct('lines', repmat({{}}, 1, length(fields(param))));

% Get fieldnames
fieldname = fields(param);

for i = 1:length(fields(param))
    startStr = ['  Parametric:SetValueForRun,' char(13) char(10)];
    startStr = [startStr '    ' '$' char(fieldname{i}) ',' char(13) char(10) '    '];
    vec = param.(char(fieldname(i)));
    for j = 1:size(vec,1)-1
        startStr = [startStr num2str(vec(j)) ',']; 
    end
    startStr = [startStr num2str(vec(j)) ';' char(13) char(10)];
    data(i).lines = startStr;
end







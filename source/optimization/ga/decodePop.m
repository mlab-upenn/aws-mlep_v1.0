function popDec = decodePop(pop,stringlength,dimension,x_bound)
%DECODEPOP Decodes the binary chromosomes into real-valued parameters
% 
% 

x_bound = x_bound';

% Population Size
popsize=size(pop,1);
temp=2.^(stringlength-1:-1:0)/(2^stringlength-1);
bound = zeros(1,dimension);
for i=1:dimension
    bound(i)=x_bound(i,2)-x_bound(i,1);
end

% Allocate decoded population variable
popDec = zeros(popsize, dimension);

% m = zeros();
% For each individual
for i=1:popsize
    % For each dimension (Parameter)
    for j=1:dimension
        m(:,j)=pop(i,stringlength*(j-1)+1:stringlength*j);
    end
    x=temp*m;
    x=x.*bound+x_bound(:,1)';
    
    % Decoded individual 
    popDec(i,:) = x;
end
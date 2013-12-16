function pop = gaMutate(pop,stringlength,dimension,pm)
%GAMUTATE Mutates the parameters on the 

% Population size
popsize=size(pop,1);

% For each individual
for i=1:popsize
    % Probability of mutation
    if rand<pm
        % Decide where mutation occurs
        mpoint=round(rand(1,dimension)*(stringlength-1))+1;
        % Mutate every parameter
        for j=1:dimension
            pop(i,(j-1)*stringlength+mpoint(j))=1-pop(i,(j-1)*stringlength+mpoint(j));
        end
    end
end
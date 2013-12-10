function fitness = getFitness(comfort, powConsume)
%   Function to get the fitness of each individual within an population in one generation
%   INPUT    delayRecPerGen     The delay of each individual in the population
%            expect             The expected result? or the expected total delay                  
%   OUTPUT   fitness            Each individual's fitness
%   Created by Tao Lei (leitao@seas.upenn.edu) Sep 2013

% expect = 45000;
% fitness = expect./(mean(comfort .* powConsume) - expect);

expect = 5500;
fitness= expect./(mean(powConsume) - expect);
end




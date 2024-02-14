% Generate test array 
function [errors_array] = generate_test_arrays(n)
% Generates test array with n values, 5 values of choice randomly assigned
% 1 to 4. 

% Initialize array with zeros
temp = zeros(n, 1);

% Select 5 random indices
indices = randperm(n, 5);

rand_values = randi(4,1,5); 

% Assign random values in the range of 0 to 5 to the selected indices
for i = 1:5
    temp(indices(i)) = rand_values(i); % Random value in the range of 0 to 5
end

% Display the errors_array
disp(temp);
errors_array = temp;

end

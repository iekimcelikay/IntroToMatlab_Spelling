no_of_errors(random_numbers(kk)) % this gives me an index of the words actually. 

no_of_errors % is a 38x1 double. no_of_errors(1)  is ant. 

scores = struct;
scores.NbErrors = no_of_errors;

ind = 1:38; 

for ind = 1:38
    no_of_errors(ind) = nb_error_vocab ;  
end

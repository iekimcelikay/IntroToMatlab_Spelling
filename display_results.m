no_of_errors(random_numbers(idx)); % this gives me an index of the words actually. 

no_of_errors; % is a 38x1 double. no_of_errors(1)  is ant. 

scores = struct;
scores.NbErrors = no_of_errors;
max(no_of_errors) % This would give me the maximum no of error of the word

max_error_inds = find(no_of_errors == max(no_of_errors)); %%% This will give me indices for the words that is wronged most.
%max_indices will contain the indices of all occurrences of the maximum value in the array A.
%
% then if i take the index values from this array, and use that to iterate in words list, it will provide me the word that is wronged most. 
error_vocab_list = {}; %% The column can be the session number. Figure out a way to implement this. 
session; % (this value comes from the exercise menu)

for idx_word = 1:length(max_error_inds)
    words{idx_word} = error_vocab; % The word that is wronged. 
    error_vocab_list{idx_word, session} = error_vocab; %%% The columns will be the sessions, the rows will be the words. THen you will print this. 
    disp(error_vocab_list{idx_word, session})
    Screen('FillRect', win, [4 124 172]);
    Str = convertCharsToStrings(error_vocab);
    DrawFormattedText(win, Str, 'center', 'center', [0 0 0], [], [], [],[],[], position);
    position = position + [0 25 0 25];
    Screen(win, 'Flip', [], 1);
end

% Example array with repeated values
A = no_of_errors;

% Find unique values and their indices
[unique_values, ~, idx] = unique(A);

% Find the maximum values
max_values = max(unique_values);

% Find the indices of the highest three unique values
highest_indices = find(idx == mode(idx, 1), 3);

% Get the corresponding values
highest_three = unique_values(highest_indices);


%ind = 1:38; 

%for ind = 1:38
%    no_of_errors(ind) = nb_error_vocab ;  
%end

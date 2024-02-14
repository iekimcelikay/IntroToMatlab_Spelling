

no_of_errors; % is a 38x1 double. no_of_errors(1)  is ant. 

scores = struct;
scores.NbErrors = no_of_errors;
A = no_of_errors;


all(A,2); %% This gives me a logical mask, so when I apply this to another vector with same size(10x1) I can get the values whioch are not equal to 0. 
%% Display the vocab items that was wrong. 
words_presented{all(A,2)}; %% This prints out the words that was errored using the logical mask above. 

vocab_errors_array = words_presented(all(A,2)); % Cell array of wronged words. 
num_errors = size(words_presented(all(A,2)),2); % that number of errored words for that session 

 
session; % (this value comes from the exercise menu)

for idx_word = 1:num_errors
    error_vocab = vocab_errors_array{idx_word};
    Str = convertCharsToStrings(error_vocab);
    %DrawFormattedText(win, Str, 'center', 'center', [0 0 0], [], [], [],[],[], position);
    %position = position + [0 25 0 25];
    %Screen(win, 'Flip', [], 1);
end


%ind = 1:38; 

%for ind = 1:38
%    no_of_errors(ind) = nb_error_vocab ;  
%end

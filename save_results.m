function [scores]=save_results(main_dir,num_sessions, words_presented, no_of_errors, T)
    % Currently this only works to save the table. 
    % INPUTS:
    % words_presented = array of words_presented that session. exercise_menu creates this. 
    % no_of_errors = 
    scores = [];
    temp = no_of_errors;
    all(temp,2); %% This will give me a logical mask filled with 1s and 0s.  1s for errors present. -> To learn which words are errored. 
    % If I sum up those 1s, then I get the number of total errors. (Each word error is counted as 1.) That can give me a score. 
    sum(all(temp,2)); %% Number of total errors in session. (Each word is counted once, trial number does not matter.)
    
    vocab_errors_array = words_presented(all(temp,2)); % Cell array of wronged words. 
    num_errors = size(words_presented(all(temp,2)),2); % that number of errored words for that session 
    scores(:,num_sessions) = temp;
    
    raw_scores = scores; 


    name = sprintf('session %d', num_sessions);
    % Save this to an external file
    disp(['session name:' name]);
    T.NewColumn = scores(:,num_sessions);
    T.Properties.VariableNames{end}=name;

    cd(main_dir);
    writetable(T, 'user_scores.xls'); 
    disp('table new scores written')
end
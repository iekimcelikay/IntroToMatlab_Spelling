function [num_sessions, no_of_errors, scores] = exercise_menu(x2, y2, win, words, main_dir,images_path,words_sound_path,letters_sound_path, session, deviceid, idx, table_fname)
%% EXERCISE MENU
% mainmenu: -> 'box3: exercise' clicked -> exercise menu. 
%================================================================
%---------------------------------------------------------------
%|                                                              |
%|                 ______________________                       |
%|               |                       |                      |
%|               |                       |                      |
%|               |         IMAGE         |                      |
%|               |                       |                      |
%|               |                       |                      | 
%|               |_______________________|                      |
%|                                                              |
%|                                                              |
%|                     "write the word"                         |
%|                ________________________                      |
%|               |      answer box       |                      |
%|               |   (show input here)   |                      |
%|               |_______________________|                      |
%|                                                              |
%|                                                              | 
%|______________________________________________________________|
%================================================================
%% Updates: 
% 10.02.2024: 
%------------
%   - Added return keypress after the word is finished.
%   - Added correct word & error message. 
%   - After 3 errors, it skips to the next word. 
%   - 
%
% 13.02.2024:
%------------
%   - Backspace won't work. 
%   - kk changed with idx. 
%   - x2 y2 - rounding implemented. (So you don't need to enter the coordinates everytime.)
%   - 38 changed with vocab_num = 38. So you can test it with less vocab words.
%%   - REMOVE THE SESSION COUNTER TO MAIN CODE BECAUSE IT NEEDS TO BE RESETTED THERE. 
%_________________________________________________________________________
%% Todo: 
%   [+] Return to main menu after all of the words are completed. (idx == 38 == vocab_num)
%   [+] Display this session's accuracy results. 
%   [+] Return to main menu 
 %
% https://colorswall.com/palette/14961 Color palette 
%
%% Design: 
%  Write the word when you see the image.
% 1. Randomly present the images 
% 2. Ask input from the user 
% 3. Show the input on the screen
% 4. Check if the input is correct
%.5. If correct, display 'correct' 
%.6. If incorrect, display 'incorrect'. 
% 7. Save correct and incorrect responses. 
% 8. After every image is practiced, give the accuracy results. 
%==============================================================
%%%%
%% CODE STARTS HERE
%---------------------

    % Pressing ESC will cause abrupt exit. Nothin will be saved
    % Unless the main app is exited, session number doesn't change however
    % the errors are still saved in the excel file. 

cd(main_dir);
% 2. Set the rectangles on the screen
    %             left, top, right, bottom
    image_rect = [520 100 740 340]; % Main image rectangle. Image to be shown in this.
    box1 = [420 430 840 510]; % Answer Box
    box2 = [420 350 840 400]; % Prompt text: Write the name of the object
    %box2 = ; % Exit button
    %box3 = ; % Return to menu button
    box4 = [0+round(x2*0.10) 0+round(y2*0.10) round(x2*0.90) round(y2*0.90)]; % to display the errrors.
    message_rect =[0+round(x2*0.25) 0+round(y2*0.15) round(x2*0.75) round(y2*0.85)];
    box5 = [0 + round(x2*0.70) 0+round(y2*0.90) round(x2*0.97) round(y2*0.97)]; %%% for the press any key to return to main menu text.
    
    %Variables & Arrays needed:
    vocab_num = size(words,2);
    random_numbers = randperm(vocab_num); %%% For exercise items to be shown randomly.
    no_of_errors =zeros(vocab_num,1);
    n_trial = 3; % Set up the trials per word you want. This doesn't change the score. 
    
    words_presented={};
    typedWord=[];
    T = readtable(table_fname);

    % Text messages:
    text1 = 'Type the correct vocabulary for this image, press ENTER after your answer. ';
    text2 = 'Correct!';
    Screen('FillRect', win, [99 159 176]);
    Screen('flip', win);
    
    %%
    %ListenChar(-1); % Enable or disable key presses in the editor or command window.
    while true
        %%% Showing the image on screen
        filename = fullfile([images_path, words{random_numbers(idx)}, '.jpg']);
        myImage = imread(filename);
        tex=Screen('MakeTexture', win, myImage);
        Screen('DrawTexture', win, tex, [], image_rect);
        Screen('FrameRect', win, [250 250 250], box1 , [2]);
        DrawFormattedText(win, text1, 'center' , 'center',[0 0 0], [], [], [], [], [], box2);
        Screen(win, 'Flip', [], 1);
    
        %%% Collecting the user input
    
        %%% Check against: (The word that is shown:)
        correctWord = words{random_numbers(idx)};
        words_presented{random_numbers(idx)} = correctWord;
    
        [keyTime, keyCode] = KbStrokeWait;
        keyPressed = KbName(keyCode);
        %typedWord = [typedWord keyPressed];
        if ~(strcmpi(keyPressed, 'BackSpace') || strcmpi(keyPressed, 'Space'))
            typedWord = [typedWord keyPressed]; %typedWord cannot contain these keys.
            letters = {};
            position = box1;
            for l=1:numel(typedWord)
                letter = typedWord(l);
                % Append the letter to this array.
                letters(l) = {letter};
                % Draw the formatted text
                Str = [letters{l}]; % This is if you want  to add something in between
                if ~(contains(typedWord, 'Return') || contains(typedWord, 'BackSpace'))
                    DrawFormattedText(win, Str, 'center', 'center', [0 0 0], [], [], [],[],[], position);
                    position = position + [15 0 15 0];
                    Screen(win, 'Flip', [], 1);
                end
            end
    
            if strcmpi(keyPressed, 'Return')
                typedWord = erase(typedWord, 'Return');
                if strcmpi(typedWord, correctWord)
                    Screen('FillRect', win, [121 176 99], message_rect);
                    DrawFormattedText(win, text2, 'center', 'center');
                    Screen('Flip',win);
                    pause(1.5);
                    idx=idx+1;
                    typedWord = [];
                else
                    no_of_errors(random_numbers(idx))=no_of_errors(random_numbers(idx))+1;
                    no_of_try = n_trial - no_of_errors(random_numbers(idx));
                    text3 = sprintf('You made a mistake.\n\n Trials left: %d', no_of_try);
    
                    Screen('FillRect', win, [176 99 121], message_rect);
                    DrawFormattedText(win, text3, 'center', 'center');
                    Screen('Flip',win);
                    pause(1.5);
                    typedWord = [];
                    if no_of_errors(random_numbers(idx)) == n_trial %%% no of errors actually gives me an index.
                        idx = idx+1;
                    end
                end
    
            elseif strcmpi(keyPressed, 'Escape')
                %A = no_of_errors;
                %vocab_errors_array = words_presented(all(A,2)); % Cell array of wronged words.
                %num_errors = size(words_presented(all(A,2)),2);
                %num_sessions = session;
                %scores{:,num_sessions} = no_of_errors;
                num_sessions = session;
                cd(main_dir);
                mainmenu(win,x2, y2, words, main_dir,images_path,words_sound_path,letters_sound_path, session, deviceid, table_fname)
                return
            end

            if idx > vocab_num
                % Increment the count for session.  Everytime exercise menu is
                % run count will incrase. 

                disp('scores saved');
                Screen('FillRect', win, [4 124 172]);
                text = 'You finished this session. Press a key to exit and see your errors in this session.';
                DrawFormattedText(win, text, 'center', 'center');
                Screen(win,'Flip');
                KbStrokeWait;

                session = session +1;
                disp(['Exercise session:  has been run ', num2str(session), ' times.']);
                num_sessions = session;
                global num_sessions;
                disp(['num sessions ', num2str(num_sessions)]);
                % Save scores
                [scores]=save_results(main_dir,num_sessions, words_presented, no_of_errors, T);

                Screen(win, 'Flip', [], 1);
                Screen('FillRect', win, [4 124 172]);

                A = no_of_errors;
                vocab_errors_array = words_presented(all(A,2)); % Cell array of wronged words.
                num_errors = size(words_presented(all(A,2)),2); % that number of errored words for that session

                pos = box4;
                title_pos = box4 - [0 30 0 30];
                 
                if any(no_of_errors) %%% At least one error. if any elements are non-zero. 
                    for idx_word = 1:num_errors  
                        error_vocab = vocab_errors_array{idx_word};
                        %Str = convertCharsToStrings(error_vocab);
                        results_text = sprintf('Errors in this session: \n\n');
                        DrawFormattedText(win, results_text, 'center', 'center', [0 0 0], [], [], [],[],[], title_pos);
                        DrawFormattedText(win, error_vocab, 'center', 'center', [0 0 0], [], [], [],[],[], pos);
                        pos = pos + [0 30 0 30];
                        DrawFormattedText(win, 'Press any key to return to main menu', 'center', 'center', [0 0 0], [], [], [],[],[], box5);
                        Screen(win, 'Flip', [], 1);
                    end
                else %%% No errors made. (all elements are zero)                 
                    results_text = sprintf('Congratulations! \n\n  Perfect score!!!');
                    DrawFormattedText(win, results_text, 'center', 'center', [0 0 0], [], [], [],[],[], title_pos);
                    DrawFormattedText(win, 'Press any key to return to main menu', 'center', 'center', [0 0 0], [], [], [],[],[], box5);
                    Screen(win, 'Flip', [], 1);
                end
                KbStrokeWait;
                cd(main_dir);
                disp('returning to main menu');
                disp(['num sessions: ' num2str(num_sessions)]);
                 
                mainmenu(win,x2, y2, words, main_dir,images_path,words_sound_path,letters_sound_path, num_sessions, deviceid, table_fname)
                disp('before return statement - return to main menu still'); %%% This only gets executed after pressing exit on main menu.
                return
            end
        else
            continue
        end
    end
end








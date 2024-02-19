%% 
% SET THE ROOTDIR 
% SET DEVICEID



clear all;
close all;
rootdir = 'C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\';
maindir_name = 'IntroToMatlab_Spelling';
images_pathname = [filesep 'images' filesep];
words_sound_pathname = [filesep 'words' filesep];
letters_sound_pathname = [filesep 'letters' filesep];

images_path = fullfile(rootdir, [maindir_name, images_pathname]);
words_sound_path = fullfile(rootdir, [maindir_name, words_sound_pathname]);
letters_sound_path = fullfile(rootdir, [maindir_name, letters_sound_pathname]);

%words list
words =  {'ant','axe','banana','bat','belt','brush','canary','cape','cat','cherry','dog','dress','duck','eagle','fox','goat','goose','hat','jacket','kiwi','koala','ladder','lemon','lion','mole','peach','pencil','penguin','pig','pumpkin','rabbit','sheep','shirt','skunk','swan','tiger','tomato','zebra'};

InitializePsychSound(1);
deviceid = 2; 

%%SET UP
Screen('Preference', 'VisualDebugLevel', 0);
Screen('Preference','SkipSyncTests',1);

%% This is the main directory that includes all the files. You need to return to the main dir. wwhen switching between functions. 
main_dir= fullfile(rootdir, [maindir_name]);
cd(main_dir); %% Return to main_dir when switching between functions. MATLAB suggests avoiding this but I couldn't find another way to switch between functions. 

%% COUNTER FOR SCRIPT RUN: INCREASING EVERYTIME THE SCRIPT IS RUN
% The file will be uploaded with 0. In case of ending the session abruptly,
% you need to set it back again MANUALLY. 
% File path to store the counter

counterFilePath = 'session_counter.txt';

% Check if counter file exists
if exist(counterFilePath, 'file')
    % Read the current count from the file
    fileID = fopen(counterFilePath, 'r');
    count = fscanf(fileID, '%d');
    fclose(fileID);
else
    % If the counter file doesn't exist, initialize count to 0
    count = 0;
end
% Increment the count
disp(['Script has been run ', num2str(count), ' times.']);
session = count;

%% create RESULTS TABLE
table_fname = 'user_scores.xls';
if count == 0
    T = cell2table(words'); %%% create table variable, Var1 = words 
    T.Properties.VariableNames{1} = 'Vocabulary'; 
    cd(main_dir);
    writetable(T, table_fname);
end

%%size and background colour of your screen
x2=1280;
y2=800;
size_of_main_window=[0 0 x2 y2];
bg_color=[99 159 176]; 
[win, mainScreen]=Screen('OpenWindow', 0, bg_color, size_of_main_window);

KbName('UnifyKeyNames');
Screen('TextSize', win, 18);
Screen('TextFont', win, 'Helvetica');


welcome_text = ['Welcome to spelling for English! \n Press enter to continue to main menu.'];

% 1. Opening Screen: Show welcome text, open mainmenu if enter is pressed. 

while true
     PTBdisplaytext(welcome_text, win);
     
     [~, keyCode]= KbStrokeWait;
     key_pressed=KbName(keyCode);
     
     if strcmp(key_pressed,'Return')
         break;
     end
 end
mainmenu(win,x2, y2, words, main_dir,images_path,words_sound_path,letters_sound_path, session, deviceid, table_fname)

%

%KbWait can also wait for releasing of keys instead of pressing of keys
%if you set the optional 2nd argument ‘forWhat’ to 1.

%If you want to wait for a single keystroke, set the ‘forWhat’ value to 2.
%KbWait will then first wait until all keys are released, then for the
%first keypress, then it will return. The above example could be realized
%via:

%KbWait([], 2);
%If you would set ‘forWhat’ to 3 then it would wait for releasing the key
%after pressing it againg, ie. waitForAllKeysReleased -> waitForKeypress
% 
% 
% -> waitForAllKeysReleased -> Return [secs, keyCode] of the key press.


% You ll typically use kbstrokewait for the input of a single character, or confirmation
% 'press any key to continue' like this. 


%% FUNCTIONS

%% MAIN MENU 
function mainmenu(win,x2, y2, words, main_dir,images_path,words_sound_path,letters_sound_path, session, deviceid, table_fname)
cd(main_dir)
% set the rectangles on the screen
rect1 = [0 125 1199 200];
rect2 = [150 400 450 475];
rect3= [750 400 1050 475];
rect4 = [0 + round(x2*0.85) 0+round(y2*0.90) round(x2*0.97) round(y2*0.97)];

% Buttons 
box1 = 'Welcome to English spelling trainer! Select the options below:';
box2 = 'Study';
box3 = 'Exercise';
box4 = 'Exit';

idx = 1; 
selection = strings;

    while true
        Screen('flip', win);
        %%% This is for getting mouse buttons. 
        %To programmatically exit the loop, use a break statement. To skip the rest of the instructions in the loop and begin the next iteration, use a continue statement.
        
        %% Draw rectangle frames for buttons with text. 
        Screen('FrameRect', win, [250 250 250], rect1 , [2]);
        Screen('FrameRect', win, [250 250 250], rect2 , [2]);
        Screen('FrameRect', win, [250 250 250], rect3, [2]);

        Screen('FrameRect', win, [250 250 250], rect4 , [2]);

        %% Write the button names
        DrawFormattedText(win, box1, 'center' , 'center',[0 0 0], [], [], [], [], [], rect1);
        DrawFormattedText(win, box2, 'center' , 'center',[0 0 0], [], [], [], [], [], rect2);
        DrawFormattedText(win, box3, 'center' , 'center',[0 0 0], [], [], [], [], [], rect3);
        DrawFormattedText(win, box4, 'center' , 'center',[0 0 0], [], [], [], [], [], rect4);
        %% To show buttons
        Screen(win, 'Flip', [], 1);
        
        [mouseX, mouseY, buttons] = GetMouse;
        %% Check which button is pressed 
        if buttons(1) ==1
            % Study Menu
            if mouseX>rect2(1) & mouseX<rect2(3) & mouseY>rect2(2) & mouseY<rect2(4)
                selection = 'Study Menu';
                disp(selection)
                %% Test if any mouse button is pressed.
                % if any(buttons)
                % fprintf(‘Someone’’s pressing a button.\n’);
                % end

                %while any(buttons) % if already down, wait for release
                % [x,y,buttons] = GetMouse;
                % end
                %% If any buttons is down, check again (so wait for buttons=0 again)
                while any(buttons)
                    [a,b,buttons] = GetMouse;
                end
                break;
%                 
            % Exercise Menu
            elseif mouseX > rect3(1) & mouseX<rect3(3) & mouseY>rect3(2) & mouseY<rect3(4)
                selection = 'Exercise Menu';
                disp(selection)
               while any(buttons)
                   [a,b,buttons] = GetMouse;
               end
               break;

            elseif mouseX > rect4(1) & mouseX<rect4(3) & mouseY>rect4(2) & mouseY<rect4(4)
                selection = 'Exit';
                while any(buttons)
                    [a,b,buttons] = GetMouse;
                end
                break;
            end % Inner if loop
        end %buttons if loop
    end %while loop
    cd(main_dir);
    switch selection
        case 'Study Menu'
            % Open window
            PTBdisplaytext('Opening the study menu', win);
            pause(1)
            PTBdisplaytext(['To change between words you need to use arrow keys. \n ' ...
                '\n Keys must be pressed twice.' ...
                'When you reach the last word, you can press ESC to return to the main menu.\n\n'
                'Press any key to continue. '], win)
            KbWait([], 3);
            studymenu(win,words,main_dir, images_path,words_sound_path,letters_sound_path,session, deviceid, table_fname, idx)

        case 'Exercise Menu'
            % Open window
            PTBdisplaytext('Opening the exercise menu', win);
            pause(1)
            PTBdisplaytext([...
                'Press any key to continue. \n \n Pressing ESC will abruptly quit and will not save your progress.\n\n'...
                'Space and Backspace does not work.\n \n'], win)
            KbWait([], 3);
            [num_sessions, no_of_errors, scores] = exercise_menu(x2, y2, win, words, main_dir, images_path,words_sound_path,letters_sound_path, session,deviceid, idx, table_fname);
            count = num_sessions;

            disp(['Script has been run ', num2str(count), ' times.']);
            counterFilePath = 'session_counter.txt';
             fileID = fopen(counterFilePath, 'w');
             fprintf(fileID, '%d', count);
             fclose(fileID);

        case 'Exit'
             % Session numberis get in the exercise script just in case if it exists. 
            % Write the updated count back to the file
            disp('exit pressed');


            disp('exiting screen')
            PTBdisplaytext('Exiting screen. Goodbye!', win)
            pause(1);
            KbCheck();
            sca;
            return
    end % switch selection
end

%% 2. STUDY MENU
function [] = studymenu(win,words,main_dir,images_path,words_sound_path,letters_sound_path,session, deviceid, table_fname, idx)
    cd(main_dir);
    


    % INSTRUCTIONS
    % Right and Left arrow keys are used for navigating between the 38 words.
    % There needs to be 2 keypresses. If you press the right arrow keys 2
    % times, you will go to the next word's page.
    % If you press ESC key, (2 times), you will quit the PTB window.

   
    %%%%%%%%%%%%%%%%%%%%%%%


    % set the rectangles on the screen
    image_rect = [520 100 740 340];
    rect1 = [220 400 420 450];
    rect2 = [220 600 420 650];
    rect3= [860 400 1060 450];
    rect4 = [860 600 1060 650];

    %Buttons for practice
    box1 = 'See the word';
    box2 = 'Listen the word';
    box3 = 'see the spelling';
    box4 = 'listen the spelling';


    keepRunning = true;

    countClick = 0;
    Screen('FillRect', win, [99 159 176]);
    Screen('flip', win);

    if idx>= 1 && idx<=38
        while keepRunning && idx <= 38
            [keyIsDown, ~, keyCode] = KbCheck;
            if keyIsDown
                [secs,   keyCode] = KbStrokeWait;
                keyPressed = KbName(keyCode);
                % Check if the 'Escape' key is pressed
                if strcmp(keyPressed, 'ESCAPE')
                    disp('Escape key pressed. Exiting the screen.');
                    %keepRunning = false;  % Set the flag to exit the loop
                    pause(0.5)
                    %%% How to go back to the main menu?
                    disp('return added here ')
                    cd(main_dir)
                    mainmenu(win,x2, y2, words, main_dir,images_path,words_sound_path,letters_sound_path, session, deviceid, table_fname);
                    return
                    
                elseif strcmp(keyPressed, 'LeftArrow') && idx > 1 
                    Screen(win,'flip')
                    idx = idx -1
                    continue
                elseif strcmp(keyPressed, 'RightArrow')   && idx < size(words,2)
                    Screen(win,'flip')
                    idx = idx+1
                    continue
                end
        
            end
            [mouseX, mouseY, buttons] = GetMouse;

            % Show the main image on the screen.
            filename=fullfile([images_path, words{idx}, '.jpg']);
            myImage = imread(filename);
            tex=Screen('MakeTexture', win, myImage);
            Screen('DrawTexture', win, tex, [], image_rect);


            % Draw rectangle frames for buttons with text.
            Screen('FrameRect', win, [250 250 250], rect1 , [2]);
            Screen('FrameRect', win, [250 250 250], rect2 , [2]);
            Screen('FrameRect', win, [250 250 250], rect3, [2]);
            Screen('FrameRect', win, [250 250 250], rect4 , [2]);
            DrawFormattedText(win, box1, 'center' , 'center',[0 0 0], [], [], [], [], [], rect1);
            DrawFormattedText(win, box2, 'center' , 'center',[0 0 0], [], [], [], [], [], rect2);
            DrawFormattedText(win, box3, 'center' , 'center',[0 0 0], [], [], [], [], [], rect3);
            DrawFormattedText(win, box4, 'center' , 'center',[0 0 0], [], [], [], [], [], rect4);

            Screen(win, 'Flip', [], 1);

            if buttons(1) ==1
                % Button 1: See the word
                if mouseX > rect1(1) & mouseX<rect1(3) & mouseY>rect1(2) & mouseY<rect1(4)
                    newStr = upper(words{idx});
                    DrawFormattedText(win, newStr, 'center' , 'center',[0 0 0], [], [], [], [], [], rect1+[0 50 0 50]);
                    Screen(win, 'Flip', [], 1);
                    countClick = countClick + 1;


                    % Button 2: Listen the word
                elseif mouseX > rect2(1) & mouseX<rect2(3) & mouseY>rect2(2) & mouseY<rect2(4)
                    % Loading the audio for word
                    audio_file = fullfile([words_sound_path, words{idx}, '.wav']);
                    [data, samplingRate]=audioread(audio_file);
                    pahandle = PsychPortAudio('Open', deviceid, [], [], samplingRate, 1);
                    PsychPortAudio('FillBuffer', pahandle, data');
                    pause(0.5);
                    PsychPortAudio('Start', pahandle);
                    countClick = countClick + 1;

                    % Button 3: See the spelling
                elseif  mouseX > rect3(1) & mouseX<rect3(3) & mouseY>rect3(2) & mouseY<rect3(4)
                    newStr = upper(words{idx});
                    letters = {};
                    position = rect3 + [0 50 0 50];
                    for l=1:numel(newStr)
                        letter = newStr(l);
                        % Append the letter to this array.
                        letters(l) = {letter};
                        % Draw the formatted text
                        Str = [letters{l} , '- '];
                        DrawFormattedText(win, Str, 'center', 'center', [0 0 0], [], [], [],[],[], position);
                        % Update the vertical position for the next string
                        position = position + [50 0 50 0];
                        Screen(win, 'Flip', [], 1);
                    end


                    %Button 4: Listen the spelling
                elseif mouseX > rect4(1) & mouseX<rect4(3) & mouseY>rect4(2) & mouseY<rect4(4)
                    % Loading the audio for letters (spelling listening)
                    newStr = upper(words{idx});
                    letters = {};
                    for l=1:numel(newStr)
                        letter = newStr(l);
                        % Append the letter to this array.
                        letters(l) = {letter};
                        letter_audio = fullfile([letters_sound_path, letters{l}, '.wav']);
                        [data, samplingRate]=audioread(letter_audio);
                        letters_pahandle{l} = PsychPortAudio('Open', deviceid, [], [], samplingRate,1);
                        PsychPortAudio('FillBuffer', letters_pahandle{l}, data');
                        pause(0.5);
                        PsychPortAudio('Start', letters_pahandle{l});
                    end

                end
                while buttons(1)==1
                    [mouseX, mouseY, buttons] = GetMouse(win);
                end
                if countClick == 250 %%% I had to add this so that code would stop at some point. Check if this is still necessary.
                    keepRunning = false;

                end
            end
        end
    end
end
%% 3. EXERCISE MENU
function [num_sessions, no_of_errors, scores] = exercise_menu(x2, y2, win, words, main_dir,images_path,words_sound_path,letters_sound_path, session, deviceid, idx, table_fname)
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

%% SAVE RESULTS
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
%% OTHER

function PTBdisplaytext(mytext,win)
    
    text = sprintf(mytext);
    Screen('FillRect', win, [99 159 176]);
    DrawFormattedText(win, text, 'center', 'center');
    Screen(win,'Flip');

end

     
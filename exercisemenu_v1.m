
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
%|  EXIT                                    return to main menu | 
%|______________________________________________________________|
%================================================================
%% Updates: 
% 10.02.2024: 
%------------
%   - Added return keypress after the word is finished.
%   - Added correct word & error message. 
%   - After 3 errors, it skips to the next word. 
%   - When idx=38, the loop stops. 
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
%%   - REMOVE THE SESSION COUNTER TO MAIN CODE BECASUE IT NEEDS TO BE RESETTED THERE.
%   - Exit button 
%   [+] Return to main menu after all of the words are completed. (idx == 38 == vocab_num)
%   - Display this session's accuracy results. ==> display_results.m 
%   - Return to main menu (button)
%   - Fix the paths when you have time.
%   - If you have time, try out the echoword function that you asked.  
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
clear all;
close all;
images_path = fullfile('C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\final_demo/images/');
words_sound_path = fullfile('C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\final_demo/words/');
letters_sound_path = fullfile('C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\final_demo/letters/');
main_dir = fullfile('C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\final_demo');
%words list
words =  {'ant','axe','banana','bat','belt','brush','canary','cape','cat','cherry','dog','dress','duck','eagle','fox','goat','goose','hat','jacket','kiwi','koala','ladder','lemon','lion','mole','peach','pencil','penguin','pig','pumpkin','rabbit','sheep','shirt','skunk','swan','tiger','tomato','zebra'};

my_devices = PsychPortAudio('GetDevices',[],[]);
deviceid= 2; %please set your speaker. 2 for computer if bluetooth is not connected.
InitializePsychSound(1);


Screen('Preference', 'VisualDebugLevel', 0);
Screen('Preference','SkipSyncTests',1);


session = 0;  %% !!!! This counter should be moved to main menu because it needs to be resetted there. 
%setting the screen

% 1. Setup the main screen -- this part should be moved to main function later. 
% x1= 0 y1= 0 for the main screen. 
x2=1280;
y2=800;
size_of_main_window=[0 0 x2 y2];
bg_color=[99 159 176];

[win, mainScreen]=Screen('OpenWindow', 0, bg_color, size_of_main_window);

%% PAGE DESIGN 

KbName('UnifyKeyNames');
Screen('TextSize', win, 24);
Screen('TextFont', win, 'Montserrat');
Screen('flip', win);
% 

% 2. Set the rectangles on the screen
%             left, top, right, bottom
image_rect = [520 100 740 340]; % Main image rectangle. Image to be shown in this. 
box1 = [420 430 840 510]; % Answer Box 
box2 = [420 350 840 400]; % Prompt text: Write the name of the object
%box2 = ; % Exit button
%box3 = ; % Return to menu button

% You can actually use percentages to calculate the coordinates. 
% [x1 y1 x2 y2] = [left, top, right, bottom] = 
% x1+x2 needs to be equal to 100. y1+y2 needs to be equal to 100. 
% x2 - x1 will give you the full width of screen. So x2 will always be the bigger value. 
% y2 - y1 will give you the full length of screen. So y2 will always be the bigger value. 
message_rect =[0+round(x_screen*0.25) 0+round(y_screen*0.15) round(x_screen*0.75) round(y_screen*0.85)];

vocab_num = 38;
random_numbers = randperm(vocab_num); %%% For exercise items to be shown randomly. 
no_of_errors =zeros(vocab_num,1);


idx =1;

%% Text messages:
text1 = 'Type the correct vocabulary for this image, press enter after your answer. ';
text2 = 'Correct!';
  


 
Screen('flip', win);


ListenChar(-1); % Enable or disable key presses in the editor or command window.
typedWord=[];
keepRunning = true;


while keepRunning
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

    [keyTime, keyCode] = KbStrokeWait;
    keyPressed = KbName(keyCode);
    if strcmpi(keyPressed, 'ESCAPE')
        disp('Escape key pressed. Exiting the screen.');
        keepRunning = false;  % Set the flag to exit the loop
        pause(0.5)
        sca;
        return
    elseif ~strcmpi(keyPressed, 'BackSpace') || ~strcmpi(keyPressed, 'Space')
        typedWord = [typedWord keyPressed]; % concatenate. You need this variable to check if the word is correctly written. Save this variable for user input. 
        letters = {};
        position = box1;    
        for l=1:numel(typedWord)
            letter = typedWord(l);
            % Append the letter to this array.
            letters(l) = {letter};
            % Draw the formatted text
            Str = [letters{l}]; % This is if you want  to add something in between
            if ~contains(typedWord, 'Return')
                DrawFormattedText(win, Str, 'center', 'center', [0 0 0], [], [], [],[],[], position);
                position = position + [15 0 15 0];
                Screen(win, 'Flip', [], 1);
            end
        end
        if  strcmpi(keyPressed, 'Return') 
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
                no_of_try = 5 - no_of_errors(random_numbers(idx));
                text3 = sprintf('You made a mistake.\n\n Trials left: %d', no_of_try); 

                Screen('FillRect', win, [176 99 121], message_rect);
                DrawFormattedText(win, text3, 'center', 'center');
                Screen('Flip',win);
                pause(1.5);
                typedWord = [];
                if no_of_errors(random_numbers(idx)) == 3 %%% no of errors actually gives me an index. 
                    idx = idx+1; 
                end 

            end
        end  
    end
    if idx > vocab_num
        session = session +1;
        Screen('FillRect', win, [4 124 172]);
        text = 'You finished this session. Press a key to exit this screen.';
        DrawFormattedText(win, text, 'center', 'center');
        Screen(win,'Flip');

        KbStrokeWait; 
        %%% This is counter for the exercise sessions. 
        sca;
        %% Display Results of this section 
        %display_results;
    end
end  

%ListenChar(0);






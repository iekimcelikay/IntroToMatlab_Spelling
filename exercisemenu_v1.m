
% EXERCISE MENU
%_--------------
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


%  Write the word when you see the image.
% 1. Randomly present the images 
% 2. Ask input from the user 
% 3. Show the input on the screen
% 4. Check if the input is correct
%. 5. If correct, display 'correct' 
%. 6. If incorrect, display 'incorrect' and the right word. 
% 7. Save correct and incorrect responses. 
% 8. After every image is practiced, give the accuracy results. 


% If box3 in mainmenu is clicked - EXERCISE
%% 1. Randomly present the images



%%%%
clear all;
close all;
images_path = fullfile('C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\final_demo/images/');
words_sound_path = fullfile('C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\final_demo/words/');
letters_sound_path = fullfile('C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\final_demo/letters/');
%words list
words =  {'ant','axe','banana','bat','belt','brush','canary','cape','cat','cherry','dog','dress','duck','eagle','fox','goat','goose','hat','jacket','kiwi','koala','ladder','lemon','lion','mole','peach','pencil','penguin','pig','pumpkin','rabbit','sheep','shirt','skunk','swan','tiger','tomato','zebra'};

my_devices = PsychPortAudio('GetDevices',[],[]);
deviceid= 2; %please set your speaker. 2 for computer if bluetooth is not connected.
InitializePsychSound(1);


Screen('Preference', 'VisualDebugLevel', 0);
Screen('Preference','SkipSyncTests',1);



%setting the screen

% 1. Setup the main screen -- this part should be moved to main function later. 

x_screen=1280;
y_screen=800;
size_of_main_window=[0 0 x_screen y_screen];
bg_colour=[195 68 122];

[win, mainScreen]=Screen('OpenWindow', 0, bg_colour, size_of_main_window);

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
box2 = [420 350 840 400]; %Write the name of the object
%box2 = ; % Exit button
%box3 = ; % Return to menu button

vocab_no = 38;
random_numbers = randperm(vocab_no); %%% For exercise items to be shown randomly. 
no_of_errors =zeros(vocab_no,1);


kk =1;

%% Text messages:
text1 = 'Type the correct vocabulary for this image, press enter after your answer. ';
text2 = 'Correct!';
  


 
Screen('flip', win);


ListenChar(-1); % Enable or disable key presses in the editor or command window.
typedWord=[];
keepRunning = true;

while keepRunning
    %%% Showing the image on screen
    filename = fullfile([images_path, words{random_numbers(kk)}, '.jpg']);
    myImage = imread(filename);
    tex=Screen('MakeTexture', win, myImage);
    Screen('DrawTexture', win, tex, [], image_rect);
    Screen('FrameRect', win, [250 250 250], box1 , [2]);
    DrawFormattedText(win, text1, 'center' , 'center',[0 0 0], [], [], [], [], [], box2);
    Screen(win, 'Flip', [], 1);

    %%% Collecting the user input 

    %%% Check against: (The word that is shown:)
    correctWord = words{random_numbers(kk)}; 

    [keyTime, keyCode] = KbStrokeWait;
    keyPressed = KbName(keyCode);
    if strcmpi(keyPressed, 'ESCAPE')
        disp('Escape key pressed. Exiting the screen.');
        keepRunning = false;  % Set the flag to exit the loop
        pause(0.5)
        sca;
        return
    else
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
                position = position + [12 0 12 0];
                Screen(win, 'Flip', [], 1);
            end
        end
        if  strcmpi(keyPressed, 'Return') 
            rect=[0+round(x_screen*0.34) 0+round(y_screen*0.25) round(x_screen*0.66) round(y_screen*0.75)];  %%% 435, 200, 845, 600
            typedWord = erase(typedWord, 'Return');
            if strcmpi(typedWord, correctWord)
                Screen('FillRect', win, [0 155 119], rect);
                DrawFormattedText(win, text2, 'center', 'center');
                Screen('Flip',win);
                pause(1.5);
                kk=kk+1;
                typedWord = [];
            else             
                no_of_errors(random_numbers(kk))=no_of_errors(random_numbers(kk))+1;
                no_of_try = 3 - no_of_errors(random_numbers(kk));
                text3 = sprintf('You made a mistake.\n\n Trials left: %d', no_of_try); 

                Screen('FillRect', win, [155 35 53], rect);
                DrawFormattedText(win, text3, 'center', 'center');
                Screen('Flip',win);
                pause(1.5);
                typedWord = [];
                if no_of_errors(random_numbers(kk)) == 3
                    kk = kk+1; 
                end 

            end
        end  
    end
    if kk == 38
        keepRunning = false;
    end
end  

ListenChar(0);

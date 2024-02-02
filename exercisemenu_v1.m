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
deviceid= 3; %please set your speaker. 1 for computer speaker, 2 for cable earphone, 3 for bluetooth earphone
InitializePsychSound(1);


Screen('Preference', 'VisualDebugLevel', 0);
Screen('Preference','SkipSyncTests',1);


x_screen=1280;
y_screen=800;
size_of_main_window=[0 0 x_screen y_screen];
bg_colour=[195 68 122];
KbName('UnifyKeyNames');

%setting the screen
[win, mainScreen]=Screen('OpenWindow', 0, bg_colour, size_of_main_window);

%% PAGE DESIGN 

KbName('UnifyKeyNames');
Screen('TextSize', win, 24);
Screen('TextFont', win, 'Montserrat');
Screen('flip', win);
% 

% 1. Setup the main screen -- this part should be moved to main function later. 

x_screen=1280;
y_screen=800;
size_of_main_window=[0 0 x_screen y_screen];
bg_colour=[195 68 122];

% 2. Set the rectangles on the screen
%             left, up, 
image_rect = [520 100 740 340]; % Main image rectangle. Image to be shown in this. 
box1 = [420 430 840 510]; % Answer Box 
box2 = [420 350 840 400]; %Write the name of the object
%box2 = ; % Exit button
%box3 = ; % Return to menu button

text1 = 'Type the correct vocabulary for this image';

 % Show the main image on the screen.
 random_numbers = randperm(38);
 kk =1;
 



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
    [keyTime, keyCode] = KbStrokeWait;
    keyPressed = KbName(keyCode);
    if strcmpi(keyPressed, 'Return')
        break
    elseif strcmpi(keyPressed, 'ESCAPE')
        disp('Escape key pressed. Exiting the screen.');
        keepRunning = false;  % Set the flag to exit the loop
        pause(0.5)
        sca;
        return
    else
        typedWord = [typedWord keyPressed]; % concatenate. You need this variable to check if the word is correctly written. 
        letters = {};
        position = box1;
        for l=1:numel(typedWord)
            letter = typedWord(l);
             % Append the letter to this array.
             letters(l) = {letter};
             % Draw the formatted text
             Str = [letters{l}]; % This is if you want  to add something in between
             DrawFormattedText(win, Str, 'center', 'center', [0 0 0], [], [], [],[],[], position);
             position = position + [12 0 12 0];
             Screen(win, 'Flip', [], 1);
        end  
    end  
end
ListenChar(0);

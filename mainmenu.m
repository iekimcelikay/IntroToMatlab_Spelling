%function [] = mainmenu(win)
%% Menu: Study or Exercise? 
% Welcome to English spelling trainer! Select if you want  to study or do
% the exercises! 
% . 

%      ____rect1_______________________________________________________________________
%     |Welcome to English spelling trainer! Select if you wannt to study or practice!  |             
%     |________________________________________________________________________________|
%    
%     _____rect2_____                                   _______rect3_______
%    |Study          |                                 |Exercise           |
%    |_______________|                                 |___________________| 
%
%     _____rect4_________                               ________rect5_____
%    |See previous scores|                              |Exit           |
%    |___________________|                              |______________|
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
rootdir = 'C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\';
maindir_name = 'IntroToMatlab_Spelling';
images_pathname = [filesep 'images' filesep];
words_sound_pathname = [filesep 'words' filesep];
letters_sound_pathname = [filesep 'letters' filesep];

images_path = fullfile(rootdir, [maindir_name, images_pathname]);
words_sound_path = fullfile('C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\final_demo/words/');
letters_sound_path = fullfile('C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\final_demo/letters/');
%words list
words =  {'ant','axe','banana','bat','belt','brush','canary','cape','cat','cherry','dog','dress','duck','eagle','fox','goat','goose','hat','jacket','kiwi','koala','ladder','lemon','lion','mole','peach','pencil','penguin','pig','pumpkin','rabbit','sheep','shirt','skunk','swan','tiger','tomato','zebra'};
InitializePsychSound(1);


%%SET UP
Screen('Preference', 'VisualDebugLevel', 0);
Screen('Preference','SkipSyncTests',1);

%%please set the main directory that includes all files
main_dir= fullfile("C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\IntroToMatlab_Spelling\");
cd(main_dir);
main_list=dir; %buna ne gerek var? 


%%size and background colour of your screen

x2=1280;
y2=800;
size_of_main_window=[0 0 x2 y2];
bg_color=[99 159 176];

[win, mainScreen]=Screen('OpenWindow', 0, bg_color, size_of_main_window);

KbName('UnifyKeyNames');
Screen('TextSize', win, 18);
Screen('TextFont', win, 'Helvetica');
Screen('flip', win);


% set the rectangles on the screen
rect1 = [0 125 1199 200];
rect2 = [150 400 450 475];
rect3= [750 400 1050 475];
rect4 = [150 600 450 675];
rect5 = [750 600 1050 675];

% Buttons 
box1 = 'Welcome to English spelling trainer! Select the options below:';
box2 = 'Study';
box3 = 'Exercise';
box4 = 'See past scores';
box5 = 'Exit';

noClickYet = true;
deviceid = 2; 
idx = 1; 
selection = strings;

    while true
        %%% This is for getting mouse buttons. 
        %To programmatically exit the loop, use a break statement. To skip the rest of the instructions in the loop and begin the next iteration, use a continue statement.
        
        %% Draw rectangle frames for buttons with text. 
        Screen('FrameRect', win, [250 250 250], rect1 , [2]);
        Screen('FrameRect', win, [250 250 250], rect2 , [2]);
        Screen('FrameRect', win, [250 250 250], rect3, [2]);
        Screen('FrameRect', win, [250 250 250], rect4 , [2]);
        Screen('FrameRect', win, [250 250 250], rect5 , [2]);

        %% Write the button names
        DrawFormattedText(win, box1, 'center' , 'center',[0 0 0], [], [], [], [], [], rect1);
        DrawFormattedText(win, box2, 'center' , 'center',[0 0 0], [], [], [], [], [], rect2);
        DrawFormattedText(win, box3, 'center' , 'center',[0 0 0], [], [], [], [], [], rect3);
        DrawFormattedText(win, box4, 'center' , 'center',[0 0 0], [], [], [], [], [], rect4);
        DrawFormattedText(win, box5, 'center' , 'center',[0 0 0], [], [], [], [], [], rect5);
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

            % See previous scores 
            elseif mouseX > rect4(1) & mouseX<rect4(3) & mouseY>rect4(2) & mouseY<rect4(4)
                selection = 'Past Scores';
                while any(buttons)
                    [a,b,buttons] = GetMouse;
                end
                break;

            elseif mouseX > rect5(1) & mouseX<rect5(3) & mouseY>rect5(2) & mouseY<rect5(4)
                selection = 'Exit';
                while any(buttons)
                    [a,b,buttons] = GetMouse;
                end
                break;
            end % Inner if loop
        end %buttons if loop
    end %while loop

    switch selection
        case 'Study Menu'
            PTBdisplaytext('Opening the study menu', win);
            pause(1)
            PTBdisplaytext(['To change between words you need to use arrow keys. \n ' ...
                '\n Keys must be pressed twice.' ...
                'When you reach the last word, you can press ESC to return to the main menu.\n\n' ...
                'Press any key to continue. '], win)
            KbWait([], 3);
            studymenu(win,words,images_path,words_sound_path,letters_sound_path,deviceid,idx)

        case 'Exercise Menu'
            %exercise_menu()
            disp('exercise')
        
        case 'Past Scores'
            %display_scores()
            disp('scores')

        case 'Exit'
            disp('exiting screen')
            PTBdisplaytext('Exiting screen. Goodbye!', win)
            pause(1);
            sca
            %return
    end % switch selection

    %Within each case block, you can include any number of statements, 
    % and when MATLAB encounters a *return* statement within a case block, 
    % it simply exits that block of code and continues evaluating subsequent cases 
    % (if any) or exits the switch statement entirely if no further cases are matched.

    %so if  I put return in one of the earlier cases, the rest of the cases
    %will not be evaluated. 
    
%%% FUNCTIONS


%% STUDY MENU
function [] = studymenu(win,words,images_path,words_sound_path,letters_sound_path,deviceid,idx)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% win = which PTB window this will work on
% x_screen = width of window
% y_screen = length of window
% main_filepath = the folder where all the files are.
% (ıntrotomatlab_spelling)
% deviceid = you should define your audio player. 1= main speaker 2= cable
% earphone 3=bluetooth earphone.

% INSTRUCTIONS
% Right and Left arrow keys are used for navigating between the 38 words.
% There needs to be 2 keypresses. If you press the right arrow keys 2
% times, you will go to the next word's page.
% If you press ESC key, (2 times), you will quit the PTB window.

%%% If ESC is pressed then you should return to the main menu. How to solve
%%% this?


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
                mainmenu;
                return
                
            elseif strcmp(keyPressed, 'LeftArrow') && idx > 1 
                Screen(win,'flip')
                idx = idx -1
                continue
            elseif strcmp(keyPressed, 'RightArrow')   && idx < 38
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
    % FOr some reason it doesn't reach here eeven when I allow idx to
    % become 39.
% elseif idx == 39
%     disp('idx became 39')
%     PTBdisplaytext('You have finished the study section. Press ESC to exit.', win);
%     [secs,   keyCode] = KbWait([], 3);
%     keyPressed = KbName(keyCode);
%      if strcmp(keyPressed, 'ESCAPE')
%         disp('Escape key pressed. Exiting the screen.');
%         mainmenu;
%         return
%      end
%              

end
end
    

%% OTHER 
function PTBdisplaytext(mytext,win)
    
text = sprintf(mytext);
Screen('FillRect', win, [99 159 176]);
DrawFormattedText(win, text, 'center', 'center');
Screen(win,'Flip');

end







%end

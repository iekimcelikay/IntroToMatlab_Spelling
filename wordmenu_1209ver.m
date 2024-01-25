clear all;
close all;
images_path = fullfile('C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\final_demo/images/');
words_sound_path = fullfile('C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\final_demo/words/');
letters_sound_path = fullfile('C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\final_demo/letters/')
%words list
words =  {'ant','axe','banana','bat','belt','brush','canary','cape','cat','cherry','dog','dress','duck','eagle','fox','goat','goose','hat','jacket','kiwi','koala','ladder','lemon','lion','mole','peach','pencil','penguin','pig','pumpkin','rabbit','sheep','shirt','skunk','swan','tiger','tomato','zebra'};

my_devices = PsychPortAudio('GetDevices',[],[]);
deviceid= 2; %please set your speaker. 1 for computer speaker, 2 for cable earphone, 3 for bluetooth earphone
InitializePsychSound(1);


Screen('Preference', 'VisualDebugLevel', 0);
Screen('Preference','SkipSyncTests',1);

%Set the size of the MAIN MAIN screen.

x_screen=1280;
y_screen=800;
size_of_main_window=[0 0 x_screen y_screen];
bg_colour=[195 68 122];

%setting the MAIN screen.
[win, mainScreen]=Screen('OpenWindow', 0, bg_colour, size_of_main_window);
Screen('TextSize', win, 18);
Screen('TextFont', win, 'Kristen ITC');
Screen('flip', win);

% set the rectangles on the screen
image_rect = [520 100 740 340];
rect1 = [220 400 420 450];
rect2 = [220 600 420 650];
rect3= [860 400 1060 450];
rect4 = [860 600 1060 650];
% Buttons for practice
box1 = 'See the word';
box2 = 'Listen the word';
box3 = 'see the spelling';
box4 = 'listen the spelling';

i = 1;
while 1==1

    % Show the main image on the screen.
    filename=fullfile([images_path, words{i}, '.jpg']);
    myImage = imread(filename);
    tex=Screen('MakeTexture', win, myImage);
    Screen('DrawTexture', win, tex, [], image_rect);


    % Loading the audio for word
    audio_file = fullfile([words_sound_path, words{i}, '.wav']);
    [data, samplingRate]=audioread(audio_file);
    pahandle = PsychPortAudio('Open', deviceid, [], [], samplingRate,1);
    PsychPortAudio('FillBuffer', pahandle, data');

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





mouseCount = 0;
    while mouseCount<5
        [mouseX, mouseY, buttons] = GetMouse;
        
        if buttons(1) ==1
            % Button 1: See the word
            if mouseX > rect1(1) & mouseX<rect1(3) & mouseY>rect1(2) & mouseY<rect1(4)
                newStr = upper(words{i});
                Screen('TextSize', win, 42);
                DrawFormattedText(win, newStr, 'center' , 'center',[0 0 0], [], [], [], [], [], rect1+[0 50 0 50]);
                Screen(win, 'Flip', [], 1);
                mouseCount = mouseCount +1;

                % Button 2: Listen the word
            elseif mouseX > rect2(1) & mouseX<rect2(3) & mouseY>rect2(2) & mouseY<rect2(4)
                pause(0.5); % I put this to prevent crashing
                PsychPortAudio('Start', pahandle);
                mouseCount = mouseCount +1;

                % Button 3: See the spelling
            elseif  mouseX > rect3(1) & mouseX<rect3(3) & mouseY>rect3(2) & mouseY<rect3(4)
                newStr = upper(words{i});
                Screen('TextSize', win, 42);
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
                mouseCount = mouseCount +1;

                %Button 4: Listen the spelling
            elseif mouseX > rect4(1) & mouseX<rect4(3) & mouseY>rect4(2) & mouseY<rect4(4)
                % Loading the audio for letters (spelling listening)
                newStr = upper(words{i});
                letters = {};
                for l=1:numel(newStr)
                    letter = newStr(l);
                    % Append the letter to this array.
                    letters(l) = {letter};
                    letter_audio = fullfile([letters_sound_path, letters{l}, '.wav']);
                    [data, samplingRate]=audioread(letter_audio);
                    letters_pahandle{l} = PsychPortAudio('Open', deviceid, [], [], samplingRate,1);
                    PsychPortAudio('FillBuffer', letters_pahandle{l}, data');
                    pause(0.5); % I put this to prevent crashing
                    PsychPortAudio('Start', letters_pahandle{l});
                end
                mouseCount = mouseCount +1;

            end

        end
    end



    % Wait for a key press
    [~, keyCode]= KbStrokeWait;
    key_pressed=KbName(keyCode);

    % Check for arrow key presses
    if keyCode(KbName('left')) && i>=1
        % Go to the previous page
        i= i-1;
    elseif keyCode(KbName('right')) && i<38
        % Go to the next page
        i= i+1;
    elseif keyCode(KbName('esc'))
        % Exit the loop if the Escape key is pressed
        break;
    end
end


% if i make the spelled letters and word itself not clickable but visible
% on the screen, i will save some clicks. I can jjust increase the number
% but this will also solve the problem of remaining letters in the screen.



% 



% Close the Psychtoolbox windows

%%
function [] = studymenu(win,words,images_path,words_sound_path,letters_sound_path,deviceid)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% win = which PTB window this will work on
% x_screen = width of window
% y_screen = length of window
% main_filepath = the folder where all the files are.
% (ıntrotomatlab_spelling)
% deviceid = you should define your audio player. 1= main speaker 2= cable
% earphone 3=bluetooth earphone.

Screen('TextSize', win, 18);
Screen('TextFont', win, 'Kristen ITC');
Screen('flip', win);

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


while kk>= 1 && kk<=38

    % Show the main image on the screen.
    filename=fullfile([images_path, words{kk}, '.jpg']);
    myImage = imread(filename);
    tex=Screen('MakeTexture', win, myImage);
    Screen('DrawTexture', win, tex, [], image_rect);


    % Loading the audio for word
    audio_file = fullfile([words_sound_path, words{kk}, '.wav']);
    [data, samplingRate]=audioread(audio_file);
    pahandle = PsychPortAudio('Open', deviceid, [], [], samplingRate,1);
    PsychPortAudio('FillBuffer', pahandle, data');

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
    noClick = true;
    while noClick
        [mouseX, mouseY, buttons] = GetMouse;

        if buttons(1) ==1
            % Button 1: See the word
            if mouseX > rect1(1) & mouseX<rect1(3) & mouseY>rect1(2) & mouseY<rect1(4)
                newStr = upper(words{kk});
                Screen('TextSize', win, 42);
                DrawFormattedText(win, newStr, 'center' , 'center',[0 0 0], [], [], [], [], [], rect1+[0 50 0 50]);
                Screen(win, 'Flip', [], 1);

                % Button 2: Listen the word
            elseif mouseX > rect2(1) & mouseX<rect2(3) & mouseY>rect2(2) & mouseY<rect2(4)
                pause(0.5); % I put this to prevent crashing
                PsychPortAudio('Start', pahandle);

                % Button 3: See the spelling
            elseif  mouseX > rect3(1) & mouseX<rect3(3) & mouseY>rect3(2) & mouseY<rect3(4)
                newStr = upper(words{kk});
                Screen('TextSize', win, 42);
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
                newStr = upper(words{kk});
                letters = {};
                for l=1:numel(newStr)
                    letter = newStr(l);
                    % Append the letter to this array.
                    letters(l) = {letter};
                    letter_audio = fullfile([letters_sound_path, letters{l}, '.wav']);
                    [data, samplingRate]=audioread(letter_audio);
                    letters_pahandle{l} = PsychPortAudio('Open', deviceid, [], [], samplingRate,1);
                    PsychPortAudio('FillBuffer', letters_pahandle{l}, data');
                    pause(0.5); % I put this to prevent crashing
                    PsychPortAudio('Start', letters_pahandle{l});
                end

            end

        end
        [~, ~, keyCode] = KbCheck;
        if ~isempty(keyCode)
            noClick = false;
        end

    end
end
end





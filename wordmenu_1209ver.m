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


% Create an array of 38 windows, one window per word.

pageWindows = cell(38, 1);
for i = 1:38
    % Buraya yani pageWindows{i} diye tanımladığım variable'ın satırına
    % açtığım pencere here şeyi barındırıyor.

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

    %
    pageWindows{i} = Screen('OpenOffscreenWindow', win, bg_colour, size_of_main_window);
    % Show the main image on the screen.
    filename=fullfile([images_path, words{i}, '.jpg']);
    myImage = imread(filename);
    tex=Screen('MakeTexture', win, myImage);
    Screen('DrawTexture', pageWindows{i}, tex, [], image_rect);

    % Loading the audio for word
    audio_file = fullfile([words_sound_path, words{i}, '.wav']);
    [data, samplingRate]=audioread(audio_file);
    pahandle = PsychPortAudio('Open', deviceid, [], [], samplingRate,1);
    PsychPortAudio('FillBuffer', pahandle, data');

    % Draw rectangle frames for buttons with text.
    Screen('FrameRect', pageWindows{i}, [250 250 250], rect1 , [2]);
    Screen('FrameRect', pageWindows{i}, [250 250 250], rect2 , [2]);
    Screen('FrameRect', pageWindows{i}, [250 250 250], rect3, [2]);
    Screen('FrameRect', pageWindows{i}, [250 250 250], rect4 , [2]);
    DrawFormattedText(pageWindows{i}, box1, 'center' , 'center',[0 0 0], [], [], [], [], [], rect1);
    DrawFormattedText(pageWindows{i}, box2, 'center' , 'center',[0 0 0], [], [], [], [], [], rect2);
    DrawFormattedText(pageWindows{i}, box3, 'center' , 'center',[0 0 0], [], [], [], [], [], rect3);
    DrawFormattedText(pageWindows{i}, box4, 'center' , 'center',[0 0 0], [], [], [], [], [], rect4);
end

currentPage = 1;


while true
    % Display the current page
    Screen('CopyWindow', pageWindows{currentPage}, win);
    Screen('Flip', win);

    % Wait for a key press
    [~, keyCode]= KbStrokeWait;
    key_pressed=KbName(keyCode);

    % Check for arrow key presses
    if keyCode(KbName('left'))
        % Go to the previous page
        currentPage = max(1, currentPage - 1);
    elseif keyCode(KbName('right'))
        % Go to the next page
        currentPage = min(38, currentPage + 1);
    elseif keyCode(KbName('esc'))
        % Exit the loop if the Escape key is pressed
        break;
    end
end

% Close the Psychtoolbox windows
for i = 1:38
    Screen('Close', pageWindows{i});
end
sca;


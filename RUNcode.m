
%% **********************plan*********************************************************************************
% 4 tane dikdörtgene ihtiyacım var.
% Rectangle 1: See the word
% Rectangle 2: Listen the word
% Rectangle 3: See the spelling
% Rect 4: Listen the spelling
%      ____rect1____               ______rect3_____
%     |see the word |             |see the spelling|
%     |_____________|             |________________|
%    
%     _____rect2_____             _______rect4_______
%    |listen the word|           |listen the spelling|
%    |_______________|           |___________________| 
% ************************************************************************************************************

% function wordmenu_options(win, x_screen, y_screen, images_path, words_sound_path, deviceid, my_device_right_click)
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
mainmenu(win)


% kk=1;
%      studymenu(win,words,images_path,words_sound_path,letters_sound_path,deviceid,kk);
%





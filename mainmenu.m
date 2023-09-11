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

%%SET UP
Screen('Preference', 'VisualDebugLevel', 0);
Screen('Preference','SkipSyncTests',1);

%%please set the main directory that includes all files
main_dir= fullfile("C:\Users\iekim\Documents\College\UniTrento_CimEC\Fall_2022_23\IntroductiontoComputerProgramming_Matlab_FAIRHALL\MATLAB\IntroToMatlab_Spelling\");
cd(main_dir);
main_list=dir; %buna ne gerek var? 


%%size and background colour of your screen
x_screen=1200;
y_screen=800;
size_of_main_window=[0 0 x_screen y_screen];
bg_colour=[195 68 122];

%size and font of your text
text_font='Futura';
text_size=round(x_screen*0.03);
text_colour=[255 255 255];

%cursor size and colour
cursor_colour=[0 0 0];
cursor_size=10;
my_device_right_click=3; %please set your right click

%setting the screen
[win, mainScreen]=Screen('OpenWindow', 0, bg_colour, size_of_main_window);
Screen('TextSize', win, text_size);
Screen('TextFont', win, text_font);
Screen('flip', win);

%Screen center constants
screenCntrX = mainScreen(3)/2;
screenCntrY = mainScreen(4)/2;

% set the rectangles on the screen
rect1 = [0 125 1199 200];
rect2 = [150 400 450 475];
rect3= [750 400 1050 475];
rect4 = [150 600 450 675];
rect5 = [750 600 1050 675];

% Buttons 
box1 = 'Welcome to spelling trainer!';
box2 = 'Study';
box3 = 'Exercise';
box4 = 'See past scores';
box5 = 'Exit';


% Draw rectangle frames for buttons with text. 
Screen('FrameRect', win, [250 250 250], rect1 , [2]);
Screen('FrameRect', win, [250 250 250], rect2 , [2]);
Screen('FrameRect', win, [250 250 250], rect3, [2]);
Screen('FrameRect', win, [250 250 250], rect4 , [2]);
Screen('FrameRect', win, [250 250 250], rect5 , [2]);

% Write the button names. 
DrawFormattedText(win, box1, 'center' , 'center',[0 0 0], [], [], [], [], [], rect1);
DrawFormattedText(win, box2, 'center' , 'center',[0 0 0], [], [], [], [], [], rect2);
DrawFormattedText(win, box3, 'center' , 'center',[0 0 0], [], [], [], [], [], rect3);
DrawFormattedText(win, box4, 'center' , 'center',[0 0 0], [], [], [], [], [], rect4);
DrawFormattedText(win, box5, 'center' , 'center',[0 0 0], [], [], [], [], [], rect5);

Screen(win, 'Flip', [], 1);



function mainmenu(win,x2, y2, words, main_dir,images_path,words_sound_path,letters_sound_path, session, deviceid, table_fname)
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
                    'When you reach the last word, you can press ESC to return to the main menu.\n\n' ...
                    'Press any key to continue. '], win)
                KbWait([], 3);
                studymenu(win,words,main_dir, images_path,words_sound_path,letters_sound_path,session, deviceid, table_fname, idx)
    
            case 'Exercise Menu'
                % Open window
                PTBdisplaytext('Opening the exercise menu', win);
                pause(1)
                PTBdisplaytext([...
                    'Press any key to continue. \n \n Pressing ESC will abruptly quit and will not save your progress.'], win)
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
    



%end

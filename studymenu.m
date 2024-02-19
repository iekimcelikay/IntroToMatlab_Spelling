
function [] = studymenu(win,words,main_dir,images_path,words_sound_path,letters_sound_path,session, deviceid, table_fname, idx)
    
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


%%%%%%%%%%%%%%%%%%%%%%%

    % INSTRUCTIONS
    % Right and Left arrow keys are used for navigating between the 38 words.
    % There needs to be 2 keypresses. If you press the right arrow keys 2
    % times, you will go to the next word's page.
    % If you press ESC key, (2 times), you will quit the PTB window.

    %%%%%%%%%%%%%%%%%%%%%%%
    cd(main_dir);

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

    if idx>= 1 && idx<= size(words,2)
        while keepRunning && idx <= size(words,2)
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
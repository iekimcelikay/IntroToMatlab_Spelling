
function typedWord = PTBTypedWord(win);
typedWord = [];
while true
    [keyTime, keyCode] = KbStrokeWait;
    keyPressed = KbName(keyCode);
    if strcmp(keyPressed, 'return')
        break
    end
    typedWord = [typedWord keyPressed];
    DrawFormattedText(win, typedWord, 'center', 'center');
    Screen('flip', win);
end


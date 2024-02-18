function PTBdisplaytext(mytext,win)
    
text = sprintf(mytext);
Screen('FillRect', win, [99 159 176]);
DrawFormattedText(win, text, 'center', 'center');
Screen(win,'Flip');

end
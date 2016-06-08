function fnImageKeyDown ( objectHandle , eventData )

    global b_edit;
    global i_key_state;
    disp(' key down')
    %% If not on edit, exit out
    if(b_edit == false)
        return
    end
    
    %% Get-key state
    if(i_key_state ~= 0)
        return
    end
    
    if(i_key_state == 0)
        i_key_state = 1;
        return
    end


end
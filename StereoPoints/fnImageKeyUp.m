function fnImageKeyUp ( objectHandle , eventData )

    global b_edit;
    global i_key_state;
    
    global i_operation;
    global b_state_change;
    disp(' key up')

    %% If not on edit, exit out
    if(b_edit == false)
        return
    end
    
    %% Get-key state
    if(i_key_state ~= 1)
        return
    end
    
    if(i_key_state == 1)
        
        if(strcmpi(eventData.Key,'b'))
            %% Tell it to exit
            i_operation = 0;
            b_state_change = true;
            disp('   *** Returning to Previous Menu *** ');
        end
        if(strcmpi(eventData.Key,'i'))
            if(i_operation ~= 1)
                i_operation = 1;
                b_state_change = true;
                disp('   *** Switching to Insert *** ');                
            end
        end
        if(strcmpi(eventData.Key,'d'))
            if(i_operation ~= 2)                
                i_operation = 2;
                b_state_change = true;
                disp('   *** Switching to Delete *** ');
            end
        end
        
        i_key_state = 2;
        return
    end

end
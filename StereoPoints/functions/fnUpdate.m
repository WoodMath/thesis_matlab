function [  ] = fnUpdate( fig_source, fig_dest )
%fnUpdate updates both fig_source and fig_dest
%   Detailed explanation goes here

        sfigure(fig_dest);
        drawnow;
        
        sfigure(fig_source);
        drawnow;
        



end


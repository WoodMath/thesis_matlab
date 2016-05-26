clear

i_dir = 3;
i_prefix = 8;
i_ext = 3;
i_source = 5;
i_dest = 1;


%% Directory option (i_dir)
s_dir = { ...
    'original', ...             %   i_dir = 1
    'images', ...               %   i_dir = 2
    'tsukuba', ...              %   i_dir = 3
    'ohta' ...                  %   i_dir = 4
    };

%% Prefeix opion (i_prefix)
s_prefix = { ...
    '2viewfigs-base', ...       %   i_prefix = 1
    '2viewfigs-china', ...      %   i_prefix = 2
    '2viewfigs-raw', ...        %   i_prefix = 3
    '2viewfigs-v2.', ...        %   i_prefix = 4
    '3viewfigs-base.00', ...    %   i_prefix = 5
    'Nviewfigs-base.00', ...    %   i_prefix = 6
    'estimationfigs-raw', ...   %   i_prefix = 7
    'scene1.row3.col', ...      %   i_prefix = 8
};

%% Extension Option (i_ext)
s_ext = { ...
    '.bmp', ...                 %   i_ext = 1
    '.png', ...                 %   i_ext = 2
    '.ppm' ...                  %   i_ext = 3
    };

s_source = ['./', s_dir{i_dir}, '/', s_prefix{i_prefix}, num2str(i_source), s_ext{i_ext}];
s_dest = ['./', s_dir{i_dir}, '/', s_prefix{i_prefix}, num2str(i_dest), s_ext{i_ext}];

im_source = imread(s_source);
im_dest = imread(s_dest);

% im_source = rgb2gray(imread(s_source));
% im_dest = rgb2gray(imread(s_dest));


disp(s_source)
disp(s_dest)


fig_source = sfigure(i_source);
% set(fig_source,'WindowStyle','modal');
imshow(im_source);
axis ij;

fig_dest = sfigure(i_dest);
% set(fig_dest,'WindowStyle','modal');
imshow(im_dest);
axis ij;

s_input = '';
% while(~strcmpi(s_input,'e'))  
%     hold on
%     s_prompt = ' Make selection: (N)ew, (D)elete, (E)end, or (S)kip : ';
%     s_input = input(s_prompt,'s');
%     if isempty(s_input)
%         s_input = 'e';
%     end
%     if(strcmpi(s_input,'n'))
%         [source,dest]= fnMovePoint(fig_source, fig_dest);
%     end
% end

[source,dest] = fnMovePoint(fig_source, fig_dest)


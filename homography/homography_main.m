function main = homography_main()
    % points in skewed picture to use for mapping
    % each column is a vector representing the x/y coordinates of a point
    %   in the skewed picture
    % row 1 is the x-values
    % row 2 is the y-values
    points_skewed = [0   0 50 50; 
                     0 100 75 25 ]; 

    % points in corrected picture to use for mapping
    % each column is a vector representing the x/y coordinates of a point
    %   in the corrected picture
    % row 1 is the x-values
    % row 2 is the y-values
    points_corrected = [0   0 200 200; 
                        0 100 100   0 ];

    % each column is the set of x/y coordinates of a point that should be corrected
    test_points = [42.8571, 38.4615, 33.3333, 27.2727, 20, 11.1111, 20, 27.2727, 33.3333, 38.4615, 42.8571, 46.6667, 42.8571;
                   50,      65.3846, 66.6667, 68.1818, 50, 27.7778, 30, 31.8182, 33.3333, 34.6154, 35.7143, 36.6667, 50;
                    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
      
    [H, projected] = homography_student(points_skewed, points_corrected, test_points);
    fprintf('part a: H matrix\n')
    disp(H)
    fprintf('part b: projected test points\n')
    disp(projected)
end

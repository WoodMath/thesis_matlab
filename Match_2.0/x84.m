function inliers =  x84(res, n)
% n e' il numero minimo di inliers che ritorna

location = median(res);
scale = 5.2 * median(abs(res-location));
inliers = (find(res<scale));

if length(inliers) < n
    % ritorna i primi n
    [y i] = sort(res);
    inliers = i(1:n);
    inliers =  sort(inliers);
end
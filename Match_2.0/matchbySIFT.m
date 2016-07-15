function [M, model, ml, mr] = matchbySIFT(im1,im2)
% Match two images im1 and im2 using SIFT. Inliers are discovered using
% RANSAC. Both homography and fundamental models are tried. The best model is
% selected via GRIC. The winning model matrix M and the inliers are
% returned.
% 'M' is a 3x3 matrix
% 'ml, mr' are two arrays containing the matching points
% 'model' is a variable that indicates whether M is a fundamental matrix
% (model = 3) or a homography (model = 2)

% See the README for credits and dependencies

t = .002;   % consensus threshold for ransac
sigma = 0.8; % measures std dev, used by gric
verbose = 0;

I1=imreadbw(im1) ;
I2=imreadbw(im2) ;
I1=I1-min(I1(:)) ;
I1=I1/max(I1(:)) ;
I2=I2-min(I2(:)) ;
I2=I2/max(I2(:)) ;
fprintf('Computing frames and descriptors.\n') ;
[frames1,descr1,gss1,dogss1] = sift( I1, 'Verbosity', verbose ) ;
[frames2,descr2,gss2,dogss2] = sift( I2, 'Verbosity', verbose ) ;
descr1=uint8(512*descr1) ;
descr2=uint8(512*descr2) ;
matches=siftmatch( descr1, descr2 ) ;
x1 = frames1(1:2,matches(1,:));
x2 = frames2(1:2,matches(2,:));

% this is for debugging only
save('sift_match','x1','x2');
load sift_match

m1 = [x1(1,:); x1(2,:); ones(1,length(x1))];
m2 = [x2(1,:); x2(2,:); ones(1,length(x1))];

% Try fundamental -------------------------
[F, inliers_f] = ransacfitfundmatrix7(m1, m2, t, verbose);

% Optimal fit to inliers
[F,res] = F_from_x_nonlin(F,m1(:,inliers_f),m2(:,inliers_f));
fprintf('F fitting residual RMS (after RANSAC): %0.5g pixel\n',mean(res));
% res contains distances (not squared)

% X84 to eliminate m1smatches
in_x84 = x84(res, 7);
inliers_f = inliers_f(in_x84);

% compute F with minimization of sampson distance
[F,res] = F_from_x_nonlin(F,m1(:,inliers_f),m2(:,inliers_f));
fprintf('F fitting residual RMS (after x84): %0.5g pixel\n',mean(res));

% gric wants the squared residuals wrt ALL the point, including outliers 
resf = F_sampson_distance_sqr(F,m1(:,:),m2(:,:));
fprintf('F fitting residual RMS (ALL points): %0.5g pixel\n',mean(sqrt(resf)));
gF = gric(resf, sigma, length(m1),'fundamental');
fprintf('F GRIC: %0.5g\n',gF);


% Try homography ----------------------
[H, inliers_h] = ransacfithomography(m1, m2, t, verbose);

% Optimal fit to inliers
[H,res] = vgg_H_from_x_nonlin(H,m1(:,inliers_h), m2(:,inliers_h));
fprintf('H fitting residual RMS (after RANSAC): %0.5g pixel\n',mean(res));
% res contains distances (not squared)

% X84 to eliminate m1smatches
in_x84 = x84(res, 4);
inliers_h = inliers_h(in_x84);

% compute H with minimization of sampson distance
[H,res] = vgg_H_from_x_nonlin(H,m1(:,inliers_h), m2(:,inliers_h));
fprintf('H fitting residual RMS (after x84): %0.5g pixel\n',mean(res));

% gric wants the squared residuals wrt ALL the point, including outliers 
resh = vgg_H_sampson_distance_sqr(H,m1(:,:),m2(:,:));
fprintf('H fitting residual RMS (ALL points): %0.5g pixel\n',mean(sqrt(resh)));
gH = gric(resh, sigma, length(m1),'homography');
fprintf('H GRIC: %0.5g\n',gH);
%

if gF < gH
    inliers = inliers_f;
    M = F;
    model = 3;
    disp('model: fundamental')
else
    inliers = inliers_h;
    M = H;
    model = 2;
    disp('model: homography')
end

% take only a subsample of the matches
% Comment if you want all the matches
i = randperm(length(inliers));
i = i(1: min(150,length(i)));

% save the matches
ml = m1(:,inliers(i)); mr = m2(:,inliers(i));
save('good_pairs','ml','mr');

figure(10) ; clf ;
plotmatches(I1,I2,ml,mr,[1:length(ml); 1:length(mr)]) ;
drawnow ;


clear all; clc;
load('faces.mat');
faces = double(faces)/255;
train = faces(:,1:360);
row = 56, col = 46;

% Loading my own image
alatimgs = [];
for i=1:1:9
    alatimg = imresize(rgb2gray(imread(sprintf('images/aimg%01d.jpeg',i))),[row col]);
    alatimg = reshape(alatimg, [], 1);
    alatimgs = [alatimgs alatimg];
end

testalat = imresize(rgb2gray(imread('images/aimg101.jpeg')),[row col]);
testalat = double(reshape(testalat, [], 1))/255;
alatimgs = double(alatimgs)/255;

flower = imresize(rgb2gray(imread('images/flower.jpg')),[row col]);
flower = double(reshape(flower, [], 1))/255;

train = [train alatimgs];
trainsize = 369;
xbar = mean(train')';
A = train - xbar;

xrec = testalat; % My test face
%xrec = flower; % Test face for not a face
%xrec = faces(:,362); % Test face from faces dataset
testx = xrec; % Test Face for Recognition

K = 100;
[V D] = eigs(A'*A,K); % Returns K largest eigenvalues
newV = (A*V)/(norm(A*V));
diffx = xrec - xbar;
faceX = 0;
database = [];

normav = norm(A*V);
% Face Reconstruction
eigfaces = [];
for i=1:1:K
    smalla = dot(diffx, newV(:,i));
    av = (smalla * newV(:,i));
    faceX = faceX + av;
    if i<=12
        eigfaces = [eigfaces av];
    end
end

faceX = faceX + xbar;

% Printing out 12 eigenfaces
eigfacesimgs = [];
for i=1:1:12
eigfacesimgs = [eigfacesimgs double(reshape(eigfaces(:,i)*255, [row,col]))];
end
figure; colormap(gray); montage(eigfacesimgs, 'Size', [1 1]);
hold on;

% Bulding the database for K eigfaces
database = [];
for i=1:1:trainsize
    x = train(:,i); % Test face
    diffx = x - xbar;
    dbrow = [];
    for j=1:1:K
        smalla = dot(diffx, newV(:,j));
        dbrow = [dbrow smalla];
    end
    database = [database; dbrow];
end
% Calculating of the descriptor
descriptor = [];
for i=1:1:K
    testdiffx = testx - xbar;
    descriptor = [descriptor dot(testdiffx, newV(:,i))];
end

% Face Recognition
eucdistances = [];
for i=1:1:trainsize
    eucdist = 0;
    for j=1:1:K
        eucdist = eucdist + (database(i,j)-descriptor(j))^2;
    end
    eucdistances = [eucdistances; sqrt(eucdist)];
end


% Face Recognition
mahdistances = [];
for i=1:1:trainsize
    mahdist = 0;
    for j=1:1:K
        mahdist = mahdist + ((database(i,j)-descriptor(j))^2)/D(j,j);
    end
    mahdistances = [mahdistances; mahdist];
end

recind = find(eucdistances(:) == min(eucdistances(:)));
mahrecind = find(mahdistances(:) == min(mahdistances(:)));

err = x - faceX;
N = vecnorm(err);
threshold = 8;

    disp(N);
if(N < threshold)
 	disp('It is a face');
else
    disp('It is not a face');
end

subplot(2,3,1);
imshow(uint8(reshape(xrec*255, [row,col])));
title('Original Image');
subplot(2,3,2);
imshow(uint8(reshape(faceX*255, [row,col])));
title('Reconstructed Image');

subplot(2,3,4);
imshow(uint8(reshape(testx*255, [row,col])));
title('Original Image');
subplot(2,3,5);
imshow(uint8(reshape(train(:,recind)*255, [row,col])));
title('Recognition (Euclidian)');
subplot(2,3,6);
imshow(uint8(reshape(train(:,mahrecind)*255, [row,col])));
title('Recognition (Mahalanobis)');

% each column is eigenface

% Read image from file
img = imread('TwinkleTwinkleLittleStar.bmp');
% Converting image into grayScale
img = rgb2gray(img);
img = imbinarize(img);
% Extracting Horizontal lines
BW = edge(img,'Sobel',[],'vertical');
BW =imcomplement(BW);
img = double(img) - double(BW);


%Extracting Stafflines 
dilation_SE = strel('line', 5, 90);
dilated_img = imclose(img, dilation_SE);
dilation_SE = strel('line', 5, 0);
dilated_img = imclose(dilated_img, dilation_SE);
figure, imshow(dilated_img);

%Subtract Stafflines from image
%img2 = dilated_img - img;
%img2 = imcomplement(img2);
%figure, imshow(img2);

%Extracting Stafflines 
%dilation_SE2 = strel('line', 3, 90);
%dilated_img2 = imclose(img2, dilation_SE2);
%dilated_img2 = imfill(dilated_img2);
%figure, imshow(dilated_img2);

%Shapeining image using laplacial filter
% Laplacian=[-1 -1 -1; -1 9 -1; -1 -1 -1];
% img = rgb2gray(dilated_img2);
% laplacian_img=uint8(conv2(img, Laplacian, 'same'));
% figure, imshow(laplacian_img);

% erosion_SE = strel('line', 2, 90);
% eroded_img = imerode(dilated_img, erosion_SE);
% figure, imshow(eroded_img);

% opened_SE = strel('line', 10, 90);
% opened_img = imopen(dilated_img, opened_SE);
% figure, imshow(opened_img);


% eroded_img = imfill(eroded_img);
%figure, imshow(dilated_img);
%figure, imshow(img);
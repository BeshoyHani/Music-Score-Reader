img = imread('TwinkleTwinkleLittleStar.bmp');
img = imcomplement(img);

%Extracting Stafflines 
dilation_SE = strel('line', 10, 0);
dilated_img = imopen(img, dilation_SE);
%figure, imshow(dilated_img);

%Subtract Stafflines from image
img2 = img - dilated_img;
figure, imshow(img2);

%Extracting Stafflines
eroded_SE = strel('line', 2, 90);
img2 = imopen(img2, eroded_SE);
%im = max(img2, [], 3);
%img2 = imfill(im>90,'holes');
figure, imshow(img2);

%Shapeining image using laplacial filter
% Laplacian=[-1 -1 -1; -1 9 -1; -1 -1 -1];
% Mean = [1 1 1; 1 1 1; 1 1 1];
% img = rgb2gray(img2);
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
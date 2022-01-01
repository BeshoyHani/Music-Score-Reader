function withoutLines = lineRemoval(input)
input = imcomplement(input);

%Extracting Stafflines 
openSe = strel('line', 10, 0);
openImg = imopen(input, openSe);
%figure, imshow(dilated_img);

%Subtract Stafflines from image
img2 = input - openImg;

%Closing gaps between stems and heads
openSe = strel('line', 2, 90);
img2 = imopen(img2, openSe);
openSe = strel('line', 4, 90);
withoutLines = imclose(img2, openSe);

withoutLines = imcomplement(withoutLines);
end
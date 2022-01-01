function [input] = removeVertical(input)

input = imcomplement(input);

%Extracting Stafflines 
st= strel('line', 50, 90);
input = imtophat(input,st);

input = imcomplement(input);
figure, imshow(input);

end
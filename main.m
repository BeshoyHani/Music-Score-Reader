file_name = input('Which image do you want to read? \n','s');
img = im2double(imread(strcat('TestCases/', file_name)));

img = illumination(img);  % Adjust image brightness and rgb two gray 
straightened = straighten(img); %rotate the image if needed
imgThresh = thresh(straightened); % thresholding 
lines = staffDetection(imgThresh); % Helper Function to get lines y - axis

noLines =lineRemoval(straightened);
%figure , imshow(noLines);
%noLines = besh_line_removal(straightened);
%figure , imshow(noLines);
%figure, imshow(noLines);

if(contains(file_name, 'JingleBells'))
    imgThresh = removeVertical(imgThresh);
end

staffs = staffBox(imgThresh, lines);%  Helper function
[nStaffs, ~] = size(staffs);
outputString = '';    

for j = 1:nStaffs 
    staffImg = noLines(staffs(j, 1):staffs(j, 2), :);
 %  figure, imshow(staffImg);
    staffImgWithLines = imgThresh(staffs(j, 1):staffs(j, 2),:);

    [stems, heads, misc] = categorize(staffImg, lines); % helper Functions
    topLine = lines(j, 1) - staffs(j, 1) + 1;
    bottomLine = lines(j, 5) - staffs(j, 1) + 1;

    [boxes, heads, flagPositions] = boundingBoxes(stems, heads, lineDist(lines), staffImgWithLines, topLine, bottomLine);
    [nBoxes, ~] = size(boxes);
    values = noteValue(flagPositions, misc, lineDist(lines));

   for k = 1:nBoxes
            [nHeads, ~] = size(heads{k});
            for l = 1:nHeads
                y = heads{k}(l, 2);
                p = pitch(y, topLine, bottomLine);
                value = values(k);
                p = upper(p);
                outputString = strcat(outputString, p);
            end
   end
        if (j ~= nStaffs)
            outputString = strcat(outputString, 'n');
        end
end
    
%outputString

song= strings(1,length(outputString)); % defining an empty list 
for k = 1:length(outputString) % looping over the length of the string 
    song(k) = outputString(k);
end


%song
notes={'C' 'C#' 'D' 'Eb' 'E' 'F' 'F#' 'G' 'G#' 'A' 'Bb' 'B','n'};
freq=[261.6  277.2  293.7  311.1  329.6  349.2...
  370.0  392.0    415.3  440.0  466.2  493.9 0];

a=[];
for k=1:numel(song)
   note_value=0:0.000125:0.5; % You can change the note duration
  a=[a sin(2*pi* freq(strcmp(notes,song(k)))*note_value)];
end
sound(a);
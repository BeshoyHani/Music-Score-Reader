function [stems, heads, misc] = categorize(imageNoLines, lines) 
    %only stems
    stemsImage = stemDetection(imageNoLines, lines);
    
    %only heads
    headsImage = noteHeadDetection(imageNoLines, lines);
        
    %thresh heads
    heads = imcomplement(headsImage);
    threshold = graythresh(heads);
    heads = im2bw(heads, threshold);
   
    %thresh stems
    stems = imcomplement(stemsImage);
    threshold = graythresh(stems);
    stems = im2bw(stems, threshold);
    
    thinStems = bwmorph(stems, 'thin');
    %bottoms = bwhitmiss(thinStems, [0 0 0; 0 1 0; -1 -1 -1]);
    %tops = bwhitmiss(thinStems, [-1 -1 -1; 0 1 0; 0 0 0]);
    %bottomsAndTops = (bottoms + tops) > 0;
    
    lineDist = mean(mean(lines(:,2:5) - lines(:, 1:4)));
    
    areas = bwdist(thinStems) < lineDist*(2/3);
    areas = (areas + heads) > 1;
    
    stems = imreconstruct(imdilate(areas, ones(round(lineDist*2/3))), stems);
    heads = imreconstruct(areas, heads);
        
    misc = double(1 - imageNoLines) - double(1 - stemsImage) - double(1 - headsImage);
    %misc = double(imcomplement(imageNoLines)) - double(imcomplement(stemsImage)) - double(imcomplement(headsImage));
end
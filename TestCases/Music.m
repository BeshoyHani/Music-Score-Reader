notes={'C' 'C#' 'D' 'Eb' 'E' 'F' 'F#' 'G' 'G#' 'A' 'Bb' 'B'};
freq=[261.6  277.2  293.7  311.1  329.6  349.2...
  370.0  392.0    415.3  440.0  466.2  493.9];
song={'A' 'G' 'G' 'A' 'B' 'C' 'F' 'G'};  % your song
a=[];
for k=1:numel(song)
   note_value=0:0.000125:0.5; % You can change the note duration
  a=[a sin(2*pi* freq(strcmp(notes,song{k}))*note_value)];
end
sound(a);
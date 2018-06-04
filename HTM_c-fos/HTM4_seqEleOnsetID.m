%Get sequence element onsets and ID - HTM Project
%AVP 2016
for day = 1:7 
    for animal = 1:5
        seqEleOn{animal,day} = find(diff(seqEleIDsig{animal,day} > 0.2) == 1); %Indices for element onsets
        seqEleID{animal,day} = round(seqEleIDsig{animal,day}(seqEleOn{animal,day}+1)*4); %ID for element onsets
        seqID1{animal,day} = seqEleID{animal,day} < 11;
        seqID2{animal,day} = seqEleID{animal,day} > 11;
    end
end

g11 = 2; %Seq 1 Grating 1
t11 = 4; %Seq 1 Tone 1
g12 = 6; %Seq 1 Grating 2
t12 = 8; %Seq 1 Tone 2
t11g12 = 10; %Seq 1 Tone 1 Grating 2

g21 = 12; %Seq 2 Grating 1
g22 = 14; %Seq 2 Grating 2
t21 = 16; %Seq 2 Tone 1
t22 = 18; %Seq 2 Tone 2
t21g22 = 20; %Seq 2 Tone 1 Grating 2

om = 1; %Omissions

%Get IDs for similar stimuli within and across sequences
for day = 1:7
    for animal = 1:5
        %Get onset vector for tones in seq1, seq2 or in total
        seq1Tone{animal,day} = zeros(size(seqEleID{animal,day}));
        tmpSeq1Tone{animal,day} = find(seqEleID{animal,day} == 4 | seqEleID{animal,day} == 8);
        seq2Tone{animal,day} = zeros(size(seqEleID{animal,day}));
        tmpSeq2Tone{animal,day} = find(seqEleID{animal,day} == 16 | seqEleID{animal,day} == 18);
        seq1Tone{animal,day}(tmpSeq1Tone{animal,day}) = 1; %ID of all tones in seq1
        seq2Tone{animal,day}(tmpSeq2Tone{animal,day}) = 1; %ID of all tones in seq2
        seqTone{animal,day} = zeros(size(seqEleID{animal,day}));
        seqTone{animal,day}([tmpSeq1Tone{animal,day} tmpSeq2Tone{animal,day}]) = 1; %ID of all tones in both seq
        
        %Get onset vector for gratings in seq1, seq2 or in total
        seq1Grat{animal,day} = zeros(size(seqEleID{animal,day}));
        tmpSeq1Grat{animal,day} = find(seqEleID{animal,day} == 2 | seqEleID{animal,day} == 6);
        seq2Grat{animal,day} = zeros(size(seqEleID{animal,day}));
        tmpSeq2Grat{animal,day} = find(seqEleID{animal,day} == 12 | seqEleID{animal,day} == 14);
        seq1Grat{animal,day}(tmpSeq1Grat{animal,day}) = 1; %ID of all gratings in seq1
        seq2Grat{animal,day}(tmpSeq2Grat{animal,day}) = 1; %ID of all gratings in seq2
        seqGrat{animal,day} = zeros(size(seqEleID{animal,day}));
        seqGrat{animal,day}([tmpSeq1Grat{animal,day} tmpSeq2Grat{animal,day}]) = 1; %ID of all gratings in both seq
        
        
        combStim{animal,day} = [seq1Tone{animal,day}; seq2Tone{animal,day};seqTone{animal,day};seq1Grat{animal,day};seq2Grat{animal,day};seqGrat{animal,day}];
    end
end



        
%HTM Data Preparation - HTM Project
%AVP 2016

concatenate_data;
seqEleOnsetID;
omissionSeqID;
onsetActivity;
eleRespCells;

%To get binned data
alignSeqAct;
binData;


%For any variable that includes rows or columns for the different sequence
%elements, the order is always as following:
%  1  2   3   4     5    6   7   8   9    10   11     12       13 
%g11 t11 g12 t12 t11g12 g21 g22 t21 t22 t21g22 om seq1Tones seq2Tones
%   14       15       16      17
%AllTones Seq1Grat Seq2Grat AllGrat
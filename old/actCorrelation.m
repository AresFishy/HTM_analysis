stimVec = zeros(200,1); %vector of stimuli
stimVec(15:25) = [1:5,5,fliplr(1:5)]; %Shifted 5 frames from onset
stimVec(45:55) = [1:5,5,fliplr(1:5)];
stimVec(75:85) = [1:5,5,fliplr(1:5)];
stimVec(105:115) = [1:5,5,fliplr(1:5)];
stimVec(135:145) = [1:5,5,fliplr(1:5)];

stimVec = seqActMean1{4,1}(164,:);

for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            for cell = 1:size(onsetAct{animal,day},1)
                [tmpCor1,tmpCorp1] = corrcoef(stimVec,seqActMean1{animal,day}(cell,:)); %Get correlation coefficient and p-value
                [tmpCor2,tmpCorp2] = corrcoef(stimVec,seqActMean2{animal,day}(cell,:));
                actCorr1{animal,day}(cell) = tmpCor1(1,2);
                actCorr2{animal,day}(cell) = tmpCor2(1,2);
                actCorrp1{animal,day}(cell) = tmpCorp1(1,2);
                actCorrp2{animal,day}(cell) = tmpCorp2(1,2);
            end
            actCorrCell1{animal,day} = find(actCorr1{animal,day} > 0.5 & actCorrp1{animal,day} < 0.01); %Correlation above 0.15 and significant < 0.05
            actCorrCell2{animal,day} = find(actCorr2{animal,day} > 0.5 & actCorrp2{animal,day} < 0.01);
            actCorrCell{animal,day} = unique([actCorrCell1{animal,day},actCorrCell2{animal,day}]);
        end
    end
    cellVector = [0, 361, 135, 387, 249, 324]; %Number of cells per animal
    actCorrCellComb{day} = [];
    for animal = 1:6;
        actCorrCellComb{day} = [actCorrCellComb{day}, actCorrCell{animal,day}+sum(cellVector(1:animal))];
    end
    actCorrCellCombNo(day) = length(actCorrCellComb{day});
end


%%
%Get cells that favor sound, visual stimuli or both




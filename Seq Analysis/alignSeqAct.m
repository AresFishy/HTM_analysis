%Get sequence aligned activity
%Divided between seq1 and seq2
for day = 1:8
    for animal = 1:6
        if ~isempty(seqIDsig{animal,day})
            seqStart1{animal,day} = seqEleOn{animal,day}(find(round(seqEleIDsig{animal,day}(seqEleOn{animal,day}+1)*4) == g11))-5;
            seqStart2{animal,day} = seqEleOn{animal,day}(find(round(seqEleIDsig{animal,day}(seqEleOn{animal,day}+1)*4) == g21))-5;
            seqEnd1{animal,day} = seqStart1{animal,day} + 174;
            seqEnd2{animal,day} = seqStart2{animal,day} + 174;
            
        end
    end
end

seqAct1 = {};
seqActMean1 = {};
seqActMeanOn1 = {};
seqActComb1 = {};
seqActCombOn1 = {};
seqAct2 = {};
seqActMean2 = {};
seqActMeanOn2 = {};
seqActComb2 = {};
seqActCombOn2 = {};
for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            for cell = 1:size(act{animal,day},1)
                for on = 1:length(seqStart1{animal,day})
                    seqAct1{animal,day}(cell,on,:) = act{animal,day}(cell,seqStart1{animal,day}(on):seqEnd1{animal,day}(on)); %For seq1
                end
                for on = 1:length(seqStart2{animal,day})
                    seqAct2{animal,day}(cell,on,:) = act{animal,day}(cell,seqStart2{animal,day}(on):seqEnd2{animal,day}(on)); %For seq2
                end
                seqActMean1{animal,day}(cell,:) = squeeze(mean(seqAct1{animal,day}(cell,:,:),2)); %Get mean activity per cell across sequence presentations
                seqActMean2{animal,day}(cell,:) = squeeze(mean(seqAct2{animal,day}(cell,:,:),2)); %Get mean activity per cell across sequence presentations
            end
        else %In case there was no activity for a mouse on a certain day, it will be filled with NaNs to keep indices correct
            seqActMean1{animal,day} = NaN(size(act{animal,2},1),175);
            seqActMean2{animal,day} = NaN(size(act{animal,2},1),175);
        end
        for on = 1:length(seqStart1{animal,day})
            seqActMeanOn1{animal,day}(on,:) = squeeze(mean(seqAct1{animal,day}(:,on,:),1)); %Get mean activity across cells for each sequence presentation
        end
        for on = 1:length(seqStart2{animal,day})
            seqActMeanOn2{animal,day}(on,:) = squeeze(mean(seqAct2{animal,day}(:,on,:),1)); %Get mean activity across cells for each sequence presentation
        end
    end
    seqActComb1{day} = vertcat(seqActMean1{:,day});
    seqActCombOn1{day} = vertcat(seqActMeanOn1{:,day});
    seqActComb2{day} = vertcat(seqActMean2{:,day});
    seqActCombOn2{day} = vertcat(seqActMeanOn2{:,day});
end
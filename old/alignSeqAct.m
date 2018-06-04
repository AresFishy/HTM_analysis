%Get sequence aligned activity
%Divided between seq1 and seq2 and combined
for day = 1:8
    for animal = 1:6
        if ~isempty(seqIDsig{animal,day})
            seqStart1{animal,day} = seqEleOn{animal,day}(find(round(seqEleIDsig{animal,day}(seqEleOn{animal,day}+3)*4) == g11))-10;
            seqStart2{animal,day} = seqEleOn{animal,day}(find(round(seqEleIDsig{animal,day}(seqEleOn{animal,day}+3)*4) == g21))-10;
            seqStart{animal,day} = sort([seqStart1{animal,day} seqStart2{animal,day}]);
            
            seqStart1{animal,day} = seqStart1{animal,day}(seqStart1{animal,day} > 0);
            seqStart2{animal,day} = seqStart2{animal,day}(seqStart2{animal,day} > 0);
            seqStart{animal,day} = seqStart{animal,day}(seqStart{animal,day} > 0);
            
            seqEnd1{animal,day} = seqStart1{animal,day} + 199;
            seqEnd2{animal,day} = seqStart2{animal,day} + 199;
            seqEnd{animal,day} = seqStart{animal,day} + 199;
            
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

seqAct = {};
seqActMean = {};
seqActMeanOn = {};
seqActComb = {};
seqActCombOn = {};


rewpuff1 = {};
rewpuff2 = {};
rewpuff = {};
rew1 = {};
rew2 = {};
rew = {};
puff1 = {};
puff2 = {};
puff = {};
seqActCombRew1 = {};
seqActCombRew2 = {};
seqActCombRew = {};
seqActCombPuff1 = {};
seqActCombPuff2 = {};
seqActCombPuff = {};

seqLick = {};
seqLick1 = {};
seqLick2 = {};
seqIDsig = {};
seqPupil = {};

for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            for cell = 1:size(act{animal,day},1)
                for on = 1:length(seqStart1{animal,day})
                    seqAct1{animal,day}(cell,on,:) = act{animal,day}(cell,seqStart1{animal,day}(on):seqEnd1{animal,day}(on)); %For seq1
                    if cell == 1; %only calculate this ones
                        rewpuff1{animal,day}(on,:) = reward{animal,day}(seqStart1{animal,day}(on):seqEnd1{animal,day}(on)); %For seq1, first find all rewards
                        [tmprew1{animal,day},~] = find(round(rewpuff1{animal,day}) == 1);
                        rew1{animal,day} = unique(tmprew1{animal,day})';
                        puff1{animal,day} = setdiff(1:length(seqStart1{animal,day}),rew1{animal,day}); %Puff are then the seq on that are not rewards
                    end
                end
                for on = 1:length(seqStart2{animal,day})
                    seqAct2{animal,day}(cell,on,:) = act{animal,day}(cell,seqStart2{animal,day}(on):seqEnd2{animal,day}(on)); %For seq2
                    if cell == 1;
                        rewpuff2{animal,day}(on,:) = reward{animal,day}(seqStart2{animal,day}(on):seqEnd2{animal,day}(on)); %For seq2
                        [tmprew2{animal,day},~] = find(round(rewpuff2{animal,day}) == 1);
                        rew2{animal,day} = unique(tmprew2{animal,day})';
                        puff2{animal,day} = setdiff(1:length(seqStart2{animal,day}),rew2{animal,day});
                    end
                end
                for on = 1:length(seqStart{animal,day})
                    seqAct{animal,day}(cell,on,:) = act{animal,day}(cell,seqStart{animal,day}(on):seqEnd{animal,day}(on)); %For all seq
                    if cell == 1;
                        rewpuff{animal,day}(on,:) = reward{animal,day}(seqStart{animal,day}(on):seqEnd{animal,day}(on)); %For all seq
                        [tmprew{animal,day},~] = find(round(rewpuff{animal,day}) == 1);
                        rew{animal,day} = unique(tmprew{animal,day})';
                        puff{animal,day} = setdiff(1:length(seqStart{animal,day}),rew{animal,day});
                    end
                end
                if cell == 1 %Align lick signal either in total, seq1 or seq2 or subdivided by reward or puff.
                    for on = 1:length(seqStart{animal,day})
                        seqLick{animal,day}(on,:) = Lick{animal,day}(cell,seqStart{animal,day}(on):seqEnd{animal,day}(on)); %For all seq
                        seqIDsig{animal,day}(on,:) = seqEleIDsig{animal,day}(cell,seqStart{animal,day}(on):seqEnd{animal,day}(on)); %For all seq
                    end
                    for on = 1:length(seqStart1{animal,day})
                        seqLick1{animal,day}(on,:) = Lick{animal,day}(cell,seqStart1{animal,day}(on):seqEnd1{animal,day}(on)); %For all seq
                    end
                    seqLick1R{animal,day} = seqLick1{animal,day}(rew1{animal,day},:);
                    seqLick1P{animal,day} = seqLick1{animal,day}(puff1{animal,day},:);
                    for on = 1:length(seqStart2{animal,day})
                        seqLick2{animal,day}(on,:) = Lick{animal,day}(cell,seqStart2{animal,day}(on):seqEnd2{animal,day}(on)); %For all seq
                    end
                    seqLick2R{animal,day} = seqLick2{animal,day}(rew2{animal,day},:);
                    seqLick2P{animal,day} = seqLick2{animal,day}(puff2{animal,day},:);
                    
                    for on = 1:length(seqStart{animal,day})
                        seqPupil{animal,day}(on,:) = pupilD{animal,day}(cell,seqStart{animal,day}(on):seqEnd{animal,day}(on)); %For all seq
                    end
                    
                end
                
                seqActMean1{animal,day}(cell,:) = squeeze(mean(seqAct1{animal,day}(cell,2:2:end,:),2)); %Get mean activity per cell across sequence presentations
                seqActMean2{animal,day}(cell,:) = squeeze(mean(seqAct2{animal,day}(cell,2:2:end,:),2)); %Get mean activity per cell across sequence presentations
                seqActMean{animal,day}(cell,:) = squeeze(mean(seqAct{animal,day}(cell,2:2:end,:),2)); %Get mean activity per cell across sequence presentations
                seqActMeanRew1{animal,day}(cell,:) = squeeze(mean(seqAct1{animal,day}(cell,rew1{animal,day}(2:2:end),:),2)); %Get mean activity per cell across sequence presentations
                seqActMeanRew2{animal,day}(cell,:) = squeeze(mean(seqAct2{animal,day}(cell,rew2{animal,day}(2:2:end),:),2)); %Get mean activity per cell across sequence presentations
                seqActMeanRew{animal,day}(cell,:) = squeeze(mean(seqAct{animal,day}(cell,rew{animal,day}(2:2:end),:),2)); %Get mean activity per cell across sequence presentations
                seqActMeanPuff1{animal,day}(cell,:) = squeeze(mean(seqAct1{animal,day}(cell,puff1{animal,day}(2:2:end),:),2)); %Get mean activity per cell across sequence presentations
                seqActMeanPuff2{animal,day}(cell,:) = squeeze(mean(seqAct2{animal,day}(cell,puff2{animal,day}(2:2:end),:),2)); %Get mean activity per cell across sequence presentations
                seqActMeanPuff{animal,day}(cell,:) = squeeze(mean(seqAct{animal,day}(cell,puff{animal,day}(2:2:end),:),2)); %Get mean activity per cell across sequence presentations
                
            end
        else %In case there was no activity for a mouse on a certain day, it will be filled with NaNs to keep indices correct
            seqActMean1{animal,day} = NaN(size(act{animal,2},1),200);
            seqActMean2{animal,day} = NaN(size(act{animal,2},1),200);
            seqActMean{animal,day} = NaN(size(act{animal,2},1),200);
            seqActMeanRew1{animal,day} = NaN(size(act{animal,2},1),200);
            seqActMeanRew2{animal,day} = NaN(size(act{animal,2},1),200);
            seqActMeanRew{animal,day} = NaN(size(act{animal,2},1),200);
            seqActMeanPuff1{animal,day} = NaN(size(act{animal,2},1),200);
            seqActMeanPuff2{animal,day} = NaN(size(act{animal,2},1),200);
            seqActMeanPuff{animal,day} = NaN(size(act{animal,2},1),200);
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
    seqActComb{day} = vertcat(seqActMean{:,day});
    
    seqActCombRew1{day} = vertcat(seqActMeanRew1{:,day});
    seqActCombRew2{day} = vertcat(seqActMeanRew2{:,day});
    seqActCombRew{day} = vertcat(seqActMeanRew{:,day});
    seqActCombPuff1{day} = vertcat(seqActMeanPuff1{:,day});
    seqActCombPuff2{day} = vertcat(seqActMeanPuff2{:,day});
    seqActCombPuff{day} = vertcat(seqActMeanPuff{:,day});
    
    seqLickComb1R{day} = vertcat(seqLick1R{:,day});
    seqLickComb2R{day} = vertcat(seqLick2R{:,day});
    seqLickComb1P{day} = vertcat(seqLick1P{:,day});
    seqLickComb2P{day} = vertcat(seqLick2P{:,day});
end

%Get onset ID for seq1 and seq2
for day = 1:8
    for animal = 1:6
        [~,tmpInd] = sort([seqStart1{animal,day},seqStart2{animal,day}]);
        tmpIndSort = [zeros(length(seqStart1{animal,day}),1); ones(length(seqStart2{animal,day}),1)];
        seqID12{animal,day} = tmpIndSort(tmpInd); % 0 is seq1 and 1 is seq2
    end
end

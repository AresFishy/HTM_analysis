%Onset activity - HTM Project
%AVP 2016

onsetAct = {};
onsetActMean = {};
OnsetActComb = {};
onsetActMeanOM = {};
onsetActMeanNoOM = {};
OnsetActCombOM = {};
OnsetActCombNoOM = {};
onsetActOMID = {};
sortVector = {};
selVector = {};
plotVector = {};
om = 1;
element = [g11 t11 g12 t12 t11g12 g21 g22 t21 t22 t21g22 om]; %Sequence elements in order of first Seq1 then Seq2
for ele = 1:length(element)+6;
    for day = 1:8
        for animal = 1:6
            if ~isempty(act{animal,day});
                if ele < 12 %Onset activity for the individual sequence elements
                    onsets = seqEleOn{animal,day}(seqEleID{animal,day} == element(ele)); %Set what onsets you want to look at
                    onsetIDidx = find(seqEleID{animal,day} == element(ele));
                else %Onset activity for similar sequence elements
                    onsets =  seqEleOn{animal,day}(combStim{animal,day}(ele-11,:) == 1);
                    onsetIDidx = find(combStim{animal,day}(ele-11,:) == 1);
                end
                if ele == 11 && day < 7 %Omissions should only be calculated for the last 2 days
                    onsetAct{animal,day,ele} = [];
                else
                    cnt = 0;
                    for on = 1:length(onsets)
                        if onsets(on) > 15
                            cnt = cnt + 1;
                            tmpOnsetAct{animal,day}(:,cnt,:) = act{animal,day}(:,onsets(on)-15:onsets(on)+30);
                            %Mean correct the activity
                            for cell = 1:size(act{animal,day},1)
                                onsetAct{animal,day,ele}(cell,cnt,:) = tmpOnsetAct{animal,day}(cell,cnt,:) - mean(act{animal,day}(cell,onsets(on)-6:onsets(on)-1));
                            end
                            %Get vectors containing ID for omission/no
                            %omission
                            if seqOMID{animal,day}(onsetIDidx(cnt)) == 1;
                                onsetActOMID{animal,day,ele}(cnt) = 1;
                            else
                                onsetActOMID{animal,day,ele}(cnt) = 0;
                            end
                        end
                    end
                end
                              
                onsetActMean{animal,day,ele} = squeeze(mean(onsetAct{animal,day,ele},2));
                
                if day > 6 %Get activity dependent on it being an omission sequence or not
                    onsetActMeanOM{animal,day,ele} = squeeze(mean(onsetAct{animal,day,ele}(:,onsetActOMID{animal,day,ele} == 1,:),2));
                    onsetActMeanNoOM{animal,day,ele} = squeeze(mean(onsetAct{animal,day,ele}(:,onsetActOMID{animal,day,ele} == 0,:),2));
                end
                
                          
            else %In case there was no activity for a mouse on a certain day, it will be filled with NaNs to keep indices correct (Use day 2 for dimensions)
                onsetActMean{animal,day,ele} = NaN(size(act{animal,2},1),46);
                onsetActMeanOM{animal,day,ele} = NaN(size(act{animal,2},1),46);
                onsetActMeanNoOM{animal,day,ele} = NaN(size(act{animal,2},1),46);
            end
        end
        OnsetActComb{day,ele} = vertcat(onsetActMean{:,day,ele});
        if day > 6
            OnsetActCombOM{day,ele} = vertcat(onsetActMeanOM{:,day,ele});
            OnsetActCombNoOM{day,ele} = vertcat(onsetActMeanNoOM{:,day,ele});
        end
    end
end
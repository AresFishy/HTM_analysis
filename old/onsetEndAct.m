%calculate the onset activity around the reward/punishment

onsetAct = {};
onsetActMean = {};
OnsetActComb = {};
for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day});
            for on = 1:size(seqAct{animal,day},2)
                tmpOnsetAct{animal,day}(:,on,:) = seqAct{animal,day}(:,on,170:200);
                %Mean correct the activity
                for cell = 1:size(act{animal,day},1)
                    onsetAct{animal,day}(cell,on,:) = tmpOnsetAct{animal,day}(cell,on,:) - mean(seqAct{animal,day}(cell,on,175:180));
                end
            end
            cntR = 0;
            for on = rew{animal,day}
                cntR = cntR + 1;
                tmpOnsetActR{animal,day}(:,cntR,:) = seqAct{animal,day}(:,on,170:200);
                %Mean correct the activity
                for cell = 1:size(act{animal,day},1)
                    onsetActR{animal,day}(cell,cntR,:) = tmpOnsetActR{animal,day}(cell,cntR,:) - mean(seqAct{animal,day}(cell,on,175:180));
                end
            end
            
            cntR1 = 0;
            for on = rew1G{animal,day}'
                cntR1 = cntR1 + 1;
                tmpOnsetActR1{animal,day}(:,cntR1,:) = seqAct{animal,day}(:,on,170:200);
                %Mean correct the activity
                for cell = 1:size(act{animal,day},1)
                    onsetActR1{animal,day}(cell,cntR1,:) = tmpOnsetActR1{animal,day}(cell,cntR1,:) - mean(seqAct{animal,day}(cell,on,175:180));
                end
            end
            
            cntR2 = 0;
            for on = rew2G{animal,day}'
                cntR2 = cntR2 + 1;
                tmpOnsetActR2{animal,day}(:,cntR2,:) = seqAct{animal,day}(:,on,170:200);
                %Mean correct the activity
                for cell = 1:size(act{animal,day},1)
                    onsetActR2{animal,day}(cell,cntR2,:) = tmpOnsetActR2{animal,day}(cell,cntR2,:) - mean(seqAct{animal,day}(cell,on,175:180));
                end
            end
            
            cntP = 0;
            for on = puff{animal,day}
                cntP = cntP + 1;
                tmpOnsetActP{animal,day}(:,cntP,:) = seqAct{animal,day}(:,on,170:200);
                %Mean correct the activity
                for cell = 1:size(act{animal,day},1)
                    onsetActP{animal,day}(cell,cntP,:) = tmpOnsetActP{animal,day}(cell,cntP,:) - mean(seqAct{animal,day}(cell,on,175:180));
                end
            end
            
            cntP1 = 0;
            for on = puff1G{animal,day}'
                cntP1 = cntP1 + 1;
                tmpOnsetActP1{animal,day}(:,cntP1,:) = seqAct{animal,day}(:,on,170:200);
                %Mean correct the activity
                for cell = 1:size(act{animal,day},1)
                    onsetActP1{animal,day}(cell,cntP1,:) = tmpOnsetActP1{animal,day}(cell,cntP1,:) - mean(seqAct{animal,day}(cell,on,175:180));
                end
            end
            
            cntP2 = 0;
            for on = puff2G{animal,day}'
                cntP2 = cntP2 + 1;
                tmpOnsetActP2{animal,day}(:,cntP2,:) = seqAct{animal,day}(:,on,170:200);
                %Mean correct the activity
                for cell = 1:size(act{animal,day},1)
                    onsetActP2{animal,day}(cell,cntP2,:) = tmpOnsetActP2{animal,day}(cell,cntP2,:) - mean(seqAct{animal,day}(cell,on,175:180));
                end
            end
            
            
            onsetActMean{animal,day} = squeeze(mean(onsetAct{animal,day}(:,2:2:end,:),2));
            onsetActMeanR{animal,day} = squeeze(mean(onsetActR{animal,day}(:,2:2:end,:),2));
            onsetActMeanP{animal,day} = squeeze(mean(onsetActP{animal,day}(:,2:2:end,:),2));
            onsetActMeanR1{animal,day} = squeeze(mean(onsetActR1{animal,day}(:,2:2:end,:),2));
            onsetActMeanR2{animal,day} = squeeze(mean(onsetActR2{animal,day}(:,2:2:end,:),2));
            onsetActMeanP1{animal,day} = squeeze(mean(onsetActP1{animal,day}(:,2:2:end,:),2));
            onsetActMeanP2{animal,day} = squeeze(mean(onsetActP2{animal,day}(:,2:2:end,:),2));
        else %In case there was no activity for a mouse on a certain day, it will be filled with NaNs to keep indices correct (Use day 2 for dimensions)
            onsetActMean{animal,day} = NaN(size(act{animal,2},1),31);
            onsetActMeanR{animal,day} = NaN(size(act{animal,2},1),31);
            onsetActMeanP{animal,day} = NaN(size(act{animal,2},1),31);
            onsetActMeanR1{animal,day} = NaN(size(act{animal,2},1),31);
            onsetActMeanR2{animal,day} = NaN(size(act{animal,2},1),31);
            onsetActMeanP1{animal,day} = NaN(size(act{animal,2},1),31);
            onsetActMeanP2{animal,day} = NaN(size(act{animal,2},1),31);
        end     
        if isempty(onsetActMeanR1{animal,day})
            onsetActMeanR1{animal,day} = NaN(size(act{animal,2},1),31);
        end
        if isempty(onsetActMeanR1{animal,day})
            onsetActMeanR2{animal,day} = NaN(size(act{animal,2},1),31);
        end
        if isempty(onsetActMeanR1{animal,day})
            onsetActMeanP1{animal,day} = NaN(size(act{animal,2},1),31);
        end
        if isempty(onsetActMeanR1{animal,day})
            onsetActMeanP2{animal,day} = NaN(size(act{animal,2},1),31);
        end
    end
    OnsetActComb{day} = vertcat(onsetActMean{:,day});
    OnsetActCombR{day} = vertcat(onsetActMeanR{:,day});
    OnsetActCombP{day} = vertcat(onsetActMeanP{:,day});
    OnsetActCombR1{day} = vertcat(onsetActMeanR1{:,day});
    OnsetActCombP1{day} = vertcat(onsetActMeanP1{:,day});
    OnsetActCombR2{day} = vertcat(onsetActMeanR2{:,day});
    OnsetActCombP2{day} = vertcat(onsetActMeanP2{:,day});
end



%calculate the onset activity around the omission
%Find omissions
om = {};
omSel = {};
tmpOm = {};
tmpom = {};
noOm = {};
noOmSel = {};
tmpNoOm = {};
tmpnoOm = {};
for day = 7:8
    for animal = 1:6
        [tmpOm{animal,day},~] = find(seqIDsig{animal,day} < 0.35 & seqIDsig{animal,day} > 0.15);
        tmpom{animal,day} = unique(tmpOm{animal,day});
        omSel{animal,day} = tmpom{animal,day}(find(mod(tmpom{animal,day},2) ~= 0));
        om{animal,day} = tmpom{animal,day}(find(mod(tmpom{animal,day},2) == 0));
        [tmpNoOm{animal,day},~] = find(seqIDsig{animal,day} < 2.25 & seqIDsig{animal,day} > 1.75);
        tmpnoOm{animal,day} = unique(tmpNoOm{animal,day});
        noOmSel{animal,day} = tmpnoOm{animal,day}(find(mod(tmpnoOm{animal,day},2) ~= 0));
        noOm{animal,day} = tmpnoOm{animal,day}(find(mod(tmpnoOm{animal,day},2) == 0));
        
    end
end

onsetActOM = {};
onsetActMeanOM = {};
OnsetActCombOM = {};
tmpOnsetActOM = {};
tmpOnsetActOMS = {};
onsetActNoOMS = {};
onsetActMeanOMS = {};

onsetActNoOM = {};
onsetActMeanNoOM = {};
OnsetActCombNoOM = {};
tmpOnsetActNoOM = {};
tmpOnsetActNoOMS = {};
onsetActNoOMS = {};
onsetActMeanNoOMS = {};

OnsetActCombOM = {};
OnsetActCombNoOM = {};
for day = 7:8
    for animal = 1:6
        if ~isempty(act{animal,day});
            
            cntOM = 0; %For plotting
            for onOM = [om{animal,day}]'
                cntOM = cntOM + 1;
                tmpOnsetActOM{animal,day}(:,cntOM,:) = seqAct{animal,day}(:,onOM,90:130);
                %Mean correct the activity
                for cell = 1:size(tmpOnsetActOM{animal,day},1)      
                    onsetActOM{animal,day}(cell,cntOM,:) = tmpOnsetActOM{animal,day}(cell,cntOM,:) - mean(seqAct{animal,day}(cell,onOM,90:100));
                end
            end
            
            cntOMS = 0; %For selection
            for onOM = [omSel{animal,day}]'
                cntOMS = cntOMS + 1;
                tmpOnsetActOMS{animal,day}(:,cntOMS,:) = seqAct{animal,day}(:,cntOMS,90:130);
                %Mean correct the activity
                for cell = 1:size(tmpOnsetActOMS{animal,day},1)      
                    onsetActOMS{animal,day}(cell,cntOMS,:) = tmpOnsetActOMS{animal,day}(cell,cntOMS,:) - mean(seqAct{animal,day}(cell,cntOMS,90:100));
                end
            end
            
            cntNoOM = 0; %For plotting
            for onNoOM = [noOm{animal,day}]'
                cntNoOM = cntNoOM + 1;
                tmpOnsetActNoOM{animal,day}(:,cntNoOM,:) = seqAct{animal,day}(:,onNoOM,90:130);
                %Mean correct the activity
                for cell = 1:size(tmpOnsetActNoOM{animal,day},1)      
                    onsetActNoOM{animal,day}(cell,cntNoOM,:) = tmpOnsetActNoOM{animal,day}(cell,cntNoOM,:) - mean(seqAct{animal,day}(cell,onNoOM,90:100));
                end
            end
            
            cntNoOMS = 0; %For selection
            for NoOMS = [noOmSel{animal,day}]'
                cntNoOMS = cntNoOMS + 1;
                tmpOnsetActNoOMS{animal,day}(:,cntNoOMS,:) = seqAct{animal,day}(:,NoOMS,90:130);
                %Mean correct the activity
                for cell = 1:size(tmpOnsetActNoOMS{animal,day},1)      
                    onsetActNoOMS{animal,day}(cell,cntNoOMS,:) = tmpOnsetActNoOMS{animal,day}(cell,cntNoOMS,:) - mean(seqAct{animal,day}(cell,NoOMS,90:100));
                end
            end
            
            onsetActMeanOM{animal,day} = squeeze(mean(onsetActOM{animal,day},2));
            onsetActMeanNoOM{animal,day} = squeeze(mean(onsetActNoOM{animal,day},2));
            onsetActMeanOMS{animal,day} = squeeze(mean(onsetActOMS{animal,day},2));
            onsetActMeanNoOMS{animal,day} = squeeze(mean(onsetActNoOMS{animal,day},2));
            
            
        else %In case there was no activity for a mouse on a certain day, it will be filled with NaNs to keep indices correct (Use day 2 for dimensions)
            onsetActMeanOM{animal,day} = NaN(size(act{animal,2},1),41);
            onsetActMeanNoOM{animal,day} = NaN(size(act{animal,2},1),41);
            onsetActMeanOMS{animal,day} = NaN(size(act{animal,2},1),41);
            onsetActMeanNoOMS{animal,day} = NaN(size(act{animal,2},1),41);
        end
    end
    OnsetActCombOM{day} = vertcat(onsetActMeanOM{:,day});
    OnsetActCombNoOM{day} = vertcat(onsetActMeanNoOM{:,day});
    OnsetActCombOMS{day} = vertcat(onsetActMeanOMS{:,day});
    OnsetActCombNoOMS{day} = vertcat(onsetActMeanNoOMS{:,day});
end


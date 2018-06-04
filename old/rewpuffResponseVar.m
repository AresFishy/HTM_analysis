trialMaxR     = {};
trialMaxPupR  = {};
trialMaxP     = {};
trialMaxPupP  = {};

for day = 1:8
    for animal = 1:6
        cntR = 0;
        for trial = rew{animal,day}(2:2:end)
            cntR = cntR + 1;
            trialMaxR{animal,day}(cntR) = max(mean(onsetAct{animal,day}(rewCells{animal,day},trial,:),1));
            trialMaxPupR{animal,day}(cntR) = max(pupR{animal,day}(cntR,:));
        end
        
        cntP = 0;
        for trial = puff{animal,day}(2:2:end)
            cntP = cntP + 1;
            trialMaxP{animal,day}(cntP) = max(mean(onsetAct{animal,day}(puffCells{animal,day},trial,:),1));
            [~,trialMaxPupP{animal,day}(cntP)] = min(pupP{animal,day}(cntP,:));
        end
        
        
        for trial = 1:length(puff1G{animal,day}(2:2:end))
            [~,trialMaxPupP1{animal,day}(trial)] = min(pupP1{animal,day}(trial,:));
        end
        
        for trial = 1:length(puff2G{animal,day}(2:2:end))
            [~,trialMaxPupP2{animal,day}(trial)] = min(pupP2{animal,day}(trial,:));
        end
    end
end
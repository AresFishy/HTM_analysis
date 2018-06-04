%Categorize omission trials based on the behavior of the mouse

pOM = {}; %Passive omission trials (no licking)
arOM = {}; %Active omission trials (would have resulted in reward)
apOM = {}; %Active omission trials (would have resulted in punishment)
for day = 7
    for animal = 1:4
        pOMcnt = 0;
        arOMcnt = 0;
        apOMcnt = 0;
        for trial = 1:size(omTrialAct{animal,day},1)
            lL = find(lickLOM{animal,day}(trial,40:60) < -5,1);
            lR = find(lickROM{animal,day}(trial,40:60) < -5,1);
            %Find passive trials
            if isempty([lL lR])
                pOMcnt = pOMcnt + 1;
                pOM{animal,day}(pOMcnt) = trial;
                %find wrong/right for tone 1
            elseif lL < lR & max(toneOM{animal,day}(trial,40:50)) < 2
                arOMcnt = arOMcnt + 1;
                arOM{animal,day}(arOMcnt) = trial;
            elseif (~isempty(lL) & isempty(lR)) & max(toneOM{animal,day}(trial,40:50)) < 2
                arOMcnt = arOMcnt + 1;
                arOM{animal,day}(arOMcnt) = trial;
            elseif lL > lR & max(toneOM{animal,day}(trial,40:50)) < 2
                apOMcnt = apOMcnt + 1;
                apOM{animal,day}(apOMcnt) = trial;
            elseif (isempty(lL) & ~isempty(lR)) & max(toneOM{animal,day}(trial,40:50)) < 2
                apOMcnt = apOMcnt + 1;
                apOM{animal,day}(apOMcnt) = trial;
                %Find wrong/right for tone 2
            elseif lL > lR & max(toneOM{animal,day}(trial,40:50)) > 2
                arOMcnt = arOMcnt + 1;
                arOM{animal,day}(arOMcnt) = trial;
            elseif (isempty(lL) & ~isempty(lR)) & max(toneOM{animal,day}(trial,40:50)) > 2
                arOMcnt = arOMcnt + 1;
                arOM{animal,day}(arOMcnt) = trial;
            elseif lL < lR & max(toneOM{animal,day}(trial,40:50)) > 2
                apOMcnt = apOMcnt + 1;
                apOM{animal,day}(apOMcnt) = trial;
            elseif (~isempty(lL) & isempty(lR)) & max(toneOM{animal,day}(trial,40:50)) > 2
                apOMcnt = apOMcnt + 1;
                apOM{animal,day}(apOMcnt) = trial;
            end
            
        end
    end
end

%Calculate mean activity for reward/punishment omission trials
for day = 7
    for animal = 1:4
        mOmTrialActR{animal,day} = squeeze(nanmean(omTrialAct{animal,day}(arOM{animal,day},:,:),1));
        mOmTrialActP{animal,day} = squeeze(nanmean(omTrialAct{animal,day}(apOM{animal,day},:,:),1));
    end
end
cOmTrialActR{day} = vertcat(mOmTrialActR{:,day});
cOmTrialActP{day} = vertcat(mOmTrialActP{:,day});
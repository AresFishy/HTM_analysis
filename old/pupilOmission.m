%Calculate pupil onset act around omission
for day = 7:8
    for animal = 1:6
        cntOM = 0;
        
        for on = 1:length(om{animal,day})
            cntOM = cntOM + 1;
            tmpPupOM{animal,day}(cntOM,:) = seqPupil{animal,day}(om{animal,day}(on),90:130);
            %Mean correct the activity
            
            pupOM{animal,day}(cntOM,:) = tmpPupOM{animal,day}(cntOM,:) - mean(seqPupil{animal,day}(om{animal,day}(on),90:100));
            
        end
        cntNoOM = 0;
        for on = 1:length(noOm{animal,day})
            cntNoOM = cntNoOM + 1;
            tmpPupNoOM{animal,day}(cntNoOM,:) = seqPupil{animal,day}(noOm{animal,day}(on),90:130);
            %Mean correct the activity
            
            pupNoOM{animal,day}(cntNoOM,:) = tmpPupNoOM{animal,day}(cntNoOM,:) - mean(seqPupil{animal,day}(noOm{animal,day}(on),90:100));
            
        end
        
    end
    pupCombOM{day} = vertcat(pupOM{:,day});
    pupCombNoOM{day} = vertcat(pupNoOM{:,day});
end

plotSEM(pupCombOM{7}')
plotSEM(pupCombNoOM{7}')
line([11 11],get(gca,'ylim'),'color','r')
refline([0 0])
xlabel('Frame #')
ylabel('Pupil diameter')
title('Pupil Omission Response')
legend({'No Omission','Omission'})



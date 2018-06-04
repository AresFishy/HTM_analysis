%Calculate pupil onset act around reward/puff
tmpPupP = {};
pupP = {};
pupCombP = {};

tmpPupP1 = {};
pupP1 = {};
pupCombP1 = {};

tmpPupP2 = {};
pupP2 = {};
pupCombP2 = {};

tmpPupR = {};
pupR = {};
pupCombR = {};

tmpPupR1 = {};
pupR1 = {};
pupCombR1 = {};

tmpPupR2 = {};
pupR2 = {};
pupCombR2 = {};
for day = 1:8
    for animal = 1:6
        
        cntR = 0;
        for on = rew{animal,day}(2:2:end)
            cntR = cntR + 1;
            tmpPupR{animal,day}(cntR,:) = seqPupil{animal,day}(on,160:200);
            %Mean correct the activity
            
            pupR{animal,day}(cntR,:) = tmpPupR{animal,day}(cntR,:) - mean(seqPupil{animal,day}(on,160:170));
            
        end
        
        cntR1 = 0;
        if length(rew1G{animal,day}(2:2:end)) > 2;
            for on = rew1G{animal,day}(2:2:end)'
                cntR1 = cntR1 + 1;
                tmpPupR1{animal,day}(cntR1,:) = seqPupil{animal,day}(on,160:200);
                %Mean correct the activity
                
                pupR1{animal,day}(cntR1,:) = tmpPupR1{animal,day}(cntR1,:) - mean(seqPupil{animal,day}(on,160:170));
                
            end
        else
            pupR1{animal,day} = NaN(1,41);
        end
        cntR2 = 0;
        if length(rew2G{animal,day}(2:2:end)) > 2;
            for on = rew2G{animal,day}(2:2:end)'
                cntR2 = cntR2 + 1;
                tmpPupR2{animal,day}(cntR2,:) = seqPupil{animal,day}(on,160:200);
                %Mean correct the activity
                
                pupR2{animal,day}(cntR2,:) = tmpPupR2{animal,day}(cntR2,:) - mean(seqPupil{animal,day}(on,160:170));
                
            end
        else
            pupR2{animal,day} = NaN(1,41);
        end
        
        cntP = 0;
        for on = puff{animal,day}(2:2:end)
            cntP = cntP + 1;
            tmpPupP{animal,day}(cntP,:) = seqPupil{animal,day}(on,160:200);
            %Mean correct the activity
            
            pupP{animal,day}(cntP,:) = tmpPupP{animal,day}(cntP,:) - mean(seqPupil{animal,day}(on,160:170));
            
        end
        
        
        cntP1 = 0;
        if length(puff1G{animal,day}(2:2:end)) > 2;
            for on = puff1G{animal,day}(2:2:end)'
                cntP1 = cntP1 + 1;
                tmpPupP1{animal,day}(cntP1,:) = seqPupil{animal,day}(on,160:200);
                %Mean correct the activity
                
                pupP1{animal,day}(cntP1,:) = tmpPupP1{animal,day}(cntP1,:) - mean(seqPupil{animal,day}(on,160:170));
                
            end
        else
            pupP1{animal,day} = NaN(length(puff1G{animal,day}(2:2:end)),41);
        end
        
        if length(puff2G{animal,day}(2:2:end)) > 2;
        cntP2 = 0;
        for on = puff2G{animal,day}(2:2:end)'
            cntP2 = cntP2 + 1;
            tmpPupP2{animal,day}(cntP2,:) = seqPupil{animal,day}(on,160:200);
            %Mean correct the activity
            
            pupP2{animal,day}(cntP2,:) = tmpPupP2{animal,day}(cntP2,:) - mean(seqPupil{animal,day}(on,160:170));
            
        end
        else
            pupP2{animal,day} = NaN(length(puff2G{animal,day}(2:2:end)),41);
        end
        
    end
    pupCombR{day} = vertcat(pupR{:,day});
    pupCombR1{day} = vertcat(pupR1{:,day});
    pupCombR2{day} = vertcat(pupR2{:,day});
    pupCombP{day} = vertcat(pupP{:,day});
    pupCombP1{day} = vertcat(pupP{:,day});
    pupCombP2{day} = vertcat(pupP{:,day});
end

%%
for day=1:8;
    
    subplot(121)
    plotSEM(pupCombR{day}','Color',[0.1*day 0.1*day 0.1*day]); hold on
    line([21 21],get(gca,'ylim'),'color','r')
    refline([0 0])
    xlabel('Frame #')
    ylabel('Pupil diameter')
    title('Pupil Reward Response')
    xlim([1 41])
    
    subplot(122)
    plotSEM(pupCombP{day}','Color',[0.1*day 0.1*day 0.1*day])
    line([21 21],get(gca,'ylim'),'color','r')
    refline([0 0])
    xlabel('Frame #')
    ylabel('Pupil diameter')
    title('Pupil Reward Response')
    xlim([1 41])
    
end
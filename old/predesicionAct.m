%Find cell responsive prior to reward/puff
%Find cell responsive prior to checkerboard


checkActR = {};
checkActMeanR = {};
checkActCombR = {};
tmpCheckActR = {};

checkActP = {};
checkActMeanP = {};
checkActCombP = {};
tmpCheckActP = {};
for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day});
            cntR = 0;
            
            for on = 1:length(rew{animal,day})
                cntR = cntR + 1;
                tmpCheckActR{animal,day}(:,cntR,:) = seqAct{animal,day}(:,rew{animal,day}(on),150:180);
                %Mean correct the activity
                for cell = 1:size(tmpCheckActR{animal,day},1)      
                    checkActR{animal,day}(cell,cntR,:) = tmpCheckActR{animal,day}(cell,cntR,:) - mean(seqAct{animal,day}(cell,rew{animal,day}(on),150:160));
                end
            end
            cntP = 0;
            for on = 1:length(puff{animal,day})
                cntP = cntP + 1;
                tmpCheckActP{animal,day}(:,cntP,:) = seqAct{animal,day}(:,puff{animal,day}(on),150:180);
                %Mean correct the activity
                for cell = 1:size(tmpCheckActP{animal,day},1)      
                    checkActP{animal,day}(cell,cntP,:) = tmpCheckActP{animal,day}(cell,cntP,:) - mean(seqAct{animal,day}(cell,puff{animal,day}(on),150:160));
                end
            end
            checkActMeanR{animal,day} = squeeze(mean(checkActR{animal,day},2));
            checkActMeanP{animal,day} = squeeze(mean(checkActP{animal,day},2));
            
            
        else %In case there was no activity for a mouse on a certain day, it will be filled with NaNs to keep indices correct (Use day 2 for dimensions)
            checkActMeanR{animal,day} = NaN(size(act{animal,2},1),31);
            checkActMeanP{animal,day} = NaN(size(act{animal,2},1),31);
        end
    end
    checkActCombR{day} = vertcat(checkActMeanR{:,day});
    checkActCombP{day} = vertcat(checkActMeanP{:,day});
end

%%
day = 1;

subplot(131)
plotSEM(checkActCombR{day}')
plotSEM(checkActCombP{day}')
line([11 11],get(gca,'ylim'),'color','r')
ylabel('dF/F')
xlabel('Frame #')
title('Onset activity around checkerboard')
legend('Puff Trials','Rew Trials')
subplot(132)
plotSEM(checkActCombR{day}(rewCellsNComb{day},:)')
plotSEM(checkActCombR{day}(puffCellsNComb{day},:)')
line([11 11],get(gca,'ylim'),'color','r')
ylabel('dF/F')
xlabel('Frame #')
title('RewN cells')
legend('Puff Trials','Rew Trials')
subplot(133)
plotSEM(checkActCombP{day}(rewCellsNComb{day},:)')
plotSEM(checkActCombP{day}(puffCellsNComb{day},:)')
line([11 11],get(gca,'ylim'),'color','r')
ylabel('dF/F')
xlabel('Frame #')
title('PuffN Cells')
legend('Puff Trials','Rew Trials')
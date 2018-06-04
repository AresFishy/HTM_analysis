for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            plot(squeeze(mean(mean(onsetAct{animal,day}(puffCells{animal,day},puff{animal,day}(2:2:end),15:25),1),3)),squeeze(mean(mean(onsetAct{animal,day}(rewCells{animal,day},puff{animal,day}(2:2:end),15:25),1),3)),'.r'); hold on
            
            plot(squeeze(mean(mean(onsetAct{animal,day}(puffCells{animal,day},rew{animal,day}(2:2:end),15:25),1),3)),squeeze(mean(mean(onsetAct{animal,day}(rewCells{animal,day},rew{animal,day}(2:2:end),15:25),1),3)),'.g'); hold on
        end
    end
end
refline([0 0])
line([0 0],get(gca,'ylim'),'color','k')
xlabel('Puff Cells Activity  dF/F')
ylabel('Reward Cells Activity  dF/F')
title('Reward vs. Puff Activity - onsetAct Frame 15:25 (185:195)')
legend('Puff Trials','Reward Trials')

%%
figure;
for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            plot(squeeze(mean(mean(onsetAct{animal,day}(rew1Cells{animal,day},rew1G{animal,day}(2:2:end),15:25),2),3))...
                ,squeeze(mean(mean(onsetAct{animal,day}(rew1Cells{animal,day},rew2G{animal,day}(2:2:end),15:25),2),3)),'.k'); hold on
            plot(squeeze(mean(mean(onsetAct{animal,day}(rew2Cells{animal,day},rew2G{animal,day}(2:2:end),15:25),2),3))...
                ,squeeze(mean(mean(onsetAct{animal,day}(rew2Cells{animal,day},rew1G{animal,day}(2:2:end),15:25),2),3)),'.r'); hold on
        end
    end
end
refline([0 0])
refline([1 0])
line([0 0],get(gca,'ylim'),'color','k')
xlabel('Reward Cells Activity to same same seq dF/F')
ylabel('Reward Cells Activity to opposite seq dF/F')
title('Reward1 and Reward2 Cell Activity - onsetAct Frame 15:25 (185:195)')

%%
figure;
for day = 1:8
    subplot(2,4,day)
    plotSEM(OnsetActCombR1{day}(rew1CellsComb{day},:)');
    plotSEM(OnsetActCombR2{day}(rew1CellsComb{day},:)');
    plotSEM(OnsetActCombR1{day}(rew2CellsComb{day},:)');
    plotSEM(OnsetActCombR2{day}(rew2CellsComb{day},:)');
end
%%
figure;
for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            plot(squeeze(mean(mean(onsetAct{animal,day}(rewCellsNeg{animal,day},2:2:end,20:30),1),3)),squeeze(mean(mean(onsetAct{animal,day}(puffCellsNeg{animal,day},2:2:end,20:30),1),3)),'.k'); hold on
        end
    end
end
refline([0 0])
line([0 0],get(gca,'ylim'),'color','k')
xlabel('RewN Cells Activity  dF/F')
ylabel('PuffN Cells Activity  dF/F')
title('RewN vs. PuffN Activity - onsetAct Frame 15:25 (185:195)')
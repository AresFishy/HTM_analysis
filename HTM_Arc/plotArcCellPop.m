%Plot arc levels for different cell populations

arcTone = [];
arcPuff = [];
arcRew = [];
arcPop = [];
arcGrat = [];

for day = 1:7
    for animal = 1:4
        if ~isempty(arcAct{animal,day})
            arcTone(animal,day) = mean(nanmean(arcAct{animal,day}(toneCells{animal,day},:)));
            arcPuff(animal,day) = mean(nanmean(arcAct{animal,day}(puffCells{animal,day},:)));
            arcRew(animal,day) = mean(nanmean(arcAct{animal,day}(rewCells{animal,day},:)));
            arcGrat(animal,day) = mean(nanmean(arcAct{animal,day}(gratCells{animal,day},:)));
            arcPop(animal,day) = mean(nanmean(arcAct{animal,day}));
            
            arcDiffTone(animal,day) = mean(abs(nanmean(arcDiff{animal,day}(toneCells{animal,day},:),2)));
            arcDiffPuff(animal,day) = mean(abs(nanmean(arcDiff{animal,day}(puffCells{animal,day},:),2)));
            arcDiffRew(animal,day) = mean(abs(nanmean(arcDiff{animal,day}(rewCells{animal,day},:),2)));
            arcDiffGrat(animal,day) = mean(abs(nanmean(arcDiff{animal,day}(gratCells{animal,day},:),2)));
            arcDiffPop(animal,day) = mean(abs(nanmean(arcDiff{animal,day},2)));
        end
        %arcGrat(animal,day) = nanmean(arcAct{animal,day}(gratCells{animal,day}));
    end
end

figure; hold on
subplot(121)
plot_sem(arcPuff','r',0.2)
plot_sem(arcRew','k',0.2)
plot_sem(arcTone','g',0.2)
%plot_sem(arcGrat','m',0.2)
plot_sem(arcPop','--.k',0.2)
title('Arc Levels')
ylabel('Arc level')
xlabel('Day')
legend('','PuffCells','','RewardCells','','ToneCells','','Population')
subplot(122)
plot_sem(arcDiffPuff','r',0.2)
plot_sem(arcDiffRew','k',0.2)
plot_sem(arcDiffTone','g',0.2)
%plot_sem(arcDiffGrat','m',0.2)
plot_sem(arcDiffPop','--.k',0.2)
title('Abs Change in Arc Levels')
ylabel('Abs Change in Arc level')
xlabel('Day')
legend('','PuffCells','','RewardCells','','ToneCells','','Population')
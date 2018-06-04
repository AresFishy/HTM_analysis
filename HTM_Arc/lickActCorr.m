%Lick vs Reward cells

%Plot correlation between lick and reward cell activity 
ccfR = [];
ccfP = [];
ccfT = [];
for day = 1:8
    for animal = 1:4
        lick = abs(lickL{animal,day}) + abs(lickR{animal,day});
        tmpR = corrcoef(lick,nanmean(act{animal,day}(rewCells{animal,day},:),1));
        ccfR(animal,day) = tmpR(1,2);
        tmpP = corrcoef(lick,nanmean(act{animal,day}(puffCells{animal,day},:),1));
        ccfP(animal,day) = tmpP(1,2);
        tmpT = corrcoef(lick,nanmean(act{animal,day}(toneCells{animal,day},:),1));
        ccfT(animal,day) = tmpT(1,2);
    end
end

plot_sem(ccfR','k'); hold on
plot_sem(ccfP','r'); 
plot_sem(ccfT','g'); 
ylabel('Correlation')
xlabel('Day')
legend('','RewCells','','PuffCells','','ToneCells')
title('Lick vs Cell Activity Correlation')
ylim([-0.1 1])
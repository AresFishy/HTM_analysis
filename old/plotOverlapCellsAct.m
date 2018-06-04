overlapCellsAct= [];
nonoverlapCellsAct = [];
overlapCellsActComb = [];
nonoverlapCellsActComb = [];

for day = 1:5
    for ele = 1:10
        
        a = intersect(selCellsComb{day,ele},selCellsComb{day+1,ele});
        b = setdiff(selCellsComb{day,ele},a);
        
        overlapCellsAct(day,ele,:) = nanmean(OnsetActComb{day,ele}(a,:));
        nonoverlapCellsAct(day,ele,:) = nanmean(OnsetActComb{day,ele}(b,:));
    end
    overlapCellsActComb(day,:) = squeeze(nanmean(overlapCellsAct(day,:,:),2));
    nonoverlapCellsActComb(day,:) = squeeze(nanmean(nonoverlapCellsAct(day,:,:),2));
    
    subplot(2,3,day)
    str = sprintf('Day %d to %d',day,day+1);
    plot(overlapCellsActComb(day,:)); hold on
    plot(nonoverlapCellsActComb(day,:));
    ylim([-0.005 0.05])
    refline([0 0])
    legend('Overlap Cells','Nonoverlap Cells','Location','southeast')
    ylabel('dF/F')
    xlabel('Frames')
    title(str)
end

subplot(236)
bar(1,mean(max(nonoverlapCellsActComb')./max(overlapCellsActComb'))); hold on
errorbar(1,mean(max(nonoverlapCellsActComb')./max(overlapCellsActComb')),std(max(nonoverlapCellsActComb')./max(overlapCellsActComb')))
ylim([0 1])
title('Ratio in max act for nonoverlap/overlap cells')
ylabel('Ratio')


%%
overlapCellsAct= [];
nonoverlapCellsAct = [];
overlapCellsActComb = [];
nonoverlapCellsActComb = [];
for day = 1:5
    
    
    a = intersect(actCorrCellComb{day},actCorrCellComb{day+1});
    b = setdiff(actCorrCellComb{day},a);
    
    overlapCellsAct(day,:) = nanmean(seqActComb1{day}(a,:));
    nonoverlapCellsAct(day,:) = nanmean(seqActComb1{day}(b,:));
    
    subplot(2,3,day)
    str = sprintf('Day %d to %d',day,day+1);
    plot(overlapCellsAct(day,:)); hold on
    plot(nonoverlapCellsAct(day,:));
    
    refline([0 0])
    legend('Overlap Cells','Nonoverlap Cells','Location','southeast')
    ylabel('dF/F')
    xlabel('Frames')
    title(str)
    ylim([0.95 1.1])
end

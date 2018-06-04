for day  = 1:8
    subplot(2,4,day)
    str = sprintf('Day %d',day);
    plotSEM(conseqActCombP{day}(puffCellsComb{day},:)')
    plotSEM(nonseqActCombP{day}(puffCellsComb{day},:)')
    plotSEM(conseqActCombR{day}(rewCellsComb{day},:)')
    plotSEM(nonseqActCombR{day}(rewCellsComb{day},:)')
    ylim([0 0.4])
    xlim([0 31])
    line([11 11],get(gca,'ylim'),'color','k')
    legend({'Rew non','Puff non','Puff con','Rew con'},'Location','southeast')
    title(str)
    ylabel('dF/F')
    xlabel('Frame #')
end

%%
for day = 1:8
    tmpCACP(day,:) = mean(conseqActCombP{day}(puffCellsComb{day},:),1);
    tmpNACP(day,:) = mean(nonseqActCombP{day}(puffCellsComb{day},:),1);
    tmpCACR(day,:) = mean(conseqActCombR{day}(rewCellsComb{day},:),1);
    tmpNACR(day,:) = mean(nonseqActCombR{day}(rewCellsComb{day},:),1);
end

figure;
subplot(121)
plotSEM(tmpCACP')
plotSEM(tmpNACP')
ylim([0 0.3])
xlim([0 31])
line([11 11],get(gca,'ylim'),'color','k')
legend({'Non-consecutive','Consecutive'},'Location','southeast')
title('Puff Cell Act')
ylabel('dF/F')
xlabel('Frame #')

subplot(122)
plotSEM(tmpCACR')
plotSEM(tmpNACR')
ylim([0 0.3])
xlim([0 31])
line([11 11],get(gca,'ylim'),'color','k')
legend({'Non-consecutive','Consecutive'},'Location','southeast')
title('Reward Cell Act')
ylabel('dF/F')
xlabel('Frame #')
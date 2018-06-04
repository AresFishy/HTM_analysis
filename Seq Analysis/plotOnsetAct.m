
day = 6;

figure;
plotSEM(OnsetActComb{day,2}(selCellsComb{day,2},:)'); hold on
plotSEM(OnsetActComb{day,7}(selCellsComb{day,2},:)')

ylim([-.015 0.05])
ylabel('dF/F')
xlabel('Frame #')
line([15 15],get(gca,'ylim'),'color','k')
refline([0 0])
title('Response to element n-1 - Day 1')
legend('2 to 1', '3 to 2')

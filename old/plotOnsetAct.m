
day = 7;

figure;
plotSEM(OnsetActComb{day,9}(selCellsComb{day,9},:)'); hold on
plotSEM(OnsetActComb{day,4}(selCellsComb{day,9},:)')



ylim([-.015 0.05])
ylabel('dF/F')
xlabel('Frame #')
line([15 15],get(gca,'ylim'),'color','k')
refline([0 0])
title('Response to element n-1 - Day 1')
legend('2 to 1', '3 to 2')

cells = 2;
day = 7;

figure;
plotSEM(OnsetActCombNoOM{day,5}(selCellsComb{day,5},:)'); hold on
plotSEM(OnsetActCombOM{day,5}(selCellsComb{day,5},:)')
axis tight;
ylim([-.005 0.04])
line([15 15],get(gca,'ylim'),'color','k')
refline([0 0])
title('Response of element 5 cells to element 5 - Day 7 (1)')
legend('Omission','No Omission')

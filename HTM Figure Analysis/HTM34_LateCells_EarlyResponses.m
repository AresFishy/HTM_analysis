%Find late stimulus cells and plot their early respnses

toneCellsLate = unique([cToneCells{6},cToneCells{7}]);
puffCellsLate = unique([cPuffCells{6},cPuffCells{7}]);
rewCellsLate = unique([cRewCells{6},cRewCells{7}]);

figure;
subplot(131)
plot_sem([tone_respComb{2}(toneCellsLate,:); tone_respComb{3}(toneCellsLate,:)]','m',0.3)
plot_sem([puff_respComb{2}(toneCellsLate,:); puff_respComb{3}(toneCellsLate,:)]','k',0.3)
plot_sem([rew_respComb{2}(toneCellsLate,:); rew_respComb{3}(toneCellsLate,:)]','g',0.3)
xlim([1 131]); ylim([1 1.035])
line([51 51],ylim,'color','k','LineStyle','--')
title('Late Tone Cells Early Reponses')
legend('','Tone Response','','Puff Response','','Reward Response')
ylabel('dF/F'); xlabel('Frame')
subplot(132)
plot_sem([tone_respComb{2}(puffCellsLate,:); tone_respComb{3}(puffCellsLate,:)]','m',0.3)
plot_sem([puff_respComb{2}(puffCellsLate,:); puff_respComb{3}(puffCellsLate,:)]','k',0.3)
plot_sem([rew_respComb{2}(puffCellsLate,:); rew_respComb{3}(puffCellsLate,:)]','g',0.3)
xlim([1 131]); ylim([1 1.035])
line([51 51],ylim,'color','k','LineStyle','--')
title('Late Puff Cells Early Reponses')
legend('','Tone Response','','Puff Response','','Reward Response')
ylabel('dF/F'); xlabel('Frame')

subplot(133)
plot_sem([tone_respComb{2}(rewCellsLate,:); tone_respComb{3}(rewCellsLate,:)]','m',0.3)
plot_sem([puff_respComb{2}(rewCellsLate,:); puff_respComb{3}(rewCellsLate,:)]','k',0.3)
plot_sem([rew_respComb{2}(rewCellsLate,:); rew_respComb{3}(rewCellsLate,:)]','g',0.3)
xlim([1 131]); ylim([1 1.035])
line([51 51],ylim,'color','k','LineStyle','--')
title('Late Reward Cells Early Reponses')
legend('','Tone Response','','Puff Response','','Reward Response')
ylabel('dF/F'); xlabel('Frame')

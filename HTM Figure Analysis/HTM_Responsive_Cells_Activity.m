%Plot the response of stimulus selective cells

figure;
subplot(131)
plot_sem([tone_respCombHalf{2}(cToneCells{2},:);tone_respCombHalf{3}(cToneCells{3},:)]' - ...
    mean2([tone_respCombHalf{2}(cToneCells{2},40:49);tone_respCombHalf{3}(cToneCells{3},40:49)]),'m')
plot_sem([tone_respCombHalf{6}(cToneCells{6},:);tone_respCombHalf{7}(cToneCells{7},:)]' - ...
    mean2([tone_respCombHalf{6}(cToneCells{6},40:49);tone_respCombHalf{7}(cToneCells{7},40:49)]),'--m',0.3)
plot_sem([puff_respCombHalf{2}(cToneCells{2},:);puff_respCombHalf{3}(cToneCells{3},:)]' - ...
    mean2([puff_respCombHalf{2}(cToneCells{2},40:49);puff_respCombHalf{3}(cToneCells{3},40:49)]),'k')
plot_sem([puff_respCombHalf{6}(cToneCells{6},:);puff_respCombHalf{7}(cToneCells{7},:)]' - ...
    mean2([puff_respCombHalf{6}(cToneCells{6},40:49);puff_respCombHalf{7}(cToneCells{7},40:49)]),'--k',0.3)
plot_sem([rew_respCombHalf{2}(cToneCells{2},:);rew_respCombHalf{3}(cToneCells{3},:)]' - ...
    mean2([rew_respCombHalf{2}(cToneCells{2},40:49);rew_respCombHalf{3}(cToneCells{3},40:49)]),'r')
plot_sem([rew_respCombHalf{6}(cToneCells{6},:);rew_respCombHalf{7}(cToneCells{7},:)]' - ...
    mean2([rew_respCombHalf{6}(cToneCells{6},40:49);rew_respCombHalf{7}(cToneCells{7},40:49)]),'--r',0.3)
ylim([-0.01 0.06]); xlim([45 70]);
title('Tone Cells'); ylabel('dF/F'); xlabel('Frame')
legend('','Tone Act Early','','Tone Act Late','','Puff Act Early','','Puff Act Late','','Reward Act Early','','Reward Act Late');
line(xlim,[0 0],'Color','k','LineStyle','-')
line([51 51],ylim,'Color','k','LineStyle','-')

%Plot the response of stimulus selective cells

subplot(132)
plot_sem([tone_respCombHalf{2}(cPuffCells{2},:);tone_respCombHalf{3}(cPuffCells{3},:)]' - ...
    mean2([tone_respCombHalf{2}(cPuffCells{2},40:49);tone_respCombHalf{3}(cPuffCells{3},40:49)]),'m')
plot_sem([tone_respCombHalf{6}(cPuffCells{6},:);tone_respCombHalf{7}(cPuffCells{7},:)]' - ...
    mean2([tone_respCombHalf{6}(cPuffCells{6},40:49);tone_respCombHalf{7}(cPuffCells{7},40:49)]),'--m',0.3)
plot_sem([puff_respCombHalf{2}(cPuffCells{2},:);puff_respCombHalf{3}(cPuffCells{3},:)]' - ...
    mean2([puff_respCombHalf{2}(cPuffCells{2},40:49);puff_respCombHalf{3}(cPuffCells{3},40:49)]),'k')
plot_sem([puff_respCombHalf{6}(cPuffCells{6},:);puff_respCombHalf{7}(cPuffCells{7},:)]' - ...
    mean2([puff_respCombHalf{6}(cPuffCells{6},40:49);puff_respCombHalf{7}(cPuffCells{7},40:49)]),'--k',0.3)
plot_sem([rew_respCombHalf{2}(cPuffCells{2},:);rew_respCombHalf{3}(cPuffCells{3},:)]' - ...
    mean2([rew_respCombHalf{2}(cPuffCells{2},40:49);rew_respCombHalf{3}(cPuffCells{3},40:49)]),'r')
plot_sem([rew_respCombHalf{6}(cPuffCells{6},:);rew_respCombHalf{7}(cPuffCells{7},:)]' - ...
    mean2([rew_respCombHalf{6}(cPuffCells{6},40:49);rew_respCombHalf{7}(cPuffCells{7},40:49)]),'--r',0.3)
ylim([-0.01 0.06]); xlim([45 70]);
title('Puff Cells'); ylabel('dF/F'); xlabel('Frame')
line(xlim,[0 0],'Color','k','LineStyle','-')
line([51 51],ylim,'Color','k','LineStyle','-')

%Plot the response of stimulus selective cells

subplot(133)
plot_sem([tone_respCombHalf{2}(cRewCells{2},:);tone_respCombHalf{3}(cRewCells{3},:)]' - ...
    mean2([tone_respCombHalf{2}(cRewCells{2},40:49);tone_respCombHalf{3}(cRewCells{3},40:49)]),'m')
plot_sem([tone_respCombHalf{6}(cRewCells{6},:);tone_respCombHalf{7}(cRewCells{7},:)]' - ...
    mean2([tone_respCombHalf{6}(cRewCells{6},40:49);tone_respCombHalf{7}(cRewCells{7},40:49)]),'--m',0.3)
plot_sem([puff_respCombHalf{2}(cRewCells{2},:);puff_respCombHalf{3}(cRewCells{3},:)]' - ...
    mean2([puff_respCombHalf{2}(cRewCells{2},40:49);puff_respCombHalf{3}(cRewCells{3},40:49)]),'k')
plot_sem([puff_respCombHalf{6}(cRewCells{6},:);puff_respCombHalf{7}(cRewCells{7},:)]' - ...
    mean2([puff_respCombHalf{6}(cRewCells{6},40:49);puff_respCombHalf{7}(cRewCells{7},40:49)]),'--k',0.3)
plot_sem([rew_respCombHalf{2}(cRewCells{2},:);rew_respCombHalf{3}(cRewCells{3},:)]' - ...
    mean2([rew_respCombHalf{2}(cRewCells{2},40:49);rew_respCombHalf{3}(cRewCells{3},40:49)]),'r')
plot_sem([rew_respCombHalf{6}(cRewCells{6},:);rew_respCombHalf{7}(cRewCells{7},:)]' - ...
    mean2([rew_respCombHalf{6}(cRewCells{6},40:49);rew_respCombHalf{7}(cRewCells{7},40:49)]),'--r',0.3)
ylim([-0.01 0.06]); xlim([45 70]);
title('Reward Cells'); ylabel('dF/F'); xlabel('Frame')
line(xlim,[0 0],'Color','k','LineStyle','-')
line([51 51],ylim,'Color','k','LineStyle','-')


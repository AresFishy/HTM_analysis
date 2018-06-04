for day = 1:7
   stimCells{day} = unique([cToneCells{day} cPuffCells{day} cRewCells{day}]);
   nostimCells{day} = setdiff(1:3090,stimCells{day});
end

figure;
subplot(131)
plot_sem([tone_respCombHalf{2}(stimCells{2},:); tone_respCombHalf{3}(stimCells{3},:)]'-...
    mean2([tone_respCombHalf{2}(stimCells{2},1:10); tone_respCombHalf{3}(stimCells{3},1:10)]),'r',0.3)
plot_sem([tone_respCombHalf{6}(stimCells{6},:); tone_respCombHalf{7}(stimCells{7},:)]'-...
    mean2([tone_respCombHalf{6}(stimCells{6},1:10); tone_respCombHalf{7}(stimCells{7},1:10)]),'--r',0.3)
plot_sem([tone_respCombHalf{2}(nostimCells{2},:); tone_respCombHalf{3}(nostimCells{3},:)]'-...
    mean2([tone_respCombHalf{2}(nostimCells{2},1:10); tone_respCombHalf{3}(nostimCells{3},1:10)]),'b')
plot_sem([tone_respCombHalf{6}(nostimCells{6},:); tone_respCombHalf{7}(nostimCells{7},:)]'-...
    mean2([tone_respCombHalf{6}(nostimCells{6},1:10); tone_respCombHalf{7}(nostimCells{7},1:10)]),'--b')
xlim([1 200]); ylim([-0.01 0.035])
line(xlim,[0 0],'Color','k','LineStyle','--')
line([51 51],ylim,'Color','k','LineStyle','--')
line([71 71],ylim,'Color','k','LineStyle','--')
legend('','StimCells Early','','StimeCells Late','','NoStimCells Early','','NoStimeCells Late','')
ylabel('dF/F'); xlabel('Frame #')
title('Tone Activity')

subplot(132)
plot_sem([puff_respCombHalf{2}(stimCells{2},:); puff_respCombHalf{3}(stimCells{3},:)]'-...
    mean2([puff_respCombHalf{2}(stimCells{2},1:10); puff_respCombHalf{3}(stimCells{3},1:10)]),'r',0.3)
plot_sem([puff_respCombHalf{6}(stimCells{6},:); puff_respCombHalf{7}(stimCells{7},:)]'-...
    mean2([puff_respCombHalf{6}(stimCells{6},1:10); puff_respCombHalf{7}(stimCells{7},1:10)]),'--r',0.3)
plot_sem([puff_respCombHalf{2}(nostimCells{2},:); puff_respCombHalf{3}(nostimCells{3},:)]'-...
    mean2([puff_respCombHalf{2}(nostimCells{2},1:10); puff_respCombHalf{3}(nostimCells{3},1:10)]),'b')
plot_sem([puff_respCombHalf{6}(nostimCells{6},:); puff_respCombHalf{7}(nostimCells{7},:)]'-...
    mean2([puff_respCombHalf{6}(nostimCells{6},1:10); puff_respCombHalf{7}(nostimCells{7},1:10)]),'--b')
xlim([1 200]); ylim([-0.01 0.035])
line(xlim,[0 0],'Color','k','LineStyle','--')
line([51 51],ylim,'Color','k','LineStyle','--')
line([71 71],ylim,'Color','k','LineStyle','--')
legend('','StimCells Early','','StimeCells Late','','NoStimCells Early','','NoStimeCells Late','')
ylabel('dF/F'); xlabel('Frame #')
title('Puff Activity')

subplot(133)
plot_sem([rew_respCombHalf{2}(stimCells{2},:); rew_respCombHalf{3}(stimCells{3},:)]'-...
    mean2([rew_respCombHalf{2}(stimCells{2},1:10); rew_respCombHalf{3}(stimCells{3},1:10)]),'r',0.3)
plot_sem([rew_respCombHalf{6}(stimCells{6},:); rew_respCombHalf{7}(stimCells{7},:)]'-...
    mean2([rew_respCombHalf{6}(stimCells{6},1:10); rew_respCombHalf{7}(stimCells{7},1:10)]),'--r',0.3)
plot_sem([rew_respCombHalf{2}(nostimCells{2},:); rew_respCombHalf{3}(nostimCells{3},:)]'-...
    mean2([rew_respCombHalf{2}(nostimCells{2},1:10); rew_respCombHalf{3}(nostimCells{3},1:10)]),'b')
plot_sem([rew_respCombHalf{6}(nostimCells{6},:); rew_respCombHalf{7}(nostimCells{7},:)]'-...
    mean2([rew_respCombHalf{6}(nostimCells{6},1:10); rew_respCombHalf{7}(nostimCells{7},1:10)]),'--b')
xlim([1 200]); ylim([-0.01 0.035])
line(xlim,[0 0],'Color','k','LineStyle','--')
line([51 51],ylim,'Color','k','LineStyle','--')
line([71 71],ylim,'Color','k','LineStyle','--')
legend('','StimCells Early','','StimeCells Late','','NoStimCells Early','','NoStimeCells Late','')
ylabel('dF/F'); xlabel('Frame #')
title('Reward Activity')
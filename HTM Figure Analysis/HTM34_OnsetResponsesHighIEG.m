%Plot Tone Responses for population, high IEG early and late

figure;
subplot(121)
% plot_sem([tone_respComb{2}(cArcCells{2},:); tone_respComb{3}(cArcCells{3},:)]'-mean2([tone_respComb{2}(cArcCells{2},41:49); tone_respComb{3}(cArcCells{3},41:49)]),'b',0.3);
% plot_sem([tone_respComb{6}(cArcCells{6},:); tone_respComb{7}(cArcCells{7},:)]'-mean2([tone_respComb{6}(cArcCells{6},41:49); tone_respComb{7}(cArcCells{7},41:49)]),'--b',0.3);
plot_sem([tone_respComb{2}(arcCells,:); tone_respComb{3}(arcCells,:)]'-mean2([tone_respComb{2}(arcCells,41:49); tone_respComb{3}(arcCells,41:49)]),'k',0.3);
plot_sem([tone_respComb{6}(arcCells,:); tone_respComb{7}(arcCells,:)]'-mean2([tone_respComb{6}(arcCells,41:49); tone_respComb{7}(arcCells,41:49)]),'--k',0.3);
xlim([40 70]); ylim([-0.005 0.01])
line(xlim,[0 0],'Color','k','LineStyle','--')
line([50 50],ylim,'Color','k','LineStyle','--')
title('Tone Response')
legend('','High Arc Early','','High Arc Late','','Population Early','','Population Late')
xlabel('Frame #'); ylabel('dF/F')
subplot(122)
% plot_sem([tone_respComb{2}(cCfosCells{2},:); tone_respComb{3}(cCfosCells{3},:)]'-mean2([tone_respComb{2}(cCfosCells{2},41:49); tone_respComb{3}(cCfosCells{3},41:49)]),'r',0.3);
% plot_sem([tone_respComb{6}(cCfosCells{6},:); tone_respComb{7}(cCfosCells{7},:)]'-mean2([tone_respComb{6}(cCfosCells{6},41:49); tone_respComb{7}(cCfosCells{7},41:49)]),'--r',0.3);
plot_sem([tone_respComb{2}(cfosCells,:); tone_respComb{3}(cfosCells,:)]'-mean2([tone_respComb{2}(cfosCells,41:49); tone_respComb{3}(cfosCells,41:49)]),'k',0.3);
plot_sem([tone_respComb{6}(cfosCells,:); tone_respComb{7}(cfosCells,:)]'-mean2([tone_respComb{6}(cfosCells,41:49); tone_respComb{7}(cfosCells,41:49)]),'--k',0.3);
xlim([40 70]); ylim([-0.005 0.01])
line(xlim,[0 0],'Color','k','LineStyle','--')
line([50 50],ylim,'Color','k','LineStyle','--')
title('Tone Response')
legend('','High cFos Early','','High cFos Late','','Population Early','','Population Late')
xlabel('Frame #'); ylabel('dF/F')

%%
%Plot Puff Responses for population, high IEG early and late

figure;
subplot(121)
plot_sem([puff_respComb{2}(cArcCells{2},:); puff_respComb{3}(cArcCells{3},:)]'-mean2([puff_respComb{2}(cArcCells{2},41:49); puff_respComb{3}(cArcCells{3},41:49)]),'b',0.3);
plot_sem([puff_respComb{6}(cArcCells{6},:); puff_respComb{7}(cArcCells{7},:)]'-mean2([puff_respComb{6}(cArcCells{6},41:49); puff_respComb{7}(cArcCells{7},41:49)]),'--b',0.3);
plot_sem([puff_respComb{2}(arcCells,:); puff_respComb{3}(arcCells,:)]'-mean2([puff_respComb{2}(arcCells,41:49); puff_respComb{3}(arcCells,41:49)]),'k',0.3);
plot_sem([puff_respComb{6}(arcCells,:); puff_respComb{7}(arcCells,:)]'-mean2([puff_respComb{6}(arcCells,41:49); puff_respComb{7}(arcCells,41:49)]),'--k',0.3);
xlim([40 70]); ylim([-0.005 0.02])
line(xlim,[0 0],'Color','k','LineStyle','--')
line([50 50],ylim,'Color','k','LineStyle','--')
title('Puff Response')
legend('','High Arc Early','','High Arc Late','','Population Early','','Population Late')
xlabel('Frame #'); ylabel('dF/F')
subplot(122)
plot_sem([puff_respComb{2}(cCfosCells{2},:); puff_respComb{3}(cCfosCells{3},:)]'-mean2([puff_respComb{2}(cCfosCells{2},41:49); puff_respComb{3}(cCfosCells{3},41:49)]),'r',0.3);
plot_sem([puff_respComb{6}(cCfosCells{6},:); puff_respComb{7}(cCfosCells{7},:)]'-mean2([puff_respComb{6}(cCfosCells{6},41:49); puff_respComb{7}(cCfosCells{7},41:49)]),'--r',0.3);
plot_sem([puff_respComb{2}(cfosCells,:); puff_respComb{3}(cfosCells,:)]'-mean2([puff_respComb{2}(cfosCells,41:49); puff_respComb{3}(cfosCells,41:49)]),'k',0.3);
plot_sem([puff_respComb{6}(cfosCells,:); puff_respComb{7}(cfosCells,:)]'-mean2([puff_respComb{6}(cfosCells,41:49); puff_respComb{7}(cfosCells,41:49)]),'--k',0.3);
xlim([40 70]); ylim([-0.005 0.02])
line(xlim,[0 0],'Color','k','LineStyle','--')
line([50 50],ylim,'Color','k','LineStyle','--')
title('Puff Response')
legend('','High cFos Early','','High cFos Late','','Population Early','','Population Late')
xlabel('Frame #'); ylabel('dF/F')

%%
%Plot Reward Responses for population, high IEG early and late

figure;
subplot(121)
plot_sem([rew_respComb{2}(cArcCells{2},:); rew_respComb{3}(cArcCells{3},:)]'-mean2([rew_respComb{2}(cArcCells{2},41:49); rew_respComb{3}(cArcCells{3},41:49)]),'b',0.3);
plot_sem([rew_respComb{6}(cArcCells{6},:); rew_respComb{7}(cArcCells{7},:)]'-mean2([rew_respComb{6}(cArcCells{6},41:49); rew_respComb{7}(cArcCells{7},41:49)]),'--b',0.3);
plot_sem([rew_respComb{2}(arcCells,:); rew_respComb{3}(arcCells,:)]'-mean2([rew_respComb{2}(arcCells,41:49); rew_respComb{3}(arcCells,41:49)]),'k',0.3);
plot_sem([rew_respComb{6}(arcCells,:); rew_respComb{7}(arcCells,:)]'-mean2([rew_respComb{6}(arcCells,41:49); rew_respComb{7}(arcCells,41:49)]),'--k',0.3);
xlim([40 70]); ylim([-0.01 0.02])
line(xlim,[0 0],'Color','k','LineStyle','--')
line([50 50],ylim,'Color','k','LineStyle','--')
title('Reward Response')
legend('','High Arc Early','','High Arc Late','','Population Early','','Population Late')
xlabel('Frame #'); ylabel('dF/F')
subplot(122)
plot_sem([rew_respComb{2}(cCfosCells{2},:); rew_respComb{3}(cCfosCells{3},:)]'-mean2([rew_respComb{2}(cCfosCells{2},41:49); rew_respComb{3}(cCfosCells{3},41:49)]),'r',0.3);
plot_sem([rew_respComb{6}(cCfosCells{6},:); rew_respComb{7}(cCfosCells{7},:)]'-mean2([rew_respComb{6}(cCfosCells{6},41:49); rew_respComb{7}(cCfosCells{7},41:49)]),'--r',0.3);
plot_sem([rew_respComb{2}(cfosCells,:); rew_respComb{3}(cfosCells,:)]'-mean2([rew_respComb{2}(cfosCells,41:49); rew_respComb{3}(cfosCells,41:49)]),'k',0.3);
plot_sem([rew_respComb{6}(cfosCells,:); rew_respComb{7}(cfosCells,:)]'-mean2([rew_respComb{6}(cfosCells,41:49); rew_respComb{7}(cfosCells,41:49)]),'--k',0.3);
xlim([40 70]); ylim([-0.01 0.02])
line(xlim,[0 0],'Color','k','LineStyle','--')
line([50 50],ylim,'Color','k','LineStyle','--')
title('Reward Response')
legend('','High cFos Early','','High cFos Late','','Population Early','','Population Late')
xlabel('Frame #'); ylabel('dF/F')
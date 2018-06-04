figure;
subplot(121)
plot_sem([puff_respActComb{2}; puff_respActComb{3}]'-mean2([puff_respActComb{2}(:,1:10); puff_respActComb{3}(:,1:10)]),'k',0.3)
plot_sem([rew_respActComb{2}; rew_respActComb{3}]'-mean2([rew_respActComb{2}(:,1:10); rew_respActComb{3}(:,1:10)]),'g',0.3)

plot_sem([puff_respActComb{6}; puff_respActComb{7}]'-mean2([puff_respActComb{6}(:,1:10); puff_respActComb{7}(:,1:10)]),'--k',0.3)
plot_sem([rew_respActComb{6}; rew_respActComb{7}]'-mean2([rew_respActComb{6}(:,1:10); rew_respActComb{7}(:,1:10)]),'--g',0.3)
xlim([31 91])
line(xlim,[0 0],'color','k'); line([51 51],ylim,'color','k');
ylabel('dF/F'); xlabel('Time [s]')
title('Puff-Reward Activity')
legend('','Puff Resp Early','','Reward Resp Early','','Puff Resp Late','','Reward Resp Late')
set(gca,'XTick',[31 41 51 61 71 81 91 101 111 121 131],'XTickLabel',{'-2','-1','0','1','2','3','4','5','6','7','8'})

subplot(122)
plot_sem(abs([lickPuffComb{2},lickPuffComb{3}]),'k',0.3);
plot_sem(abs([lickPuffComb{6},lickPuffComb{7}]),'--k',0.3);
plot_sem(abs([lickRewComb{2},lickRewComb{3}]),'g',0.3);
plot_sem(abs([lickRewComb{6},lickRewComb{7}]),'--g',0.3);
xlim([31 91])
line(xlim,[0 0],'color','k'); line([51 51],ylim,'color','k');
ylabel('Lick'); xlabel('Time [s]')
title('Puff-Reward Activity')
legend('','Lick Puff Resp Early','','Lick Reward Resp Early','','Lick Puff Resp Late','','Lick Reward Resp Late')
set(gca,'XTick',[31 41 51 61 71 81 91 101 111 121 131],'XTickLabel',{'-2','-1','0','1','2','3','4','5','6','7','8'})

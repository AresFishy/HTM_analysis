nToneCells6 = setdiff(1:3090,cToneCells{6});
nToneCells7 = setdiff(1:3090,cToneCells{7});

figure;
subplot(121)
plot_sem(([tone_respRComb{6}(cToneCells{6},:); tone_respRComb{7}(cToneCells{7},:)]-mean2([tone_respRComb{6}(cToneCells{6},40:49); tone_respRComb{7}(cToneCells{7},40:49)]))','g',0.3)
plot_sem(([tone_respPAComb{6}(cToneCells{6},:); tone_respPAComb{7}(cToneCells{7},:)]-mean2([tone_respPAComb{6}(cToneCells{6},40:49); tone_respPAComb{7}(cToneCells{7},40:49)]))','k',0.3)
plot_sem(([tone_respPPComb{6}(cToneCells{6},:); tone_respPPComb{7}(cToneCells{7},:)]-mean2([tone_respPPComb{6}(cToneCells{6},40:49); tone_respPPComb{7}(cToneCells{7},40:49)]))',[0.4 0.4 0.4],0.3)
plot_sem(([tone_respRComb{6}(nToneCells6,:); tone_respRComb{7}(nToneCells7,:)]-mean2([tone_respRComb{6}(nToneCells6,40:49); tone_respRComb{7}(nToneCells7,40:49)]))','--g',0.3)
plot_sem(([tone_respPAComb{6}(nToneCells6,:); tone_respPAComb{7}(nToneCells7,:)]-mean2([tone_respPAComb{6}(nToneCells6,40:49); tone_respPAComb{7}(nToneCells7,40:49)]))','--k',0.3)

legend('','Reward','','Active Puff','','Passive Puff')
xlim([31 131])
line(xlim,[0 0],'color','k'); line([51 51],ylim,'color','k');
ylabel('dF/F'); xlabel('Time [s]')
set(gca,'XTick',[31 41 51 61 71 81 91 101 111 121 131],'XTickLabel',{'-2','-1','0','1','2','3','4','5','6','7','8'})
title('Tone Cells Response - Late')

subplot(122)
%plot_sem(abs([lickPuffComb{2},lickPuffComb{3}]),'k',0.3);
plot_sem(abs([lickPuffComb{6},lickPuffComb{7}]),'k',0.3);
%plot_sem(abs([lickRewComb{2},lickRewComb{3}]),'g',0.3);
plot_sem(abs([lickRewComb{6},lickRewComb{7}]),'g',0.3);
xlim([31 131])
line(xlim,[0 0],'color','k'); line([51 51],ylim,'color','k');
ylabel('Lick'); xlabel('Time [s]')
title('Puff-Reward Activity')
legend('','Lick Puff Resp Early','','Lick Reward Resp Early','','Lick Puff Resp Late','','Lick Reward Resp Late')
set(gca,'XTick',[31 41 51 61 71 81 91 101 111 121 131],'XTickLabel',{'-2','-1','0','1','2','3','4','5','6','7','8'})

%%
tR = mean([tone_respRComb{6}(cToneCells{6},55:70); tone_respRComb{7}(cToneCells{7},55:70)]-mean2([tone_respRComb{6}(cToneCells{6},40:49); tone_respRComb{7}(cToneCells{7},40:49)]),2);
tP = mean([tone_respPAComb{6}(cToneCells{6},55:70); tone_respPAComb{7}(cToneCells{7},55:70)]-mean2([tone_respPPComb{6}(cToneCells{6},40:49); tone_respPPComb{7}(cToneCells{7},40:49)]),2);
ranksum(tR,tP)

%%
plot_sem(([tone_respRComb{6}(cHighIEG,:); tone_respRComb{7}(cHighIEG,:)]-mean2([tone_respRComb{6}(cHighIEG,40:49); tone_respRComb{7}(cHighIEG,40:49)]))','g',0.3)
plot_sem(([tone_respPAComb{6}(cHighIEG,:); tone_respPAComb{7}(cHighIEG,:)]-mean2([tone_respPAComb{6}(cHighIEG,40:49); tone_respPAComb{7}(cHighIEG,40:49)]))','k',0.3)
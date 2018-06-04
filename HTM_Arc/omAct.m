%Plot omission trials for positive responsive cells

day = 7;

figure;
plot_sem(cRewTrialAct{day}(cRewCells{day},:)','k',0.5)
hold on
plot_sem(cOmTrialActR{day}(cRewCells{day},:)','r',0.5)
plot_sem(cOmTrialActR{day}(setdiff(cRewCells{day},cToneCells{day}),:)','m',0.5)
plot_sem(cOmTrialActR{day}(setdiff(cToneCells{day},cRewCells{day}),:)','c',0.5)
axis tight;
ylim([-0.01 0.12])
line([20 20],ylim,'color','b','LineStyle','--')
line([40 40],ylim,'color','b')
legend('','Reward Trials RewCells','','Omission Trials RewCells','','OM Rew Cells not Tone','','OM Tone cells not Rew')
ylabel('dF/F')
xlabel('Frame #')
title('Reward Day 7')

figure;
plot_sem(caPuffTrialAct{day}(cPuffCells{day},:)','k',0.5)
hold on
plot_sem(cOmTrialActP{day}(cPuffCells{day},:)','r',0.5)
plot_sem(cOmTrialActP{day}(setdiff(cPuffCells{day},cToneCells{day}),:)','m',0.5)
plot_sem(cOmTrialActP{day}(setdiff(cToneCells{day},cPuffCells{day}),:)','c',0.5)
axis tight;
ylim([-0.01 0.12])
line([20 20],ylim,'color','b','LineStyle','--')
line([40 40],ylim,'color','b')
legend('','aPuff Trials PuffCells','','Omission Trials PuffCElls','','OM Puff Cells not Tone','','OM Tone cells not Puff')
ylabel('dF/F')
xlabel('Frame #')
title('aPuff Day 7')

figure;
plot_sem(cTrialAct{7}','k',0.5)
plot_sem(cOmTrialAct{7}','r',0.5)
legend('','Trial Activity','','Omission Trial Activity')
axis tight
line([20 20],ylim,'color','b','LineStyle','--')
line([40 40],ylim,'color','b')
ylabel('dF/F')
xlabel('Frame #')
title('Trial vs Omission Trial Population Response')

%%
%Plot omission trials for positive responsive cells

day = 7;

figure;
plot_sem(cRewTrialAct{day}(cnRewCells{day},:)','k',0.5)
hold on
plot_sem(cOmTrialActR{day}(cnRewCells{day},:)','r',0.5)
plot_sem(cOmTrialActR{day}','m',0.5)
axis tight;
ylim([-0.04 0.04])
line([20 20],ylim,'color','b','LineStyle','--')
line([40 40],ylim,'color','b')
legend('','Reward Trials nRewCells','','Omission Trials nRewCells','','Omission Trials Population','Tone Onset','Grace Period ends')
ylabel('dF/F')
xlabel('Frame #')
title('Reward Day 7')

figure;
plot_sem(caPuffTrialAct{day}(cnPuffCells{day},:)','k',0.5)
hold on
plot_sem(cOmTrialActP{day}(cnPuffCells{day},:)','r',0.5)
plot_sem(cOmTrialActP{day}','m',0.5)
axis tight;
ylim([-0.04 0.04])
line([20 20],ylim,'color','b','LineStyle','--')
line([40 40],ylim,'color','b')
legend('','aPuff Trials nPuffCells','','Omission Trials nPuffCElls','','Omission Trials Population','Tone Onset','Grace Period ends')
ylabel('dF/F')
xlabel('Frame #')
title('aPuff Day 7')

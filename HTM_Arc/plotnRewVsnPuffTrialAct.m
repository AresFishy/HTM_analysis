%Plot trial activity for positive and negative modulated cells

%Puff trials
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(caPuffTrialAct{day}(cnPuffCells{day},:)','b',0.3); hold on
    hold on
    plot_sem(caPuffTrialAct{day}(cPuffCells{day},:)','k',0.3)
    plot_sem(caPuffTrialAct{day}(cRewCells{day},:)','r',0.3)
    plot_sem(caPuffTrialAct{day}(cnRewCells{day},:)','m',0.3)
    axis tight; ylim([-0.05 0.1])
    line(xlim,[0 0],'color','k','LineStyle','--')
    line([20 20],ylim,'color','k','LineStyle','--')
    line([40 40],ylim,'color','k','LineStyle','--')
    title(sprintf('PuffTrialAct Day %d',day))
    legend('','nPuff','','Puff','','Rew','','nRew')
    ylabel('dF/F'); xlabel('Frame')
end

%Reward trials
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(cRewTrialAct{day}(cnPuffCells{day},:)','b',0.3); hold on
    hold on
    plot_sem(cRewTrialAct{day}(cPuffCells{day},:)','k',0.3)
    plot_sem(cRewTrialAct{day}(cRewCells{day},:)','r',0.3)
    plot_sem(cRewTrialAct{day}(cnRewCells{day},:)','m',0.3)
    axis tight; ylim([-0.05 0.1])
    line(xlim,[0 0],'color','k','LineStyle','--')
    line([20 20],ylim,'color','k','LineStyle','--')
    line([40 40],ylim,'color','k','LineStyle','--')
    title(sprintf('RewTrialAct Day %d',day))
    legend('','nPuff','','Puff','','Rew','','nRew')
    ylabel('dF/F'); xlabel('Frame')
end
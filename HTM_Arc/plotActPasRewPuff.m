%Plot Active reward vs. passive reward
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(cRewAct{day}');hold on
    plot_sem(cpRewAct{day}','r')
    ylim([-0.005 0.01])
    line(xlim,[0 0],'color','k','LineStyle','--')
    title(sprintf('Reward Act Day %d',day))
    legend('','aRew','','pRew')
    ylabel('dF/F')
    xlabel('Day')
end

%Plot Active puff vs. passive puff trials
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(caPuffAct{day}');hold on
    plot_sem(cpPuffAct{day}','r')
    axis tight
    ylim([-0.01 0.02])
    line(xlim,[0 0],'color','k','LineStyle','--')
    title(sprintf('Puff Trial Act Day %d',day))
    legend('','aPuff','','pPuff')
    ylabel('dF/F')
    xlabel('Day')
end
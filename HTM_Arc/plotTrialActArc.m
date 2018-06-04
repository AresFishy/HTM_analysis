%Plot trial act for arc up/down neurons

for day = 1:7
    subplot(2,4,day)
    plot_sem(cTrialAct{day+1}(upArc{day},:)','r')
    hold on
    plot_sem(cTrialAct{day+1}(downArc{day},:)','b')
    axis tight;
    title(sprintf('All Trial Day %d - %d',day,day+1));
    legend('','upArc','','downArc')
    ylabel('dF/F')
    xlabel('Frame #')
end

%%

for day = 1:7
    subplot(2,4,day)
    plot_sem(cRewTrialAct{day+1}(upArc{day},:)','r')
    hold on
    plot_sem(cRewTrialAct{day+1}(downArc{day},:)','b')
    axis tight;
    title(sprintf('Rew Trial Day %d - %d',day,day+1));
    legend('','upArc','','downArc')
    ylabel('dF/F')
    xlabel('Frame #')
end

%%
for day = 1:7
    subplot(2,4,day)
    plot_sem(caPuffTrialAct{day+1}(upArc{day},:)','r')
    hold on
    plot_sem(caPuffTrialAct{day+1}(downArc{day},:)','b')
    axis tight;
    title(sprintf('Puff Trial Day %d - %d',day,day+1));
    legend('','upArc','','downArc')
    ylabel('dF/F')
    xlabel('Frame #')
end



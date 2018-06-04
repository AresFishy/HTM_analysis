%Plot rew trials
figure;
for day = 1:7
    subplot(2,4,day)
    imagesc(cRewTrialAct{day}(cnRewCells{day},:));
    set(gca,'clim',[0 0.05])
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
end
    
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(cRewTrialAct{day}(cnRewCells{day},:)','k');
    axis tight;
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    ylim([-0.05 0.05])
    line([20 20],ylim,'color','b','LineStyle','--')
    line([40 40],ylim,'color','b')
end


%%
%Plot puff trials

figure;
for day = 1:7
    subplot(2,4,day)
    imagesc(caPuffTrialAct{day}(cnPuffCells{day},:));
    set(gca,'clim',[0 0.05])
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
end
    
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(caPuffTrialAct{day}(cnPuffCells{day},:)','k');
    axis tight;
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    ylim([-0.05 0.05])
    line([20 20],ylim,'color','b','LineStyle','--')
    line([40 40],ylim,'color','b')
end
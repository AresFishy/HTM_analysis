%Plot activity overview across days for stimulus responsive cells

mtmpPuffActn = [];   stmpPuffActn = [];
mtmpRewActn = [];   stmpRewActn = [];
mtmpToneActn = [];   stmpToneActn = [];
mtmpGratActn = [];   stmpGratActn = [];


for day = 1:7
    mtmpPuffActn(day) = mean(nanmean(caPuffAct{day}(cnPuffCells{day},15:25),2));
    stmpPuffActn(day) = std(nanmean(caPuffAct{day}(cnPuffCells{day},15:25),2)) / sqrt(length(cnPuffCells{day}));
    mtmpRewActn(day) = mean(nanmean(cRewAct{day}(cnRewCells{day},15:25),2));
    stmpRewActn(day) = std(nanmean(cRewAct{day}(cnRewCells{day},15:25),2)) / sqrt(length(cnRewCells{day}));
    mtmpToneActn(day) = mean(nanmean(cToneAct{day}(cnToneCells{day},15:25),2));
    stmpToneActn(day) = std(nanmean(cToneAct{day}(cnToneCells{day},15:25),2)) / sqrt(length(cnToneCells{day}));
    mtmpGratActn(day) = mean(nanmean(cGratAct{day}(cnGratCells{day},15:25),2));
    stmpGratActn(day) = std(nanmean(cGratAct{day}(cnGratCells{day},15:25),2)) / sqrt(length(cnGratCells{day}));
end

figure; hold on
plot([1:7],mtmpPuffActn,'r'); 
errorbar([1:7],mtmpPuffActn,stmpPuffActn,'r')
plot([1:7],mtmpRewActn,'k');
errorbar([1:7],mtmpRewActn,stmpRewActn,'k')
plot([1:7],mtmpToneActn,'g'); 
errorbar([1:7],mtmpToneActn,stmpToneActn,'g')
plot([1:7],mtmpGratActn,'m'); 
errorbar([1:7],mtmpGratActn,stmpGratActn,'m')
ylim([-0.05 0.01])
line(xlim,[0 0],'color','k','LineStyle','--')
title('Stimulus Responsive Cells')
legend('nPuff Cells Puff Act','','nReward Cells Reward Act','','nTone Cells Tone Act','','nGrating Cells Grating Act','')
ylabel('dF/F')
xlabel('Day')

%%
%Puff act puff cells
figure;
for day = 1:7
    subplot(2,4,day)
    imagesc(caPuffAct{day}(cnPuffCells{day},:)); hold on
    set(gca,'clim',[-0.02 0])
    line([10 10],ylim,'color','r')
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
end
    
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(caPuffAct{day}(cnPuffCells{day},:)','k'); hold on
    axis tight;
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    ylim([-0.05 0.01])
    line([10 10], ylim,'color','k','LineStyle','--')
    line(xlim,[0 0],'color','k','LineStyle','--')
end

%Rew act rew cells
figure;
for day = 1:7
    subplot(2,4,day)
    imagesc(cRewAct{day}(cnRewCells{day},:)); hold on
    set(gca,'clim',[-0.02 0])
    line([10 10],ylim,'color','r')
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
end
    
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(cRewAct{day}(cnRewCells{day},:)','k'); hold on
    axis tight;
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    ylim([-0.05 0.01])
    line([10 10], ylim,'color','k','LineStyle','--')
    line(xlim,[0 0],'color','k','LineStyle','--')
end


%Tone act tone cells
figure;
for day = 1:7
    subplot(2,4,day)
    imagesc(cToneAct{day}(cnToneCells{day},:)); hold on
    set(gca,'clim',[-0.02 0])
    line([10 10],ylim,'color','r')
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
end
    
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(cToneAct{day}(cnToneCells{day},:)','k'); hold on
    axis tight;
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    ylim([-0.05 0.01])
    line([10 10], ylim,'color','k','LineStyle','--')
    line(xlim,[0 0],'color','k','LineStyle','--')
end


%Grating act grating cells
figure;
for day = 1:7
    subplot(2,4,day)
    imagesc(cGratAct{day}(cnGratCells{day},:)); hold on
    set(gca,'clim',[-0.02 0])
    line([10 10],ylim,'color','r')
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
end
    
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(cGratAct{day}(cnGratCells{day},:)','k'); hold on
    axis tight;
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    ylim([-0.05 0.01])
    line([10 10], ylim,'color','k','LineStyle','--')
    line(xlim,[0 0],'color','k','LineStyle','--')
end

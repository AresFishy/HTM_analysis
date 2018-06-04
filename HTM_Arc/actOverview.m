%Plot activity overview across days for stimulus responsive cells

mtmpPuffAct = [];   stmpPuffAct = [];
mtmpRewAct = [];   stmpRewAct = [];
mtmpToneAct = [];   stmpToneAct = [];
mtmpGratAct = [];   stmpGratAct = [];


for day = 1:7
    mtmpPuffAct(day) = mean(nanmean(caPuffAct{day}(cPuffCells{day},15:25),2));
    stmpPuffAct(day) = std(nanmean(caPuffAct{day}(cPuffCells{day},15:25),2)) / sqrt(length(cPuffCells{day}));
    mtmpRewAct(day) = mean(nanmean(cRewAct{day}(cRewCells{day},15:25),2));
    stmpRewAct(day) = std(nanmean(cRewAct{day}(cRewCells{day},15:25),2)) / sqrt(length(cRewCells{day}));
    mtmpToneAct(day) = mean(nanmean(cToneAct{day}(cToneCells{day},15:25),2));
    stmpToneAct(day) = std(nanmean(cToneAct{day}(cToneCells{day},15:25),2)) / sqrt(length(cToneCells{day}));
    mtmpGratAct(day) = mean(nanmean(cGratAct{day}(cGratCells{day},15:25),2));
    stmpGratAct(day) = std(nanmean(cGratAct{day}(cGratCells{day},15:25),2)) / sqrt(length(cGratCells{day}));
end

figure; hold on
plot([1:7],mtmpPuffAct,'r'); 
errorbar([1:7],mtmpPuffAct,stmpPuffAct,'r')
plot([1:7],mtmpRewAct,'k');
errorbar([1:7],mtmpRewAct,stmpRewAct,'k')
plot([1:7],mtmpToneAct,'g'); 
errorbar([1:7],mtmpToneAct,stmpToneAct,'g')
plot([1:7],mtmpGratAct,'m'); 
errorbar([1:7],mtmpGratAct,stmpGratAct,'m')
ylim([0 0.1])
title('Stimulus Responsive Cells')
legend('Puff Cells Puff Act','','Reward Cells Reward Act','','Tone Cells Tone Act','','Grating Cells Grating Act','')
ylabel('dF/F')
xlabel('Day')

%%
%Puff act puff cells
figure;
for day = 1:8
    subplot(2,4,day)
    imagesc(caPuffAct{day}(cPuffCells{day},:)); hold on
    set(gca,'clim',[0 0.1])
    line([10 10],ylim,'color','r')
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
end
    
figure;
for day = 1:8
    subplot(2,4,day)
    plot_sem(caPuffAct{day}(cPuffCells{day},:)','k'); hold on
    axis tight;
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    ylim([-0.01 0.1])
    line([10 10], ylim,'color','k','LineStyle','--')
    line(xlim,[0 0],'color','k','LineStyle','--')
end

%Rew act rew cells
figure;
for day = 1:8
    subplot(2,4,day)
    imagesc(cRewAct{day}(cRewCells{day},:)); hold on
    set(gca,'clim',[0 0.1])
    line([10 10],ylim,'color','r')
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
end
    
figure;
for day = 1:8
    subplot(2,4,day)
    plot_sem(cRewAct{day}(cRewCells{day},:)','k'); hold on
    axis tight;
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    ylim([-0.01 0.1])
    line([10 10], ylim,'color','k','LineStyle','--')
    line(xlim,[0 0],'color','k','LineStyle','--')
end


%Tone act tone cells
figure;
for day = 1:8
    subplot(2,4,day)
    imagesc(cToneAct{day}(cToneCells{day},:)); hold on
    set(gca,'clim',[0 0.1])
    line([10 10],ylim,'color','r')
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
end
    
figure;
for day = 1:8
    subplot(2,4,day)
    plot_sem(cToneAct{day}(cToneCells{day},:)','k'); hold on
    axis tight;
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    ylim([-0.01 0.1])
    line([10 10], ylim,'color','k','LineStyle','--')
    line(xlim,[0 0],'color','k','LineStyle','--')
end


%Grating act grating cells
figure;
for day = 1:8
    subplot(2,4,day)
    imagesc(cGratAct{day}(cGratCells{day},:)); hold on
    set(gca,'clim',[0 0.1])
    line([10 10],ylim,'color','r')
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
end
    
figure;
for day = 1:8
    subplot(2,4,day)
    plot_sem(cGratAct{day}(cGratCells{day},:)','k'); hold on
    axis tight;
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    ylim([-0.01 0.1])
    line([10 10], ylim,'color','k','LineStyle','--')
    line(xlim,[0 0],'color','k','LineStyle','--')
end

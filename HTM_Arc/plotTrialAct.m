%Plot all trials

figure;
for day = 1:7
    subplot(2,4,day)
    imagesc(cTrialAct{day});
    set(gca,'clim',[0 0.1])
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    line([20 20],ylim,'color','r','LineStyle','--')
    line([40 40],ylim,'color','r','LineStyle','--')
    line([60 60],ylim,'color','r','LineStyle','--')
end
    
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(cTrialAct{day}','k');
    axis tight;
    ylim([-0.005 0.01])
    line(xlim,[0 0],'color','k','LineStyle','--')
    line([20 20],ylim,'color','k','LineStyle','--')
    line([40 40],ylim,'color','k','LineStyle','--')
    line([60 60],ylim,'color','k','LineStyle','--')
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
end
    
%%
%Plot rew trials
figure;
for day = 1:7
    subplot(2,4,day)
    imagesc(cRewTrialAct{day});
    set(gca,'clim',[0 0.1])
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    line([20 20],ylim,'color','r','LineStyle','--')
    line([40 40],ylim,'color','r','LineStyle','--')
    line([60 60],ylim,'color','r','LineStyle','--')
end
    
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(cRewTrialAct{day}','k');
    axis tight;
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    ylim([-0.01 0.02])
    line(xlim,[0 0],'color','k','LineStyle','--')
    line([20 20],ylim,'color','k','LineStyle','--')
    line([40 40],ylim,'color','k','LineStyle','--')
    line([60 60],ylim,'color','k','LineStyle','--')
end

figure;
for day = 1:7
    subplot(2,4,day)
    imagesc(cRewTrialAct{day}(cRewCells{day},:));
    set(gca,'clim',[0 0.1])
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
end
    
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(cRewTrialAct{day}(cRewCells{day},:)','k');
    axis tight;
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    ylim([-0.01 0.1])
    line([20 20],ylim,'color','b','LineStyle','--')
    line([40 40],ylim,'color','b')
end

tmpAntR = [];
tmpAntP = [];
for day = 1:7
    for animal = 1:4
        if ~isempty(act{animal,day}) 
            tmpAntR(animal,day) = mean(nanmean(mRewTrialAct{animal,day}(rewCells{animal,day},30:40),2));
            if ~isempty(maPuffTrialAct{animal,day})
                tmpAntP(animal,day) = mean(nanmean(maPuffTrialAct{animal,day}(puffCells{animal,day},30:40),2));
            else
                tmpAntP(animal,day) = NaN(1,1);
            end
        else
            tmpAntR(animal,day) = NaN(1,1);
            tmpAntP(animal,day) = NaN(1,1);
        end
    end
end
figure;
plot_sem(tmpAntP','r',0.5)
hold on
plot_sem(tmpAntR','k',0.5)
title('Anticipatory activity: Frame 30-40')
legend('','PuffCells PuffAct','','RewCells RewAct')
ylabel('dF/F')
xlabel('Day')

%%
%Plot puff trials
figure;
for day = 1:7
    subplot(2,4,day)
    imagesc(caPuffTrialAct{day});
    set(gca,'clim',[0 0.1])
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    line([20 20],ylim,'color','r','LineStyle','--')
    line([40 40],ylim,'color','r','LineStyle','--')
    line([60 60],ylim,'color','r','LineStyle','--')
end
    
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(caPuffTrialAct{day}','k');
    axis tight;
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    ylim([-0.01 0.02])
    line(xlim,[0 0],'color','k','LineStyle','--')
    line([20 20],ylim,'color','k','LineStyle','--')
    line([40 40],ylim,'color','k','LineStyle','--')
    line([60 60],ylim,'color','k','LineStyle','--')
end

figure;
for day = 1:7
    subplot(2,4,day)
    imagesc(caPuffTrialAct{day}(cPuffCells{day},:));
    set(gca,'clim',[0 0.1])
    ylabel('Cell #')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
end
    
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(caPuffTrialAct{day}(cPuffCells{day},:)','k');
    axis tight;
    ylabel('dF/F')
    xlabel('Frame #')
    title(sprintf('Day %d',day));
    ylim([-0.01 0.1])
    line([20 20],ylim,'color','b','LineStyle','--')
    line([40 40],ylim,'color','b')
end
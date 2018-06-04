%Plot the correlation between cell population specific stimulus responses
%and their Arc expression level.

%Tone cells and Tone Activity
tmpTc = [];
tmpTp = [];
for day = 1:7;
    for animal = 1:4
        tmpTc(animal,day) = corr(mean(mToneAct{animal,day}(toneCells{animal,day},15:25),2),mArcAct{animal,day}(toneCells{animal,day}));
        tmpTp(animal,day) = corr(mean(mToneAct{animal,day}(:,15:25),2),mArcAct{animal,day});
    end
end
figure;
subplot(131)
plot_sem(tmpTc','g',0.5)
plot_sem(tmpTp','--g',0.5)
axis tight;
ylim([-0.8 0.8])
line(xlim,[0 0],'color','k','LineStyle','--')
title('Tone Cells Tone Act - Arc Correlation')
xlabel('Day'); ylabel('Correlation Coefficient')
legend('','Tone Cells','','Population')

%Puff cells and Puff Activity
tmpPc = [];
tmpPp = [];
for day = 1:7;
    for animal = 1:4
        if ~isempty(puffCells{animal,day})
            tmpPc(animal,day) = corr(mean(maPuffAct{animal,day}(puffCells{animal,day},15:25),2),mArcAct{animal,day}(puffCells{animal,day}));
            tmpPp(animal,day) = corr(mean(maPuffAct{animal,day}(:,15:25),2),mArcAct{animal,day});
        else
            tmpPc(animal,day) = NaN;
        end
    end
end
subplot(132)
plot_sem(tmpPc','r',0.5)
plot_sem(tmpPp','--r',0.5)
axis tight;
ylim([-0.8 0.8])
line(xlim,[0 0],'color','k','LineStyle','--')
title('Puff Cells Puff Act - Arc Correlation')
xlabel('Day'); ylabel('Correlation Coefficient')
legend('','Puff Cells','','Population')

%Reward Cells and Reward Activity
tmpRc = [];
tmpRp = [];
for day = 1:7;
    for animal = 1:4
        if ~isempty(rewCells{animal,day})
            tmpRc(animal,day) = corr(mean(mRewAct{animal,day}(rewCells{animal,day},15:25),2),mArcAct{animal,day}(rewCells{animal,day}));
            tmpRp(animal,day) = corr(mean(mRewAct{animal,day}(:,15:25),2),mArcAct{animal,day});
        else
            tmpRc(animal,day) = NaN;
        end
    end
end
subplot(133)
plot_sem(tmpRc','k',0.5)
plot_sem(tmpRp','--k',0.5)
axis tight;
ylim([-0.8 0.8])
line(xlim,[0 0],'color','k','LineStyle','--')
title('Reward Cells Reward Act - Arc Correlation')
xlabel('Day'); ylabel('Correlation Coefficient')
legend('','Reward Cells','','Population')

%%
%Plot scatter plots for Tone cells
figure;
for day = 1:7
    for animal = 1:4
        subplot(2,4,day)
        plot(mean(mToneAct{animal,day}(toneCells{animal,day},15:25),2),mArcAct{animal,day}(toneCells{animal,day}),'o'); hold on
        ylim([-0.1 0.8])
        xlim([-0.05 0.1])
        line(xlim,[0 0],'color','k','LineStyle','--')
        line([0 0],ylim,'color','k','LineStyle','--')
        title(sprintf('Tone Day %d',day))
        xlabel('Tone Act')
        ylabel('Arc Level')
    end
end

%Plot scatter plots for Puff cells
figure;
for day = 1:7
    for animal = 1:4
        subplot(2,4,day)
        plot(mean(maPuffAct{animal,day}(puffCells{animal,day},15:25),2),mArcAct{animal,day}(puffCells{animal,day}),'o'); hold on
        ylim([-0.1 0.8])
        xlim([-0.05 0.1])
        line(xlim,[0 0],'color','k','LineStyle','--')
        line([0 0],ylim,'color','k','LineStyle','--')
        title(sprintf('Tone Day %d',day))
        xlabel('Puff Act')
        ylabel('Arc Level')
    end
end

%Plot scatter plots for Reward cells
figure;
for day = 1:7
    for animal = 1:4
        subplot(2,4,day)
        plot(mean(mRewAct{animal,day}(rewCells{animal,day},15:25),2),mArcAct{animal,day}(rewCells{animal,day}),'o'); hold on
        ylim([-0.1 0.8])
        xlim([-0.05 0.1])
        line(xlim,[0 0],'color','k','LineStyle','--')
        line([0 0],ylim,'color','k','LineStyle','--')
        title(sprintf('Tone Day %d',day))
        xlabel('Reward Act')
        ylabel('Arc Level')
    end
end

%%
%Plot the correlation between cell population specific stimulus responses
%and their Arc expression level.

%Tone cells and Tone Activity
tmpTc = [];
tmpTp = [];
for day = 1:7;
    tmpTc(day) = corr(nanmean(cToneAct{day}(cToneCells{day},15:25),2),cArcAct{day}(cToneCells{day}));
    tmpTp(day) = corr(nanmean(cToneAct{day}(:,15:25),2),cArcAct{day});
end
figure;
subplot(131)
plot(tmpTc,'g'); hold on
plot(tmpTp,'--g')
axis tight;
ylim([-0.8 0.8])
line(xlim,[0 0],'color','k','LineStyle','--')
title('Tone Cells Tone Act - Arc Correlation')
xlabel('Day'); ylabel('Correlation Coefficient')
legend('Tone Cells','Population')

%Puff cells and Puff Activity
tmpPc = [];
tmpPp = [];
for day = 1:7;
    tmpPc(day) = corr(nanmean(caPuffAct{day}(cPuffCells{day},15:25),2),cArcAct{day}(cPuffCells{day}));
    tmpPp(day) = corr(nanmean(caPuffAct{day}(:,15:25),2),cArcAct{day});
end
subplot(133)
plot(tmpPc,'r'); hold on
plot(tmpPp,'--r')
axis tight;
ylim([-0.8 0.8])
line(xlim,[0 0],'color','k','LineStyle','--')
title('Puff Cells Puff Act - Arc Correlation')
xlabel('Day'); ylabel('Correlation Coefficient')
legend('Puff Cells','Population')

%Reward Cells and Reward Activity
tmpRc = [];
tmpRp = [];
for day = 1:7;
    tmpRc(day) = corr(nanmean(cRewAct{day}(cRewCells{day},15:25),2),cArcAct{day}(cRewCells{day}),'rows','complete');
    tmpRp(day) = corr(nanmean(cRewAct{day}(:,15:25),2),cArcAct{day},'rows','complete');    
end
subplot(132)
plot(tmpRc,'k'); hold on
plot(tmpRp,'--k')
axis tight;
ylim([-0.8 0.8])
line(xlim,[0 0],'color','k','LineStyle','--')
title('Reward Cells Reward Act - Arc Correlation')
xlabel('Day'); ylabel('Correlation Coefficient')
legend('Reward Cells','Population')


%Plot the difference in correlation between day 1:3 vs 4:6 based on a
%correlation calculated datapoints pooled from all animals

%Tone cells
figure;
bar([1 2],[mean(tmpTc(1:3)) mean(tmpTc(4:6))],'g')
hold on
errorbar(1,mean(tmpTc(1:3)),std(tmpTc(1:3)),'k')
errorbar(2,mean(tmpTc(4:6)),std(tmpTc(4:6)),'k')
ylim([-0.5 0.5])
set(gca,'XTick',[1 2],'XTickLabel',{'Day 1:3','Day 4:6'})
ylabel('Correlation Coefficient')
title('Tone Cell Tone Act - Arc Correlation')

%Puff cells
figure;
bar([1 2],[mean(tmpPc(1:3)) mean(tmpPc(4:6))],'r')
hold on
errorbar(1,mean(tmpPc(1:3)),std(tmpPc(1:3)),'k')
errorbar(2,mean(tmpPc(4:6)),std(tmpPc(4:6)),'k')
ylim([-0.5 0.5])
set(gca,'XTick',[1 2],'XTickLabel',{'Day 1:3','Day 4:6'})
ylabel('Correlation Coefficient')
title('Puff Cell Puff Act - Arc Correlation')

%Reward cells
figure;
bar([1 2],[mean(tmpRc(1:3)) mean(tmpRc(4:6))],'k')
hold on
errorbar(1,mean(tmpRc(1:3)),std(tmpRc(1:3)),'k')
errorbar(2,mean(tmpRc(4:6)),std(tmpRc(4:6)),'k')
ylim([-0.5 0.5])
set(gca,'XTick',[1 2],'XTickLabel',{'Day 1:3','Day 4:6'})
ylabel('Correlation Coefficient')
title('Reward Cell Reward Act - Arc Correlation')

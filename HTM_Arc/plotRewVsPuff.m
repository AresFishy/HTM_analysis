%Plot reward and puff cells response to both reward and puff
tmpRR = [];
tmpRP = [];

tmpPR = [];
tmpPP = [];

subplot(221)
for day = 1:7
    plot_sem(cRewAct{day}(cRewCells{day},:)','k',0.2); hold on
    plot_sem(cRewAct{day}(cPuffCells{day},:)','r',0.2);
end
axis tight;
ylim([-0.01 0.12])
line([10 10],ylim,'color','k','LineStyle','--')
line(xlim,[0 0],'color','k','LineStyle','--')
title('Reward Activity')
ylabel('dF/F')
xlabel('Frame #')
legend('','Reward Cells','','Puff Cells')

subplot(222)
for day = 1:7
    tmpRR(day) = mean(nanmean(cRewAct{day}(cRewCells{day},15:25)));
    tmpRP(day) = mean(nanmean(cRewAct{day}(cPuffCells{day},15:25)));
end
plot(tmpRR,'-xk'); hold on
plot(tmpRP,'-xr'); 
axis tight;
ylim([-0.01 0.12])
xlabel('Day')
title('Reward Activity - Frame 15:25')

subplot(223)
for day = 1:7
    plot_sem(caPuffAct{day}(cRewCells{day},:)','k',0.2); hold on
    plot_sem(caPuffAct{day}(cPuffCells{day},:)','r',0.2);
end
axis tight;
ylim([-0.01 0.12])
line([10 10],ylim,'color','k','LineStyle','--')
line(xlim,[0 0],'color','k','LineStyle','--')
title('Airpuff Activity')
ylabel('dF/F')
xlabel('Frame #')
legend('','Reward Cells','','Puff Cells')

subplot(224)
for day = 1:7
    tmpPR(day) = mean(nanmean(caPuffAct{day}(cRewCells{day},15:25)));
    tmpPP(day) = mean(nanmean(caPuffAct{day}(cPuffCells{day},15:25)));
end
plot(tmpPR,'-xk'); hold on
plot(tmpPP,'-xr'); 
axis tight;
ylim([-0.01 0.12])
title('Airpuff Activity - Frame 15:25')
xlabel('Day')

%Plot the activity from trial to trial
%%
figure;
subplot(121)
for day = 1:7
    for animal = 1:4
        if ~isempty(rewAct{animal,day})
            rewRespR = mean(nanmean(rewAct{animal,day}(1:2:end,rewCells{animal,day},15:25),3),1);
            puffRespR = mean(nanmean(aPuffAct{animal,day}(1:2:end,rewCells{animal,day},15:25),3),1);
            plot(puffRespR,rewRespR,'ok'); hold on
            puffRespP = mean(nanmean(aPuffAct{animal,day}(1:2:end,puffCells{animal,day},15:25),3),1);
            rewRespP = mean(nanmean(rewAct{animal,day}(1:2:end,puffCells{animal,day},15:25),3),1);
            plot(puffRespP,rewRespP,'xr'); hold on
        end
    end
end
axis tight;
hLine1 = refline([0 0])
hLine1.Color = 'k'
hLine2 = refline([1 0])
hLine2.Color = 'k'
hLine3 = line([0 0],ylim)
hLine3.Color = 'k'

title('Reward vs Puff Cell activity')
ylabel('Reward Activity')
xlabel('Puff Activity')
legend('Puff Cells','Reward Cells')

subplot(122)
for day = 1:7
    for animal = 1:4
        if ~isempty(rewAct{animal,day})
            rewRespR = mean(nanmean(rewAct{animal,day}(1:2:end,rewCells{animal,day},15:25),3),1);
            puffRespR = mean(nanmean(aPuffAct{animal,day}(1:2:end,rewCells{animal,day},15:25),3),1);
            plot(puffRespR,rewRespR,'ok'); hold on
            puffRespP = mean(nanmean(aPuffAct{animal,day}(1:2:end,puffCells{animal,day},15:25),3),1);
            rewRespP = mean(nanmean(rewAct{animal,day}(1:2:end,puffCells{animal,day},15:25),3),1);
            plot(puffRespP,rewRespP,'xr'); hold on
        end
    end
end
hLine1 = refline([0 0])
hLine1.Color = 'k'
hLine2 = refline([1 0])
hLine2.Color = 'k'
xlim([- 0.05 0.1])
ylim([- 0.05 0.1])
hLine3 = line([0 0],ylim)
hLine3.Color = 'k'
title('Reward vs Puff Cell activity (Zoom)')
ylabel('Reward Activity')
xlabel('Puff Activity')
legend('Puff Cells','Reward Cells')
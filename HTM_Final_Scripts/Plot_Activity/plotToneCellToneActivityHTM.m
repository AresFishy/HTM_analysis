%Plot the response of Tone cells to different stilumi, and the response of
%different cell populations to Tones

figure;
for day = 1:7
    subplot(2,4,day)
    if day == 1;
        title('Tone Activity Response')
    end
    plot_sem(cToneAct{day}(cToneCells{day},:)','g',0.5);
    plot_sem(cToneAct{day}(cRewCells{day},:)','k',0.5);
    plot_sem(cToneAct{day}(cPuffCells{day},:)','r',0.5);
    axis tight
    ylim([-0.01 0.05])
    line(xlim,[0 0],'color','k','LineStyle','--')
    line([10 10],ylim,'color','k','LineStyle','--')
    ylabel('dF/F'); xlabel('Frame #')
end
legend('','Tone Cells','','Reward Cells','','Puff Cells')


figure;
for day = 1:7
    subplot(2,4,day)
    if day == 1;
        title('Tone Cells Response')
    end
    plot_sem(cToneAct{day}(cToneCells{day},:)','g',0.5);
    plot_sem(cRewAct{day}(cToneCells{day},:)','k',0.5);
    plot_sem(caPuffAct{day}(cToneCells{day},:)','r',0.5);
    ylim([-0.01 0.05])
    line(xlim,[0 0],'color','k','LineStyle','--')
    line([10 10],ylim,'color','k','LineStyle','--')
    ylabel('dF/F'); xlabel('Frame #')
end
legend('','Tone Activity','','Reward Activity','','Puff Activity')

%%

for day = 1:7
    a(animal,day) = mean(nanmean(mToneAct{animal,day}(toneCells{animal,day},11:20),2));
    b(animal,day) = mean(nanmean(mRewAct{animal,day}(toneCells{animal,day},11:20),2));
    c(animal,day) = mean(nanmean(maPuffAct{animal,day}(toneCells{animal,day},11:20),2));
end

figure;
plot_sem(a','g',0.5);
plot_sem(b','k',0.5);
plot_sem(c','r',0.5);
line(xlim,[0 0],'color','k','LineStyle','--')
ylabel('dF/F')
xlabel('Day')
title('Tone Cells Response')
legend('','Tone Activity','','Reward Activity','','Puff Activity')

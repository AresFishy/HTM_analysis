%Plop pupil size

figure;
for day = 1:7
    subplot(2,4,day)
    plot(nanmean(caPupilSizeP{day}),'k'); hold on
    plot(nanmean(cPupilSizeR{day}),'r');
    ylim([-15 15])
    xlim([1 201])
    ylabel('Pupil Size')
    xlabel('Frame #')
    title(sprintf('Day %d',day))
    legend('Puff Trials','Reward Trials')
    line(xlim,[0 0],'color','k','LineStyle','--')
    line([19 19],ylim,'color','k','LineStyle','--')
    line([39 39],ylim,'color','k','LineStyle','--')
end

tmpPup = [];
figure;
for day = 1:7
    for animal = 1:4;
        if ~isempty(act{animal,day})
            tmpPup(animal,day) = mean(nanmean(mPupilSizeR{animal,day}(:,19:39)))-mean(nanmean(maPupilSizeP{animal,day}(:,19:39)));
        end
    end
end
plot([1:7],nanmean(tmpPup,1),'-k')
errorbar([1:7],nanmean(tmpPup,1),nanstd(tmpPup,[],1)/sqrt(4),'color','k')
ylim([-2 15])
line(xlim,[0 0],'color','k','LineStyle','--')
ylabel('Pupil Size')
xlabel('Day')
title('Pupil size Rew-Puff frame 19:39')

%Plot lick activity
figure;
for day = 1:7
    subplot(2,4,day)
    plot(nanmean(caLickActP{day}),'k'); hold on
    plot(nanmean(cLickActR{day}),'r');
    ylim([0 1])
    xlim([1 201])
    ylabel('Lick Activity')
    xlabel('Frame #')
    title(sprintf('Day %d',day))
    legend('Puff Trials','Reward Trials')
    line(xlim,[0 0],'color','k','LineStyle','--')
    line([19 19],ylim,'color','k','LineStyle','--')
    line([39 39],ylim,'color','k','LineStyle','--')
end

tmpLick = [];
figure;
for day = 1:7
    for animal = 1:4;
        if ~isempty(act{animal,day})
            tmpLick(animal,day) = mean(nanmean(mLickActR{animal,day}(:,19:39)))-mean(nanmean(maLickActP{animal,day}(:,19:39)));
        end
    end
end
plot([1:7],nanmean(tmpLick,1),'-k')
errorbar([1:7],nanmean(tmpLick,1),nanstd(tmpLick,[],1)/sqrt(4),'color','k')
ylim([-0.05 0.2])
line(xlim,[0 0],'color','k','LineStyle','--')
ylabel('Lick Activity')
xlabel('Day')
title('Lick activity Rew-aPuff frame 19:39')


%Look at omission
figure;
for day = 7:8
    subplot(1,2,day-6)
    plot(nanmean(caLickActP{day}),'k'); hold on
    plot(nanmean(cLickActR{day}),'r');
    plot(nanmean(cLickActOM{day}),'g');
    ylim([0 1])
    xlim([1 201])
    ylabel('Lick Activity')
    xlabel('Frame #')
    title(sprintf('Day %d',day))
    legend('Puff Trials','Reward Trials','Omission Trials')
    line(xlim,[0 0],'color','k','LineStyle','--')
    line([19 19],ylim,'color','k','LineStyle','--')
    line([39 39],ylim,'color','k','LineStyle','--')
end

figure;
for day = 7:8
    subplot(1,2,day-6)
    plot(nanmean(caPupilSizeP{day}),'k'); hold on
    plot(nanmean(cPupilSizeR{day}),'r');
    plot(nanmean(cPupilSizeOM{day}),'g');
    ylim([-15 15])
    xlim([1 201])
    ylabel('Pupil Size')
    xlabel('Frame #')
    title(sprintf('Day %d',day))
    legend('Puff Trials','Reward Trials','Omission Trials')
    line(xlim,[0 0],'color','k','LineStyle','--')
    line([19 19],ylim,'color','k','LineStyle','--')
    line([39 39],ylim,'color','k','LineStyle','--')
end
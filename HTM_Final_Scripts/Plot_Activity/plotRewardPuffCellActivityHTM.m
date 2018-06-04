%Plot both reward and puff cells response to either Reward or Puff across
%days.

%Rew cell reponses
a = [];
b = [];
for day = 1:7
    for animal = 1:4
        a(animal,day) = nanmean(nanmean(mRewAct{animal,day}(rewCells{animal,day},15:25),2));
        b(animal,day) = nanmean(nanmean(maPuffAct{animal,day}(rewCells{animal,day},15:25),2));
        
    end
end

figure;
subplot(221)
plot_sem(a','k',0.2)
plot_sem(b','r',0.2)
ylim([0 0.1])
ylabel('dF/F')
xlabel('Day')
title('Reward Cells Response')
legend('','Reward Activity','','Puff activity')

subplot(222)
bar(1,mean(nanmean(a(:,1:3))),'k'); hold on
bar(2,mean(nanmean(a(:,4:6))),'k');
bar(3,mean(nanmean(b(:,1:3))),'r')
bar(4,mean(nanmean(b(:,4:6))),'r')
errorbar(1,mean(nanmean(a(:,1:3))),std(nanmean(a(:,1:3))),'k');
errorbar(2,mean(nanmean(a(:,4:6))),std(nanmean(a(:,4:6))),'k');
errorbar(3,mean(nanmean(b(:,1:3))),std(nanmean(b(:,1:3))),'r');
errorbar(4,mean(nanmean(b(:,4:6))),std(nanmean(b(:,4:6))),'r');
ylim([0 0.1])
ylabel('dF/F')
set(gca,'XTick',[1:4],'XTickLabel',{'Day 1:3','Day 4:6','Day 1:3','Day 4:6'})
title('Rewards Cells Response')
legend('Reward Activity','','Puff Activity','')

%Puff cell response
a = [];
b = [];
for day = 1:7
    for animal = 1:4
        a(animal,day) = nanmean(nanmean(maPuffAct{animal,day}(puffCells{animal,day},15:25),2));
        b(animal,day) = nanmean(nanmean(mRewAct{animal,day}(puffCells{animal,day},15:25),2));
        
    end
end

subplot(223)
plot_sem(a','r',0.2)
plot_sem(b','k',0.2)
ylim([0 0.1])
ylabel('dF/F')
xlabel('Day')
title('Puff Cells Response')
legend('','Puff activity','','Reward activity')

subplot(224)
bar(1,mean(nanmean(a(:,1:3))),'r'); hold on
bar(2,mean(nanmean(a(:,4:6))),'r');
bar(3,mean(nanmean(b(:,1:3))),'k')
bar(4,mean(nanmean(b(:,4:6))),'k')
errorbar(1,mean(nanmean(a(:,1:3))),std(nanmean(a(:,1:3))),'r');
errorbar(2,mean(nanmean(a(:,4:6))),std(nanmean(a(:,4:6))),'r');
errorbar(3,mean(nanmean(b(:,1:3))),std(nanmean(b(:,1:3))),'k');
errorbar(4,mean(nanmean(b(:,4:6))),std(nanmean(b(:,4:6))),'k');
ylim([0 0.1])
ylabel('dF/F')
set(gca,'XTick',[1:4],'XTickLabel',{'Day 1:3','Day 4:6','Day 1:3','Day 4:6'})
title('HighArc Cells Stimulus Response')
legend('Puff Activity','','Reward Activity','')
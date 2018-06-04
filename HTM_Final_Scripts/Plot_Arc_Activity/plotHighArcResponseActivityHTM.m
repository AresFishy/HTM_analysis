%High Arc cell reponses

for day = 1:7
    for animal = 1:4
        a(animal,day) = nanmean(nanmean(mToneAct{animal,day}(highArc{animal,day},15:20),2));
        b(animal,day) = nanmean(nanmean(mRewAct{animal,day}(highArc{animal,day},15:20),2));
        c(animal,day) = nanmean(nanmean(maPuffAct{animal,day}(highArc{animal,day},15:20),2));
        
    end
end

figure;
subplot(121)
plot_sem(a','g',0.2)
plot_sem(b','k',0.2)
plot_sem(c','r',0.2)
ylim([0 0.02])
ylabel('dF/F')
xlabel('Day')
title('HighArc Cells Stimulus Response')
legend('','hArc-Tone cells','','hArc-Rew cells','','hArc-Puff cells')

subplot(122)
bar(1,mean(nanmean(a(:,1:3))),'g'); hold on
bar(2,mean(nanmean(a(:,4:6))),'g');
bar(3,mean(nanmean(b(:,1:3))),'k')
bar(4,mean(nanmean(b(:,4:6))),'k')
bar(5,mean(nanmean(c(:,1:3))),'r')
bar(6,mean(nanmean(c(:,4:6))),'r')
errorbar(1,mean(nanmean(a(:,1:3))),std(nanmean(a(:,1:3))),'g');
errorbar(2,mean(nanmean(a(:,4:6))),std(nanmean(a(:,4:6))),'g');
errorbar(3,mean(nanmean(b(:,1:3))),std(nanmean(b(:,1:3))),'k');
errorbar(4,mean(nanmean(b(:,4:6))),std(nanmean(b(:,4:6))),'k');
errorbar(5,mean(nanmean(c(:,1:3))),std(nanmean(c(:,1:3))),'r');
errorbar(6,mean(nanmean(c(:,4:6))),std(nanmean(c(:,4:6))),'r');
ylabel('dF/F')
set(gca,'XTick',[1:6],'XTickLabel',{'Day 1:3','Day 4:6','Day 1:3','Day 4:6','Day 1:3','Day 4:6'})
title('HighArc Cells Stimulus Response')
legend('Tone Activity','','Reward Activity','','Puff activity')

%%
figure;
subplot(131)
plot_sem([cToneAct{1}(cHighArc{1},:); cToneAct{2}(cHighArc{2},:); cToneAct{3}(cHighArc{3},:)]','g')
plot_sem([cToneAct{4}(cHighArc{4},:); cToneAct{5}(cHighArc{5},:); cToneAct{6}(cHighArc{6},:)]','--g')
xlim([1 31]); ylim([-0.005 0.02]);
line(xlim,[0 0],'color','k','LineStyle','--')
line([10 10],ylim,'color','k','LineStyle','--')
ylabel('dF/F'); xlabel('Frame #'); title('Tone Activity'); legend('','Day 1:3','','Day 4:6')
subplot(132)
plot_sem([cRewAct{1}(cHighArc{1},:); cToneAct{2}(cHighArc{2},:); cRewAct{3}(cHighArc{3},:)]','k')
plot_sem([cRewAct{4}(cHighArc{4},:); cToneAct{5}(cHighArc{5},:); cRewAct{6}(cHighArc{6},:)]','--k')
xlim([1 31]); ylim([-0.005 0.02]);
line(xlim,[0 0],'color','k','LineStyle','--')
line([10 10],ylim,'color','k','LineStyle','--')
ylabel('dF/F'); xlabel('Frame #'); title('Reward Activity'); legend('','Day 1:3','','Day 4:6')
subplot(133)
plot_sem([caPuffAct{1}(cHighArc{1},:); caPuffAct{2}(cHighArc{2},:); caPuffAct{3}(cHighArc{3},:)]','r')
plot_sem([caPuffAct{4}(cHighArc{4},:); caPuffAct{5}(cHighArc{5},:); caPuffAct{6}(cHighArc{6},:)]','--r')
xlim([1 31]); ylim([-0.005 0.02]);
line(xlim,[0 0],'color','k','LineStyle','--')
line([10 10],ylim,'color','k','LineStyle','--')
ylabel('dF/F'); xlabel('Frame #'); title('Puff Activity'); legend('','Day 1:3','','Day 4:6')
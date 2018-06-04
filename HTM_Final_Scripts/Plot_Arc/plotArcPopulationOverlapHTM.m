%Plot cell overlap for Tone and Arc cells

toneArcOver = [];
ntoneArcOver = [];
rewArcOver = [];
nrewArcOver = [];
puffArcOver = [];
npuffArcOver = [];

figure; hold on
for day = 1:7
    for animal = 1:4
        toneArcOver(animal,day) = length(intersect(highArc{animal,day},toneCells{animal,day})) / length(highArc{animal,day});
        ntoneArcOver(animal,day) = length(intersect(highArc{animal,day},ntoneCells{animal,day})) / length(highArc{animal,day});
        rewArcOver(animal,day) = length(intersect(highArc{animal,day},rewCells{animal,day})) / length(highArc{animal,day});
        nrewArcOver(animal,day) = length(intersect(highArc{animal,day},nrewCells{animal,day})) / length(highArc{animal,day});
        puffArcOver(animal,day) = length(intersect(highArc{animal,day},puffCells{animal,day})) / length(highArc{animal,day});
        npuffArcOver(animal,day) = length(intersect(highArc{animal,day},npuffCells{animal,day})) / length(highArc{animal,day});
    end
end
subplot(121)
plot_sem(toneArcOver','g',0.4)
plot_sem(rewArcOver','k',0.4)
plot_sem(puffArcOver','r',0.4)
ylim([0 0.5])
ylabel('Overlap / Fraction')
xlabel('Day')
title('Cell Population Overlap')
legend('','hArc-Tone cells','','hArc-Rew cells','','hArc-Puff cells')

subplot(122)
bar(1,mean2(toneArcOver(:,1:3)),'g'); hold on
bar(2,mean2(toneArcOver(:,4:6)),'g'); 
bar(3,mean2(rewArcOver(:,1:3)),'k')
bar(4,mean2(rewArcOver(:,4:6)),'k')
bar(5,mean2(puffArcOver(:,1:3)),'r')
bar(6,mean2(puffArcOver(:,4:6)),'r')
errorbar(1,mean2(toneArcOver(:,1:3)),std(mean(toneArcOver(:,1:3))),'g');
errorbar(2,mean2(toneArcOver(:,4:6)),std(mean(toneArcOver(:,4:6))),'g');
errorbar(3,mean2(rewArcOver(:,1:3)),std(mean(toneArcOver(:,1:3))),'k');
errorbar(4,mean2(rewArcOver(:,4:6)),std(mean(toneArcOver(:,4:6))),'k');
errorbar(5,mean2(puffArcOver(:,1:3)),std(mean(toneArcOver(:,1:3))),'r');
errorbar(6,mean2(puffArcOver(:,4:6)),std(mean(toneArcOver(:,4:6))),'r');
set(gca,'XTick',[1:6],'XTickLabel',{'Day 1:3','Day 4:6','Day 1:3','Day 4:6','Day 1:3','Day 4:6'})
ylabel('Overlap / Fraction')
xlabel('Day')
title('Cell Population Overlap')
legend('','hArc-Tone cells','','hArc-Rew cells','','hArc-Puff cells')
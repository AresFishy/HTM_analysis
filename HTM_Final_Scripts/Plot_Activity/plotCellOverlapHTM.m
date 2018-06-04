%Plot cell overlap for Tone and Arc cells

toneOver = [];
rewOver = [];
puffOver = [];


figure; hold on
for day = 1:6
    for animal = 1:4
        toneOver(animal,day) = length(intersect(toneCells{animal,day},toneCells{animal,day+1})) / length(toneCells{animal,day});
        if ~isempty(rewCells{animal,day})
            rewOver(animal,day) = length(intersect(rewCells{animal,day},rewCells{animal,day+1})) / length(rewCells{animal,day});
        else
            rewOver(animal,day) = 0;
        end
        if ~isempty(puffCells{animal,day})
            puffOver(animal,day) = length(intersect(puffCells{animal,day},puffCells{animal,day+1})) / length(puffCells{animal,day});
        else
            puffOver(animal,day) = 0;
        end
    end
end
subplot(121)
plot_sem(toneOver','g',0.4)
plot_sem(rewOver','k',0.4)
plot_sem(puffOver','r',0.4)
axis tight;
ylim([0 1])
ylabel('Overlap / Fraction')
xlabel('Day')
set(gca,'XTick',[1:6],'XTickLabel',{'1-2','2-3','3-4','4-5','5-6','6:7'})
title('Cell Population Overlap')
legend('','Tone-Tone cells','','Rew-Rew cells','','Puff-Puff cells')

subplot(122)
bar(1,mean(nanmean(toneOver(:,1:3))),'g'); hold on
bar(2,mean(nanmean(toneOver(:,4:6))),'g');
bar(3,mean(nanmean(rewOver(:,1:3))),'k')
bar(4,mean(nanmean(rewOver(:,4:6))),'k')
bar(5,mean(nanmean(puffOver(:,1:3))),'r')
bar(6,mean(nanmean(puffOver(:,4:6))),'r')
errorbar(1,mean(nanmean(toneOver(:,1:3))),std2((toneOver(:,1:3))),'g');
errorbar(2,mean(nanmean(toneOver(:,4:6))),std2((toneOver(:,4:6))),'g');
errorbar(3,mean(nanmean(rewOver(:,1:3))),std2((rewOver(:,1:3))),'k');
errorbar(4,mean(nanmean(rewOver(:,4:6))),std2((rewOver(:,4:6))),'k');
errorbar(5,mean(nanmean(puffOver(:,1:3))),std2((puffOver(:,1:3))),'r');
errorbar(6,mean(nanmean(puffOver(:,4:6))),std2((puffOver(:,4:6))),'r');
set(gca,'XTick',[1:6],'XTickLabel',{'Day 1:3','Day 4:6','Day 1:3','Day 4:6','Day 1:3','Day 4:6'})
ylabel('Overlap / Fraction')
xlabel('Day')
title('Cell Population Overlap')
legend('','Tone-Tone cells','','Rew-Rew cells','','Puff-Puff cells')

%%
%Plot overlap between tone cells and Reward or Puff cells

for day = 1:7;
    for animal = 1:4
        a(animal,day) = length(intersect(rewCells{animal,day},toneCells{animal,day}))/length(rewCells{animal,day});
        b(animal,day) = length(intersect(puffCells{animal,day},toneCells{animal,day}))/length(puffCells{animal,day});
    end
end

figure;
plot_sem(a','k',0.5)
plot_sem(b','r',0.5)
ylim([0 1])
ylabel('Overlap / Fraction')
xlabel('Day')
title('Overlap Between Tone and Reward/Puff Cells')
legend('','Rew-Tone Cell','','Puff-Tone Cell')
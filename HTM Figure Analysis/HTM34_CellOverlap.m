% %Day-to-day Stability in responsive cells
% 
% for day = 1:6
%     for animal = 1:9
%         toneStab(animal,day) = length(intersect(toneCells{animal,day},toneCells{animal,day+1})) / length(toneCells{animal,day+1});
%         puffStab(animal,day) = length(intersect(puffCells{animal,day},puffCells{animal,day+1})) / length(puffCells{animal,day+1});
%         rewStab(animal,day) = length(intersect(rewCells{animal,day},rewCells{animal,day+1})) / length(rewCells{animal,day+1});
%     end
% end

for day = 1:7
    for animal = 1:9
        toneCellFraction(animal,day) = length(toneCells{animal,day}) / size(ieg_exp_cell{animal,day},1);
        gratCellFraction(animal,day) = length(gratCells{animal,day}) / size(ieg_exp_cell{animal,day},1);
        puffCellFraction(animal,day) = length(puffCells{animal,day}) / size(ieg_exp_cell{animal,day},1);
        rewCellFraction(animal,day) = length(rewCells{animal,day}) / size(ieg_exp_cell{animal,day},1); 

        rewPuffOverlap(animal,day) = length(intersect(puffCells{animal,day},rewCells{animal,day})) / length(unique([puffCells{animal,day} rewCells{animal,day}]));
        rewToneOverlap(animal,day) = length(intersect(toneCells{animal,day},rewCells{animal,day})) / length(unique([toneCells{animal,day} rewCells{animal,day}]));
        puffToneOverlap(animal,day) = length(intersect(puffCells{animal,day},toneCells{animal,day})) / length(unique([puffCells{animal,day} toneCells{animal,day}]));
    end
end
%Fraction of cells responding to Tone, Puff or Reward
figure;
subplot(121)
plot_sem(toneCellFraction','m',0.3);
plot_sem(puffCellFraction','k',0.3);
plot_sem(rewCellFraction','g',0.3);
plot_sem(gratCellFraction',[0.7 0.7 0.7],0.3);
ylim([0 0.5]); xlim([1 7])
title('Cell Fractions');
legend('','Tone Cells','','Puff Cells','','Reward Cells','','Grating Cells')

subplot(122)
%Day 2&3 vs 6&7
respCellMat = [reshape(toneCellFraction(:,2:3),18,1),reshape(toneCellFraction(:,6:7),18,1),reshape(puffCellFraction(:,2:3),18,1) ...
    reshape(puffCellFraction(:,6:7),18,1),reshape(rewCellFraction(:,2:3),18,1),reshape(rewCellFraction(:,6:7),18,1), ...
    reshape(gratCellFraction(:,2:3),18,1),reshape(gratCellFraction(:,6:7),18,1)];

boxplot(respCellMat,[1 2 3 4 5 6 7 8],'ColorGroup',[1 1 2 2 3 3 4 4],'colors',['m','k','g','c'])
title('Day 2&3 vs 6&7');
ylabel('Fraction')
ylim([0 0.5]); xlim([0 9])
legend('Early','Late','Early','Late','Early','Late','Early','Late')
hold on;

%average across the 2 days to plot individual animals
for animal = 1:9
    respMatAnimal(animal,:) = mean([respCellMat(animal,:);respCellMat(animal+9,:)],1);
end
plot(1,respMatAnimal(:,1),'om');
plot(2,respMatAnimal(:,2),'om');
plot(3,respMatAnimal(:,3),'ok');
plot(4,respMatAnimal(:,4),'ok');
plot(5,respMatAnimal(:,5),'og');
plot(6,respMatAnimal(:,6),'og');
plot(7,respMatAnimal(:,7),'oc');
plot(8,respMatAnimal(:,8),'oc');

mean2(gratCellFraction(:,2:3))
std2(gratCellFraction(:,2:3))/sqrt(18)

mean2(toneCellFraction(:,2:3))
std2(toneCellFraction(:,2:3))/sqrt(18)

ranksum(reshape(gratCellFraction(:,2:3),[],1),reshape(gratCellFraction(:,6:7),[],1))
ranksum(reshape(toneCellFraction(:,2:3),[],1),reshape(toneCellFraction(:,6:7),[],1))
ranksum(reshape(puffCellFraction(:,2:3),[],1),reshape(puffCellFraction(:,6:7),[],1))
ranksum(reshape(rewCellFraction(:,2:3),[],1),reshape(rewCellFraction(:,6:7),[],1))

[h,p] =  ttest(nanmean(gratCellFraction(:,2:3),2),nanmean(gratCellFraction(:,6:7),2))
[h,p] = ttest(nanmean(toneCellFraction(:,2:3),2),nanmean(toneCellFraction(:,6:7),2))
[h,p] =  ttest(nanmean(puffCellFraction(:,2:3),2),nanmean(puffCellFraction(:,6:7),2))
[h,p] = ttest(nanmean(rewCellFraction(:,2:3),2),nanmean(rewCellFraction(:,6:7),2))


% bar(1,mean2(toneCellFraction(:,2:3)),'FaceColor','w','EdgeColor','m'); hold on
% bar(2,mean2(toneCellFraction(:,6:7)),'FaceColor','w','EdgeColor','m','LineStyle',':');
% bar(3,mean2(puffCellFraction(:,2:3)),'FaceColor','w','EdgeColor','k');
% bar(4,mean2(puffCellFraction(:,6:7)),'FaceColor','w','EdgeColor','k','LineStyle',':');
% bar(5,mean2(rewCellFraction(:,2:3)),'FaceColor','w','EdgeColor','g');
% bar(6,mean2(rewCellFraction(:,6:7)),'FaceColor','w','EdgeColor','g','LineStyle',':');
% 
% errorbar(1,mean2(toneCellFraction(:,2:3)),std2(toneCellFraction(:,2:3))/sqrt(18),'k');
% errorbar(2,mean2(toneCellFraction(:,6:7)),std2(toneCellFraction(:,6:7))/sqrt(18),'k');
% errorbar(3,mean2(puffCellFraction(:,2:3)),std2(puffCellFraction(:,2:3))/sqrt(18),'k');
% errorbar(4,mean2(puffCellFraction(:,6:7)),std2(puffCellFraction(:,6:7))/sqrt(18),'k');
% errorbar(5,mean2(rewCellFraction(:,2:3)),std2(rewCellFraction(:,2:3))/sqrt(18),'k');
% errorbar(6,mean2(rewCellFraction(:,6:7)),std2(rewCellFraction(:,6:7))/sqrt(18),'k');

%%
%Overlap between responsive cells
figure;
subplot(121)
plot_sem(rewPuffOverlap','k',0.3);
plot_sem(rewToneOverlap','--k',0.3);
plot_sem(puffToneOverlap',':k',0.3);
ylim([0 0.5]); xlim([1 7])
legend('','Reward-Puff','','Reward-Tone','','Puff-Tone');
ylabel('Fraction'); xlabel('Day')
title('Overlap between responsive cells')

%Day 2&3 vs 6&7
subplot(122)
bar(1,mean2(rewPuffOverlap(:,2:3)),'FaceColor','w','LineStyle','-'); hold on
bar(2,mean2(rewPuffOverlap(:,6:7)),'FaceColor','w','LineStyle','-');
bar(3,mean2(rewToneOverlap(:,2:3)),'FaceColor','w','LineStyle','--');
bar(4,mean2(rewToneOverlap(:,6:7)),'FaceColor','w','LineStyle','--');
bar(5,mean2(puffToneOverlap(:,2:3)),'FaceColor','w','LineStyle',':');
bar(6,mean2(puffToneOverlap(:,6:7)),'FaceColor','w','LineStyle',':');

errorbar(1,mean2(rewPuffOverlap(:,2:3)),std2(rewPuffOverlap(:,2:3))/sqrt(18),'k');
errorbar(2,mean2(rewPuffOverlap(:,6:7)),std2(rewPuffOverlap(:,6:7))/sqrt(18),'k');
errorbar(3,mean2(rewToneOverlap(:,2:3)),std2(rewToneOverlap(:,2:3))/sqrt(18),'k');
errorbar(4,mean2(rewToneOverlap(:,6:7)),std2(rewToneOverlap(:,6:7))/sqrt(18),'k');
errorbar(5,mean2(puffToneOverlap(:,2:3)),std2(puffToneOverlap(:,2:3))/sqrt(18),'k');
errorbar(6,mean2(puffToneOverlap(:,6:7)),std2(puffToneOverlap(:,6:7))/sqrt(18),'k');
title('Day 2&3 vs 6&7');
ylabel('Fraction')
ylim([0 0.5]); xlim([0 7])
legend('Early','Late','Early','Late','Early','Late')
%%
%Fraction of cells being stabile from day to day

    
        

%%

figure;
subplot(121)
plot_sem(toneStab','m',0.3);
plot_sem(puffStab','k',0.3);
plot_sem(rewStab','g',0.3);
legend('','Tone Cells','','Puff Cells','','Reward Cells')
ylabel('Fraction'); title('Cell Stability')
ylim([0 1]); xlim([1 6]);

subplot(122)
%Day 2-3,3-4 vs 5-6,6-7
bar(1,mean2(toneStab(:,2:3)),'FaceColor','w','EdgeColor','m'); hold on
bar(2,mean2(toneStab(:,5:6)),'FaceColor','w','EdgeColor','m','LineStyle',':');
bar(3,mean2(puffStab(:,2:3)),'FaceColor','w','EdgeColor','k');
bar(4,mean2(puffStab(:,5:6)),'FaceColor','w','EdgeColor','k','LineStyle',':');
bar(5,mean2(rewStab(:,2:3)),'FaceColor','w','EdgeColor','g');
bar(6,mean2(rewStab(:,5:6)),'FaceColor','w','EdgeColor','g','LineStyle',':');

errorbar(1,mean2(toneStab(:,2:3)),std2(toneStab(:,2:3))/sqrt(18),'k');
errorbar(2,mean2(toneStab(:,5:6)),std2(toneStab(:,5:6))/sqrt(18),'k');
errorbar(3,mean2(puffStab(:,2:3)),std2(puffStab(:,2:3))/sqrt(18),'k');
errorbar(4,mean2(puffStab(:,5:6)),std2(puffStab(:,5:6))/sqrt(18),'k');
errorbar(5,mean2(rewStab(:,2:3)),std2(rewStab(:,2:3))/sqrt(18),'k');
errorbar(6,mean2(rewStab(:,5:6)),std2(rewStab(:,5:6))/sqrt(18),'k');
title('Day 2-3 & 3-4 vs 5-6 & 6-7');
ylabel('Fraction')
ylim([0 1]); xlim([0 7])
legend('Early','Late','Early','Late','Early','Late')
%%
%Overlap between High IEG cells and Tone/Puff/Reward
for day = 1:7
    for animal = 1:9
        toneOverlapIEG(animal,day) = length(intersect(highIEG{animal,day},toneCells{animal,day})) / length(highIEG{animal,day});
        puffOverlapIEG(animal,day) = length(intersect(highIEG{animal,day},puffCells{animal,day})) / length(highIEG{animal,day});
        rewOverlapIEG(animal,day) = length(intersect(highIEG{animal,day},rewCells{animal,day})) / length(highIEG{animal,day});
    end
end

figure;
subplot(131)
plot_sem(toneOverlapIEG(1:4,:)','m',0.3)
plot_sem(puffOverlapIEG(1:4,:)','k',0.3)
plot_sem(rewOverlapIEG(1:4,:)','g',0.3)
plot_sem(toneOverlapIEG(5:9,:)','--m',0.3)
plot_sem(puffOverlapIEG(5:9,:)','--k',0.3)
plot_sem(rewOverlapIEG(5:9,:)','--g',0.3)
ylim([0 0.5]); xlim([1 7])
legend('','Arc-Tone Cells','','Arc-Puff Cells','','Arc-Reward Cells','','cFos-Tone Cells','','cFos-Puff Cells','','cFos-Reward Cells')
ylabel('Fraction');
title('Fraction of IEG cells Overlapping with Stimulus')

subplot(132)
%Day 2&3 vs 6&7
bar(1,mean2(toneOverlapIEG(1:4,2:3)),'FaceColor','w','EdgeColor','m'); hold on
bar(2,mean2(toneOverlapIEG(1:4,6:7)),'FaceColor','w','EdgeColor','m','LineStyle',':');
bar(3,mean2(puffOverlapIEG(1:4,2:3)),'FaceColor','w','EdgeColor','k');
bar(4,mean2(puffOverlapIEG(1:4,6:7)),'FaceColor','w','EdgeColor','k','LineStyle',':');
bar(5,mean2(rewOverlapIEG(1:4,2:3)),'FaceColor','w','EdgeColor','g');
bar(6,mean2(rewOverlapIEG(1:4,6:7)),'FaceColor','w','EdgeColor','g','LineStyle',':');

errorbar(1,mean2(toneOverlapIEG(1:4,2:3)),std2(toneOverlapIEG(1:4,2:3))/sqrt(8),'k');
errorbar(2,mean2(toneOverlapIEG(1:4,6:7)),std2(toneOverlapIEG(1:4,6:7))/sqrt(8),'k');
errorbar(3,mean2(puffOverlapIEG(1:4,2:3)),std2(puffOverlapIEG(1:4,2:3))/sqrt(8),'k');
errorbar(4,mean2(puffOverlapIEG(1:4,6:7)),std2(puffOverlapIEG(1:4,6:7))/sqrt(8),'k');
errorbar(5,mean2(rewOverlapIEG(1:4,2:3)),std2(rewOverlapIEG(1:4,2:3))/sqrt(8),'k');
errorbar(6,mean2(rewOverlapIEG(1:4,6:7)),std2(rewOverlapIEG(1:4,6:7))/sqrt(8),'k');
title('Arc Day 2&3 vs 6&7');
ylabel('Fraction')
ylim([0 0.5]); xlim([0 7])
legend('Early','Late','Early','Late','Early','Late')

subplot(133)
bar(1,mean2(toneOverlapIEG(5:9,2:3)),'FaceColor','w','EdgeColor','m'); hold on
bar(2,mean2(toneOverlapIEG(5:9,6:7)),'FaceColor','w','EdgeColor','m','LineStyle',':');
bar(3,mean2(puffOverlapIEG(5:9,2:3)),'FaceColor','w','EdgeColor','k');
bar(4,mean2(puffOverlapIEG(5:9,6:7)),'FaceColor','w','EdgeColor','k','LineStyle',':');
bar(5,mean2(rewOverlapIEG(5:9,2:3)),'FaceColor','w','EdgeColor','g');
bar(6,mean2(rewOverlapIEG(5:9,6:7)),'FaceColor','w','EdgeColor','g','LineStyle',':');

errorbar(1,mean2(toneOverlapIEG(5:9,2:3)),std2(toneOverlapIEG(5:9,2:3))/sqrt(10),'k');
errorbar(2,mean2(toneOverlapIEG(5:9,6:7)),std2(toneOverlapIEG(5:9,6:7))/sqrt(10),'k');
errorbar(3,mean2(puffOverlapIEG(5:9,2:3)),std2(puffOverlapIEG(5:9,2:3))/sqrt(10),'k');
errorbar(4,mean2(puffOverlapIEG(5:9,6:7)),std2(puffOverlapIEG(5:9,6:7))/sqrt(10),'k');
errorbar(5,mean2(rewOverlapIEG(5:9,2:3)),std2(rewOverlapIEG(5:9,2:3))/sqrt(10),'k');
errorbar(6,mean2(rewOverlapIEG(5:9,6:7)),std2(rewOverlapIEG(5:9,6:7))/sqrt(10),'k');
title('cFos Day 2&3 vs 6&7');
ylabel('Fraction')
ylim([0 0.5]); xlim([0 7])
legend('Early','Late','Early','Late','Early','Late')
%%
%Overlap between Tone/Puff/Reward and High IEG cells 
for day = 1:7
    for animal = 1:9
        iegOverlapTone(animal,day) = length(intersect(highIEG{animal,day},toneCells{animal,day})) / length(toneCells{animal,day});
        iegOverlapPuff(animal,day) = length(intersect(highIEG{animal,day},puffCells{animal,day})) / length(puffCells{animal,day});
        iegOverlapRew(animal,day) = length(intersect(highIEG{animal,day},rewCells{animal,day})) / length(rewCells{animal,day});
    end
end

figure;
subplot(131)
plot_sem(iegOverlapTone(1:4,:)','m',0.3)
plot_sem(iegOverlapPuff(1:4,:)','k',0.3)
plot_sem(iegOverlapRew(1:4,:)','g',0.3)
plot_sem(iegOverlapTone(5:9,:)','-.m',0.3)
plot_sem(iegOverlapPuff(5:9,:)','-.k',0.3)
plot_sem(iegOverlapRew(5:9,:)','-.g',0.3)
ylim([0 1]); xlim([1 7])
legend('','Arc-Tone Cells','','Arc-Puff Cells','','Arc-Reward Cells','','cFos-Tone Cells','','cFos-Puff Cells','','cFos-Reward Cells')
ylabel('Fraction');
title('Fraction of Stimulus cells Overlapping with IEG')

arcOverlapRewEarly = iegOverlapRew(1:4,2:3);
subplot(132)
%Day 2&3 vs 6&7
bar(1,mean2(iegOverlapTone(1:4,2:3)),'FaceColor','w','EdgeColor','m'); hold on
bar(2,mean2(iegOverlapTone(1:4,6:7)),'FaceColor','w','EdgeColor','m','LineStyle',':');
bar(3,mean2(iegOverlapPuff(1:4,2:3)),'FaceColor','w','EdgeColor','k');
bar(4,mean2(iegOverlapPuff(1:4,6:7)),'FaceColor','w','EdgeColor','k','LineStyle',':');
bar(5,nanmean(arcOverlapRewEarly(:)),'FaceColor','w','EdgeColor','g');
bar(6,mean2(iegOverlapRew(1:4,6:7)),'FaceColor','w','EdgeColor','g','LineStyle',':');

errorbar(1,mean2(iegOverlapTone(1:4,2:3)),std2(iegOverlapTone(1:4,2:3))/sqrt(8),'k');
errorbar(2,mean2(iegOverlapTone(1:4,6:7)),std2(iegOverlapTone(1:4,6:7))/sqrt(8),'k');
errorbar(3,mean2(iegOverlapPuff(1:4,2:3)),std2(iegOverlapPuff(1:4,2:3))/sqrt(8),'k');
errorbar(4,mean2(iegOverlapPuff(1:4,6:7)),std2(iegOverlapPuff(1:4,6:7))/sqrt(8),'k');
errorbar(5,nanmean(arcOverlapRewEarly(:)),nanstd(arcOverlapRewEarly(:))/sqrt(8),'k');
errorbar(6,mean2(iegOverlapRew(1:4,6:7)),std2(iegOverlapRew(1:4,6:7))/sqrt(8),'k');
title('Arc Day 2&3 vs 6&7');
ylabel('Fraction')
ylim([0 1]); xlim([0 7])
legend('Early','Late','Early','Late','Early','Late')
subplot(133)
bar(1,mean2(iegOverlapTone(5:9,2:3)),'FaceColor','w','EdgeColor','m'); hold on
bar(2,mean2(iegOverlapTone(5:9,6:7)),'FaceColor','w','EdgeColor','m','LineStyle',':');
bar(3,mean2(iegOverlapPuff(5:9,2:3)),'FaceColor','w','EdgeColor','k');
bar(4,mean2(iegOverlapPuff(5:9,6:7)),'FaceColor','w','EdgeColor','k','LineStyle',':');
bar(5,mean2(iegOverlapRew(5:9,2:3)),'FaceColor','w','EdgeColor','g');
bar(6,mean2(iegOverlapRew(5:9,6:7)),'FaceColor','w','EdgeColor','g','LineStyle',':');

errorbar(1,mean2(iegOverlapTone(5:9,2:3)),std2(iegOverlapTone(5:9,2:3))/sqrt(10),'k');
errorbar(2,mean2(iegOverlapTone(5:9,6:7)),std2(iegOverlapTone(5:9,6:7))/sqrt(10),'k');
errorbar(3,mean2(iegOverlapPuff(5:9,2:3)),std2(iegOverlapPuff(5:9,2:3))/sqrt(10),'k');
errorbar(4,mean2(iegOverlapPuff(5:9,6:7)),std2(iegOverlapPuff(5:9,6:7))/sqrt(10),'k');
errorbar(5,mean2(iegOverlapRew(5:9,2:3)),std2(iegOverlapRew(5:9,2:3))/sqrt(10),'k');
errorbar(6,mean2(iegOverlapRew(5:9,6:7)),std2(iegOverlapRew(5:9,6:7))/sqrt(10),'k');
title('cFos Day 2&3 vs 6&7');
ylabel('Fraction')
ylim([0 1]); xlim([0 7])
legend('Early','Late','Early','Late','Early','Late')
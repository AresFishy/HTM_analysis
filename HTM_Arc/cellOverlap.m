%Find overlap between cell groups


for day = 1:7
    for animal = 1:4
        rpCellOverlap(animal,day) = length(intersect(rewCells{animal,day},puffCells{animal,day})) / length(rewCells{animal,day});
        prCellOverlap(animal,day) = length(intersect(puffCells{animal,day},rewCells{animal,day})) / length(puffCells{animal,day});
    end
end

figure;
plot_sem(rpCellOverlap','k',0.5); hold on
plot_sem(prCellOverlap','r',0.5)
ylim([0 1])
ylabel('Overlap / Fraction')
xlabel('Day')
legend('','Rew-Puff cells','','Puff-Rew cells')
title('Cell Population Overlap')

%%
%Find overlap between cell groups


for day = 1:7
    for animal = 1:4
        nrpCellOverlap(animal,day) = length(intersect(nrewCells{animal,day},npuffCells{animal,day})) / length(nrewCells{animal,day});
        nprCellOverlap(animal,day) = length(intersect(npuffCells{animal,day},nrewCells{animal,day})) / length(npuffCells{animal,day});
        nrp1CellOverlap(animal,day) = length(intersect(nrewCells{animal,day},puffCells{animal,day})) / length(nrewCells{animal,day});
        npr1CellOverlap(animal,day) = length(intersect(npuffCells{animal,day},rewCells{animal,day})) / length(npuffCells{animal,day});
    end
end

figure;
plot_sem(nrpCellOverlap','k',0.5); hold on
plot_sem(nprCellOverlap','r',0.5)
plot_sem(nrp1CellOverlap','--k',0.5); hold on
plot_sem(npr1CellOverlap','--r',0.5)
ylim([0 1])
ylabel('Overlap / Fraction')
xlabel('Day')
legend('','nRew-nPuff cells','','nPuff-nRew cells','','nRew-Puff cells','','nPuff-Rew cells')
title('Cell Population Overlap')

%%
%Overlap for rew and puff cells across days
rrCellOverlap = []; ppCellOverlap = [];
rp1CellOverlap = []; pr1CellOverlap = [];
for day = 1:6
    for animal = 1:4
    rrCellOverlap(animal,day) = length(intersect(rewCells{animal,day},rewCells{animal,day+1})) / length(rewCells{animal,day});
    ppCellOverlap(animal,day) = length(intersect(puffCells{animal,day},puffCells{animal,day+1})) / length(puffCells{animal,day});
    rp1CellOverlap(animal,day) = length(intersect(rewCells{animal,day},puffCells{animal,day+1})) / length(rewCells{animal,day});
    pr1CellOverlap(animal,day) = length(intersect(puffCells{animal,day},rewCells{animal,day+1})) / length(puffCells{animal,day});
    end
end

figure;
plot_sem(rrCellOverlap','k',0.3); hold on
plot_sem(ppCellOverlap','r',0.3)
plot_sem(rp1CellOverlap','--k',0.3);
plot_sem(pr1CellOverlap','--r',0.3)
ylim([0 1])
ylabel('Overlap / Fraction')
xlabel('Day')
legend('','Rew-Rew cells','','Puff-Puff cells','','Rew-Puff cells','','Puff-Rew cells')
set(gca,'XTick',[1:1:6])
set(gca,'XTickLabel', {'1-2','2-3','3-4','4-5','5-6','6-7'});
title('Cell Population Overlap Between Days')

%%
%Overlap for negative rew and puff cells across days
nrrCellOverlap = []; nppCellOverlap = [];
nrp1CellOverlap = []; npr1CellOverlap = [];
for day = 1:6
    nrrCellOverlap(animal,day) = length(intersect(nrewCells{animal,day},nrewCells{animal,day+1})) / length(nrewCells{animal,day});
    nppCellOverlap(animal,day) = length(intersect(npuffCells{animal,day},npuffCells{animal,day+1})) / length(npuffCells{animal,day});
    nrp1CellOverlap(animal,day) = length(intersect(nrewCells{animal,day},npuffCells{animal,day+1})) / length(nrewCells{animal,day});
    npr1CellOverlap(animal,day) = length(intersect(npuffCells{animal,day},nrewCells{animal,day+1})) / length(npuffCells{animal,day});
end

figure;
plot_sem(nrrCellOverlap','k',0.3); hold on
plot_sem(nppCellOverlap','r',0.3)
plot_sem(nrp1CellOverlap','--k',0.3);
plot_sem(npr1CellOverlap','--r',0.3)
ylim([0 1])
ylabel('Overlap / Fraction')
xlabel('Day')
legend('','nRew-nRew cells','','nPuff-nPuff cells','','nRew-nPuff cells','','nPuff-nRew cells')
set(gca,'XTick',[1:1:6])
set(gca,'XTickLabel', {'1-2','2-3','3-4','4-5','5-6','6-7'});
title('Cell Population Overlap Between Days')
%%
%Plot cell overlap for Tone and Arc cells

toneArcOver = [];
ntoneArcOver = [];
rewArcOver = [];
nrewArcOver = [];
puffArcOver = [];
npuffArcOver = [];

figure; hold on
for day = 1:6
    for animal = 1:4
        toneArcOver(animal,day) = length(intersect(highArc{animal,day},toneCells{animal,day+1})) / length(highArc{animal,day});
        ntoneArcOver(animal,day) = length(intersect(highArc{animal,day},ntoneCells{animal,day+1})) / length(highArc{animal,day});
        rewArcOver(animal,day) = length(intersect(highArc{animal,day},rewCells{animal,day+1})) / length(highArc{animal,day});
        nrewArcOver(animal,day) = length(intersect(highArc{animal,day},nrewCells{animal,day+1})) / length(highArc{animal,day});
        puffArcOver(animal,day) = length(intersect(highArc{animal,day},puffCells{animal,day+1})) / length(highArc{animal,day});
        npuffArcOver(animal,day) = length(intersect(highArc{animal,day},npuffCells{animal,day+1})) / length(highArc{animal,day});
    end
end
subplot(131)
plot_sem(toneArcOver','g',0.4)
plot_sem(rewArcOver','k',0.4)
plot_sem(puffArcOver','r',0.4)
ylim([0 0.5])
ylabel('Overlap / Fraction')
xlabel('Day')
set(gca,'XTick',[1:1:6])
set(gca,'XTickLabel', {'1-2','2-3','3-4','4-5','5-6','6-7'});
title('Cell Population Overlap Between Days')
legend('','hArc-Tone cells','','hArc-Rew cells','','hArc-Puff cells')
subplot(132)
plot_sem(ntoneArcOver','--g',0.4)
plot_sem(nrewArcOver','--k',0.4)
plot_sem(npuffArcOver','--r',0.4)
ylim([0 0.5])
ylabel('Overlap / Fraction')
xlabel('Day')
set(gca,'XTick',[1:1:6])
set(gca,'XTickLabel', {'1-2','2-3','3-4','4-5','5-6','6-7'});
title('nCell Population Overlap Between Days')
legend('','hArc-Tone cells','','hArc-Rew cells','','hArc-Puff cells')
subplot(133)
plot_sem((toneArcOver-ntoneArcOver)','g',0.4)
plot_sem((rewArcOver-nrewArcOver)','k',0.4)
plot_sem((puffArcOver-npuffArcOver)','r',0.4)
ylim([-0.1 0.5])
ylabel('Overlap Difference/ Fraction')
xlabel('Day')
set(gca,'XTick',[1:1:6])
set(gca,'XTickLabel', {'1-2','2-3','3-4','4-5','5-6','6-7'});
title('Difference in Cell Population Overlap Between Days')
legend('','hArc-Tone cells','','hArc-Rew cells','','hArc-Puff cells')
%%
%Plot overlap between tone cells and puff/reward cells
for day = 1:8
    for animal = 1:4
        trtmp(animal,day) = length(intersect(toneCells{animal,day},rewCells{animal,day}))/length(toneCells{animal,day});
        tptmp(animal,day) = length(intersect(toneCells{animal,day},puffCells{animal,day}))/length(toneCells{animal,day});
    end
end

plot_sem(trtmp','k',0.5); hold on
plot_sem(tptmp','r',0.5);
ylim([0 1])
title('ToneCell overlap')
legend('','Tone-RewCells','','Tone-PuffCells')
ylabel('Overlap / Fraction')
xlabel('Day')
%%
%Plot overlap between days for Low and High Arc neurons
for day = 1:6
    for animal = 1:4
        llArcCells(animal,day) = length(intersect(lowArc{animal,day},lowArc{animal,day+1})) / length(lowArc{animal,day});
        hlArcCells(animal,day) = length(intersect(highArc{animal,day},lowArc{animal,day+1})) / length(highArc{animal,day});
        hhArcCells(animal,day) = length(intersect(highArc{animal,day},highArc{animal,day+1})) / length(highArc{animal,day});
        lhArcCells(animal,day) = length(intersect(lowArc{animal,day},highArc{animal,day+1})) / length(lowArc{animal,day});
    end
end
figure; hold on
plot_sem(llArcCells','k');
plot_sem(hhArcCells','r');
plot_sem(hlArcCells','--k');
plot_sem(lhArcCells','--r');
ylim([0 1])
ylabel('Overlap / Fraction')
xlabel('Day')
set(gca,'XTick',[1:1:6])
set(gca,'XTickLabel', {'1-2','2-3','3-4','4-5','5-6','6-7'});
legend('','lowArc Cells','','highArc Cells');
title('Arc cell population overlap')

%%
%Plot number of responsive cells
tmpP = []; tmpR = []; tmpT = []; tmpG = [];
figure; hold on
for day = 1:7
    for animal = 1:4
        tmpP(animal,day) = length(puffCells{animal,day})/size(trialAct{animal,1},2);
        tmpR(animal,day) = length(rewCells{animal,day})/size(trialAct{animal,1},2);
        tmpT(animal,day) = length(toneCells{animal,day})/size(trialAct{animal,1},2);
        tmpG(animal,day) = length(gratCells{animal,day})/size(trialAct{animal,1},2);
    end
end

plot_sem(tmpP','k',0.3);
plot_sem(tmpR','r',0.3);
plot_sem(tmpT','g',0.3);
plot_sem(tmpG','m',0.3);
ylim([0 1])
ylabel('Fraction of population')
legend('','Puff Cells','','Reward Cells','','Tone Cells','','Grating Cells')
xlabel('Day')

%%
%Plot number of responsive cells
tmpnP = []; tmpnR = []; tmpnT = []; tmpnG = [];
figure; hold on
for day = 1:7
    for animal = 1:4
        tmpnP(animal,day) = length(npuffCells{animal,day})/size(trialAct{animal,1},2);
        tmpnR(animal,day) = length(nrewCells{animal,day})/size(trialAct{animal,1},2);
        tmpnT(animal,day) = length(ntoneCells{animal,day})/size(trialAct{animal,1},2);
        tmpnG(animal,day) = length(ngratCells{animal,day})/size(trialAct{animal,1},2);
    end
end

plot_sem(tmpnP','k',0.3);
plot_sem(tmpnR','r',0.3);
plot_sem(tmpnT','g',0.3);
plot_sem(tmpnG','m',0.3);
ylim([0 1])
ylabel('Fraction of population')
legend('','Puff Cells','','Reward Cells','','Tone Cells','','Grating Cells')
xlabel('Day')

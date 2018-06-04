%--------------------------------------------------------------------------
%Plot overlap in activity and cells across days
%--------------------------------------------------------------------------

%Plot mean activity overlaps
cnt = 0;
for day = 1:8
    for day2 = 1:8
        cnt = cnt + 1;
        subplot(8,8,cnt)
        imagesc(nanmean(seqActComb{day}(combCells{day2},:)))
        set(gca,'clim',[1 1.1])
    end
end
% xlabel('Day X')
% ylabel('Day Y')
% title('Activity per day based on day of selection')
%%
%Plot mean activity overlaps of frame 180:200
cnt = 0;
for day = 1:8
    for day2 = 1:8
        actOverlap(day,day2) = mean(nanmean(OnsetActComb{day}(combCells{day2},15:25)));
    end
end

imagesc(actOverlap)
set(gca,'clim',[0 0.05])
line([4.5 4.5],get(gca,'ylim'),'color','k')
line(get(gca,'xlim'),[4.5 4.5],'color','k')
xlabel('Day X')
ylabel('Day Y')
title('Activity per day based on day of selection - Mean frame 15:25')
%%
%Plot overlap in End responsive cells
cnt = 0;
for day = 1:8
    for day2 = 1:8
        cellOverlap(day,day2) = length(intersect(combCells{day},combCells{day2}))/length(combCells{day});
        cellNOverlap(day,day2) = length(intersect([rewCellsNComb{day} puffCellsNComb{day}],[rewCellsNComb{day2} puffCellsNComb{day2}]))/length([rewCellsNComb{day} puffCellsNComb{day}]);
    end
end
figure;
imagesc(cellOverlap)
line([4.5 4.5],get(gca,'ylim'),'color','k')
line(get(gca,'xlim'),[4.5 4.5],'color','k')
set(gca,'clim',[0 0.5])
xlabel('Day X')
ylabel('Day Y')
title('Overlap in End responsive cells')

figure;
imagesc(cellNOverlap)
line([4.5 4.5],get(gca,'ylim'),'color','k')
line(get(gca,'xlim'),[4.5 4.5],'color','k')
set(gca,'clim',[0 0.5])
xlabel('Day X')
ylabel('Day Y')
title('Overlap in End Neg responsive cells')

%%
%Plot the overlap from day to day
figure;
plot(diag(cellOverlap,1));
ylim([0 1])
ylabel('Day')
xlabel('Overlap fraction')
title('Overlap in End responsive cells')
refline([0 0.1])

figure;
plot(diag(cellNOverlap,1));
ylim([0 1])
ylabel('Day')
xlabel('Overlap fraction')
title('Overlap in End Neg responsive cells')
refline([0 0.1])

%%
test = [];
for day = 1:8
    rewpuffOverlap(day) = length(intersect(rewCellsComb{day},puffCellsComb{day})) / length(unique([rewCellsComb{day} puffCellsComb{day}]));
    rewNpuffNOverlap(day) = length(intersect(rewCellsNComb{day},puffCellsNComb{day})) / length(unique([rewCellsNComb{day} puffCellsNComb{day}]));
    rew1rew2Overlap(day) = length(intersect(rew1CellsComb{day},rew2CellsComb{day})) / length(unique([rew1CellsComb{day} rew2CellsComb{day}]));
    puff1puff2Overlap(day) = length(intersect(puff1CellsComb{day},puff2CellsComb{day})) / length(unique([puff1CellsComb{day} puff2CellsComb{day}]));
end

figure;
plot(rewpuffOverlap); hold on
plot(rewNpuffNOverlap)
plot(rew1rew2Overlap)
plot(puff1puff2Overlap)
legend({'rewpuff','rewNpuffN','rew1rew2','puff1puff2'},'location','southeast')
xlabel('Day')
ylabel('Overlap fraction')
title('Overlap between cell groups')


%%
%Plot activity of overlapping and non-overlapping cells
for day = 1:7
    subplot(4,2,day)
    a = intersect(combCells{day},combCells{day + 1});
    b = setdiff(combCells{day},a);
    str = sprintf('Day %d',day);
    overlapMeanAct(day) = mean(nanmean(OnsetActComb{day}(a,15:25),2));
    nonoverlapMeanAct(day) = mean(nanmean(OnsetActComb{day}(b,15:25),2));
    
    plotSEM(OnsetActComb{day}(a,:)','b')
    plotSEM(OnsetActComb{day}(b,:)','r')
    legend({'Non-overlap Cells','Overlap Cells'},'Location','northwest')
    title(str)
    xlim([1 31])
    ylim([0 0.25])
end
subplot(4,2,8)
bar(1,mean(overlapMeanAct),'b'); hold on
bar(2,mean(nonoverlapMeanAct),'r')
errorbar(1,mean(overlapMeanAct),std(overlapMeanAct))
errorbar(2,mean(nonoverlapMeanAct),std(nonoverlapMeanAct))
%%
%Plot activity of overlapping and non-overlapping negative cells
for day = 1:7
    subplot(4,2,day)
    a = intersect([rewCellsNComb{day} puffCellsNComb{day}],[rewCellsNComb{day+1} puffCellsNComb{day+1}]);
    b = setdiff([rewCellsNComb{day} puffCellsNComb{day}],a);
    str = sprintf('Day %d',day);
    overlapMeanAct(day) = mean(nanmean(OnsetActComb{day}(a,15:25),2));
    nonoverlapMeanAct(day) = mean(nanmean(OnsetActComb{day}(b,15:25),2));
    
    plotSEM(OnsetActComb{day}(a,:)','b')
    plotSEM(OnsetActComb{day}(b,:)','r')
    legend({'Non-overlap Cells','Overlap Cells'},'Location','northwest')
    title(str)
    refline([0 0])
    xlim([1 31])
    ylim([-0.1 0.1])
end
subplot(4,2,8)
bar(1,mean(overlapMeanAct),'b'); hold on
bar(2,mean(nonoverlapMeanAct),'r')
errorbar(1,mean(overlapMeanAct),std(overlapMeanAct))
errorbar(2,mean(nonoverlapMeanAct),std(nonoverlapMeanAct))
%%
%Plot correlation of responses across days

for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            tmpCor = triu(corrcoef(squeeze(nanmean(seqAct{animal,day}(:,rew{animal,day},:),3))'),1);
            meanCor(animal,day) = mean(nanmean(tmpCor(tmpCor > 0)));
        end
    end
end

figure;
plotSEM(meanCor')
ylim([0 1])





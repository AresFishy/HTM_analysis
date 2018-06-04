%Count how many days a cell contributes by responding to the same element

for ele = 1:10;
    daysOverlapCell(:,ele) = histcounts(horzcat(selCellsComb{:,ele}),[0.5:1:1735.5]);
    [daysOverlapHist(:,ele),daysOverlapEdge(:,ele)] = histcounts(daysOverlapCell(:,ele),[-0.5:1:8.5]);
end

figure;
plot(daysOverlapEdge(2:end,:)+.5,daysOverlapHist,'--x')
ylabel('No. of Cells')
xlabel('Number of days responsive')
title('How many days cells respond to a given seq. element')

%Get cells that are responsive to an element at least 4 days
[stabCellsR,~] = find(daysOverlapCell > 3);
stabCells = unique(stabCellsR);



%Count how many elements a cell contributes to within the same day

for day = 1:8;
    eleOverlapCell{day} = histcounts(horzcat(selCellsComb{day,1:10}),[0.5:1:1735.5]);
    [eleOverlapHist(day,:), eleOverlapEdge(day,:)] = histcounts(eleOverlapCell{day},[-0.5:1:17.5]);
end

figure;
plot(eleOverlapEdge(:,2:end)'-.5,eleOverlapHist','--x')
axis tight;
xlim([0 10])
ylabel('No. of Cells')
xlabel('Number of elements responsive')
title('How many elements cells respond to a given day')

%Get overlap in cells from day to day
cellOverlapNo = [];
cellOverlapFrac = [];
for day = 1:7
    for ele = 1:10
        cellOverlapNo(day,ele) = length(intersect(selCellsComb{day,ele},selCellsComb{day+1,ele}));
        cellOverlapFrac(day,ele) = (cellOverlapNo(day,ele) / length(selCellsComb{day,ele}))*100;
    end
end

figure
plotSEM(cellOverlapFrac)
ylim([0 50])
ylabel('Overlap %')
xlabel('Days')
set(gca,'XTick',[1:size(cellOverlapFrac,1)],'XTickLabel',{'D1-2','D2-3','D3-4','D4-5','D5-6','D6-7','D7-8'})
title('Overlap in element responsive cells from day to day')

figure;
plotSEM(cellOverlapFrac')
ylim([0 50])
ylabel('Overlap %')
xlabel('Element')
title('Overlap in element responsive cells across days')

%%
%Show overlap as a function of days
tempOv = {};
tempOv2 = [];
for ele = 1:10
    tempOv{ele} = [];
    for day = 1:5
        tempOv{ele} = [tempOv{ele}, intersect(selCellsComb{day,ele},selCellsComb{6,ele})];
        tempOv2(day,ele) = (length(intersect(selCellsComb{day,ele},selCellsComb{6,ele})) / length(selCellsComb{day,ele}))*100;
    end
end

figure;
plotSEM(tempOv2,'k')
title('Overlap between day 6 and prior')
ylim([0 50])
ylabel('Overlap %')
xlabel('Days')
set(gca,'XTick',[1:size(tempOv2,1)],'XTickLabel',{'D1-6','D2-6','D3-6','D4-6','D5-6'})

%%
%Show overlap across all sequence responsive cells

for day = 1:8
    combSelCells{day} = unique(horzcat(selCellsComb{day,1:10}));
end

combSelCellsOverlap = {};
combSelCellsOverlapFrac = [];
conseqDayActDiff = [];
nonseqDayActDiff = [];
cnt = 0;
for day1 = 1:7
    for day2 = day1+1:8;
        combSelCellsOverlapFrac(day1,day2) = length(intersect(combSelCells{day1},combSelCells{day2})) / length(combSelCells{day1});
        combSelCellsOverlap{day1,day2} = intersect(combSelCells{day1},combSelCells{day2});
        combSelCellsNoOverlap{day1,day2} = setdiff(combSelCells{day1},combSelCellsOverlap{day1,day2});
        
        overlapActDif(day1,day2,:) = mean(seqActComb1{day1}(combSelCellsOverlap{day1,day2},:)) -  mean(seqActComb1{day1}(combSelCellsNoOverlap{day1,day2},:));
        if day2-day1 == 1; %Get consecutive days
            conseqDayActDiff(day1,:) =  squeeze(overlapActDif(day1,day2,:));
        elseif day2-day1 > 1; %Get days more than 1 day apart
            cnt = cnt + 1;
            nonseqDayActDiff(cnt,:) =  squeeze(overlapActDif(day1,day2,:));
        end
    end
end

figure;
plotSEM(conseqDayActDiff')
hold on
plotSEM(nonseqDayActDiff')
xlabel('Frame #')
ylabel('dF/F\')
legend('Non-Consecutive Days','Consecutive Days')
title('Difference in activity between overlapping and non-overlapping cells')
refline([0])


%%

combSelCellsOverlap = {};
combSelCellsOverlapFrac = [];
conseqDayActDiff = [];
nonseqDayActDiff = [];
cnt = 0;
for day1 = 1:7
    for day2 = day1+1:8;
        combSelCellsOverlapFrac(day1,day2) = length(intersect(actCorrCellComb{day1},actCorrCellComb{day2})) / length(actCorrCellComb{day1});
        combSelCellsOverlap{day1,day2} = intersect(actCorrCellComb{day1},actCorrCellComb{day2});
        combSelCellsNoOverlap{day1,day2} = setdiff(actCorrCellComb{day1},combSelCellsOverlap{day1,day2});
        
        overlapActDif(day1,day2,:) = mean(seqActComb1{day1}(combSelCellsOverlap{day1,day2},:)) -  mean(seqActComb1{day1}(combSelCellsNoOverlap{day1,day2},:));
        if day2-day1 == 1; %Get consecutive days
            conseqDayActDiff(day1,:) =  squeeze(overlapActDif(day1,day2,:));
        elseif day2-day1 > 1; %Get days more than 1 day apart
            cnt = cnt + 2;
            nonseqDayActDiff(cnt,:) =  squeeze(overlapActDif(day1,day2,:));
        end
    end
end

figure;
plotSEM(conseqDayActDiff')
hold on
plotSEM(nonseqDayActDiff')
xlabel('Frame #')
ylabel('dF/F\')
legend('Non-Consecutive Days','Consecutive Days')
title('Difference in activity between overlapping and non-overlapping cells')
refline([0])



%%
for day = 1:7
    tmp(day) = length(intersect(actCorrCellComb{day},actCorrCellComb{day+1})) / length(actCorrCellComb{day});
end
plot(tmp)



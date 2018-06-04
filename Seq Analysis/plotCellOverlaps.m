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











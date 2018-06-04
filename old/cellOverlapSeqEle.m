%Get overlap of cells for across elements for each day
selCellsAll = {};
selCellsUnique = {};
selCellsRepNo = {};
selCellsRepID = {};
for day = 1:8;
    selCellsAll{day} = [];
    for ele = 1:10;
        selCellsAll{day} = [selCellsAll{day}, selCellsComb{day,ele}];
    end
    selCellsUnique{day} = unique(selCellsAll{day});
    [selCellsRepNo{day},selCellsRepID{day}] = histcounts(selCellsAll{day},selCellsUnique{day});
end

for day = 1:8
    str = sprintf('Day %d',day);
    subplot(2,4,day)
    histogram(selCellsRepNo{day},[0.5:1:10.5],'Normalization','probability')
    ylim([0 1])
    xlim([0.5 10.5])
    title(str)
    xlabel('Number of elements showing response')
    ylabel('Number of cells')
end

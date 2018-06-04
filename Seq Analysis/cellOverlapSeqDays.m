%Get overlap of cells for each element across days
selCellsAll = {};
selCellsUnique = {};
selCellsRepNo = {};
selCellsRepID = {};
for ele = 1:10;
    selCellsAll{ele} = [];
    for day = 1:8;
        selCellsAll{ele} = [selCellsAll{ele}, selCellsComb{day,ele}];
    end
    selCellsUnique{ele} = unique(selCellsAll{ele});
    [selCellsRepNo{ele},selCellsRepID{ele}] = histcounts(selCellsAll{ele},selCellsUnique{ele});
end

for ele = 1:10
    if ele < 6;
        str = sprintf('Seq1 Element %d',ele);
    else
        str = sprintf('Seq2 Element %d',ele-5);
    end
    subplot(2,5,ele)
    histogram(selCellsRepNo{ele},[0.5:1:8.5],'Normalization','probability')
    ylim([0 1])
    xlim([0.5 8.5])
    title(str)
    xlabel('Number of days showing response')
    ylabel('Number of cells')
end

%Get cells that are active across minimum 2 days
for ele = 1:10
    selCellsRep{ele} = selCellsRepID{ele}(find(selCellsRepNo{ele} > 2));
    for day = 1:8
        for cell = 1:length(selCellsRep{ele})
            selCellsPres{ele}(cell,day) = ismember(selCellsRep{ele}(cell), selCellsComb{day,ele});
        end
        [~,tmpMax] = max(selCellsPres{ele}');
        [~,tmpSort{ele}] = sort(tmpMax);
    end
    selCellsRepAct(ele,:) = sum(selCellsPres{ele});
end
figure;
for ele = 1:10;
    subplot(2,5,ele)
    if ele < 6;
        str = sprintf('Seq1 Element %d',ele);
    else
        str = sprintf('Seq2 Element %d',ele-5);
    end
    imagesc(selCellsPres{ele}(tmpSort{ele},:)); colormap gray;
    title(str)
end
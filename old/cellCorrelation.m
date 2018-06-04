%Correlation in activity

%Use spikeActivity
corrCellX = {};
corrCellY = {};
for day = 1:8
    for animal = 1:6
        tmpCorr = corrcoef(thresAct{animal,day}');
        [corrCellX{animal,day},corrCellY{animal,day}] = find(triu(tmpCorr) > 0.001 & triu(tmpCorr) < 0.9);
    end
end



%Get euclidean distace between pairs
cellsMouse = [0 size(act{1,1},1) size(act{2,1},1) size(act{3,1},1) size(act{4,1},1) size(act{5,1},1) size(act{6,1},1)];
corrPairDist = {};
corrCellXComb = {};
corrCellYComb = {};
for day = 1:8;
    %Get total index of correlation cells
    corrCellXComb{day} = [];
    corrCellYComb{day} = [];
    for animal = 1:5
        corrCellXComb{day} = [corrCellXComb{day}; corrCellX{animal,day}+sum(cellsMouse(1:animal))];
        corrCellYComb{day} = [corrCellYComb{day}; corrCellY{animal,day}+sum(cellsMouse(1:animal))];
    end
    
    %Calculate distance between correlating cells
    for ind = 1:length(corrCellXComb{day});
        cell1x = roiCntrX(corrCellXComb{day}(ind));
        cell1y = roiCntrY(corrCellXComb{day}(ind));
        cell2x = roiCntrX(corrCellYComb{day}(ind));
        cell2y = roiCntrY(corrCellYComb{day}(ind));
        
        corrPairDist{day}(ind) = sqrt(sum(([cell1x cell1y] - [cell2x cell2y]).^2));
    end
end

figure;
histogram(corrPairDist{1},300)
xlabel('Distance between correlated cell pairs')

%Find correlated cell pairs more than 20 um from each other
for day = 1:8
    corrCells{day} = find(corrPairDist{day} > 20);
end


figure;
for day = 1:8
    subplot(2,4,day)
    tmpHist = histogram(corrCellXComb{day}(corrCells{day}),[0.5:1:1735.5]);
    corrHistVal(day,:) = tmpHist.Values;
    corrHistIdx(day,:) = tmpHist.BinEdges;
end

figure;
for day = 1:8
    subplot(2,4,day)
    str = sprintf('Day %d',day);
    histogram(corrHistVal(day,:),[-0.5:1:30.5],'Normalization','Probability');
    xlim([-1 11])
    ylim([0 1])
    xlabel('No. of correlation partners')
    ylabel('Fraction')
    title(str)
end
%%
for ind = 1:50
    hold off
    plot(act{5,1}(corrCellX{5,1}(ind),:));
    hold on
    plot(act{5,1}(corrCellY{5,1}(ind),:));
    pause
end
    
    
    
    

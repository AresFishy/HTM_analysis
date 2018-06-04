%Find different Arc groups

for day = 1:8
    for animal = 1:3
        for cell = 1:size(arcAct{animal,day},1)
            arcDiff{animal,day}(cell) = arcAct{animal,day}(cell,6)-arcAct{animal,day}(cell,1);
        end
        tmpArcCellH{animal,day} = find(arcDiff{animal,day} > (median(arcDiff{animal,day})+abs(median(arcDiff{animal,day}))*1.5));
        tmpArcCellL{animal,day} = find(arcDiff{animal,day} < (median(arcDiff{animal,day})-abs(median(arcDiff{animal,day}))*1.5));
    end
end

%Combine cells across animals cells
cellList = [0 336 336+512];


 cArcCellH = {};
 cArcCellL = {};
for day = 1:8
    cArcCellH{day} = [];
    cArcCellL{day} = [];
    for animal = 1:3
        cArcCellH{day} = [cArcCellH{day} tmpArcCellH{animal,day}+cellList(animal)];
        cArcCellL{day} = [cArcCellL{day} tmpArcCellL{animal,day}+cellList(animal)];
    end
end

%%
for day = 1:8
    plot(nanmean(cRewAct{day}(cArcCellH{day},:)),'k'); hold on
    plot(nanmean(cRewAct{day}),'r'); hold on
end
       
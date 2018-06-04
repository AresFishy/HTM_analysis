%Get Arc Expression Normalized for each recording and animal

animals=1:9;
days=1:14;
cellL = [0 289 487 195 300 343 394 373 443];
cellList = cumsum(cellL);
arcCells = 1:1271;
arcAnim = 1:4;
cfosAnim = 5:9;
cfosCells = 1272:3090;

iegAct = {};
tmpIegAct = {};
tmp2IegAct = {};
for animal = animals
    daycnt = 0;
    for day = days(1:2:14)
        daycnt = daycnt +1;
        if size(proj_meta(animal).rd,2)-day > -1;
            for layer = 1:4;
                for secTmp = 1:size(proj_meta(animal).rd(layer,day).template_sec,3)
                    for rois = 1:length(proj_meta(animal).rd(layer,day).ROIinfo);
                        [roiX, roiY] = ind2sub([400 750],proj_meta(animal).rd(layer,day).ROIinfo(rois).indices);
                        tmpIegAct{animal,daycnt,layer}(rois,secTmp) = mean(mean(proj_meta(animal).rd(layer,day).template_sec(roiX,roiY,secTmp)));
                    end
                end
            end
        end
        %Calculate dF/F for Arc expression by normalizing to median of
        %lowest 10% of the average IEG snapshot.
         tmp2IegAct{animal,daycnt} = vertcat(tmpIegAct{animal,daycnt,:});
%         sortIeg = sort(tmp2IegAct{animal,daycnt});
%         low8Ieg = median(sortIeg(1:round(length(sortIeg)/12.5),:));
        tmpTemp = mean(proj_meta(animal).rd(layer,day).template_sec,3);
        sortIeg = sort(tmpTemp(:));
        low10Ieg = median(sortIeg(1:round(length(sortIeg)*0.1)));
        for tp = 1:6
            iegAct{animal,daycnt}(:,tp) = (tmp2IegAct{animal,daycnt}(:,tp))./low10Ieg;
        end
        %Calculate mean Arc expression
        if ~isempty(iegAct{animal,daycnt})
            mIegAct{animal,daycnt} = nanmean(iegAct{animal,daycnt},2);
        else
            mIegAct{animal,daycnt} = NaN(size(iegAct{animal,1},1),1);
        end
        
        %Calculate the difference in Arc expression across the 6 recordings
        iegDiff{animal,daycnt} = diff(iegAct{animal,daycnt},1,2);
        %Calculate total change in Arc expression
        if ~isempty(iegDiff{animal,daycnt})
            mIegDiff{animal,daycnt} = sum(iegDiff{animal,daycnt},2);
        else
            mIegDiff{animal,daycnt} = NaN(size(iegAct{animal,1},1),1);
        end
    end
end

for animal = 1:9
    meanIEG{animal} = mean(horzcat(mIegAct{animal,:}),2);
end

%%
cHighIEG = [];    cLowIEG = [];          cIntIEG = [];
cArcCells = [];   cLowArcCells = [];     cIntArcCells = [];
cCfosCells = [];  cLowCfosCells = [];    cIntCfosCells = [];


for animal = 1:9
    %Find cells with the highest IEG expression across all days
    [~,tmpIdx] = sort(meanIEG{animal},'descend');
    highIEG{animal} = tmpIdx(1:round(length(meanIEG{animal})*0.1));
    lowIEG{animal} = tmpIdx(end-round(length(meanIEG{animal})*0.1):end);
    intIEG{animal} = tmpIdx(round(length(meanIEG{animal})*0.1):end-round(length(meanIEG{animal})*0.1));
    
    cHighIEG = [cHighIEG; highIEG{animal}+cellList(animal)];
    cLowIEG = [cLowIEG; lowIEG{animal}+cellList(animal)];
    cIntIEG = [cIntIEG; intIEG{animal}+cellList(animal)];
    
    if animal < 5
        cArcCells = [cArcCells; highIEG{animal}+cellList(animal)];
        cLowArcCells = [cLowArcCells; lowIEG{animal}+cellList(animal)];
        cIntArcCells = [cIntArcCells; intIEG{animal}+cellList(animal)];
    else
        cCfosCells = [cCfosCells; highIEG{animal}+cellList(animal)];
        cLowCfosCells = [cLowCfosCells; lowIEG{animal}+cellList(animal)];
        cIntCfosCells = [cIntCfosCells; intIEG{animal}+cellList(animal)];
    end
end

%Combine the Arc and change in Arc expression across animals
cIegDiff = [];
cIegAct = [];
for day = 1:7
    cIegDiff(:,day) = vertcat(mIegDiff{:,day});
    cIegAct(:,day) = vertcat(mIegAct{:,day});
end

%Find cells that are high across all days
% highArcHist =  histogram(vertcat(cArcCells{:,:}),1271);
% highArcConst = find(highArcHist.Values > 6);
% close(gcf)
% highCfosHist =  histogram(vertcat(cCfosCells{:,:}),1819);
% highCfosConst = find(highCfosHist.Values > 6)+1271;
% close(gcf)
% 


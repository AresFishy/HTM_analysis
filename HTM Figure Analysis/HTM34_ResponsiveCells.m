function [toneCells, cToneCells, gratCells, cGratCells, rewCells, cRewCells, puffCells, cPuffCells] = HTM34_ResponsiveCells(tone_resp, grat_resp, puff_resp, rew_resp)

%Find responsive cells

%Tone Cells
toneCells = {};
puffCells = {};
rewCells = {};
gratCells = {};

for day = 1:7
    for animal = 1:9
        cntT = 1;
        cntP = 1;
        cntR = 1;
        cntG = 1;
        for cell = 1:size(tone_resp{animal,day},1)
            resT = ttest(mean(tone_resp{animal,day}(cell,45:49,2:2:end),2),mean(tone_resp{animal,day}(cell,55:59,2:2:end),2),'alpha',0.01,'Tail','Left');
            if resT == 1
                toneCells{animal,day}(cntT) = cell;
                cntT = cntT + 1;
            end
            
            resG = ttest(mean(grat_resp{animal,day}(cell,45:49,2:2:end),2),mean(grat_resp{animal,day}(cell,55:59,2:2:end),2),'alpha',0.01,'Tail','Left');
            if resG == 1
                gratCells{animal,day}(cntG) = cell;
                cntG = cntG + 1;
            end
            
            resP = ttest(mean(puff_resp{animal,day}(cell,45:49,2:2:end),2),mean(puff_resp{animal,day}(cell,55:59,2:2:end),2),'alpha',0.01,'Tail','Left');
            if resP == 1
                puffCells{animal,day}(cntP) = cell;
                cntP = cntP + 1;
            end
            
            if ~isempty(rew_resp{animal,day});
                resR = ttest(mean(rew_resp{animal,day}(cell,45:49,2:2:end),2),mean(rew_resp{animal,day}(cell,55:59,2:2:end),2),'alpha',0.01,'Tail','Left');
                if resR == 1
                    rewCells{animal,day}(cntR) = cell;
                    cntR = cntR + 1;
                end
            end
        end
    end
end

%Combine cells across animals for a combined list
cellL = [0 289 487 195 300 343 394 373 443];
cellList = cumsum(cellL);
cToneCells = {};
cGratCells = {};
cRewCells = {};
cPuffCells = {};

for day = 1:7
    cToneCells{day} = [];
    cGratCells{day} = [];
    cRewCells{day} = [];
    cPuffCells{day} = [];
    for animal = 1:9
        cToneCells{day} = [cToneCells{day} toneCells{animal,day}+cellList(animal)];
        cGratCells{day} = [cGratCells{day} gratCells{animal,day}+cellList(animal)];
        cRewCells{day} = [cRewCells{day} rewCells{animal,day}+cellList(animal)];
        cPuffCells{day} = [cPuffCells{day} puffCells{animal,day}+cellList(animal)];
    end
end
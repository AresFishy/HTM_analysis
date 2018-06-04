function [toneCells, ntoneCells, cToneCells, cnToneCells, cTone1Cells, cTone2Cells, gratCells, ngratCells, cGratCells, cnGratCells, rewCells, nrewCells, cRewCells, cnRewCells,...
    puffCells, npuffCells, cPuffCells, cnPuffCells] = HTM34_respCells(act, toneAct, tone1Act, tone2Act, gratAct, aPuffAct, rewAct)

%Get Stimulus Responsive Cells based on their onset activity.
%Use half of the trials of the selection (The ones not used for calculating onset activity).

days=1:7;
animals=1:9;

%Get tone responsive cells
toneCells = {};
ntoneCells = {};
for day = days
    for animal = animals
        A = [];
        B = [];
        p = [];
        pn = [];
        for cell = 1:size(act{animal,day},1)
            A = squeeze(mean(toneAct{animal,day}(2:2:end,cell,20:25),3));
            B = squeeze(mean(toneAct{animal,day}(2:2:end,cell,1:5),3));
            p(cell) = ttest(A,B,'Alpha',0.025,'Tail','right'); %Find cells with a significant positive response
            pn(cell) = ttest(A,B,'Alpha',0.025,'Tail','left'); %Find cells with a significant negative response
        end
        
        toneCells{animal,day} = find(p == 1);
        ntoneCells{animal,day} = find(pn == 1);
    end
end

tone1Cells = {};
for day = days
    for animal = animals
        A = [];
        B = [];
        p = [];
        for cell = 1:size(act{animal,day},1)
            A = squeeze(mean(tone1Act{animal,day}(2:2:end,cell,20:25),3));
            B = squeeze(mean(tone1Act{animal,day}(2:2:end,cell,1:5),3));
            p(cell) = ttest(A,B,'Alpha',0.025,'Tail','right'); %Find cells with a significant positive response
        end
        
        tone1Cells{animal,day} = find(p == 1);
    end
end
tone2Cells = {};
for day = days
    for animal = animals
        A = [];
        B = [];
        p = [];
        for cell = 1:size(act{animal,day},1)
            A = squeeze(mean(tone2Act{animal,day}(2:2:end,cell,20:25),3));
            B = squeeze(mean(tone2Act{animal,day}(2:2:end,cell,1:5),3));
            p(cell) = ttest(A,B,'Alpha',0.025,'Tail','right'); %Find cells with a significant positive response
        end
        
        tone2Cells{animal,day} = find(p == 1);
    end
end

%Get grating responsive cells
gratCells = {};
ngratCells = {};
for day = days
    for animal = animals
        A = [];
        B = [];
        p = [];
        pn = [];
        for cell = 1:size(act{animal,day},1)
            A = squeeze(mean(gratAct{animal,day}(2:2:end,cell,20:25),3));
            B = squeeze(mean(gratAct{animal,day}(2:2:end,cell,1:5),3));
            p(cell) = ttest(A,B,'Alpha',0.025,'Tail','right'); %Find cells with a significant positive response
            pn(cell) = ttest(A,B,'Alpha',0.025,'Tail','left'); %Find cells with a significant negative response
        end
        
        gratCells{animal,day} = find(p == 1);
        ngratCells{animal,day} = find(pn == 1);
    end
end

%Get active puff responsive cells
puffCells = {};
npuffCells = {};
for day = days
    for animal = animals
        A = [];
        B = [];
        p = [];
        pn = [];
        if ~isempty(aPuffAct{animal,day})
            for cell = 1:size(act{animal,day},1)
                A = squeeze(mean(aPuffAct{animal,day}(2:2:end,cell,20:25),3));
                B = squeeze(mean(aPuffAct{animal,day}(2:2:end,cell,1:5),3));
                p(cell) = ttest(A,B,'Alpha',0.025,'Tail','right'); %Find cells with a significant positive response
                pn(cell) = ttest(A,B,'Alpha',0.025,'Tail','left'); %Find cells with a significant negative response
            end
            puffCells{animal,day} = find(p == 1);
            npuffCells{animal,day} = find(pn == 1);
        else
            puffCells{animal,day} = [];
            npuffCells{animal,day} = [];
        end
    end
end

%Get reward responsive cells
rewCells = {};
nrewCells = {};
for day = days
    for animal = animals
        if length(size(rewAct{animal,day})) > 2
            A = [];
            B = [];
            p = [];
            pn = [];
            for cell = 1:size(act{animal,day},1)
                A = squeeze(mean(rewAct{animal,day}(2:2:end,cell,20:25),3));
                B = squeeze(mean(rewAct{animal,day}(2:2:end,cell,1:5),3));
                p(cell) = ttest(A,B,'Alpha',0.025,'Tail','right'); %Find cells with a significant positive response
                pn(cell) = ttest(A,B,'Alpha',0.025,'Tail','left'); %Find cells with a significant negative response
            end
            rewCells{animal,day} = find(p == 1);
            nrewCells{animal,day} = find(pn == 1);
        else
            rewCells{animal,day} = [];
            nrewCells{animal,day} = [];
        end
    end
end

%Combine cells across animals for a combined list
cellL = [0 289 487 195 300 343 394 373 443];
cellList = cumsum(cellL);
arcCells = 1:1271;
arcAnim = 1:4;
cfosAnim = 5:9;
cfosCells = 1272:3090;
cToneCells = {};
cnToneCells = {};
cTone1Cells = {};
cTone2Cells = {};
cGratCells = {};
cnGratCells = {};
cRewCells = {};
cnRewCells = {};
cPuffCells = {};
cnPuffCells = {};
for day = days
    cToneCells{day} = [];
    cnToneCells{day} = [];
    cTone1Cells{day} = [];
    cTone2Cells{day} = [];
    cGratCells{day} = [];
    cnGratCells{day} = [];
    cRewCells{day} = [];
    cnRewCells{day} = [];
    cPuffCells{day} = [];
    cnPuffCells{day} = [];
    for animal = animals
        cToneCells{day} = [cToneCells{day} toneCells{animal,day}+cellList(animal)];
        cnToneCells{day} = [cnToneCells{day} ntoneCells{animal,day}+cellList(animal)];
        cTone1Cells{day} = [cTone1Cells{day} tone1Cells{animal,day}+cellList(animal)];
        cTone2Cells{day} = [cTone2Cells{day} tone2Cells{animal,day}+cellList(animal)];
        cGratCells{day} = [cGratCells{day} gratCells{animal,day}+cellList(animal)];
        cnGratCells{day} = [cnGratCells{day} ngratCells{animal,day}+cellList(animal)];
        cRewCells{day} = [cRewCells{day} rewCells{animal,day}+cellList(animal)];
        cnRewCells{day} = [cnRewCells{day} nrewCells{animal,day}+cellList(animal)];
        cPuffCells{day} = [cPuffCells{day} puffCells{animal,day}+cellList(animal)];
        cnPuffCells{day} = [cnPuffCells{day} npuffCells{animal,day}+cellList(animal)];
    end
end

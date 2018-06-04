%Get reward/puff responsive cells
rew1Cells = {};
rew2Cells = {};
rewCells = {};
rewCellsNeg = {};
puff1Cells = {};
puff2Cells = {};
puffCells = {};
puffCellsNeg = {};
totCells = [];
cellMat = zeros(8,1735,4);

pstwdw = 185:195;
prewdw = 170:180;
for day = 1:8
    for animal = 1:6
        testRew1 = [];  testRew2 = [];  testRew = [];   testRewN = []; 
        testPuff1 = []; testPuff2 = []; testPuff = [];  testPuffN = [];
        mArew1 = [];    mBrew1 = [];    mArew = [];     mArewN = [];
        mApuff1 = [];   mBpuff1 = [];   mApuff = [];    mApuffN = [];
        mArew2 = [];    mBrew2 = [];    mBrew = [];     mBrewN = [];
        mApuff2 = [];   mBpuff2 = [];   mBpuff = [];    mBpuffN = [];
        
        for cell = 1:size(act{animal,day},1);
            Arew1 = mean(seqAct{animal,day}(cell,rew1G{animal,day}(1:2:end),pstwdw),3); %For reward in seq 1
            Brew1 = mean(seqAct{animal,day}(cell,rew1G{animal,day}(1:2:end),prewdw),3);
            mArew1(cell) = mean(Arew1);
            mBrew1(cell) = mean(Brew1);
            testRew1(cell) = ttest(Arew1,Brew1,'alpha',0.05);
            
            
            Apuff1 = mean(seqAct{animal,day}(cell,puff1G{animal,day}(1:2:end),pstwdw),3); %For puff in seq 1
            Bpuff1 = mean(seqAct{animal,day}(cell,puff1G{animal,day}(1:2:end),prewdw),3);
            mApuff1(cell) = mean(Apuff1);
            mBpuff1(cell) = mean(Bpuff1);
            testPuff1(cell) = ttest(Apuff1,Bpuff1,'alpha',0.05);
            
            Arew2 = mean(seqAct{animal,day}(cell,rew2G{animal,day}(1:2:end),pstwdw),3); %For reward in seq 2
            Brew2 = mean(seqAct{animal,day}(cell,rew2G{animal,day}(1:2:end),prewdw),3);
            mArew2(cell) = mean(Arew2);
            mBrew2(cell) = mean(Brew2);
            testRew2(cell) = ttest(Arew2,Brew2,'alpha',0.05);
            
            
            Apuff2 = mean(seqAct{animal,day}(cell,puff2G{animal,day}(1:2:end),pstwdw),3); %For puff in seq 2
            Bpuff2 = mean(seqAct{animal,day}(cell,puff2G{animal,day}(1:2:end),prewdw),3);
            mApuff2(cell) = mean(Apuff2);
            mBpuff2(cell) = mean(Bpuff2);
            testPuff2(cell) = ttest(Apuff2,Bpuff2,'alpha',0.05);
            
            Arew = mean(seqAct{animal,day}(cell,rew{animal,day}(1:2:end),pstwdw),3); %For all reward 
            Brew = mean(seqAct{animal,day}(cell,rew{animal,day}(1:2:end),prewdw),3);
            mArew(cell) = mean(Arew);
            mBrew(cell) = mean(Brew);
            testRew(cell) = ttest(Arew,Brew,'alpha',0.05);
            
            ArewN = mean(seqAct{animal,day}(cell,rew{animal,day}(1:2:end),pstwdw+5),3); %For all reward 
            BrewN = mean(seqAct{animal,day}(cell,rew{animal,day}(1:2:end),prewdw),3);
            mArewN(cell) = mean(ArewN);
            mBrewN(cell) = mean(BrewN);
            testRewN(cell) = ttest(ArewN,BrewN,'alpha',0.05);
            
            Apuff = mean(seqAct{animal,day}(cell,puff{animal,day}(1:2:end),pstwdw),3); %For all puff
            Bpuff = mean(seqAct{animal,day}(cell,puff{animal,day}(1:2:end),prewdw),3);
            mApuff(cell) = mean(Apuff);
            mBpuff(cell) = mean(Bpuff);
            testPuff(cell) = ttest(Apuff,Bpuff,'alpha',0.05);
            
            ApuffN = mean(seqAct{animal,day}(cell,puff{animal,day}(1:2:end),pstwdw+5),3); %For all puff
            BpuffN = mean(seqAct{animal,day}(cell,puff{animal,day}(1:2:end),prewdw),3);
            mApuffN(cell) = mean(ApuffN);
            mBpuffN(cell) = mean(BpuffN);
            testPuffN(cell) = ttest(ApuffN,BpuffN,'alpha',0.05);
            
        end
        rew1Cells{animal,day} = find(testRew1 == 1 & (mArew1-mBrew1) > 0.05);
        puff1Cells{animal,day} = find(testPuff1 == 1 & (mApuff1-mBpuff1) > 0.05);
        rew2Cells{animal,day} = find(testRew2 == 1 & (mArew2-mBrew2) > 0.05);
        puff2Cells{animal,day} = find(testPuff2 == 1 & (mApuff2-mBpuff2) > 0.05);
        rewCells{animal,day} = find(testRew == 1 & (mArew-mBrew) > 0.05);
        rewCellsNeg{animal,day} = find(testRewN == 1 & (mArewN-mBrewN) < -0.05);
        puffCells{animal,day} = find(testPuff == 1 & (mApuff-mBpuff) > 0.05);
        puffCellsNeg{animal,day} = find(testPuffN == 1 & (mApuffN-mBpuffN) < -0.05);

    end
    cellVector = [0, 361, 135, 387, 249, 324]; %Number of cells per animal
    rew1CellsComb{day} = [];
    rew2CellsComb{day} = [];
    rewCellsComb{day} = [];
    rewCellsNComb{day} = [];
    puff1CellsComb{day} = [];
    puff2CellsComb{day} = [];
    puffCellsComb{day} = [];
    puffCellsNComb{day} = [];
    for animal = 1:6;
        rew1CellsComb{day} = [rew1CellsComb{day}, rew1Cells{animal,day}+sum(cellVector(1:animal))];
        rew2CellsComb{day} = [rew2CellsComb{day}, rew2Cells{animal,day}+sum(cellVector(1:animal))];
        rewCellsComb{day} = [rewCellsComb{day}, rewCells{animal,day}+sum(cellVector(1:animal))];
        rewCellsNComb{day} = [rewCellsNComb{day}, rewCellsNeg{animal,day}+sum(cellVector(1:animal))];
        puff1CellsComb{day} = [puff1CellsComb{day}, puff1Cells{animal,day}+sum(cellVector(1:animal))];
        puff2CellsComb{day} = [puff2CellsComb{day}, puff2Cells{animal,day}+sum(cellVector(1:animal))];
        puffCellsComb{day} = [puffCellsComb{day}, puffCells{animal,day}+sum(cellVector(1:animal))];
        puffCellsNComb{day} = [puffCellsNComb{day}, puffCellsNeg{animal,day}+sum(cellVector(1:animal))];
    end
    for cell = 1:1735
        if ismember(cell,rew1CellsComb{day}); %Order in matrix is Reward1, Reward2, Puff1, Puff2
            cellMat(day,cell,1) = 1;
        end
        if ismember(cell,rew2CellsComb{day});
            cellMat(day,cell,2) = 1;
        end
        if ismember(cell,puff1CellsComb{day});
            cellMat(day,cell,3) = 1;
        end
        if ismember(cell,puff2CellsComb{day});
            cellMat(day,cell,4) = 1;
        end
    end
    combCells{day} = unique([rew1CellsComb{day} rew2CellsComb{day} puff1CellsComb{day} puff2CellsComb{day}]);
end


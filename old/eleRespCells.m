%Selective Cells - HTM Project
%AVP 2016

%Based on the onsets selected in 'onsetActivity.m'
selCells = {};
selCellsComb = {};
on = 15; %Frame of element onset
element = [g11 t11 g12 t12 t11g12 g21 g22 t21 t22 t21g22 om];
for ele = 1:length(element)+6; %Individual elements + 6 combinations
    for day = 1:8
        for animal = 1:6
            tmpSel = [];
            B = [];
            A = [];
            if ~isempty(onsetAct{animal,day,ele})
                for cell = 1:size(onsetAct{animal,day,ele},1)
                    B(cell,:) = nanmean(onsetAct{animal,day,ele}(cell,:,on-10:on-1),3);
                    A(cell,:) = nanmean(onsetAct{animal,day,ele}(cell,:,on+5:on+15),3);
                    tmpSel(cell) = ttest(A(cell,:),B(cell,:));
                end
                selCells{animal,day,ele} = find(tmpSel == 1 & (mean(A,2)>mean(B,2))');
                selCellsNo(animal,day,ele) = length(selCells{animal,day,ele});                              
            else
                selCells{animal,day,ele} = [];
                selCellsNo(animal,day,ele) = 0;
            end
        end
        cellVector = [0, 361, 135, 387, 249, 324]; %Number of cells per animal
        selCellsComb{day,ele} = [];
        for animal = 1:6;
            selCellsComb{day,ele} = [selCellsComb{day,ele}, selCells{animal,day,ele}+sum(cellVector(1:animal))];
        end
        selCellsCombNo(day,ele) = length(selCellsComb{day,ele});
    end
    
end


%Count responses
selCellsCount = {};
selCellsCountComb = {};
respCount = {};
on = 15; %Frame of element onset
element = [g11 t11 g12 t12 t11g12 g21 g22 t21 t22 t21g22 om];
for ele = 1:10; %length(element)+6; %Individual elements + 6 combinations
    for day = 1:8
        for animal = 1:6
            tmpSel = [];
            B = [];
            A = [];
            if ~isempty(onsetAct{animal,day,ele})
                for cell = 1:size(onsetAct{animal,day,ele},1)
                    B(cell,:) = nanmean(onsetAct{animal,day,ele}(cell,:,on-10:on-1),3);
                    A(cell,:) = nanmean(onsetAct{animal,day,ele}(cell,:,on+5:on+15),3);
                    A(A < 0) = 0;
                    B(B < 0) = 0;
                    tmpSel(cell,:) = (A(cell,:)-B(cell,:))./(A(cell,:)+B(cell,:));
                    respCount{animal,day,ele}(cell) = length(find(tmpSel(cell,:) > 0.3 & A(cell,:) > 0.15));
                end
                
                selCellsCount{animal,day,ele} = find(respCount{animal,day,ele} > size(onsetAct{animal,day,ele},2)/10);
                selCellsCountNo(animal,day,ele) = length(selCells{animal,day,ele});                              
            else
                selCellsCount{animal,day,ele} = [];
                selCellsCountNo(animal,day,ele) = 0;
            end
        end
        cellVector = [0, 361, 135, 387, 249, 324]; %Number of cells per animal
        selCellsCountComb{day,ele} = [];
        for animal = 1:6;
            selCellsCountComb{day,ele} = [selCellsCountComb{day,ele}, selCellsCount{animal,day,ele}+sum(cellVector(1:animal))];
        end
        selCellsCountCombNo(day,ele) = length(selCellsCountComb{day,ele});
    end   
end
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
                    B(cell,:) = nanmean(onsetAct{animal,day,ele}(cell,:,on-10:on-5),3);
                    A(cell,:) = nanmean(onsetAct{animal,day,ele}(cell,:,on+5:on+10),3);
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

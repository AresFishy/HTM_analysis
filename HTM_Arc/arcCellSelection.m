%Arc Cells Selection

downArc = {}; %Decrease in Arc
upArc = {}; %Increase in Arc
highArc = {}; %High expression level of Arc
lowArc = {}; %Low expression level of Arc

for day = 1:7
    %Trick to avoid the NaN's in the sorting
    for animal = 1:4
        if ~isempty(act{animal,day})
            tmp = find(~isnan(mArcDiff{animal,day}));
            [~,tmp_sort] = sort(mArcDiff{animal,day}(tmp));
            
            downArc{animal,day} = tmp(tmp_sort(1:30));
            upArc{animal,day} = tmp(tmp_sort(end-29:end));
            flatArc{animal,day} = find(mArcDiff{animal,day} < 0.25 & mArcDiff{animal,day} > -0.25);
            
            tmp = find(~isnan(mArcAct{animal,day}));
            [~,tmp_sort] = sort(mArcAct{animal,day}(tmp));
            
            lowArc{animal,day} = tmp(tmp_sort(1:round(length(tmp))/3)); %30% lowests Arc expression cells
            highArc{animal,day} = tmp(tmp_sort(end-round(length(tmp))/3:end)); %30% highest Arc expression cells
        end
    end
end


%Combine cells across animals cells
cellList = [0 289 289+487 289+487+195];
cDownArc = {};
cUpArc = {};
cLowArc = {};
cHighArc = {};

for day = 1:7
    cDownArc{day} = [];
    cUpArc{day} = [];
    cLowArc{day} = [];
    cHighArc{day} = [];
    
    for animal = 1:4
        cDownArc{day} = [cDownArc{day}; downArc{animal,day}+cellList(animal)];
        cUpArc{day} = [cUpArc{day}; upArc{animal,day}+cellList(animal)];
        cLowArc{day} = [cLowArc{day}; lowArc{animal,day}+cellList(animal)];
        cHighArc{day} = [cHighArc{day}; highArc{animal,day}+cellList(animal)];
    end
end

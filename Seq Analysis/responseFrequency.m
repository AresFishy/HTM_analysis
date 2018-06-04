%Response frequency

for day = 1:8
    for animal = 1:6
        for ele = 1:10
            if ~isempty(onsetAct{animal,day,ele})
                for cell = 1:size(onsetAct{animal,day,ele},1)
                    respFreq{animal,day,ele}(cell,:) = length(find(nanmean(onsetAct{animal,day,ele}(cell,:,20:30),3) > 0.2));
                end
            else
                respFreq{animal,day,ele} = NaN(size(onsetAct{animal,2,ele},1),1);
            end
            respFreqCells{animal,day,ele} = find(respFreq{animal,day,ele} >= 5);
        end
    end
    for ele = 1:10
        respFreqComb{day,ele} = vertcat(respFreq{:,day,ele});
        respFreqCombCells{day,ele} = find(respFreqComb{day,ele} >= 5);
    end
end
earlyOnsetAct = {};
lateOnsetAct = {};
third1 = [];
third3 = [];
for day = 1:8
    for animal = 1:6
        for ele = 1:10
            if ~isempty(act{animal,day});
                third1 = 1:round(size(onsetAct{animal,day,ele},2)/3);
                third3 = third1(end)*2:round(size(onsetAct{animal,day,ele},2));
                
                earlyOnsetAct{animal,day,ele} = squeeze(nanmean(onsetAct{animal,day,ele}(:,third1,:),2));
                lateOnsetAct{animal,day,ele} = squeeze(nanmean(onsetAct{animal,day,ele}(:,third3,:),2));
                
                earlyOnsetActMean{animal,day,ele} = squeeze(nanmean(earlyOnsetAct{animal,day,ele}(selCells{animal,day,ele},:,:),1));
                lateOnsetActMean{animal,day,ele} = squeeze(nanmean(lateOnsetAct{animal,day,ele}(selCells{animal,day,ele},:,:),1));
            end
        end
    end
end

for day = 1:8
    for ele = 1:10
        earlyOnsetActMeanComb{day,ele} = nanmean(vertcat(earlyOnsetActMean{:,day,ele}),1);
        lateOnsetActMeanComb{day,ele} = nanmean(vertcat(lateOnsetActMean{:,day,ele}),1);
    end
end

for ele = 1:10
    subplot(5,2,ele)
    str = sprintf('Element %d', ele)
    plot(earlyOnsetActMeanComb{1,ele}); hold on;  
    plot(lateOnsetActMeanComb{1,ele}); 
    line([15 15],[-0.005 0.05]); refline([0 0])
    ylim([-0.005 0.05])
    ylabel('dF/F')
    xlabel('Frame #')
    title(str)
end
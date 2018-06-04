%Spike activity
thresAct = {};
spikesAct = {};
for day = 1:8    
    for animal = 1:6
        for cell = 1:size(act{animal,day},1)
           smDifAct = smooth(abs(diff(smooth(act{animal,day}(cell,:),3))),3);
           tmpSort = sort(smDifAct);
           stdLowAct = std(tmpSort(1:round(length(tmpSort)/2))); %std of lower 50% of activity
           thresAct{animal,day}(cell,:) = smDifAct > 50*stdLowAct;
           spikesAct{animal}(day,cell) = length(find(diff(thresAct{animal,day}(cell,:)) == 1)) / (length(act{animal,day})/10);
        end
    end
end

cellActHigh = [];
cellActMed = [];
cellActLow = [];
cnt = 0;
for animal = [1,3,4,5]
    cnt = cnt + 1;
    [~,cellSort{animal}] = sort(spikesAct{animal}(1,:));
    cellActHigh(cnt,:) = mean(spikesAct{animal}(:,cellSort{animal}(round(length(cellSort{animal})-length(cellSort{animal})/10):end)),2);
    cellActMed(cnt,:) = mean(spikesAct{animal}(:,cellSort{animal}(round(length(cellSort{animal})-3*length(cellSort{animal})/5):round(length(cellSort{animal})-2*length(cellSort{animal})/5))),2);
    cellActLow(cnt,:) = mean(spikesAct{animal}(:,cellSort{animal}(1:round(length(cellSort{animal})/10))),2);
end

figure;
plotSEM(cellActHigh')
hold on
plotSEM(cellActMed')
plotSEM(cellActLow')
ylabel('Calcium Spikes per second')
xlabel('Day')
legend('Top 10%','Middle 20%', 'Bottom 10%')
legend('Bottom 10%','Top 10 %','Middle 20%')
title('Selected on Day 1')
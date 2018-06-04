%Plot the mean activity for each animal across days
%Needs binData.m

meanAct = {};

for day = 1:8
    for animal = 1:6
        meanAct{animal,day} = nanmean(seqActBinMean{animal,day},2);
    end
end

for animal = 1:6
    meanActAni{animal,1} = horzcat(meanAct{animal,:});
end

figure;
for animal = 1:6
    plotSEM(meanActAni{animal}');
    hold on 
end
plotSEM(vertcat(meanActAni{:})','--k')
xlabel('Day')
ylabel('dF/F')
legend('Averge','Mice')
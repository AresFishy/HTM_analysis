%Plot the mean activity for each animal across days
%Needs alignSeqAct.m

meanAct = {};

for day = 1:8
    for animal = 1:6
        meanAct{animal,day} = nanmean(seqActMean2{animal,day},2);
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

%%
%Plot mean act for each day

figure;
for day = 1:8
    plot(nanmean(seqActComb1{day}));
    hold on
end
ylim([1 1.04 ])
line([10 10],get(gca,'ylim'),'color','k')
line([40 40],get(gca,'ylim'),'color','k')
line([70 70],get(gca,'ylim'),'color','k')
line([100 100],get(gca,'ylim'),'color','k')
line([130 130],get(gca,'ylim'),'color','k')
line([150 150],get(gca,'ylim'),'color','b')
line([180 180],get(gca,'ylim'),'color','r')
title('Mean Act per day  - Seq1')

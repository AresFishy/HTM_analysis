%Plot sequence activity for overview

animal = 1;
day = 1;

for cell = 1:size(seqAct1{animal,1,1},1)
    clf
    str = sprintf('Cell %d',cell); 
    subplot(3,4,1:4)
    plotSEM(squeeze(seqAct1{animal,day}(cell,:,:))')
    line([10 10],get(gca,'ylim'),'color','k')
    line([40 40],get(gca,'ylim'),'color','k')
    line([70 70],get(gca,'ylim'),'color','k')
    line([100 100],get(gca,'ylim'),'color','k')
    line([130 130],get(gca,'ylim'),'color','k')
    line([150 150],get(gca,'ylim'),'color','b')
    line([180 180],get(gca,'ylim'),'color','r')
    title(str)
    
    subplot(3,4,5:8)
    plot(squeeze(seqAct1{animal,day}(cell,:,:))')
    line([10 10],get(gca,'ylim'),'color','k')
    line([40 40],get(gca,'ylim'),'color','k')
    line([70 70],get(gca,'ylim'),'color','k')
    line([100 100],get(gca,'ylim'),'color','k')
    line([130 130],get(gca,'ylim'),'color','k')
    line([150 150],get(gca,'ylim'),'color','b')
    line([180 180],get(gca,'ylim'),'color','r')
    
    subplot(3,4,5:8)
    plot(squeeze(seqAct1{animal,day}(cell,:,:))')
    line([10 10],get(gca,'ylim'),'color','k')
    line([40 40],get(gca,'ylim'),'color','k')
    line([70 70],get(gca,'ylim'),'color','k')
    line([100 100],get(gca,'ylim'),'color','k')
    line([130 130],get(gca,'ylim'),'color','k')
    line([150 150],get(gca,'ylim'),'color','b')
    line([180 180],get(gca,'ylim'),'color','r')
    
    subplot(3,4,9:10)
    plotSEM(squeeze(seqAct1{animal,day}(cell,rew1{animal,day},:))'); hold on
    plotSEM(squeeze(seqAct1{animal,day}(cell,puff1{animal,day},:))');
    line([180 180],get(gca,'ylim'),'color','k')
    
    subplot(3,4,11:12)
    plotSEM(squeeze(seqAct2{animal,day}(cell,rew2{animal,day},:))'); hold on
    plotSEM(squeeze(seqAct2{animal,day}(cell,puff2{animal,day},:))');
    line([180 180],get(gca,'ylim'),'color','k')
    
    pause
end

%%
for day = 1:8
    plotSEM(seqActComb{day}')
end
ylim([1 1.05])
ylabel('dF/F')
xlabel('Frame #')
title('Population Sequence aligned activity')
legend({'Day1','Day2','Day3','Day4','Day5','Day6','Day7','Day8'})

figure;
for day = 1:8
    plotSEM(OnsetActComb{day}')
end
refline([0 0])
ylim([-0.005 0.02])
xlim([1 31])
ylabel('dF/F')
xlabel('Frame #')
title('Population End Onset activity')
legend({'Day1','Day2','Day3','Day4','Day5','Day6','Day7','Day8'})

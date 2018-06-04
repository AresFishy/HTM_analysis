maxToneTC = [];
for day = 1:7
    for animal = 1:9
        maxToneTC(animal,day) = mean(mean(tone_respMeanHalf{animal}(toneCells{animal,day},55:70,day),2) - mean(tone_respMeanHalf{animal}(toneCells{animal,day},41:49,day),2));
        maxPuffTC(animal,day) = mean(mean(puff_respMeanHalf{animal}(toneCells{animal,day},55:70,day),2) - mean(puff_respMeanHalf{animal}(toneCells{animal,day},41:49,day),2));
        maxRewTC(animal,day) = mean(mean(rew_respMeanHalf{animal}(toneCells{animal,day},55:70,day),2) - mean(rew_respMeanHalf{animal}(toneCells{animal,day},41:49,day),2));
        
        maxTonePC(animal,day) = mean(mean(tone_respMeanHalf{animal}(puffCells{animal,day},55:70,day),2) - mean(tone_respMeanHalf{animal}(puffCells{animal,day},41:49,day),2));
        maxPuffPC(animal,day) = mean(mean(puff_respMeanHalf{animal}(puffCells{animal,day},55:70,day),2) - mean(puff_respMeanHalf{animal}(puffCells{animal,day},41:49,day),2));
        maxRewPC(animal,day) = mean(mean(rew_respMeanHalf{animal}(puffCells{animal,day},55:70,day),2) - mean(rew_respMeanHalf{animal}(puffCells{animal,day},41:49,day),2));
        
        maxToneRC(animal,day) = mean(mean(tone_respMeanHalf{animal}(rewCells{animal,day},55:70,day),2) - mean(tone_respMeanHalf{animal}(rewCells{animal,day},41:49,day),2));
        maxPuffRC(animal,day) = mean(mean(puff_respMeanHalf{animal}(rewCells{animal,day},55:70,day),2) - mean(puff_respMeanHalf{animal}(rewCells{animal,day},41:49,day),2));
        maxRewRC(animal,day) = mean(mean(rew_respMeanHalf{animal}(rewCells{animal,day},55:70,day),2) - mean(rew_respMeanHalf{animal}(rewCells{animal,day},41:49,day),2));
    end
end

normTE = max([mean(nanmean(maxToneTC(:,2:3))),mean(nanmean(maxPuffTC(:,2:3))),mean(nanmean(maxRewTC(:,2:3)))]);
normPE = max([mean(nanmean(maxTonePC(:,2:3))),mean(nanmean(maxPuffPC(:,2:3))),mean(nanmean(maxRewPC(:,2:3)))]);
normRE = max([mean(nanmean(maxToneRC(:,2:3))),mean(nanmean(maxPuffRC(:,2:3))),mean(nanmean(maxRewRC(:,2:3)))]);

figure;
subplot(121)
imagesc([mean(nanmean(maxToneTC(:,2:3)))/normTE,mean(nanmean(maxPuffTC(:,2:3)))/normTE,mean(nanmean(maxRewTC(:,2:3)))/normTE;...
    mean(nanmean(maxTonePC(:,2:3)))/normPE,mean(nanmean(maxPuffPC(:,2:3)))/normPE,mean(nanmean(maxRewPC(:,2:3))/normPE);...
    mean(nanmean(maxToneRC(:,2:3)))/normRE,mean(nanmean(maxPuffRC(:,2:3)))/normRE,mean(nanmean(maxRewRC(:,2:3)))/normRE]);
set(gca,'XTick',[1 2 3],'XTickLabel',{'Tone Stim','Puff Stim','Rew Stim'});
set(gca,'YTick',[1 2 3],'YTickLabel',{'Tone Cells','Puff Cells','Rew Cells'})
set(gca,'clim',[0 1])
title('Early')
colormap jet;
subplot(122)
imagesc([mean(nanmean(maxToneTC(:,6:7)))/normTE,mean(nanmean(maxPuffTC(:,6:7)))/normTE,mean(nanmean(maxRewTC(:,6:7)))/normTE;...
    mean(nanmean(maxTonePC(:,6:7)))/normPE,mean(nanmean(maxPuffPC(:,6:7)))/normPE,mean(nanmean(maxRewPC(:,6:7)))/normPE;...
    mean(nanmean(maxToneRC(:,6:7)))/normRE,mean(nanmean(maxPuffRC(:,6:7)))/normRE,mean(nanmean(maxRewRC(:,6:7)))/normRE]);
set(gca,'XTick',[1 2 3],'XTickLabel',{'Tone Stim','Puff Stim','Rew Stim'});
set(gca,'YTick',[1 2 3],'YTickLabel',{'Tone Cells','Puff Cells','Rew Cells'})
set(gca,'clim',[0 1])
% figure;
% 
% plot_sem((maxToneTC)','m',0.3);
% plot_sem((maxTonePC)','k',0.3);
% plot_sem((maxToneRC)','g',0.3);
% 
% line(xlim,[0 0],'Color','k','linestyle','--')
% legend('','Tone Cells','','Puff Cells','','Reward Cells')
% title('Tone Response size - (Puff + Reward)')
% ylabel('dF/F'); xlabel('Day')



title('Late')
colormap jet;
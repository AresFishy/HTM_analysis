tps_exp=1:7;
meanTone = {};
for day = 1:7
    for animal = 1:9
        meanTone{animal,day} = mean(tone_respMean{animal}(:,55:70,day),2)-mean(tone_respMean{animal}(:,41:50,day),2);
        toneIegCorr(animal,day) = corr(meanTone{animal,day},nanmean(IEG_exp{animal}(:,:,tp),2),'type','spearman');
    end
end

figure;
subplot(121)
bar(1,mean2(toneIegCorr(1:4,2:3)),'FaceColor','w','EdgeColor','b'); hold on
bar(2,mean2(toneIegCorr(1:4,6:7)),'FaceColor','w','EdgeColor','b','LineStyle','--');
bar(3,mean2(toneIegCorr(5:9,2:3)),'FaceColor','w','EdgeColor','r'); 
bar(4,mean2(toneIegCorr(5:9,6:7)),'FaceColor','w','EdgeColor','r','LineStyle','--');

errorbar(1,mean2(toneIegCorr(1:4,2:3)),std2(toneIegCorr(1:4,2:3))/sqrt(8),'k'); hold on
errorbar(2,mean2(toneIegCorr(1:4,6:7)),std2(toneIegCorr(1:4,6:7))/sqrt(8),'k');
errorbar(3,mean2(toneIegCorr(5:9,2:3)),std2(toneIegCorr(5:9,2:3))/sqrt(10),'k'); 
errorbar(4,mean2(toneIegCorr(5:9,6:7)),std2(toneIegCorr(5:9,6:7))/sqrt(10),'k');
ylim([-0.05 0.25]); xlim([0 5])
title('Tone Response IEG Level Correlation - Spearman'); ylabel('Correlation coeffecient');
legend('Arc Early','Arc Late','cFos Early','cFos Late')

arcToneE = toneIegCorr(1:4,2:3);
arcToneL = toneIegCorr(1:4,6:7);
cfosToneE = toneIegCorr(5:9,2:3);
cfosToneL = toneIegCorr(5:9,6:7);

ranksum(arcToneE(:),arcToneL(:))
ranksum(cfosToneE(:),cfosToneL(:))

%Linear model fit of arc
mdlArc = fitlm([1:7,1:7,1:7,1:7],[toneIegCorr(1,:),toneIegCorr(2,:),toneIegCorr(3,:),toneIegCorr(4,:)])
fvalArc = sprintf('Arc LM Fit F-val %d',mdlArc.Coefficients{2,4});
%Linear model fit of c-fos
mdlCfos = fitlm([1:7,1:7,1:7,1:7,1:7],[toneIegCorr(5,:),toneIegCorr(6,:),toneIegCorr(7,:),toneIegCorr(8,:),toneIegCorr(9,:)])
fvalCfos = sprintf('c-Fos LM Fit F-val %d',mdlCfos.Coefficients{2,4});


subplot(122)
plot_sem(toneIegCorr(1:4,:)','b',0.3)
plot_sem(toneIegCorr(5:9,:)','r',0.3)
plot(toneIegCorr(1:4,:)','k')
plot(toneIegCorr(5:9,:)','c')
plot(mdlCfos.Coefficients{1,1}+mdlCfos.Coefficients{2,1}*[1:7],'--r')
plot(mdlArc.Coefficients{1,1}+mdlArc.Coefficients{2,1}*[1:7],'--b')
line(xlim,[0 0],'color','k','linestyle','--')
legend('',fvalArc,'',fvalCfos,'','arc')
ylabel('Correlation Coefficient');
xlabel('Day')
xlim([1 7])
ylim([-0.2 0.45])


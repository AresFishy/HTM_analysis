meanRew = {};
for day = 1:7
    for animal = 1:9
        meanRew{animal,day} = mean(rew_respMean{animal}(:,55:70,day),2)-mean(rew_respMean{animal}(:,41:50,day),2);
        rewIegCorr(animal,day) = corr(meanRew{animal,day},ieg_exp_cell{animal,day});
    end
end

figure;
subplot(121)
bar(1,mean2(rewIegCorr(1:4,2:3)),'FaceColor','w','EdgeColor','b'); hold on
bar(2,mean2(rewIegCorr(1:4,6:7)),'FaceColor','w','EdgeColor','b','LineStyle','--');
bar(3,mean2(rewIegCorr(5:9,2:3)),'FaceColor','w','EdgeColor','r'); 
bar(4,mean2(rewIegCorr(5:9,6:7)),'FaceColor','w','EdgeColor','r','LineStyle','--');

errorbar(1,mean2(rewIegCorr(1:4,2:3)),std2(rewIegCorr(1:4,2:3))/sqrt(8),'k'); hold on
errorbar(2,mean2(rewIegCorr(1:4,6:7)),std2(rewIegCorr(1:4,6:7))/sqrt(8),'k');
errorbar(3,mean2(rewIegCorr(5:9,2:3)),std2(rewIegCorr(5:9,2:3))/sqrt(10),'k'); 
errorbar(4,mean2(rewIegCorr(5:9,6:7)),std2(rewIegCorr(5:9,6:7))/sqrt(10),'k');
ylim([-0.05 0.20]); xlim([0 5])
title('Rew Response IEG Level Correlation'); ylabel('Correlation coefficient');
legend('Arc Early','Arc Late','cFos Early','cFos Late')
earlyTone = {};
earlyPuff = {};
earlyRew = {};
lateTone = {};


for animal = 1:9
    earlyTone{animal} = mean([mean(tone_respMean{animal}(:,55:70,2),2)-mean(tone_respMean{animal}(:,45:50,3),2), mean(tone_respMean{animal}(:,55:70,3),2)-mean(tone_respMean{animal}(:,45:50,3),2)],2);
    earlyPuff{animal} = mean([mean(puff_respMean{animal}(:,55:70,2),2)-mean(puff_respMean{animal}(:,45:50,3),2), mean(puff_respMean{animal}(:,55:70,3),2)-mean(puff_respMean{animal}(:,45:50,3),2)],2);
    earlyRew{animal} = mean([mean(rew_respMean{animal}(:,55:70,2),2)-mean(rew_respMean{animal}(:,45:50,3),2), mean(rew_respMean{animal}(:,55:70,3),2)-mean(rew_respMean{animal}(:,45:50,3),2)],2);
    lateTone{animal} = mean([mean(tone_respMean{animal}(:,55:70,6),2)-mean(tone_respMean{animal}(:,45:50,7),2), mean(tone_respMean{animal}(:,55:70,7),2)-mean(tone_respMean{animal}(:,45:50,7),2)],2);
    
end

%%

for animal = 1:9
    eTlT(animal) = corr(earlyTone{animal},lateTone{animal});
    ePlT(animal) = corr(earlyPuff{animal},lateTone{animal});
    eRlT(animal) = corr(earlyRew{animal},lateTone{animal});
end

signrank(eTlT)
signrank(ePlT)
signrank(eRlT)

for animal = 1:9
    subplot(221)
    plot(earlyTone{animal},lateTone{animal},'.m'); hold on
    ylim([-0.1 0.1]); xlim([-0.1 0.1]);
    xlabel('Early Tone Response'); ylabel('Late Tone Response');
    line(xlim,[0 0],'Color','k','LineStyle','--'); line([0 0],ylim,'Color','k','LineStyle','--');
    subplot(222)
    plot(earlyPuff{animal},lateTone{animal},'.k'); hold on
    ylim([-0.1 0.1]); xlim([-0.1 0.1])
    xlabel('Early Puff Response'); ylabel('Late Tone Response');
    line(xlim,[0 0],'Color','k','LineStyle','--'); line([0 0],ylim,'Color','k','LineStyle','--');
    subplot(223)
    plot(earlyRew{animal},lateTone{animal},'.g'); hold on
    ylim([-0.1 0.1]); xlim([-0.1 0.1])
    xlabel('Early Reward Response'); ylabel('Late Tone Response');
    line(xlim,[0 0],'Color','k','LineStyle','--'); line([0 0],ylim,'Color','k','LineStyle','--');
end
subplot(224)
bar(1,mean(eTlT),'FaceColor','m'); hold on
bar(2,mean(ePlT),'FaceColor','k');
bar(3,mean(eRlT),'FaceColor','g');

errorbar(1,mean(eTlT),std(eTlT)/sqrt(9),'Color','k');
errorbar(2,mean(ePlT),std(ePlT)/sqrt(9),'Color','k');
errorbar(3,mean(eRlT),std(eRlT)/sqrt(9),'Color','k');
ylabel('Correlation');
title('Correlation with Late Tone response');
legend('early Tone','early Puff','early Reward')
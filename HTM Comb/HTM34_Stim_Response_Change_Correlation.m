meanTone = {};
meanPuff = {};
meanRew = {};
tonePuffCor = [];
toneRewCor = [];
puffRewCor = [];
for day = 1:7
    for animal = 1:9
        meanTone{animal,day} = mean(tone_respMean{animal}(:,55:70,day),2)-mean(tone_respMean{animal}(:,40:49,day),2);
        meanPuff{animal,day} = mean(puff_respMean{animal}(:,55:70,day),2)-mean(puff_respMean{animal}(:,40:49,day),2);
        meanRew{animal,day} = mean(rew_respMean{animal}(:,55:70,day),2)-mean(rew_respMean{animal}(:,40:49,day),2);
        
    end
end

for animal = 1:9
    diffTone{animal} = diff(horzcat(meanTone{animal,:}),[],2);
    diffPuff{animal} = diff(horzcat(meanPuff{animal,:}),[],2);
    diffRew{animal} = diff(horzcat(meanRew{animal,:}),[],2);
    for day = 1:6
        tonePuffCor(animal,day) = corr(diffTone{animal}(:,day),diffPuff{animal}(:,day),'type','spearman');
        toneRewCor(animal,day) = corr(diffTone{animal}(:,day),diffRew{animal}(:,day),'type','spearman');
        puffRewCor(animal,day) = corr(diffPuff{animal}(:,day),diffRew{animal}(:,day),'type','spearman');
    end
%     diffTone{animal} = mean(horzcat(meanTone{animal,6:7}),2)-mean(horzcat(meanTone{animal,2:3}),2);
%     diffPuff{animal} = mean(horzcat(meanPuff{animal,6:7}),2)-mean(horzcat(meanPuff{animal,2:3}),2);
%     diffRew{animal} = mean(horzcat(meanRew{animal,6:7}),2)-mean(horzcat(meanRew{animal,2:3}),2);
%     for day = 1:6
%         tonePuffCor(animal) = corr(diffTone{animal},diffPuff{animal},'type','spearman');
%         toneRewCor(animal) = corr(diffTone{animal},diffRew{animal},'type','spearman');
%         puffRewCor(animal) = corr(diffPuff{animal},diffRew{animal},'type','spearman');
%     end
end

%%
figure;
subplot(121)
bar(1,nanmean(tonePuffCor(:)),'FaceColor','w','EdgeColor','k'); hold on
bar(2,nanmean(toneRewCor(:)),'FaceColor','w','EdgeColor','k','LineStyle',':');
bar(3,nanmean(puffRewCor(:)),'FaceColor','w','EdgeColor','k','LineStyle','-.');
errorbar(1,nanmean(tonePuffCor(:)),nanSEM(tonePuffCor(:)),'Color','k');
errorbar(2,nanmean(toneRewCor(:)),nanSEM(toneRewCor(:)),'Color','k');
errorbar(3,nanmean(puffRewCor(:)),nanSEM(puffRewCor(:)),'Color','k');
ylim([-0.25 0.2])
ylabel('Correlation Coefficient')
legend('Tone-Puff Change','Tone-Reward Change','Puff-Reward Change')
title('Correlation between change in Tone vs Puff vs Reward response')

signrank(tonePuffCor(:))
signrank(toneRewCor(:))
signrank(puffRewCor(:))

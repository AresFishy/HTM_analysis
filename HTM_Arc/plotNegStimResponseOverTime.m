%Plot stimuli responses over time

%Population response and selected negative cells responses

%Reward response
subplot(421)
for day = 1:7
    plot(nanmean(cRewAct{day})); hold on
end
axis tight;
title('Population Rew Act')
subplot(422)
for day = 1:7
    plot(nanmean(cRewAct{day}(cnRewCells{day},:))); hold on
end
axis tight;
title('nCell Rew Act')

%Puff response
subplot(423)
for day = 1:7
    plot(nanmean(caPuffAct{day})); hold on
end
axis tight;
title('Population Puff Act')

subplot(424)
for day = 1:7
    plot(nanmean(caPuffAct{day}(cnPuffCells{day},:))); hold on
end
axis tight;
title('nCell Puff Act')

%Tone response
subplot(425)
for day = 1:7
    plot(nanmean(cToneAct{day})); hold on
end
axis tight;
title('Population Tone Act')

subplot(426)
for day = 1:7
    plot(nanmean(cToneAct{day}(cnToneCells{day},:))); hold on
end
axis tight;
title('nCell Tone Act')

%Grating response
subplot(427)
for day = 1:7
    plot(nanmean(cGratAct{day})); hold on
end
axis tight;
title('Population Grating Act')

subplot(428)
for day = 1:7
    plot(nanmean(cGratAct{day}(cnGratCells{day},:))); hold on
end
axis tight;
title('nCell Grating Act')
%Plot stimuli responses over time

%Population response and selected cells responses

%Reward response
subplot(421)
for day = 1:7
    plot(nanmean(cRewAct{day})); hold on
end
axis tight;
title('Population Rew Act')
subplot(422)
for day = 1:7
    plot(nanmean(cRewAct{day}(cRewCells{day},:))); hold on
end
axis tight;
title('Cell Rew Act')

%Puff response
subplot(423)
for day = 1:7
    plot(nanmean(caPuffAct{day})); hold on
end
axis tight;
title('Population Puff Act')

subplot(424)
for day = 1:7
    plot(nanmean(caPuffAct{day}(cPuffCells{day},:))); hold on
end
axis tight;
title('Cell Puff Act')

%Tone response
subplot(425)
for day = 1:7
    plot(nanmean(cToneAct{day})); hold on
end
axis tight;
title('Population Tone Act')

subplot(426)
for day = 1:7
    plot(nanmean(cToneAct{day}(cToneCells{day},:))); hold on
end
axis tight;
title('Cell Tone Act')

%Grating response
subplot(427)
for day = 1:7
    plot(nanmean(cGratAct{day})); hold on
end
axis tight;
title('Population Grating Act')

subplot(428)
for day = 1:7
    plot(nanmean(cGratAct{day}(cGratCells{day},:))); hold on
end
axis tight;
title('Cell Grating Act')
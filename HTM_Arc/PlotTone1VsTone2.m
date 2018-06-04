%For tone cells

subplot(221)
for day = 1:7
    plot(nanmean(cTone1Act{day}(cTone1Cells{day},:))','color',[day/10 day/10 day/10]); hold on
    plot(nanmean(cTone1Act{day}(cTone2Cells{day},:))','color',[day/10 0 0]);
end
axis tight;
ylim([-0.01 0.04])

subplot(222)
for day = 1:7
    plot(day,mean(nanmean(cTone1Act{day}(cTone1Cells{day},15:25)))','xk'); hold on
    plot(day,mean(nanmean(cTone1Act{day}(cTone2Cells{day},15:25)))','xr');
end
axis tight;

subplot(223)
for day = 1:7
    plot(nanmean(cTone2Act{day}(cTone2Cells{day},:))','color',[day/10 day/10 day/10]); hold on
    plot(nanmean(cTone2Act{day}(cTone1Cells{day},:))','color',[day/10 0 0]);
end
axis tight;
ylim([-0.01 0.04])

subplot(224)
for day = 1:7
    plot(day,mean(nanmean(cTone2Act{day}(cTone2Cells{day},15:25)))','xk'); hold on
    plot(day,mean(nanmean(cTone2Act{day}(cTone1Cells{day},15:25)))','xr');
end
axis tight;

%%
%For Reward and Puff cells
figure;
subplot(221)
for day = 1:7
    plot(nanmean(cTone1Act{day}(cRewCells{day},:))','color',[day/10 day/10 day/10]); hold on
    plot(nanmean(cTone2Act{day}(cRewCells{day},:))','color',[day/10 0 0]);
end
axis tight;
ylim([-0.01 0.04])

subplot(222)
for day = 1:7
    plot(day,mean(nanmean(cTone1Act{day}(cRewCells{day},10:20)))','xk'); hold on
    plot(day,mean(nanmean(cTone2Act{day}(cRewCells{day},10:20)))','xr');
end
axis tight;

subplot(223)
for day = 1:7
    plot(nanmean(cTone1Act{day}(cPuffCells{day},:))','color',[day/10 day/10 day/10]); hold on
    plot(nanmean(cTone2Act{day}(cPuffCells{day},:))','color',[day/10 0 0]);
end
axis tight;
ylim([-0.01 0.04])

subplot(224)
for day = 1:7
    plot(day,mean(nanmean(cTone1Act{day}(cPuffCells{day},10:20)))','xk'); hold on
    plot(day,mean(nanmean(cTone2Act{day}(cPuffCells{day},10:20)))','xr');
end
axis tight;
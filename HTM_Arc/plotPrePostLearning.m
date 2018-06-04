%Plot day 1:3 vs 4:6 for different measures

%Performance
figure; hold on
bar(1,mean(nanmean(rate(:,1:3))),'k');
bar(2,mean(nanmean(rate(:,4:6))),'r');
errorbar(1,mean(nanmean(rate(:,1:3))),nanstd(nanmean(rate(:,1:3))),'k')
errorbar(2,mean(nanmean(rate(:,4:6))),nanstd(nanmean(rate(:,4:6))),'r')
ylim([0, 1])
ylabel('Performance / Fraction correct')
legend('Day 1:3','Day 4:6')
title('Performance day 1:3 vs 4:6')

%Arc vs Act Correlation
figure; hold on
bar(1,mean(nanmean(ccf(:,1:3))),'k');
bar(2,mean(nanmean(ccf(:,4:6))),'r');
errorbar(1,mean(nanmean(ccf(:,1:3))),nanstd(nanmean(ccf(:,1:3))),'k')
errorbar(2,mean(nanmean(ccf(:,4:6))),nanstd(nanmean(ccf(:,4:6))),'r')
ylim([0, 1])
ylabel('Correlation Coefficient')
legend('Day 1:3','Day 4:6')
title('Arc vs Act Correlation day 1:3 vs 4:6')

%Activity of high and low Arc neurons compared to population average
figure; hold on
tmp1 = nanmean(highArcAct(:,1:3))-nanmean(populationAct(:,1:3));
tmp2 = nanmean(highArcAct(:,4:6))-nanmean(populationAct(:,4:6));
bar(1,mean(tmp1),'k');
bar(2,mean(tmp2),'r');
errorbar(1,mean(tmp1),nanstd(tmp1),'k')
errorbar(2,mean(tmp2),nanstd(tmp2),'r')
ylim([0, 0.02])
ylabel('dF/F')
legend('Day 1:3','Day 4:6')
title('High Arc Act - Population Act day 1:3 vs 4:6')

figure; hold on
tmp1 = nanmean(lowArcAct(:,1:3))-nanmean(populationAct(:,1:3));
tmp2 = nanmean(lowArcAct(:,4:6))-nanmean(populationAct(:,4:6));
bar(1,mean(tmp1),'k');
bar(2,mean(tmp2),'r');
errorbar(1,mean(tmp1),nanstd(tmp1),'k')
errorbar(2,mean(tmp2),nanstd(tmp2),'r')
ylim([-0.02, 0.0])
ylabel('dF/F')
legend('Day 1:3','Day 4:6')
title('Low Arc Act - Population Act day 1:3 vs 4:6')

%Change in Arc - Positive and Negative
figure; hold on
bar(1,mean(nanmean(arcChangePos(:,1:3))),'k');
bar(2,mean(nanmean(arcChangePos(:,4:6))),'r');
errorbar(1,mean(nanmean(arcChangePos(:,1:3))),nanstd(nanmean(arcChangePos(:,1:3))),'k')
errorbar(2,mean(nanmean(arcChangePos(:,4:6))),nanstd(nanmean(arcChangePos(:,4:6))),'r')
ylim([0, 5])
ylabel('Change in Arc')
legend('Day 1:3','Day 4:6')
title('Mean Positive Arc change day 1:3 vs 4:6')

figure; hold on
bar(1,mean(nanmean(arcChangeNeg(:,1:3))),'k');
bar(2,mean(nanmean(arcChangeNeg(:,4:6))),'r');
errorbar(1,mean(nanmean(arcChangeNeg(:,1:3))),nanstd(nanmean(arcChangeNeg(:,1:3))),'k')
errorbar(2,mean(nanmean(arcChangeNeg(:,4:6))),nanstd(nanmean(arcChangeNeg(:,4:6))),'r')
ylim([-5, 0])
ylabel('Change in Arc')
legend('Day 1:3','Day 4:6')
title('Mean Negative Arc change day 1:3 vs 4:6')

%Tone1 vs tone2 correlation
figure; hold on
bar(1,mean(nanmean(toneActCor(:,1:3))),'k');
bar(2,mean(nanmean(toneActCor(:,4:6))),'r');
errorbar(1,mean(nanmean(toneActCor(:,1:3))),nanstd(nanmean(toneActCor(:,1:3))),'k')
errorbar(2,mean(nanmean(toneActCor(:,4:6))),nanstd(nanmean(toneActCor(:,4:6))),'r')
ylim([0 1])
ylabel('Correlation')
legend('Day 1:3','Day 4:6')
title('Tone1 Tone2 Correlation day 1:3 vs 4:6')

%Rew vs Puff correlation
figure; hold on
bar(1,mean(nanmean(rpActCor(:,1:3))),'k');
bar(2,mean(nanmean(rpActCor(:,4:6))),'r');
errorbar(1,mean(nanmean(rpActCor(:,1:3))),nanstd(nanmean(rpActCor(:,1:3))),'k')
errorbar(2,mean(nanmean(rpActCor(:,4:6))),nanstd(nanmean(rpActCor(:,4:6))),'r')
ylim([0 1])
ylabel('Correlation')
legend('Day 1:3','Day 4:6')
title('Rew Puff Correlation day 1:3 vs 4:6')

%Anticipatory Pupil changes
figure; hold on
bar(1,mean(nanmean(tmpPup(:,1:3))),'k');
bar(2,mean(nanmean(tmpPup(:,4:6))),'r');
errorbar(1,mean(nanmean(tmpPup(:,1:3))),nanstd(nanmean(tmpPup(:,1:3))),'k')
errorbar(2,mean(nanmean(tmpPup(:,4:6))),nanstd(nanmean(tmpPup(:,4:6))),'r')
ylim([0 4])
ylabel('Correlation')
legend('Day 1:3','Day 4:6')
title('Difference in anticipatory pupil size R-P day 1:3 vs 4:6')

%Anticipatory Lick changes
figure; hold on
bar(1,mean(nanmean(tmpLick(:,1:3))),'k');
bar(2,mean(nanmean(tmpLick(:,4:6))),'r');
errorbar(1,mean(nanmean(tmpLick(:,1:3))),nanstd(nanmean(tmpLick(:,1:3))),'k')
errorbar(2,mean(nanmean(tmpLick(:,4:6))),nanstd(nanmean(tmpLick(:,4:6))),'r')
ylim([-0.05 0.1])
ylabel('Correlation')
legend('Day 1:3','Day 4:6')
title('Difference in anticipatory lick act R-P day 1:3 vs 4:6')

%Classification Analysis
figure; hold on
bar(1,mean(nanmean(performance(:,1:3))),'k');
bar(2,mean(nanmean(performance(:,4:6))),'r');
errorbar(1,mean(nanmean(performance(:,1:3))),nanstd(nanmean(performance(:,1:3))),'k')
errorbar(2,mean(nanmean(performance(:,4:6))),nanstd(nanmean(performance(:,4:6))),'r')
ylim([0.4 1])
ylabel('Correlation')
legend('Day 1:3','Day 4:6')
title('Reward vs Puff Classification day 1:3 vs 4:6')
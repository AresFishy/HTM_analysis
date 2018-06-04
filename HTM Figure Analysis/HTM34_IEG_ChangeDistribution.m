%Get standard deviation for the distributuions of mean IEG change
arcDifStd = std2(vertcat(mIegDiff{1:4,:}));
cfosDifStd = std2(vertcat(mIegDiff{5:9,:}));

figure;
subplot(2,3,[1,4])
histogram(vertcat(mIegDiff{1:4,:}),[-0.3:0.01:0.3],'FaceColor','b')
line([arcDifStd arcDifStd], ylim, 'color','k','linestyle','--')
line([-arcDifStd -arcDifStd], ylim, 'color','k','linestyle','--')
ylabel('Count #')
xlabel('deltaArc')
title('Change in Arc')
legend('Arc','1 Std')

subplot(2,3,[2,5])
histogram(vertcat(mIegDiff{5:9,:}),[-0.3:0.01:0.3],'FaceColor','r')
line([cfosDifStd cfosDifStd], ylim, 'color','k','linestyle','--')
line([-cfosDifStd -cfosDifStd], ylim, 'color','k','linestyle','--')
ylabel('Count #')
xlabel('deltaCfos')
title('Change in cFos')
legend('cFos','1 Std')

arcUp = length(find(vertcat(mIegDiff{1:4,:}) > arcDifStd)) / size(vertcat(mIegDiff{1:4,:}),1);
arcDown = length(find(vertcat(mIegDiff{1:4,:}) < -arcDifStd)) / size(vertcat(mIegDiff{1:4,:}),1);
arcFixed = 1 - (arcUp + arcDown);

cfosUp = length(find(vertcat(mIegDiff{5:9,:}) > cfosDifStd)) / size(vertcat(mIegDiff{5:9,:}),1);
cfosDown = length(find(vertcat(mIegDiff{5:9,:}) < -cfosDifStd)) / size(vertcat(mIegDiff{5:9,:}),1);
cfosFixed = 1 - (cfosUp + cfosDown);

subplot(2,3,[3,6]);
bar(1, arcDown, 'FaceColor',[0 0 0.6]); hold on
bar(2, arcUp, 'FaceColor',[0 0 0.9]);
bar(3, cfosDown, 'FaceColor',[0.6 0 0]);
bar(4, cfosUp, 'FaceColor',[0.9 0 0]);
ylim([0 0.2]); ylabel('Fraction of Cells')
legend('arcDown','arcUp','cfosDown','cfosUp')
title('Fraction Up/Down in IEG')
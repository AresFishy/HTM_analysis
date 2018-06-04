
arcCor = corrcoef(horzcat(cArcAct{1:7}));

figure;
imagesc(arcCor);
set(gca,'clim',[0 1]);
xlabel('Days')
ylabel('Days')
title('Arc population correlation')

figure;
plot(diag(arcCor,1),'-ok')
set(gca,'XTick',[1:1:6]);
set(gca,'XTickLabel', {'1-2','2-3','3-4','4-5','5-6','6-7'});
ylim([0 1])
tmp = triu(arcCor,2);
line(xlim,[mean(tmp(tmp ~= 0)) mean(tmp(tmp ~= 0))],'color','k','LineStyle','--');
title('Arc Correlation across day')
ylabel('Correlation Coefficient')
xlabel('Days')
legend('Consecutive days','Other combinations')

%%
arcDiffCor = corrcoef(horzcat(cArcDiff{1:7}));

figure;
imagesc(arcDiffCor);
set(gca,'clim',[0 1]);
xlabel('Days')
ylabel('Days')
title('ArcDiff population correlation')

figure;
plot(diag(arcDiffCor,1),'-ok')
set(gca,'XTick',[1:1:6]);
set(gca,'XTickLabel', {'1-2','2-3','3-4','4-5','5-6','6-7'});
ylim([-0.2 1])
tmp = triu(arcDiffCor,2);
line(xlim,[mean(tmp(tmp ~= 0)) mean(tmp(tmp ~= 0))],'color','k','LineStyle','--');
title('ArcDiff Correlation across day')
ylabel('Correlation Coefficient')
xlabel('Days')
legend('Consecutive days','Other combinations')

%%
tmpAct = horzcat(cGratAct{1:7});
tmpActDif = diff(tmpAct,[],2);

for day = 1:6
    plot(day,corr(tmpActDif(:,day),cArcAct{day+1}),'ok'); hold on
end
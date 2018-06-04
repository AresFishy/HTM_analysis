tpActMean = {};
tpActMax = {};
tpActVar = {};

for day = 1:7
    for animal = 1:9
        for tp = 1:5
            tpActMean{animal,day}(:,tp) = mean(act{animal,day}(:,5000*tp-4999:5000*tp),2);
            tpActMax{animal,day}(:,tp) = max(act{animal,day}(:,5000*tp-4999:5000*tp),[],2);
            tpActVar{animal,day}(:,tp) = std(act{animal,day}(:,5000*tp-4999:5000*tp),[],2);
        end
        tpActDiff{animal,day} = diff(tpActMean{animal,day},1,2);
        tpActDiffMean{animal,day} = mean(tpActDiff{animal,day},2);
    end
end
%%
arcActDiffStd = std2(vertcat(tpActDiff{1:4,:}));
cfosActDiffStd = std2(vertcat(tpActDiff{5:9,:}));

figure;
subplot(2,3,[1,4])
histogram(vertcat(tpActDiff{1:4,:}),[-0.1:0.002:0.1])
line([arcActDiffStd arcActDiffStd], ylim, 'color','k','linestyle','--')
line([-arcActDiffStd -arcActDiffStd], ylim, 'color','k','linestyle','--')
ylabel('Number of cells')
xlabel('deltaArc Activity')

subplot(2,3,[2,5])
histogram(vertcat(tpActDiff{5:9,:}),[-0.1:0.002:0.1])
line([cfosActDiffStd cfosActDiffStd], ylim, 'color','k','linestyle','--')
line([-cfosActDiffStd -cfosActDiffStd], ylim, 'color','k','linestyle','--')
ylabel('Number of cells')
xlabel('deltaArc Activity')

arcActUp = length(find(vertcat(tpActDiff{1:4,:}) > arcActDiffStd)) / size(vertcat(tpActDiff{1:4,:}),1);
arcActDown = length(find(vertcat(tpActDiff{1:4,:}) < -arcActDiffStd)) / size(vertcat(tpActDiff{1:4,:}),1);
arcActFixed = 1 - (arcActUp + arcActDown);

cfosActUp = length(find(vertcat(tpActDiff{5:9,:}) > cfosActDiffStd)) / size(vertcat(tpActDiff{5:9,:}),1);
cfosActDown = length(find(vertcat(tpActDiff{5:9,:}) < -cfosActDiffStd)) / size(vertcat(tpActDiff{5:9,:}),1);
cfosFixed = 1 - (cfosActUp + cfosActDown);

subplot(2,3,3);
bar(1, arcActDown, 'FaceColor',[0 0 0.6]); hold on
bar(2, arcActUp, 'FaceColor',[0 0 0.9]);
bar(3, cfosActDown, 'FaceColor',[0.6 0 0]);
bar(4, cfosActUp, 'FaceColor',[0.9 0 0]);
ylim([0 0.2]); ylabel('Fraction of Cells')
legend('arcActDown','arcActUp','cfosActDown','cfosActUp')

%% Get correlation between change in activity within session and change in IEG
for day = 1:7
    for animal = 1:4
        arcDiffActDiffCor(animal,day) = corr(ieg_diff_cell{animal}(:,day),tpActDiffMean{animal,day});
    end
    for animal = 5:9
        cfosDiffActDiffCor(animal-4,day) = corr(ieg_diff_cell{animal}(:,day),tpActDiffMean{animal,day});
    end
end

figure;
bar(1,mean2(arcDiffActDiffCor),'b'); hold on
bar(2,mean2(cfosDiffActDiffCor),'r');
errorbar([1 2],[mean2(arcDiffActDiffCor) mean2(cfosDiffActDiffCor)], ...
    [std2(arcDiffActDiffCor)/sqrt(length(arcDiffActDiffCor(:))) std2(cfosDiffActDiffCor)/sqrt(length(cfosDiffActDiffCor(:)))],'k')
ylim([0 0.2]); 
ylabel('Correlation'); legend('Arc','cFos'); title('deltaAct vs. deltaIEG')



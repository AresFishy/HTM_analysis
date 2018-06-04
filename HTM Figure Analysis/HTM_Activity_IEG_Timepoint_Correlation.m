for day = 1:7
    for animal = 1:9
        for tp = 1:5
            tpActMean = mean(act{animal,day}(:,5000*tp-4999:5000*tp),2);
            tpActMax = max(act{animal,day}(:,5000*tp-4999:5000*tp),[],2);
            
            tpActMeanCor{animal,day}(:,tp) = corr(tpActMean,iegAct{animal,day}(:,tp+1));
            tpActMaxCor{animal,day}(:,tp) = corr(tpActMax,iegAct{animal,day}(:,tp+1));
        end
    end
end

%Plot overall within session correlation
figure;
plot_sem(vertcat(tpActMaxCor{1:4,:})','b',0.3)
plot_sem(vertcat(tpActMeanCor{1:4,:})','--b',0.3)
plot_sem(vertcat(tpActMaxCor{5:9,:})','r',0.3)
plot_sem(vertcat(tpActMeanCor{5:9,:})','--r',0.3)
ylim([0 0.4]); xlim([1 5])
title('Within Session IEG Activity Correlation')
ylabel('Correlation')
xlabel('Timepoint')
legend('','Arc Max Activity','','Arc Mean Activity','','cFos Max Activity','','cFos Mean Activity')

% Plot first 2 timepoints vs. last 2 timepoints
tpAMeanCarc = vertcat(tpActMeanCor{1:4,:});
tpAMeanCcfos = vertcat(tpActMeanCor{5:9,:});
tpAMaxCarc = vertcat(tpActMaxCor{1:4,:});
tpAMaxCcfos = vertcat(tpActMaxCor{5:9,:});


figure;
subplot(121)
bar(1,mean2(tpAMeanCarc(:,1:2)),'FaceColor',[0 0 0.6]);hold on
bar(2,mean2(tpAMeanCarc(:,4:5)),'FaceColor',[0 0 0.9]);
bar(3,mean2(tpAMeanCcfos(:,1:2)),'FaceColor',[0.6 0 0]);
bar(4,mean2(tpAMeanCcfos(:,4:5)),'FaceColor',[0.9 0 0]);
errorbar(1,mean2(tpAMeanCarc(:,1:2)),std2(tpAMeanCarc(:,1:2))/sqrt(size(tpAMeanCarc,1)),'k')
errorbar(2,mean2(tpAMeanCarc(:,4:5)),std2(tpAMeanCarc(:,4:5))/sqrt(size(tpAMeanCarc,1)),'k')
errorbar(3,mean2(tpAMeanCcfos(:,1:2)),std2(tpAMeanCcfos(:,1:2))/sqrt(size(tpAMeanCcfos,1)),'k')
errorbar(4,mean2(tpAMeanCcfos(:,4:5)),std2(tpAMeanCcfos(:,4:5))/sqrt(size(tpAMeanCcfos,1)),'k')
ylabel('Correlation');
legend('Arc TP1-2','Arc TP4-5','cFos TP1-2','cFos TP4-5')
title('Mean Activity IEG Correlation')

subplot(122)
bar(1,mean2(tpAMaxCarc(:,1:2)),'FaceColor',[0 0 0.6]);hold on
bar(2,mean2(tpAMaxCarc(:,4:5)),'FaceColor',[0 0 0.9]);
bar(3,mean2(tpAMaxCcfos(:,1:2)),'FaceColor',[0.6 0 0]);
bar(4,mean2(tpAMaxCcfos(:,4:5)),'FaceColor',[0.9 0 0]);
errorbar(1,mean2(tpAMaxCarc(:,1:2)),std2(tpAMaxCarc(:,1:2))/sqrt(size(tpAMaxCarc,1)),'k')
errorbar(2,mean2(tpAMaxCarc(:,4:5)),std2(tpAMaxCarc(:,4:5))/sqrt(size(tpAMaxCarc,1)),'k')
errorbar(3,mean2(tpAMaxCcfos(:,1:2)),std2(tpAMaxCcfos(:,1:2))/sqrt(size(tpAMaxCcfos,1)),'k')
errorbar(4,mean2(tpAMaxCcfos(:,4:5)),std2(tpAMaxCcfos(:,4:5))/sqrt(size(tpAMaxCcfos,1)),'k')
ylabel('Correlation');
legend('Arc TP1-2','Arc TP4-5','cFos TP1-2','cFos TP4-5')
title('Max Activity IEG Correlation')

%% Mean Act - IEG Corr
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(vertcat(tpActMeanCor{1:4,day})','b',0.3)
    plot_sem(vertcat(tpActMeanCor{5:9,day})','r',0.3)
    ylim([-0.1 0.4]); xlim([1 5])
    line(xlim,[0 0],'Color','k','LineStyle','--')
    title(sprintf('Day %d',day))
    ylabel('Correlation')
    xlabel('Timepoint')
end
subplot(2,4,8)
plot_sem(vertcat(tpActMeanCor{1:4,:})','b',0.3)
plot_sem(vertcat(tpActMeanCor{5:9,:})','r',0.3)
ylim([-0.1 0.4]); xlim([1 5])
title('All Days')
line(xlim,[0 0],'Color','k','LineStyle','--')
ylabel('Correlation')
xlabel('Timepoint')
legend('','Mean Act - Arc','','Mean Act - cFos')

%% Max Act - IEG Corr
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(vertcat(tpActMaxCor{1:4,day})','b',0.3)
    plot_sem(vertcat(tpActMaxCor{5:9,day})','r',0.3)
    ylim([-0.1 0.4]); xlim([1 5])
    line(xlim,[0 0],'Color','k','LineStyle','--')
    title(sprintf('Day %d',day))
    ylabel('Correlation')
    xlabel('Timepoint')
end


%% Plot first 2 timepoints vs. last 2 timepoints
tpAMeanCarc = vertcat(tpActMeanCor{1:4,:});
tpAMeanCcfos = vertcat(tpActMeanCor{5:9,:});


figure;
bar(1,mean2(tpAMeanCarc(:,1:2)),'FaceColor',[0 0 0.6]);hold on
bar(2,mean2(tpAMeanCarc(:,4:5)),'FaceColor',[0 0 0.9]);
bar(3,mean2(tpAMeanCcfos(:,1:2)),'FaceColor',[0.6 0 0]);
bar(4,mean2(tpAMeanCcfos(:,4:5)),'FaceColor',[0.9 0 0]);
errorbar(1,mean2(tpAMeanCarc(:,1:2)),std2(tpAMeanCarc(:,1:2))/sqrt(size(tpAMeanCarc,1)),'k')
errorbar(2,mean2(tpAMeanCarc(:,4:5)),std2(tpAMeanCarc(:,4:5))/sqrt(size(tpAMeanCarc,1)),'k')
errorbar(3,mean2(tpAMeanCcfos(:,1:2)),std2(tpAMeanCcfos(:,1:2))/sqrt(size(tpAMeanCcfos,1)),'k')
errorbar(4,mean2(tpAMeanCcfos(:,4:5)),std2(tpAMeanCcfos(:,4:5))/sqrt(size(tpAMeanCcfos,1)),'k')
ylabel('Correlation');
legend('Arc TP1-2','Arc TP4-5','cFos TP1-2','cFos TP4-5')
title('Mean Act IEG Correlation')
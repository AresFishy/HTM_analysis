%Calculate IEG Diff activity correlation
for day = 1:7
    for animal = 1:9
        meanActIEGDiff(animal,day) = corr(mean(act{animal,day},2),mean(iegDiff{animal,day},2));
        maxActIEGDiff(animal,day) = corr(max(act{animal,day},[],2),mean(iegDiff{animal,day},2));
    end
end
%Plot IEG - Activity correlation across all days
figure;
bar(1,mean2(meanActIEGDiff(1:4,:)),'FaceColor',[0 0 0.6]); hold on
bar(2,mean2(maxActIEGDiff(1:4,:)),'FaceColor',[0 0 0.9]);
bar(3,mean2(meanActIEGDiff(5:9,:)),'FaceColor',[0.6 0 0]); 
bar(4,mean2(maxActIEGDiff(5:9,:)),'FaceColor',[0.9 0 0]);

errorbar(1,mean2(meanActIEGDiff(1:4,:)),std2(meanActIEGDiff(1:4,:))/sqrt(28),'k');
errorbar(2,mean2(maxActIEGDiff(1:4,:)),std2(maxActIEGDiff(1:4,:))/sqrt(28),'k');
errorbar(3,mean2(meanActIEGDiff(5:9,:)),std2(meanActIEGDiff(5:9,:))/sqrt(35),'k');
errorbar(4,mean2(maxActIEGDiff(5:9,:)),std2(maxActIEGDiff(5:9,:))/sqrt(35),'k');
ylim([0 0.45])
ylabel('Correlation')
legend('Diff Arc Mean Activity','Diff Arc Max Activity','cFos Mean Activity','cFos Max Activity')
title('Activity and IEG Diff Correlation')

%Plot correlation coefficient for IEG and Act for each day
figure;
subplot(121)
plot_sem(meanActIEGDiff(1:4,:)','b',0.3);
plot_sem(maxActIEGDiff(1:4,:)','r',0.3);
ylim([-0.2 1]); xlim([1 7])
ylabel('Correlation Coefficient'); xlabel('Day')
title('Arc Diff correlation with Activity')
legend('','Mean Act','','Max Act')
subplot(122)
plot_sem(meanActIEGDiff(5:9,:)','b',0.3);
plot_sem(maxActIEGDiff(5:9,:)','r',0.3);
ylim([-0.2 1]); xlim([1 7])
ylabel('Correlation Coefficient'); xlabel('Day')
title('cFos Diff correlation with Activity')
legend('','Mean Act','','Max Act','')
%%
%Plot examples of correlation across animals for day 1 and 7
for day = 1 %For first day
    subplot(221)
    for animal = 1:4
        plot(max(act{animal,day},[],2),mean(iegDiff{animal,day},2),'.'); hold on
    end
    ylim([-0.1 0.1]); xlim([0.5 6])
    line(xlim,[0 0],'color','k','linestyle','--');line([1 1],ylim,'color','k','linestyle','--');
    ylabel('Arc Diff'); xlabel('Max Act dF/F'); legend('Animal 1','Animal 2','Animal 3','Animal 4')
    title('Arc Day 1')
    subplot(223)
    for animal = 5:9
        plot(max(act{animal,day},[],2),mean(iegDiff{animal,day},2),'.'); hold on
    end
    ylim([-0.03 0.03]); xlim([0.5 6])
    line(xlim,[0 0],'color','k','linestyle','--');line([1 1],ylim,'color','k','linestyle','--');
    ylabel('cFos Diff'); xlabel('Max Act dF/F'); legend('Animal 1','Animal 2','Animal 3','Animal 4','Animal 5')
    title('cFos Day 1')
end
for day = 7 %For last day
    subplot(222)
    for animal = 1:4
        plot(max(act{animal,day},[],2),mean(iegDiff{animal,day},2),'.'); hold on
    end
    ylim([-0.1 0.1]); xlim([0.5 6])
    line(xlim,[0 0],'color','k','linestyle','--');line([1 1],ylim,'color','k','linestyle','--');
    ylabel('Arc Diff'); xlabel('Max Act dF/F'); legend('Animal 1','Animal 2','Animal 3','Animal 4')
    title('Arc Day 7')
    subplot(224)
    for animal = 5:9
        plot(max(act{animal,day},[],2),mean(iegDiff{animal,day},2),'.'); hold on
    end
    ylim([-0.03 0.03]); xlim([0.5 6])
    line(xlim,[0 0],'color','k','linestyle','--');line([1 1],ylim,'color','k','linestyle','--');
    ylabel('cFos Diff'); xlabel('Max Act dF/F'); legend('Animal 1','Animal 2','Animal 3','Animal 4','Animal 5')
    title('cFos Day 7')
end



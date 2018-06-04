%% Plot change in IEG across days
arcLevel = []; mArcAct = [];
cfosLevel = []; mCfosAct = [];
for day = 1:7
    for animal = 1:9
        if animal < 5
            arcLevel(animal,day) = mean(mIegAct{animal,day});
            mArcAct(animal,day) =  mean2(act{animal,day});
        else
            cfosLevel(animal-4,day) = mean(mIegAct{animal,day});
            mCfosAct(animal-4,day) =  mean2(act{animal,day});
        end
    end
end

figure;
subplot(121)
plot_sem(arcLevel','b',0.3);
plot_sem(cfosLevel','r',0.3);
ylim([1 1.3]); xlim([1 7])
ylabel('IEG/Activity Level'); xlabel('Day')
legend('','Arc','','c-Fos')
title('IEG/Activity level')
subplot(122)
plot_sem(mArcAct','k',0.3);
plot_sem(mCfosAct','[0.5 0.5 0.5]',0.3);
ylim([1 1.02]); xlim([1 7])
ylabel('IEG/Activity Level'); xlabel('Day')
legend('','Activity Arc Population','','Activity cFos Population')
title('IEG/Activity level')


%% Plot within session IEG level
tpArcLevel = vertcat(iegAct{1:4,:});
tpCfosLevel = vertcat(iegAct{5:9,:});

figure;
plot_sem(tpArcLevel' ./ mean(tpArcLevel(:,1)),'b')
plot_sem(tpCfosLevel' ./ mean(tpCfosLevel(:,1)),'r')
ylim([0.995 1.015]); xlim([1 6]);
title('Within session IEG expression level')
xlabel('Timepoint'); ylabel('IEG Expression Level');
legend('','Arc','','cFos')
line(xlim,[1 1],'Color','k','LineStyle','--')

%% Plot first 2 timepoints vs. last 2 timepoints

figure;
subplot(121)
bar(1,mean2(tpArcLevel(:,1:2) / mean(tpArcLevel(:,1))),'FaceColor','w','EdgeColor','b');hold on
bar(2,mean2(tpArcLevel(:,5:6) / mean(tpArcLevel(:,1))),'FaceColor','w','LineStyle','--','EdgeColor','b');
errorbar(1,mean2(tpArcLevel(:,1:2)) / mean(tpArcLevel(:,1)),std2(tpArcLevel(:,1:2))/sqrt(2*8897),'k')
errorbar(2,mean2(tpArcLevel(:,5:6)) / mean(tpArcLevel(:,1)),std2(tpArcLevel(:,5:6))/sqrt(2*8897),'k')
ylim([0.995 1.015])
title('Within Session Arc Level');
legend('Early','Late')
ylabel('Expression Level'); 
subplot(122)
bar(1,mean2(tpCfosLevel(:,1:2) / mean(tpCfosLevel(:,1))),'FaceColor','w','EdgeColor','r'); hold on
bar(2,mean2(tpCfosLevel(:,5:6) / mean(tpCfosLevel(:,1))),'FaceColor','w','LineStyle','--','EdgeColor','r');
errorbar(1,mean2(tpCfosLevel(:,1:2) / mean(tpCfosLevel(:,1))),std2(tpCfosLevel(:,1:2))/sqrt(2*12733),'k')
errorbar(2,mean2(tpCfosLevel(:,5:6) / mean(tpCfosLevel(:,1))),std2(tpCfosLevel(:,5:6))/sqrt(2*12733),'k')
ylim([0.995 1.015])
title('Within Session c-fos Level');
legend('Early','Late')
ylabel('Expression Level'); 

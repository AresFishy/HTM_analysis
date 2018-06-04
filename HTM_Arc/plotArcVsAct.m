%Plot arc vs activity
for day = 1:6
    for animal = 1:4
        if ~isempty(act{animal,day})
            plot(mean(act{animal,day},2),mean(arcAct{animal,day},2),'.'); hold on
        end
    end
end
xlabel('Activity dF/F')
ylabel('Arc Expression Level')
title('Arc vs Activity across mice and days')

%%
%Plot arc change vs activity
for day = 1:6
    for animal = 1:4
        if ~isempty(act{animal,day})
            plot(mean(act{animal,day},2),mean(arcDiff{animal,day},2),'.'); hold on
        end
    end
end
xlabel('Activity dF/F')
ylabel('Change in Arc Expression Level')
title('Arc change vs Activity across mice and days')


%%
%Plot mean activity for high and low Arc neurons
highArcAct = [];
lowArcAct = [];
populationAct = [];
for day = 1:7
    for animal = 1:4
        highArcAct(animal,day) = mean(nanmean(act{animal,day}(highArc{animal,day},:)));
        lowArcAct(animal,day) = mean(nanmean(act{animal,day}(lowArc{animal,day},:)));
        populationAct(animal,day) = mean(nanmean(act{animal,day}));
    end
end
plot_sem(highArcAct','k',0.5)
hold on
plot_sem(lowArcAct','r',0.5)
plot_sem(populationAct','g',0.5)

xlabel('Day')
ylabel('Mean Activity dF/F')
title('Activity of high and low Arc neurons')
legend('','High Arc','','Low Arc','','Population')

%%
%Plot mean activity for up and down Arc neurons
upArcAct = [];
downArcAct = [];

for day = 1:7
    for animal = 1:4
        upArcAct(animal,day) = mean(nanmean(act{animal,day}(upArc{animal,day},:)));
        downArcAct(animal,day) = mean(nanmean(act{animal,day}(downArc{animal,day},:)));
        populationAct(animal,day) = mean(nanmean(act{animal,day}));
    end
end
plot_sem(upArcAct','k',0.5)
hold on
plot_sem(downArcAct','r',0.5)
plot_sem(populationAct','g',0.5)

xlabel('Day')
ylabel('Mean Activity dF/F')
title('Activity of up and down Arc neurons')
legend('','Up Arc','','Down Arc','','Population')

%%

%Plot correlation between arc and activity
ccf = [];
for day = 1:7
    for animal = 1:4
        if ~isempty(act{animal,day})
            tmp = corrcoef(nanmean(arcAct{animal,day},2),mAct{animal,day},'rows','complete');
            ccf(animal,day) = tmp(1,2);
        end
    end
end

figure;
for animal = 1:4
    plot(ccf(animal,:),'k'); hold on
end
plot(mean(ccf,1),'--')
ylim([-0.1 1])
title('Arc expression vs. mean activity')
ylabel('Correlation Coefficient')
xlabel('Day')
legend('Animal 1','Animal 2','Animal 3','Animal 4','Mean')





%%
%Plot correlation between arc level and arc change
figure; hold on
for day = 1:7
    tmpCorr(day) = corr(cArcAct{day},abs(cArcDiff{day}),'rows','complete');
end
plot(tmpCorr,'-ok')
ylim([0 1])
ylabel('Correlation')
xlabel('Day')
title('Arc level vs. Arc change')

%%
%Plot Stimulus activity of cells seleted on same day
figure;
for day = 1:7;
    subplot(2,4,day)
    if day == 1
        title('Puff activity')
    end
    
    plot_sem(caPuffAct{day}(cHighArc{day},:)','k',0.5)
    hold on
    plot_sem(caPuffAct{day}(cLowArc{day},:)','r',0.5)
    axis tight;
    ylim([-0.01 0.04])
    legend({'','High Arc','','Low Arc'})
    ylabel('dF/F')
    xlabel('Frame #')
    %plot_sem(cPuffAct{day}(flatArc{1},:)','g')
end

%%
%Plot Mean Onset Stimulus activity of cells seleted on same day
stimActHArc = [];
stimActLArc = [];
for day = 1:7
    for animal = 1:4
        stim = mGratAct{animal,day};
        stimActHArc(animal,day) = mean(nanmean(stim(highArc{animal,day},15:20),2));
        stimActLArc(animal,day) = mean(nanmean(stim(lowArc{animal,day},15:20),2));
        
    end
end
figure;
plot_sem(stimActHArc','k',0.5);
plot_sem(stimActLArc','r',0.5);
axis tight;
ylim([0 0.015])
legend({'','High Arc','','Low Arc'})
ylabel('dF/F')
xlabel('Frame #')
title('Grating Act')
%%
%Plot the change in arc across days
arcChangePos = [];
arcChangeNeg = [];
for day = 1:7
    for animal = 1:4
        arcChangePos(animal,day) = nanmean(mArcDiff{animal,day}(mArcDiff{animal,day} > 0));
        arcChangeNeg(animal,day) = nanmean(mArcDiff{animal,day}(mArcDiff{animal,day} < 0));
    end
end

figure; hold on
plot_sem(arcChangePos','k')
plot_sem(arcChangeNeg','r')
legend({'','Mean Positive Arc Change','','Mean Negative Arc Change'})
title('Change in Arc across days')
ylabel('Arc change')
xlabel('Day')

%%
%Plot the change in arc across days for high and low Arc neurons
for day = 1:7
    for animal = 1:4
        tmparcDiffHigh = arcDiff{animal,day}(highArc{animal,day});
        tmparcDiffLow = arcDiff{animal,day}(lowArc{animal,day});
        arcDiffHighPos(animal,day) = nanmean(tmparcDiffHigh(tmparcDiffHigh > 0));
        arcDiffLowPos(animal,day) = nanmean(tmparcDiffLow(tmparcDiffLow > 0));
        arcDiffHighNeg(animal,day) = nanmean(tmparcDiffHigh(tmparcDiffHigh < 0));
        arcDiffLowNeg(animal,day) = nanmean(tmparcDiffLow(tmparcDiffLow < 0));
    end
end

figure; hold on
plot_sem(arcDiffHighPos','k')
plot_sem(arcDiffHighNeg','--k')
plot_sem(arcDiffLowPos','r')
plot_sem(arcDiffLowNeg','--r')
legend({'Mean Positive Arc Change HIGH','Mean Negative Arc Change HIGH','Mean Positive Arc Change LOW','Mean Negative Arc Change LOW'})
title('Change in Arc across days')
ylabel('Arc change')
xlabel('Day')
%%
%Plot puff activity of cells seleted on day 1
for day = 1:7;
    subplot(2,4,day)
    if day == 1
        title('Trial activity')
    end
    figure;
    plot_sem(cTrialAct{day}(cHighArc{day},:)','k',0.5)
    hold on
    plot_sem(cTrialAct{day}(cLowArc{day},:)','r',0.5)
    axis tight;
    ylim([-0.01 0.02])
    legend({'','High Arc','','Low Arc'})
    ylabel('dF/F')
    xlabel('Frame #')
end

%%


%Look at cells increasing or decreasing in Arc

downArc = {};
upArc = {};
highArc = {};
lowArc = {};

for day = 1:8
    %Trick to avoid the NaN's in the sorting
    for animal = 1:4
        if ~isempty(act{animal,day})
            tmp = find(~isnan(mArcDiff{animal,day}));
            [~,tmp_sort] = sort(mArcDiff{animal,day}(tmp));
            
            downArc{animal,day} = tmp(tmp_sort(1:30));
            upArc{animal,day} = tmp(tmp_sort(end-29:end));
            flatArc{animal,day} = find(mArcDiff{animal,day} < 0.25 & mArcDiff{animal,day} > -0.25);
            
            tmp = find(~isnan(mArcAct{animal,day}));
            [~,tmp_sort] = sort(mArcAct{animal,day}(tmp));
            
            lowArc{animal,day} = tmp(tmp_sort(1:30));
            highArc{animal,day} = tmp(tmp_sort(end-29:end));
        end
    end
end

    %Combine cells across animals cells
    cellList = [0 289 289+487 289+487+195];
    cDownArc = {};
    cUpArc = {};
    cLowArc = {};
    cHighArc = {};

for day = 1:8
    cDownArc{day} = [];
    cUpArc{day} = [];
    cLowArc{day} = [];
    cHighArc{day} = [];
    
    for animal = 1:4
        cDownArc{day} = [cDownArc{day}; downArc{animal,day}+cellList(animal)];
        cUpArc{day} = [cUpArc{day}; upArc{animal,day}+cellList(animal)];
        cLowArc{day} = [cLowArc{day}; lowArc{animal,day}+cellList(animal)];
        cHighArc{day} = [cHighArc{day}; highArc{animal,day}+cellList(animal)];
    end
end
for day = 1:8
        subplot(121)
        plot(day,nanmean(cArcAct{day}(cUpArc{day})),'ok'); hold on
        plot(day,nanmean(cArcAct{day}(cDownArc{day})),'or'); hold on
        subplot(122)
        plot(day,nanmean(cArcDiff{day}(cUpArc{day})),'ok'); hold on
        plot(day,abs(nanmean(cArcDiff{day}(cDownArc{day}))),'or'); hold on
end

%%
%Plot correlation between arc level and arc change
figure; hold on
for day = 1:8
    tmpCorr(day) = corr(cArcAct{day},abs(cArcDiff{day}),'rows','complete');
end
plot(tmpCorr,'-ok')
ylim([0 1])
ylabel('Correlation')
xlabel('Day')
title('Arc level vs. Arc change')

%%
%Plot puff activity of cells seleted on day 1
for day = 1:8;
    subplot(2,4,day)
    if day == 1
        title('Grating activity')
    end
    
    plot_sem(cGratAct{day}(cHighArc{day},:)','k',0.5)
    hold on
    plot_sem(cGratAct{day}(cLowArc{day},:)','r',0.5)
    axis tight;
    ylim([-0.01 0.04])
    legend({'','High Arc','','Low Arc'})
    ylabel('dF/F')
    xlabel('Frame #')
    %plot_sem(cPuffAct{day}(flatArc{1},:)','g')
end
%%
%Plot the change in arc across days
for day = 1:8
    for animal = 1:4
        arcChangePos(animal,day) = nanmean(mArcDiff{animal,day}(mArcDiff{animal,day} > 0));
        arcChangeNeg(animal,day) = nanmean(mArcDiff{animal,day}(mArcDiff{animal,day} < 0));
    end
end

figure; hold on
plot(nanmean(arcChangePos),'k') 
plot(nanmean(arcChangeNeg),'r')
legend({'Mean Positive Arc Change','Mean Negative Arc Change'})
title('Change in Arc across days')
ylabel('Arc change')
xlabel('Day')

%%
%Plot the change in arc across days for high and low Arc neurons
for day = 1:8
    tmparcDiffHigh = cArcDiff{day}(cHighArc{day});
    tmparcDiffLow = cArcDiff{day}(cLowArc{day});
    arcDiffHighPos(day) = nanmean(tmparcDiffHigh(tmparcDiffHigh > 0));
    arcDiffLowPos(day) = nanmean(tmparcDiffLow(tmparcDiffLow > 0));
    arcDiffHighNeg(day) = nanmean(tmparcDiffHigh(tmparcDiffHigh < 0));
    arcDiffLowNeg(day) = nanmean(tmparcDiffLow(tmparcDiffLow < 0));
end

figure; hold on
plot(arcDiffHighPos,'k')
plot(arcDiffHighNeg,'--k')
plot(arcDiffLowPos,'r')
plot(arcDiffLowNeg,'--r')
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
    
    plot_sem(cTrialAct{day}(highArc{day},:)','k',0.5)
    hold on
    plot_sem(cTrialAct{day}(lowArc{day},:)','r',0.5)
    axis tight;
    ylim([-0.01 0.02])
    legend({'','High Arc','','Low Arc'})
    ylabel('dF/F')
    xlabel('Frame #')
end


%%
%Plot overlap across days for cells that up or downregulate Arc

for day = 1:7
    upArcLap(day) = length(intersect(upArc{day},upArc{day+1}))/length(upArc{day});
    downArcLap(day) = length(intersect(downArc{day},downArc{day+1}))/length(downArc{day});
end
figure;
plot(upArcLap,'k'); hold on
plot(downArcLap,'r')
hLine =line(xlim,[0.08 0.08]);
hLine.Color = 'b'
hLine.LineStyle = '--'
ylim([0 1])
legend('upArc','downArc')
ylabel('Overlap Fraction')
ax.XTickLabel = {'1-2','2-3','3-4','4-5','6-7','7-8'};
xlabel('Days')
title('Overlap in Arc up/down regulating cells across days')
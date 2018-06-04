for day = 1:7
    for animal = 1:4
        stdPuffAct{animal,day} = std(nanmean(aPuffAct{animal,day}(:,:,15:20),3),[],1);
        mResPuffAct{animal,day} = mean(nanmean(aPuffAct{animal,day}(:,:,15:20),3),1);
        if ~isempty(rewAct{animal,day})
            stdRewAct{animal,day} = std(nanmean(rewAct{animal,day}(:,:,15:20),3),[],1);
            mResRewAct{animal,day} = mean(nanmean(rewAct{animal,day}(:,:,15:20),3),1);
        end
        stdToneAct{animal,day} = std(nanmean(toneAct{animal,day}(:,:,15:20),3),[],1);
        mResToneAct{animal,day} = mean(nanmean(toneAct{animal,day}(:,:,15:20),3),1);
        stdGratAct{animal,day} = std(nanmean(gratAct{animal,day}(:,:,15:20),3),[],1);
        mResGratAct{animal,day} = mean(nanmean(gratAct{animal,day}(:,:,15:20),3),1);
        
    end
end



stdPuffArcCorr = [];
stdRewArcCorr = [];
stdToneArcCorr = [];
stdGratArcCorr = [];
stdOnArcCorr = [];
for day = 1:7
    for animal = 1:4
        stdPuffArcCorr(animal,day) = corr(stdPuffAct{animal,day}',mArcAct{animal,day});
        mPuffArcCorr(animal,day) = corr(mResPuffAct{animal,day}',mArcAct{animal,day});
        if ~isempty(rewAct{animal,day})
            stdRewArcCorr(animal,day) = corr(stdRewAct{animal,day}',mArcAct{animal,day});
            mRewArcCorr(animal,day) = corr(mResRewAct{animal,day}',mArcAct{animal,day});
        end
        stdToneArcCorr(animal,day) = corr(stdToneAct{animal,day}',mArcAct{animal,day});
        mToneArcCorr(animal,day) = corr(mResToneAct{animal,day}',mArcAct{animal,day});
        stdGratArcCorr(animal,day) = corr(stdGratAct{animal,day}',mArcAct{animal,day});
        mGratArcCorr(animal,day) = corr(mResGratAct{animal,day}',mArcAct{animal,day});
        
    end
end

figure; hold on
plot_sem(stdPuffArcCorr','r',0.2)
plot_sem(stdRewArcCorr','k',0.2)
plot_sem(stdToneArcCorr','g',0.2)
plot_sem(stdGratArcCorr','m',0.2)
plot_sem(mPuffArcCorr','--r',0.2)
plot_sem(mRewArcCorr','--k',0.2)
plot_sem(mToneArcCorr','--g',0.2)
plot_sem(mGratArcCorr','--m',0.2)
legend('','Puff Act','','Reward Act','','Tone Act','','Grat Act')
ylabel('Correlation Coefficient'); xlabel('Day'); title('Response Variation - and Mean -- vs Arc Correlation')

figure;
plot_sem([stdPuffArcCorr-mPuffArcCorr; stdRewArcCorr-mRewArcCorr; stdToneArcCorr-mToneArcCorr; stdGratArcCorr-mGratArcCorr]','-b',1);
title('Difference in Correlation for Arc|ActStd and Arc|ActMean')
ylabel('Difference in Correlation')
xlabel('Day')

%Plot std act vs arc
figure;
for day = 1:7
    for animal = 1:4
        subplot(221)
        plot(stdPuffAct{animal,day}',mArcAct{animal,day},'.r'); hold on
        ylabel('Arc Level'); xlabel('Puff Act Std'); title('Puff Act Std vs Arc Correlation')
        ylim([0 1]); xlim([0 0.1])
        subplot(222)
        if ~isempty(rewAct{animal,day})
            plot(stdRewAct{animal,day}',mArcAct{animal,day},'.k'); hold on
        end
        ylabel('Arc Level'); xlabel('Reward Act Std'); title('Reward Act Std vs Arc Correlation')
        ylim([0 1]); xlim([0 0.1])
        subplot(223)
        plot(stdToneAct{animal,day}',mArcAct{animal,day},'.g'); hold on
        ylabel('Arc Level'); xlabel('Tone Act Std'); title('Tone Act Std vs Arc Correlation')
        ylim([0 1]); xlim([0 0.1])
        subplot(224)
        plot(stdGratAct{animal,day}',mArcAct{animal,day},'.m'); hold on
        ylabel('Arc Level'); xlabel('Grating Act Std'); title('Grating Act Std vs Arc Correlation')
        ylim([0 1]); xlim([0 0.1])
    end
end

%Plot mean act vs arc
figure;
for day = 1:7
    for animal = 1:4
        subplot(221)
        plot(mResPuffAct{animal,day}',mArcAct{animal,day},'.r'); hold on
        ylabel('Arc Level'); xlabel('Puff Act Mean'); title('Puff Act Mean vs Arc Correlation')
        ylim([0 1]); xlim([-0.1 0.1])
        subplot(222)
        if ~isempty(rewAct{animal,day})
            plot(mResRewAct{animal,day}',mArcAct{animal,day},'.k'); hold on
        end
        ylabel('Arc Level'); xlabel('Reward Act Mean'); title('Reward Act Mean vs Arc Correlation')
        ylim([0 1]); xlim([-0.1 0.1])
        subplot(223)
        plot(mResToneAct{animal,day}',mArcAct{animal,day},'.g'); hold on
        ylabel('Arc Level'); xlabel('Tone Act Mean'); title('Tone Act Mean vs Arc Correlation')
        ylim([0 1]); xlim([-0.1 0.1])
        subplot(224)
        plot(mResGratAct{animal,day}',mArcAct{animal,day},'.m'); hold on
        ylabel('Arc Level'); xlabel('Grating Act Mean'); title('Grating Act Mean vs Arc Correlation')
        ylim([0 1]); xlim([-0.1 0.1])
    end
end

%Plot std act vs change in arc
figure;
for day = 1:7
    for animal = 1:4
        subplot(221)
        plot(stdPuffAct{animal,day}',mArcDiff{animal,day},'.r'); hold on
        ylabel('Arc Change'); xlabel('Puff Act Std'); title('Puff Act Std vs Arc Change Correlation')
        ylim([-1 1]); xlim([0 0.1])
        line([0 0],ylim,'color','k','LineStyle','--')
        line(xlim,[0 0],'color','k','LineStyle','--')
        subplot(222)
        if ~isempty(rewAct{animal,day})
            plot(stdRewAct{animal,day}',mArcDiff{animal,day},'.k'); hold on
        end
        ylabel('Arc Change'); xlabel('Reward Act Std'); title('Reward Act Std vs Arc Change Correlation')
        ylim([-1 1]); xlim([0 0.1])
        line([0 0],ylim,'color','k','LineStyle','--')
        line(xlim,[0 0],'color','k','LineStyle','--')
        subplot(223)
        plot(stdToneAct{animal,day}',mArcDiff{animal,day},'.g'); hold on
        ylabel('Arc Change'); xlabel('Tone Act Std'); title('Tone Act Std vs Arc Change Correlation')
        ylim([-1 1]); xlim([0 0.1])
        line([0 0],ylim,'color','k','LineStyle','--')
        line(xlim,[0 0],'color','k','LineStyle','--')
        subplot(224)
        plot(stdGratAct{animal,day}',mArcDiff{animal,day},'.m'); hold on
        ylabel('Arc Change'); xlabel('Grating Act Std'); title('Grating Act Std vs Arc Change Correlation')
        ylim([-1 1]); xlim([0 0.1])
        line([0 0],ylim,'color','k','LineStyle','--')
        line(xlim,[0 0],'color','k','LineStyle','--')
    end
end

%Plot mean act vs change in arc
figure;
for day = 1:7
    for animal = 1:4
        subplot(221)
        plot(mResPuffAct{animal,day}',mArcDiff{animal,day},'.r'); hold on
        ylabel('Arc Change'); xlabel('Puff Act Mean'); title('Puff Act Mean vs Arc Change Correlation')
        ylim([-1 1]); xlim([-0.1 0.1])
        line([0 0],ylim,'color','k','LineStyle','--')
        line(xlim,[0 0],'color','k','LineStyle','--')
        subplot(222)
        if ~isempty(rewAct{animal,day})
            plot(mResRewAct{animal,day}',mArcDiff{animal,day},'.k'); hold on
        end
        ylabel('Arc Change'); xlabel('Reward Act Mean'); title('Reward Act Mean vs Arc Change Correlation')
        ylim([-1 1]); xlim([-0.1 0.1])
        line([0 0],ylim,'color','k','LineStyle','--')
        line(xlim,[0 0],'color','k','LineStyle','--')
        subplot(223)
        plot(mResToneAct{animal,day}',mArcDiff{animal,day},'.g'); hold on
        ylabel('Arc Change'); xlabel('Tone Act Mean'); title('Tone Act Mean vs Arc Change Correlation')
        ylim([-1 1]); xlim([-0.1 0.1])
        line([0 0],ylim,'color','k','LineStyle','--')
        line(xlim,[0 0],'color','k','LineStyle','--')
        subplot(224)
        plot(mResGratAct{animal,day}',mArcDiff{animal,day},'.m'); hold on
        ylabel('Arc Change'); xlabel('Grating Act Mean'); title('Grating Act Mean vs Arc Change Correlation')
        ylim([-1 1]); xlim([-0.1 0.1])
        line([0 0],ylim,'color','k','LineStyle','--')
        line(xlim,[0 0],'color','k','LineStyle','--')
    end
end


%%
%For full trial activity
for day = 1:7
    for animal = 1:4
        stdTrialAct{animal,day} = std(nanmean(trialAct{animal,day}(:,:,:),3),[],1);
    end
end

stdTrialArcCorr = [];
for day = 1:7
    for animal = 1:4
        stdTrialArcCorr(animal,day) = corr(stdTrialAct{animal,day}',mArcAct{animal,day});
        mTrialArcCorr(animal,day) = corr(mean(mTrialAct{animal,day},2),mArcAct{animal,day});
    end
end

plot_sem(stdTrialArcCorr','k',0.5)
plot_sem(mTrialArcCorr','r',0.5)


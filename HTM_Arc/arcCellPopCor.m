for day = 1:7
    for animal = 1:4
        if ~isempty(toneCells{animal,day})
            tmpArcTone(animal,day) = corr(mArcAct{animal,day}(toneCells{animal,day}),nanmean(mToneAct{animal,day}(toneCells{animal,day},15:25),2));
            tmpArcPopT(animal,day) = corr(mArcAct{animal,day},nanmean(mToneAct{animal,day}(:,15:30),2));
        end
        if ~isempty(puffCells{animal,day})
            tmpArcPuff(animal,day) = corr(mArcAct{animal,day}(puffCells{animal,day}),nanmean(maPuffAct{animal,day}(puffCells{animal,day},15:25),2));
            tmpArcPopP(animal,day) = corr(mArcAct{animal,day},nanmean(maPuffAct{animal,day}(:,15:30),2));
        end
        if ~isempty(rewCells{animal,day})
            tmpArcRew(animal,day) = corr(mArcAct{animal,day}(rewCells{animal,day}),nanmean(mRewAct{animal,day}(rewCells{animal,day},15:25),2));
            tmpArcPopR(animal,day) = corr(mArcAct{animal,day},nanmean(mRewAct{animal,day}(:,15:30),2));
        end
        
        tmpArcPopG(animal,day) = corr(mArcAct{animal,day},nanmean(mGratAct{animal,day}(:,15:30),2));
        
    end
end

figure; hold on
% plot_sem(tmpArcTone','g',0.2)
% plot_sem(tmpArcPuff','r',0.2)
% plot_sem(tmpArcRew','k',0.2)
plot_sem(tmpArcPopR','k',0.2)
plot_sem(tmpArcPopP','r',0.2)
plot_sem(tmpArcPopT','g',0.2)
plot_sem(tmpArcPopG','m',0.2)
line(xlim,[0 0],'color','k','LineStyle','--')
title('Act vs Arc Population Correlation')
legend('','RewAct','','PuffAct','','ToneAct')
xlabel('Day')
ylabel('Correlation')
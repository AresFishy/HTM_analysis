for day = 1:7
    for animal = 1:4
        hArchActCells{animal,day} = find(mArcAct{animal,day} > median(mArcAct{animal,day}) & mAct{animal,day} > mean(mAct{animal,day}));
        lArchActCells{animal,day} = find(mArcAct{animal,day} < median(mArcAct{animal,day}) & mAct{animal,day} > mean(mAct{animal,day}));
    end
end

%Combine cells across animals cells
cellList = [0 289 289+487 289+487+195];
chArchActCells = {};
clArchActCells = {};
for day = 1:7
    chArchActCells{day} = [];
    clArchActCells{day} = [];
    for animal = 1:4
        chArchActCells{day} = [chArchActCells{day}; hArchActCells{animal,day}+cellList(animal)'];
        clArchActCells{day} = [clArchActCells{day}; lArchActCells{animal,day}+cellList(animal)'];
    end
end

dayC = 1;
figure; %Trial activity
for day = 1:7
    subplot(2,4,day)
    plot_sem(cTrialAct{day}(chArchActCells{dayC},:)','k',0.5);
    plot_sem(cTrialAct{day}(clArchActCells{dayC},:)','r',0.5);
    axis tight
    ylim([-0.01 0.05])
end

figure; %Puff activity
for day = 1:7
    subplot(2,4,day)
    plot_sem(caPuffAct{day}(chArchActCells{dayC},:)','k',0.5);
    plot_sem(caPuffAct{day}(clArchActCells{dayC},:)','r',0.5);
    axis tight
    ylim([-0.01 0.05])
    line([10 10], ylim,'color','k','LineStyle','--')
    line(xlim,[0 0],'color','k','LineStyle','--')
    title(sprintf('Puff Activity day %d',day))
    legend('','hArchAct D1','','lArchAct D1')
    xlabel('Day')
    ylabel('dF/F')
end

figure; %Rew activity
for day = 1:7
    subplot(2,4,day)
    plot_sem(cRewAct{day}(chArchActCells{dayC},:)','k',0.5);
    plot_sem(cRewAct{day}(clArchActCells{dayC},:)','r',0.5);
    axis tight
    ylim([-0.01 0.05])
    line([10 10], ylim,'color','k','LineStyle','--')
    line(xlim,[0 0],'color','k','LineStyle','--')
    title(sprintf('Reward Activity day %d',day))
    legend('','hArchAct D1','','lArchAct D1')
    xlabel('Day')
    ylabel('dF/F')
end

figure; %Tone activity
for day = 1:7
    subplot(2,4,day)
    plot_sem(cToneAct{day}(chArchActCells{dayC},:)','k',0.5);
    plot_sem(cToneAct{day}(clArchActCells{dayC},:)','r',0.5);
    axis tight
    ylim([-0.01 0.05])
    line([10 10], ylim,'color','k','LineStyle','--')
    line(xlim,[0 0],'color','k','LineStyle','--')
    title(sprintf('Tone Activity day %d',day))
    legend('','hArchAct D1','','lArchAct D1')
    xlabel('Day')
    ylabel('dF/F')
end

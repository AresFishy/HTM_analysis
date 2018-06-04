%Plot the tone response of cells that increase or decrease in Arc during
%the session
figure;
for day = 1:7
    subplot(2,4,day)
    plot_sem(cToneAct{day}(cDownArc{day},:)','b',0.5)
    plot_sem(cToneAct{day}(cUpArc{day},:)','r',0.5)
    if day == 1
        title('Tone Response')
        legend('','DownArc','','UpArc')
    end
    ylabel('dF/F')
    xlabel('Frame #')
    axis tight;
    ylim([-0.005 0.01])
    line(xlim,[0 0],'color','k','LineStyle','--')
    line([10 10],ylim,'color','k','LineStyle','--')
end
subplot(2,4,8)
plot_sem([cToneAct{1}(cDownArc{1},:);cToneAct{2}(cDownArc{2},:);cToneAct{3}(cDownArc{3},:);cToneAct{4}(cDownArc{4},:);cToneAct{5}(cDownArc{5},:);cToneAct{6}(cDownArc{6},:);cToneAct{7}(cDownArc{7},:)]','b',0.5)
plot_sem([cToneAct{1}(cUpArc{1},:);cToneAct{2}(cUpArc{2},:);cToneAct{3}(cUpArc{3},:);cToneAct{4}(cUpArc{4},:);cToneAct{5}(cUpArc{5},:);cToneAct{6}(cUpArc{6},:);cToneAct{7}(cUpArc{7},:)]','r',0.5)
ylim([-0.005 0.01])
line(xlim,[0 0],'color','k','LineStyle','--')
line([10 10],ylim,'color','k','LineStyle','--')
title('Mean Tone Response')
legend('','DownArc','','UpArc')


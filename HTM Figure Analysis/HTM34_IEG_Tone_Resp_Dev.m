%Plot tone response for Low/Int/High Arc
figure;
subplot(121)
plot_sem([tone_respComb{2}(cLowArcCells,:); tone_respComb{3}(cLowArcCells,:)]' - ...
    mean2([tone_respComb{2}(cLowArcCells,20:30); tone_respComb{3}(cLowArcCells,20:30)]),'b',0.3)
plot_sem([tone_respComb{6}(cLowArcCells,:); tone_respComb{7}(cLowArcCells,:)]' - ...
    mean2([tone_respComb{6}(cLowArcCells,20:30); tone_respComb{7}(cLowArcCells,20:30)]),'--b',0.3)

% plot_sem([tone_respComb{2}(cIntArcCells,:); tone_respComb{3}(cIntArcCells,:)]' - ...
%     mean2([tone_respComb{2}(cIntArcCells,1:10); tone_respComb{3}(cIntArcCells,1:10)]),'g',0.3)
% plot_sem([tone_respComb{6}(cIntArcCells,:); tone_respComb{7}(cIntArcCells,:)]' - ...
%     mean2([tone_respComb{6}(cIntArcCells,1:10); tone_respComb{7}(cIntArcCells,1:10)]),'--g',0.3)

plot_sem([tone_respComb{2}(cArcCells,:); tone_respComb{3}(cArcCells,:)]' - ...
    mean2([tone_respComb{2}(cArcCells,20:30); tone_respComb{3}(cArcCells,20:30)]),'r',0.3)
plot_sem([tone_respComb{6}(cArcCells,:); tone_respComb{7}(cArcCells,:)]' - ...
    mean2([tone_respComb{6}(cArcCells,20:30); tone_respComb{7}(cArcCells,20:30)]),'--r',0.3)

plot_sem([tone_respComb{2}(arcCells,:); tone_respComb{3}(arcCells,:)]' - ...
    mean2([tone_respComb{2}(arcCells,20:30); tone_respComb{3}(arcCells,20:30)]),'k',0.3)
plot_sem([tone_respComb{6}(arcCells,:); tone_respComb{7}(arcCells,:)]' - ...
    mean2([tone_respComb{6}(arcCells,20:30); tone_respComb{7}(arcCells,20:30)]),'--k',0.3)
xlim([31 131]); ylim([-0.005 0.02]);
line(xlim,[0 0],'color','k'); line([51 51],ylim,'color','k');
ylabel('dF/F'); xlabel('Time [s]')
title('Tone Activity - Arc')
legend('','Low Arc Early','','Low Arc Late','','High Arc Early','','High Arc Late','','Population Early','','Population Late')
set(gca,'XTick',[31 41 51 61 71 81 91 101 111 121 131],'XTickLabel',{'-2','-1','0','1','2','3','4','5','6','7','8'})

%Plot tone response for Low/Int/High cfos
subplot(122)
plot_sem([tone_respComb{2}(cLowCfosCells,:); tone_respComb{3}(cLowCfosCells,:)]' - ...
    mean2([tone_respComb{2}(cLowCfosCells,20:30); tone_respComb{3}(cLowCfosCells,20:30)]),'b',0.3)
plot_sem([tone_respComb{6}(cLowCfosCells,:); tone_respComb{7}(cLowCfosCells,:)]' - ...
    mean2([tone_respComb{6}(cLowCfosCells,20:30); tone_respComb{7}(cLowCfosCells,20:30)]),'--b',0.3)

% plot_sem([tone_respComb{2}(cIntCfosCells,:); tone_respComb{3}(cIntCfosCells,:)]' - ...
%     mean2([tone_respComb{2}(cIntCfosCells,1:10); tone_respComb{3}(cIntCfosCells,1:10)]),'g',0.3)
% plot_sem([tone_respComb{6}(cIntCfosCells,:); tone_respComb{7}(cIntCfosCells,:)]' - ...
%     mean2([tone_respComb{6}(cIntCfosCells,1:10); tone_respComb{7}(cIntCfosCells,1:10)]),'--g',0.3)

plot_sem([tone_respComb{2}(cCfosCells,:); tone_respComb{3}(cCfosCells,:)]' - ...
    mean2([tone_respComb{2}(cCfosCells,20:30); tone_respComb{3}(cCfosCells,20:30)]),'r',0.3)
plot_sem([tone_respComb{6}(cCfosCells,:); tone_respComb{7}(cCfosCells,:)]' - ...
    mean2([tone_respComb{6}(cCfosCells,20:30); tone_respComb{7}(cCfosCells,20:30)]),'--r',0.3)

plot_sem([tone_respComb{2}(cfosCells,:); tone_respComb{3}(cfosCells,:)]' - ...
    mean2([tone_respComb{2}(cfosCells,20:30); tone_respComb{3}(cfosCells,20:30)]),'k',0.3)
plot_sem([tone_respComb{6}(cfosCells,:); tone_respComb{7}(cfosCells,:)]' - ...
    mean2([tone_respComb{6}(cfosCells,20:30); tone_respComb{7}(cfosCells,20:30)]),'--k',0.3)
xlim([31 131]); ylim([-0.005 0.02]);
line(xlim,[0 0],'color','k'); line([51 51],ylim,'color','k');
ylabel('dF/F'); xlabel('Time [s]')
title('Tone Activity - cFos')
legend('','Low cFos Early','','Low cFos Late','','High cFos Early','','High cFos Late','','Population Early','','Population Late')
set(gca,'XTick',[31 41 51 61 71 81 91 101 111 121 131],'XTickLabel',{'-2','-1','0','1','2','3','4','5','6','7','8'})
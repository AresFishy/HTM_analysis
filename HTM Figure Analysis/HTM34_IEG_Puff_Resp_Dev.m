%Plot puff response for Low/Int/High Arc
figure;
subplot(121)
plot_sem([puff_respComb{2}(cLowArcCells{2},:); puff_respComb{3}(cLowArcCells{3},:)]' - ...
    mean2([puff_respComb{2}(cLowArcCells{2},1:10); puff_respComb{3}(cLowArcCells{3},1:10)]),'b',0.3)
plot_sem([puff_respComb{6}(cLowArcCells{6},:); puff_respComb{7}(cLowArcCells{7},:)]' - ...
    mean2([puff_respComb{6}(cLowArcCells{6},1:10); puff_respComb{7}(cLowArcCells{7},1:10)]),'--b',0.3)

plot_sem([puff_respComb{2}(cIntArcCells{2},:); puff_respComb{3}(cIntArcCells{3},:)]' - ...
    mean2([puff_respComb{2}(cIntArcCells{2},1:10); puff_respComb{3}(cIntArcCells{3},1:10)]),'g',0.3)
plot_sem([puff_respComb{6}(cIntArcCells{6},:); puff_respComb{7}(cIntArcCells{7},:)]' - ...
    mean2([puff_respComb{6}(cIntArcCells{6},1:10); puff_respComb{7}(cIntArcCells{7},1:10)]),'--g',0.3)

plot_sem([puff_respComb{2}(cArcCells{2},:); puff_respComb{3}(cArcCells{3},:)]' - ...
    mean2([puff_respComb{2}(cArcCells{2},1:10); puff_respComb{3}(cArcCells{3},1:10)]),'r',0.3)
plot_sem([puff_respComb{6}(cArcCells{6},:); puff_respComb{7}(cArcCells{7},:)]' - ...
    mean2([puff_respComb{6}(cArcCells{6},1:10); puff_respComb{7}(cArcCells{7},1:10)]),'--r',0.3)

plot_sem([puff_respComb{2}(arcCells,:); puff_respComb{3}(arcCells,:)]' - ...
    mean2([puff_respComb{2}(arcCells,1:10); puff_respComb{3}(arcCells,1:10)]),'k',0.3)
plot_sem([puff_respComb{6}(arcCells,:); puff_respComb{7}(arcCells,:)]' - ...
    mean2([puff_respComb{6}(arcCells,1:10); puff_respComb{7}(arcCells,1:10)]),'--k',0.3)
xlim([40 70]); ylim([-0.002 0.02]);
line(xlim,[0 0],'color','k'); line([51 51],ylim,'color','k');
ylabel('dF/F'); xlabel('Frame #')
title('Puff Activity - Arc')
legend('','Low Arc Early','','Low Arc Late','','Mid Arc Early','','Mid Arc Late','','High Arc Early','','High Arc Late','','Population Early','','Population Late')

%Plot puff response for Low/Int/High cfos
subplot(122)
plot_sem([puff_respComb{2}(cLowCfosCells{2},:); puff_respComb{3}(cLowCfosCells{3},:)]' - ...
    mean2([puff_respComb{2}(cLowCfosCells{2},1:10); puff_respComb{3}(cLowCfosCells{3},1:10)]),'b',0.3)
plot_sem([puff_respComb{6}(cLowCfosCells{6},:); puff_respComb{7}(cLowCfosCells{7},:)]' - ...
    mean2([puff_respComb{6}(cLowCfosCells{6},1:10); puff_respComb{7}(cLowCfosCells{7},1:10)]),'--b',0.3)

plot_sem([puff_respComb{2}(cIntCfosCells{2},:); puff_respComb{3}(cIntCfosCells{3},:)]' - ...
    mean2([puff_respComb{2}(cIntCfosCells{2},1:10); puff_respComb{3}(cIntCfosCells{3},1:10)]),'g',0.3)
plot_sem([puff_respComb{6}(cIntCfosCells{6},:); puff_respComb{7}(cIntCfosCells{7},:)]' - ...
    mean2([puff_respComb{6}(cIntCfosCells{6},1:10); puff_respComb{7}(cIntCfosCells{7},1:10)]),'--g',0.3)

plot_sem([puff_respComb{2}(cCfosCells{2},:); puff_respComb{3}(cCfosCells{3},:)]' - ...
    mean2([puff_respComb{2}(cCfosCells{2},1:10); puff_respComb{3}(cCfosCells{3},1:10)]),'r',0.3)
plot_sem([puff_respComb{6}(cCfosCells{6},:); puff_respComb{7}(cCfosCells{7},:)]' - ...
    mean2([puff_respComb{6}(cCfosCells{6},1:10); puff_respComb{7}(cCfosCells{7},1:10)]),'--r',0.3)

plot_sem([puff_respComb{2}(cfosCells,:); puff_respComb{3}(cfosCells,:)]' - ...
    mean2([puff_respComb{2}(cfosCells,1:10); puff_respComb{3}(cfosCells,1:10)]),'k',0.3)
plot_sem([puff_respComb{6}(cfosCells,:); puff_respComb{7}(cfosCells,:)]' - ...
    mean2([puff_respComb{6}(cfosCells,1:10); puff_respComb{7}(cfosCells,1:10)]),'--k',0.3)
xlim([40 70]); ylim([-0.002 0.02]);
line(xlim,[0 0],'color','k'); line([51 51],ylim,'color','k');
ylabel('dF/F'); xlabel('Frame #')
title('Puff Activity - cFos')
legend('','Low cFos Early','','Low cFos Late','','Mid cFos Early','','Mid cFos Late','','High cFos Early','','High cFos Late','','Population Early','','Population Late')

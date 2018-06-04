ele = 11;
day = 8;
figure;
subplot(211)
if ele < 6
    imagesc(seqActBinComb1{day}(selCellsComb{day,ele},:)); set(gca,'clim',[1 1.1])
else
    imagesc(seqActBinComb2{day}(selCellsComb{day,ele},:)); set(gca,'clim',[1 1.1])
end
subplot(212)
if ele < 6
    plotSEM(seqActBinComb1{day}(selCellsComb{day,ele},:)');
else
    plotSEM(seqActBinComb2{day}(selCellsComb{day,ele},:)');
end
ylim([1 1.1])
line([1 1],get(gca,'ylim'),'color','k')
line([7 7],get(gca,'ylim'),'color','k')
line([13 13],get(gca,'ylim'),'color','k')
line([19 19],get(gca,'ylim'),'color','k')
line([25 25],get(gca,'ylim'),'color','k')
line([31 31],get(gca,'ylim'),'color','r')


%% Plot the time dependence of the element respons specificity
cnt = 0;
for ele = 1:5;
    cnt = cnt + 1;
    str = sprintf('Element %d',ele);
    for day = [1,6];
        subplot(2,3,cnt)
        hold on
        if ele < 6
            plotSEM(seqActBinComb1{day}(selCellsComb{day,ele},:)');
        else
            plotSEM(seqActBinComb2{day}(selCellsComb{day,ele},:)');
        end
    end
    axis tight;
    title(str)
    xlabel('Time bin #')
    ylabel('dF/F')
    legend('Day 6','Day 1')
    ylim([1 1.1])
    line([2 2],get(gca,'ylim'),'color','k')
    line([8 8],get(gca,'ylim'),'color','k')
    line([14 14],get(gca,'ylim'),'color','k')
    line([20 20],get(gca,'ylim'),'color','k')
    line([26 26],get(gca,'ylim'),'color','k')
    line([30 30],get(gca,'ylim'),'color','b')
    line([36 36],get(gca,'ylim'),'color','r')
end

%%
%Plot mean activity across all responsive cells for all elements
for day = 1:6
     combSeqActBin{day} = [];
    for ele = 6:10
        if ele < 6
            combSeqActBin{day} = [combSeqActBin{day};seqActBinComb2{day}(selCellsComb{day,ele},:)];
        else
            combSeqActBin{day} = [combSeqActBin{day};seqActBinComb2{day}(selCellsComb{day,ele},:)];
        end
    end
    plotSEM(combSeqActBin{day}');
    hold on
end
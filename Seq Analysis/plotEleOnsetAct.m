%Plot the activity of the responsive cells to each element
figure;
for ele = 1:10;
    if ele < 6;
        str = sprintf('Seq1 Element %d',ele);
    else
        str = sprintf('Seq2 Element %d',ele-5);
    end
    subplot(2,5,ele)
    for i = 1:8;
        plotSEM(OnsetActComb{i,ele}(selCellsComb{i,ele},:)')
        hold on
        ylim([-0.01 0.04])
    end
    
    title(str)
    ylabel('dF/F')
    xlabel('Frame #')
    line([15 15],get(gca,'ylim'),'color','k')
    refline([0 0])
end

figure;
%Plot the activity of the responsive cells to combinations
for ele = 12:17;
    if ele < 14;
        str = sprintf('Seq %d Tones',ele - 11);
    else
        str = sprintf('Seq %d Gratings',ele-14);
    end
    subplot(2,3,ele-11)
    for i = 1:8;
        plotSEM(OnsetActComb{i,ele}(selCellsComb{i,ele},:)')
        hold on
    end
    
    title(str)
    if ele == 14
        title('All Tones')
    elseif ele == 17
        title('All Gratings')
    end
    ylabel('dF/F')
    xlabel('Frame #')
    ylim([-0.01 0.04])
    line([15 15],get(gca,'ylim'),'color','k')
    refline([0 0])
end
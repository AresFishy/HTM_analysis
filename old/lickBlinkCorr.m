%Lick correlation to activity

for day  = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            for cell = 1:size(act{animal,day},1)
                tmpCorr = corrcoef(act{animal,day}(cell,:),Lick{animal,day});
                lickCorr{animal,day}(cell) = tmpCorr(1,2);
            end
            lickCells{animal,day} = find(lickCorr{animal,day} > 0.3);
        end
    end
    bar(day,length(horzcat(lickCells{:,day}))/1735,'k'); hold on
end

ylim([0 1])
title('Fraction of cells that correlate (> 0.3) with licking')
ylabel('Fraction')
xlabel('Day')

%%
%Blink correlation to activity

for day  = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
        for cell = 1:size(act{animal,day},1)
            tmpCorr = corrcoef(act{animal,day}(cell,:),-blink{animal,day});
            blinkCorr{animal,day}(cell) = tmpCorr(1,2);
        end
        blinkCells{animal,day} = find(blinkCorr{animal,day} > 0.2);
        end
    end
    blinkCellsComb{day} = horzcat(blinkCells{:,day});
    bar(day,length(horzcat(blinkCells{:,day}))/1735,'k'); hold on
end

ylim([0 1])
title('Fraction of cells that correlate (> 0.2) with blinking')
ylabel('Fraction')
xlabel('Day')
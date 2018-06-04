%Switch in response 

%-------------------------------------------------------------------------%
                            %Fraction of cells
%-------------------------------------------------------------------------%
for day = 1:7
    for ele = 1:10
        eles = setdiff([1:10],ele);
        for ele2 = 1:9
            switchCells(day,ele,eles(ele2)) = length(intersect(selCellsComb{day,ele},selCellsComb{day+1,eles(ele2)}));
            switchCellsFrac(day,ele,eles(ele2)) = switchCells(day,ele,eles(ele2)) / length(selCellsComb{day,ele});
        end
    end
end

gratings = [1 3 6 7];
tones = [2 4 8 9];


switchCellsFracComb = squeeze(mean(switchCellsFrac,1));
tmpGG = switchCellsFracComb(gratings,gratings); %Overlap from grating to grating
tmpGT = switchCellsFracComb(gratings,tones);    %Overlap from grating to tone
tmpTT = switchCellsFracComb(tones,tones);       %Overlap from tone to tone
tmpTG = switchCellsFracComb(tones,gratings);    %Overlap from tone to grating
%Get mean without including the diagonal of zeros
switchCellsFracGG = mean(tmpGG(tmpGG > 0));     
switchCellsFracGT = mean(tmpGT(tmpGT > 0));
switchCellsFracTT = mean(tmpTT(tmpTT > 0));
switchCellsFracTG = mean(tmpTG(tmpTG > 0));
%Get standard deviation without including the diagonal of zeros
switchCellsFracGGstd = std(tmpGG(tmpGG > 0));
switchCellsFracGTstd = std(tmpGT(tmpGT > 0));
switchCellsFracTTstd = std(tmpTT(tmpTT > 0));
switchCellsFracTGstd = std(tmpTG(tmpTG > 0));

figure;
subplot(121)
bar(1,switchCellsFracGG,'k'); hold on
errorbar(1,switchCellsFracGG,switchCellsFracGGstd/6)
bar(2,switchCellsFracGT,'r')
errorbar(2,switchCellsFracGT,switchCellsFracGTstd/6)
ylim([0 0.1])
set(gca,'XTick',[1 2],'XTickLabel',{'GG','GT'})
ylabel('Overlap Fraction')
title('Overlap in cells dependent on stimulus type')
subplot(122)
bar(1,switchCellsFracTT,'k'); hold on
errorbar(1,switchCellsFracTT,switchCellsFracTTstd/6)
bar(2,switchCellsFracTG,'r')
errorbar(2,switchCellsFracTG,switchCellsFracTGstd/6)
ylim([0 0.1])
set(gca,'XTick',[1 2],'XTickLabel',{'TT','TG'})
ylabel('Overlap Fraction')

%%
%-------------------------------------------------------------------------%
                            %Activity of cells to other elements
%-------------------------------------------------------------------------%
tmpSwitchAct = [];
for day = 1:7
    for ele = 1:10
        eles = setdiff([1:10],ele);
        for ele2 = 1:9
            tmpSwitchAct(day,ele,eles(ele2),:) = nanmean(OnsetActComb{day,eles(ele2)}(selCellsComb{day,ele},:));
        end
    end
end
    
switchAct = squeeze(mean(tmpSwitchAct,1));
figure;

subplot(121)
plot(squeeze(mean(mean(switchAct(gratings,gratings,:))))'); hold on
plot(squeeze(mean(mean(switchAct(gratings,tones,:))))')
legend({'Grat-Grat','Grat-Tone'})
ylim([-0.005 0.01])
line([15 15],get(gca,'ylim'),'color','k')
refline([0 0])
title('Response of cells on same day to other elements based on stim. type')
ylabel('dF/F')
xlabel('Frame #')


subplot(122)
plot(squeeze(mean(mean(switchAct(tones,tones,:))))'); hold on
plot(squeeze(mean(mean(switchAct(tones,gratings,:))))')
ylim([-0.005 0.01])
line([15 15],get(gca,'ylim'),'color','k')
refline([0 0])
legend({'Tone-Tone','Tone-Grat'})
ylabel('dF/F')
xlabel('Frame #')





















day = 8;

figure;
plotSEM(OnsetActCombNoOM{day,4}(selCellsComb{day,4},:)'); hold on
plotSEM(OnsetActCombOM{day,11}(selCellsComb{day,4},:)')
axis tight;
ylim([-.02 0.05])
line([15 15],get(gca,'ylim'),'color','k')
refline([0 0])
title('Response of element 9 cells to element 4 - Day 8 (2)')
legend('Omission','No Omission')


%%
%Find omission sequences
for day = 1:8
    for animal = 1:6
        [omX,omY] = find(seqSig1{animal,day} > 0.2 & seqSig1{animal,day} < 0.3);
        omOnset{animal,day} = unique(omX);
        nonomOnset{animal,day} = setdiff([1:size(seqAct1{animal,day},2)],omOnset{animal,day});
    end
end

%%

for animal = 1:6;
day = 8;
subplot(3,2,animal)
plotSEM(squeeze(nanmean(seqAct1{animal,day}(actCorrCell1{animal,day},nonomOnset{animal,day},:),1))');
hold on
plotSEM(squeeze(nanmean(seqAct1{animal,day}(actCorrCell1{animal,day},omOnset{animal,day},:),1))');
ylim([1 1.1])
line([10 10],get(gca,'ylim'),'color','k')
line([40 40],get(gca,'ylim'),'color','k')
line([70 70],get(gca,'ylim'),'color','k')
line([100 100],get(gca,'ylim'),'color','k')
line([130 130],get(gca,'ylim'),'color','k')
line([150 150],get(gca,'ylim'),'color','b')
line([180 180],get(gca,'ylim'),'color','r')
end
%Plot correlation of cell vectors for consecutive/non-consecutive trials

figure;
subplot(221)
imagesc(corrcoef(conseqSeqActCombR{1},'rows','complete'))
set(gca,'clim',[0 1])
title('consecReward')
ylabel('Frame #')
xlabel('Frame #')

subplot(222)
imagesc(corrcoef(nonseqSeqActCombR{1},'rows','complete'))
set(gca,'clim',[0 1])
title('nonsecReward')
ylabel('Frame #')
xlabel('Frame #')

subplot(223)
imagesc(corrcoef(conseqSeqActCombP{1},'rows','complete'))
set(gca,'clim',[0 1])
title('consecPuff')
ylabel('Frame #')
xlabel('Frame #')

subplot(224)
imagesc(corrcoef(nonseqSeqActCombP{1},'rows','complete'))
set(gca,'clim',[0 1])
title('nonsecPuff')
ylabel('Frame #')
xlabel('Frame #')

%%
day = 1;

figure;
subplot(121)
plotSEM(conseqSeqActCombR{day}(combCells{day},:)')
plotSEM(nonseqSeqActCombR{day}(combCells{day},:)')
legend({'nonsec Rew','consec Rew'})
ylabel('dF/F')
xlabel('Frame #')
subplot(122)
plotSEM(conseqSeqActCombP{day}(combCells{day},:)')
plotSEM(nonseqSeqActCombP{day}(combCells{day},:)')
legend({'nonsec Puff','consec Puff'})
ylabel('dF/F')
xlabel('Frame #')
%%
for day = 1:8
    tmpConR(day,:) = nanmean(conseqSeqActCombR{day}(combCells{day},:),1);
    tmpNonR(day,:) = nanmean(nonseqSeqActCombR{day}(combCells{day},:),1);
    tmpConP(day,:) = nanmean(conseqSeqActCombP{day}(combCells{day},:),1);
    tmpNonP(day,:) = nanmean(nonseqSeqActCombP{day}(combCells{day},:),1);
end

figure;
subplot(121)
plotSEM(tmpConR')
plotSEM(tmpNonR')
legend({'nonsec Rew','consec Rew'})
ylabel('dF/F')
xlabel('Frame #')
title('Seq Act of Responsive Cells')
subplot(122)
plotSEM(tmpConP')
plotSEM(tmpNonP')
legend({'nonsec Puff','consec Puff'})
ylabel('dF/F')
xlabel('Frame #')
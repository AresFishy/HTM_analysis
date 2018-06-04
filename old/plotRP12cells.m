a = find(cellMat(1,:,4) == 1 & sum(cellMat(1,:,:),3) == 1);

subplot(221)
plot(seqActCombRew1{1}(a,:)'); hold on
plot(nanmean(seqActCombRew1{1}(a,:))','k')
title('Puff1 Cells')
xlabel('Rew1 Act')
ylim([0.9 2])

subplot(222)
plot(seqActCombRew2{1}(a,:)'); hold on
plot(nanmean(seqActCombRew2{1}(a,:))','k')
xlabel('Rew2 Act')
ylim([0.9 2])

subplot(223)
plot(seqActCombPuff1{1}(a,:)'); hold on
plot(nanmean(seqActCombPuff1{1}(a,:))','k')
xlabel('Puff1 Act')
ylim([0.9 2])

subplot(224)
plot(seqActCombPuff2{1}(a,:)'); hold on
plot(nanmean(seqActCombPuff2{1}(a,:))','k')
xlabel('Puff2 Act')
ylim([0.9 2])

%%
%for day = 1:8;
day = 1;

subplot(121)
plotSEM(OnsetActCombR{day}(puffCellsComb{day},:)','k'); hold on
plotSEM(OnsetActCombR{day}(puffCellsNComb{day},:)','b');
plotSEM(OnsetActCombR{day}(rewCellsComb{day},:)','r')
plotSEM(OnsetActCombR{day}(rewCellsNComb{day},:)','y')
refline([0 0])
xlim([1 31])
ylim([-0.1 0.35])
line([11 11],get(gca,'ylim'),'color','k')
legend({'RewN cells','PuffN Cells','Puff Cells','Rew Cells'})
title('Reward Trials')
ylabel('dF/F')
xlabel('Frame #')

subplot(122)
plotSEM(OnsetActCombP{day}(puffCellsComb{day},:)','k'); hold on
plotSEM(OnsetActCombP{day}(puffCellsNComb{day},:)','b');
plotSEM(OnsetActCombP{day}(rewCellsComb{day},:)','r')
plotSEM(OnsetActCombP{day}(rewCellsNComb{day},:)','y')
refline([0 0])
xlim([1 31])
ylim([-0.1 0.35])
line([11 11],get(gca,'ylim'),'color','k')
legend({'RewN cells','PuffN Cells','Puff Cells','Rew Cells'})
title('Puff Trials')
ylabel('dF/F')
xlabel('Frame #')
%end

%%
figure;
subplot(121)
plotSEM(seqActCombRew{1}(rewCellsComb{1},:)','k')
plotSEM(seqActCombRew{1}(rewCellsNComb{1},:)','b')
plotSEM(seqActCombRew{1}(puffCellsComb{1},:)','r')
plotSEM(seqActCombRew{1}(puffCellsNComb{1},:)','g')
legend({'puffN','rewN','rew','puff'})
xlabel('Frame #')
ylabel('dF/F')
title('Reward trial activity')
subplot(122)
plotSEM(seqActCombPuff{1}(rewCellsComb{1},:)','k')
plotSEM(seqActCombPuff{1}(rewCellsNComb{1},:)','b')
plotSEM(seqActCombPuff{1}(puffCellsComb{1},:)','r')
plotSEM(seqActCombPuff{1}(puffCellsNComb{1},:)','g')
legend({'puffN','rewN','rew','puff'})
xlabel('Frame #')
ylabel('dF/F')
title('Puff trial activity')


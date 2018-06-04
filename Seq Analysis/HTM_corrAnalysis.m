tp_fix=1;
stim_ind=1;
corrActComb=[];

for tp=1:6
corrActComb(:,tp) = nanmean(OnsetActComb{tp,stim_ind}(selCellsComb{tp_fix,stim_ind},:),2);
end

figure;imagesc(corr(corrActComb));
colorbar
colormap jet
set(gca,'clim',[-0.2 0.3])
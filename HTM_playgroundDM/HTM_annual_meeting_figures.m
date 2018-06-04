
%extract ieg data
[sel2, sel3, IEG_exp, IEG_diff, IEG_exp_mat, IEG_diff_mat] = HTM_IEG_normalization(proj_meta,siteIDs);

%calculate mean activity
[mean_act_cell, mean_act] = HTM_meanAct(proj_meta,siteIDs);

%calculate maximum activity
[max_act_cell, max_act] = HTM_maxAct(proj_meta,siteIDs);



%%

days=1:7;
tps_exp=1:2:13;
tps_act=2:2:14;
siteIDs=1:9;

tmp_mAct={};
tmp_maxAct={};
temp_mExp={};
tmp_mExp={};
temp_corr=[];
tps_act=1:7;
tps_exp=1:2:13;
for tp=tps_act
    for siteID=1:9
        tmp_mAct{siteID}(:,tp)=nanmean((mean_act_cell{siteID}(:,tp)),2);
        tmp_maxAct{siteID}(:,tp)=nanmean((max_act_cell{siteID}(:,tp)),2);
        temp_mExp{siteID}(:,tp)=nanmean(IEG_exp{siteID}(:,:,tp),2);
        temp_corr(siteID,tp,1)=corr(temp_mExp{siteID}(:,tp),tmp_mAct{siteID}(:,tp),'rows','complete');
        temp_corr(siteID,tp,2)=corr(temp_mExp{siteID}(:,tp),tmp_maxAct{siteID}(:,tp),'rows','complete');
    end
end

figure;

subplot(1,3,1);hold on
for ind=1:4
    plot(nanmean(temp_mExp{ind},2),nanmean(tmp_mAct{ind},2),'.')
    xlim([-0.05 4]); ylim([0.993 1.2])
end
title('mean Arc / mean act');

subplot(1,3,2);hold on
for ind=1:4
    plot(nanmean(temp_mExp{ind},2),nanmean(tmp_maxAct{ind},2),'.')
    xlim([-0.05 4]); ylim([0.993 4.5])
end
title('mean Arc / max act');

subplot(1,3,3);hold on
y=[(nanmean(temp_corr(1:4,:,1),2)) (nanmean(temp_corr(1:4,:,2),2))];
boxplot(y)
plot(1,nanmean(temp_corr(1:4,:,1),2),'g+')
plot(2,nanmean(temp_corr(1:4,:,2),2),'g+')
ylim([0 0.6])
[r,p]=ttest(nanmean(temp_corr(1:4,:,1),2),nanmean(temp_corr(1:4,:,2),2))



figure;

for ind=5:9
 subplot(1,3,1);hold on
    plot(nanmean(temp_mExp{ind},2),nanmean(tmp_mAct{ind},2),'.')
    xlim([-0.05 4]); ylim([0.993 1.2])
end
title('mean cfos / mean act');
for ind=5:9
 subplot(1,3,2);hold on
    plot(nanmean(temp_mExp{ind},2),nanmean(tmp_maxAct{ind},2),'.')
    xlim([-0.05 4]); ylim([0.993 4.5])
end
title('mean cfos / max act');

subplot(1,3,3);hold on
y=[(nanmean(temp_corr(5:9,:,1),2)) (nanmean(temp_corr(5:9,:,2),2))];
boxplot(y)
plot(1,nanmean(temp_corr(5:9,:,1),2),'g+')
plot(2,nanmean(temp_corr(5:9,:,2),2),'g+')
ylim([0 0.6])
[r,p]=ttest(nanmean(temp_corr(5:9,:,1),2),nanmean(temp_corr(5:9,:,2),2))





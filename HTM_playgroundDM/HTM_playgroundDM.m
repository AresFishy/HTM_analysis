function []=HTM_playgroundDM

days=1:7;
tps_exp=1:2:13;
tps_act=2:2:14;
siteIDs=1:9;
Sites={1:4;5:9};

%concatenate data
[act, airPuff, lickL, lickR, grat, tone, rewL, rewR, blink, pupilD, puffON, aPuffON, pPuffON, rewLON, rewRON, rewON, pRewON, aRewLON, pRewLON, aRewRON,...
 pRewRON, tone1ON, tone2ON, toneON, grat1ON, grat2ON, gratON, gratOFF] = HTM34_concatenate_data(proj_meta);

%extract ieg data
[sel, sel2, sel3, ieg_exp, ieg_diff_cell, ieg_exp_mat, ieg_exp_cell, ieg_diff_mat]=HTM34_normalization(proj_meta,siteIDs);

%generate onset data to select responsive cells
[toneAct, tone1Act, tone2Act, mToneAct, mTone1Act, mTone2Act, cToneAct, cTone1Act, cTone2Act, gratAct,...
 grat1Act, grat2Act, mGratAct, mGrat1Act, mGrat2Act, cGratAct, cGrat1Act, cGrat2Act, puffAct, mPuffAct,...
 cPuffAct, aPuffAct, maPuffAct, caPuffAct, pPuffAct, mpPuffAct, cpPuffAct, rewAct, mRewAct, cRewAct, pRewAct,...
 mpRewAct, cpRewAct] = HTM34_OnsetAct(proj_meta, act, toneON, tone1ON, tone2ON, gratON, grat1ON, grat2ON, aPuffON, pPuffON, rewON, pRewON);

%extract responsive cells to stimuli (selected on half of the trials)
[toneCells, ntoneCells, cToneCells, cnToneCells, cTone1Cells, cTone2Cells, gratCells, ngratCells, cGratCells, cnGratCells, rewCells, nrewCells, cRewCells, cnRewCells,...
 puffCells, npuffCells, cPuffCells, cnPuffCells] = HTM34_respCells(act, toneAct, tone1Act, tone2Act, gratAct, aPuffAct, rewAct);
 
%generate stimulus onset data for analysis
[tone_resp, tone_respMean, tone_respMeanHalf, tone_respPA, tone_respPAMean, tone_respPAMeanHalf,...
 tone_respPP, tone_respPPMean, tone_respPPMeanHalf, tone_respR, tone_respRMean, tone_respRMeanHalf,... 
 puff_resp, puff_respMean, puff_respMeanHalf, puff_respAct, puff_respActMean, puff_respActMeanHalf,...
 rew_resp, rew_respMean, rew_respMeanHalf, rew_respAct, rew_respActMean, rew_respActMeanHalf,...
 grat_resp, grat_respMean, grat_respMeanHalf, lickPuff, lickPuffMean, lickRew, lickRewMean,...
 tone_respComb, tone_respPAComb, tone_respPPComb, tone_respRComb,...
 grat_respComb, puff_respComb, puff_respActComb, rew_respComb, rew_respActComb, lickPuffComb, lickRewComb,...
 tone_respCombHalf, grat_respCombHalf, puff_respCombHalf, rew_respCombHalf] = HTM34_OnsetAct_MD(proj_meta);

%generate onset responses
[grat, tone_onset, tone1, tone2, apuff, ppuff, rewRight, rewLeft, reward] = HTM_onset_resp(proj_meta,siteIDs);

%calculate mean activity
[mean_act_cell, mean_act] = HTM_meanAct(proj_meta,siteIDs);

%calculate maximum activity
[max_act_cell, max_act] = HTM_maxAct(proj_meta,siteIDs);




%%
%plot corr of mean ieg exp
tmp_corr=[];
for siteID=1:9
    for tp=1:7
        tmp_ieg{siteID}(:,tp)=ieg_exp_cell{siteID,tp};
    end
    tmp_corr(siteID,:,:,1)=corr(tmp_ieg{siteID},'rows','complete','type','Spearman');
    tmp_corr(siteID,:,:,2)=corr(tmp_ieg{siteID},'rows','complete','type','Pearson');
end

%plot Kendall's tau of mean ieg expression
figure;imagesc(squeeze(nanmean(tmp_corr(1:4,:,:,1))))
set(gca,'clim',[0 1]);
colormap jet; colorbar
figure;imagesc(squeeze(nanmean(tmp_corr(5:9,:,:,1))))
set(gca,'clim',[0 1]);
colormap jet; colorbar

%plot Pearson corr coeff of ieg expression
figure;imagesc(squeeze(nanmean(tmp_corr(1:4,:,:,2))))
set(gca,'clim',[0 1]);
colormap jet; colorbar
figure;imagesc(squeeze(nanmean(tmp_corr(5:9,:,:,2))))
set(gca,'clim',[0 1]);
colormap jet; colorbar


%%
%plot corr of diff ieg exp
tmp_corr=[];
for siteID=1:9
    tmp_corr(siteID,:,:,1)=corr(ieg_diff_cell{siteID},'rows','complete','type','Spearman');
    tmp_corr(siteID,:,:,2)=corr(ieg_diff_cell{siteID},'rows','complete','type','Pearson');
end

%plot Kendall's tau of mean ieg expression
figure;imagesc(squeeze(nanmean(tmp_corr(1:4,:,:,1))))
set(gca,'clim',[0 1]);
colormap jet; colorbar
figure;imagesc(squeeze(nanmean(tmp_corr(5:9,:,:,1))))
set(gca,'clim',[0 1]);
colormap jet; colorbar

%plot Pearson corr coeff of ieg expression
figure;imagesc(squeeze(nanmean(tmp_corr(1:4,:,:,2))))
set(gca,'clim',[0 1]);
colormap jet; colorbar
figure;imagesc(squeeze(nanmean(tmp_corr(5:9,:,:,2))))
set(gca,'clim',[0 1]);
colormap jet; colorbar

x=diag(squeeze(nanmean(tmp_corr(1:4,:,:,2))));
[p,h]=signrank(x(2:3),x(6:7))

x=diag(squeeze(nanmean(tmp_corr(5:9,:,:,2))));
[p,h]=signrank(x(2:3),x(6:7))

%%
%plot onset resps

figure;
tps_act=2:2:14;
cnt=0;
x=1:201;
y=[];
quant_win=52:70;
tmp_quant={};
t={'high Arc','high cfos','population'};
for jnd=[1:2]
    if jnd==1
        sel_1=logical(sel2(:,1));
%         sel_1=cArcCells;
%         sel_2=logical(sel2(:,3));
        sel_ones=zeros(3090,1);
        sel_ones(1:1271,1)=1;
%         sel_3=logical(sel_ones-sel2(:,1)-sel2(:,3));
        sel_3=logical(sel_ones-sel2(:,1));
    elseif jnd==2
        sel_1=logical(sel2(:,2));
%         sel_1=cCfosCells;
%         sel_2=logical(sel2(:,4));
        sel_ones=zeros(3090,1);
        sel_ones(1272:3090,1)=1;
%         sel_3=logical(sel_ones-sel2(:,2)-sel2(:,4));
        sel_3=logical(sel_ones-sel2(:,2));
    elseif jnd==3
        sel_c=logical(sel(3,:)-sel(1,:)-sel(2,:));
    end
    cnt=cnt+1;
    subplot(1,2,cnt);hold on
    clrind='brkg';
    for ind=[1]
        if ind==1
            mat=tone_onset;
            sta=1;
            sto=0;
            mat=[];
%             for siteID=siteIDs
%                 sto=sto+size(tone_respMean{siteID},1);
%                 mat(sta:sto,:,2:2:14) = tone_respMean{siteID}(:,:,1:7);
%                 sta=sta+size(tone_respRMean{siteID},1);
%             end
            for tp_tmp=1:7
                mat(:,:,tp_tmp*2) = tone_respComb{tp_tmp};
            end
%             
            sub_win=40:49;
        elseif ind==2
            mat=reward;
            sub_win=45:49;
        elseif ind==3
            mat=apuff;
            sub_win=45:49;
        elseif ind==4
            mat=grat;
            sub_win=40:49;
        end
        tps=6:7;
%         sub_win=40:45
%high IEG response
        y=nanmean(nanmean(mat(sel_1,:,[tps_act(tps)]) - nanmean(mat(sel_1,sub_win,[tps_act(tps)]),2),3),1);
        s=nanSEM(nanmean(mat(sel_1,:,[tps_act(tps)]) - nanmean(mat(sel_1,sub_win,[tps_act(tps)]),2),3),1);
        shadedErrorBar(x,y,s,{'color','b','linestyle','--','linewidth',2});
     
        tps=2:3;
        y2=nanmean(nanmean(mat(sel_1,:,[tps_act(tps)]) - nanmean(mat(sel_1,sub_win,[tps_act(tps)]),2),3),1);
        s2=nanSEM(nanmean(mat(sel_1,:,[tps_act(tps)]) - nanmean(mat(sel_1,sub_win,[tps_act(tps)]),2),3),1);
        shadedErrorBar(x,y2,s2,{'color','r','linestyle','-','linewidth',2});
        
        tmp_quant{jnd} = NaN(sum(sel_3),2);
        tps=6:7;
        yy = nanmean(bsxfun(@minus,mat(sel_1,:,[tps_act(tps)]),nanmean(mat(sel_1,sub_win,[tps_act(tps)]),2)),3);
        tmp_quant{jnd}(1:sum(sel_1),1) = nanmean(yy(:,quant_win),2);
        tps=2:3;
        yy2 =  nanmean(bsxfun(@minus,mat(sel_1,:,[tps_act(tps)]),nanmean(mat(sel_1,sub_win,[tps_act(tps)]),2)),3);
        tmp_quant{jnd}(1:sum(sel_1),2) = nanmean(yy2(:,quant_win),2);
        
%low IEG response
%         tps=6:7;
%         y=nanmean(nanmean(bsxfun(@minus,mat(sel_2,:,[tps_act(tps)]),nanmean(mat(sel_2,sub_win,[tps_act(tps)]),2)),3),1);
%         s=nanSEM(nanmean(bsxfun(@minus,mat(sel_2,:,[tps_act(tps)]),nanmean(mat(sel_2,sub_win,[tps_act(tps)]),2)),3),1);
%         shadedErrorBar(x,y,s,{'color','r','linestyle','--','linewidth',2});
%      
%         tps=2:3;
%         y2=nanmean(nanmean(bsxfun(@minus,mat(sel_2,:,[tps_act(tps)]),nanmean(mat(sel_2,sub_win,[tps_act(tps)]),2)),3),1);
%         s2=nanSEM(nanmean(bsxfun(@minus,mat(sel_2,:,[tps_act(tps)]),nanmean(mat(sel_2,sub_win,[tps_act(tps)]),2)),3),1);
%         shadedErrorBar(x,y2,s2,{'color','r','linestyle','-','linewidth',2});
  
%remain. pop. response
        tps=6:7;
        y=nanmean(nanmean(bsxfun(@minus,mat(sel_3,:,[tps_act(tps)]),nanmean(mat(sel_3,sub_win,[tps_act(tps)]),2)),3),1);
        s=nanSEM(nanmean(bsxfun(@minus,mat(sel_3,:,[tps_act(tps)]),nanmean(mat(sel_3,sub_win,[tps_act(tps)]),2)),3),1);
        shadedErrorBar(x,y,s,{'color','k','linestyle','--','linewidth',2});
     
        tps=2:3;
        y2=nanmean(nanmean(bsxfun(@minus,mat(sel_3,:,[tps_act(tps)]),nanmean(mat(sel_3,sub_win,[tps_act(tps)]),2)),3),1);
        s2=nanSEM(nanmean(bsxfun(@minus,mat(sel_3,:,[tps_act(tps)]),nanmean(mat(sel_3,sub_win,[tps_act(tps)]),2)),3),1);
        shadedErrorBar(x,y2,s2,{'color','g','linestyle','-','linewidth',2});
        
        tmp_quant{jnd+2} = NaN(sum(sel_3),2);
        tps=6:7;
        yy = nanmean(bsxfun(@minus,mat(sel_3,:,[tps_act(tps)]),nanmean(mat(sel_3,sub_win,[tps_act(tps)]),2)),3);
        tmp_quant{jnd+2}(:,1) = nanmean(yy(:,quant_win),2);
        tps=2:3;
        yy2 = nanmean(bsxfun(@minus,mat(sel_3,:,[tps_act(tps)]),nanmean(mat(sel_3,sub_win,[tps_act(tps)]),2)),3);
        tmp_quant{jnd+2}(:,2) = nanmean(yy2(:,quant_win),2);
        
    end
    set(gca,'xlim',[40 130]);
    set(gca,'ylim',[-0.004 0.021]);
    line([0 200],[0 0],'color','k');
    line([50 50],[0 0.6],'color','k');
    ylabel('Mean dF/F','FontWeight','bold','FontSize',14);
    xlabel('Time [s]','FontWeight','bold','FontSize',14);
    set(gca,'XTick',[0:10:200]);
    set(gca,'XTickLabel',{-5:1:15},'FontSize',14);
    title(t{jnd});
end

%quantification
figure;hold on
% boxplot([tmp_quant{1}(:,2) tmp_quant{1}(:,1) tmp_quant{3}(:,2) tmp_quant{3}(:,1)]) 
y = [nanmean(tmp_quant{1}(:,2)) nanmean(tmp_quant{1}(:,1)) nanmean(tmp_quant{3}(:,2)) nanmean(tmp_quant{3}(:,1))];
s = [nanSEM(tmp_quant{1}(:,2)) nanSEM(tmp_quant{1}(:,1)) nanSEM(tmp_quant{3}(:,2)) nanSEM(tmp_quant{3}(:,1))];
superbar(y,'e',s) 
plot(1,tmp_quant{1}(:,2),'k+'); plot(2,tmp_quant{1}(:,1),'k+'); plot(3,tmp_quant{3}(:,2),'k+'); plot(4,tmp_quant{3}(:,1),'k+');

[h,p] = ttest(tmp_quant{1}(:,2), tmp_quant{1}(:,1))
[h,p] = ttest(tmp_quant{3}(:,2), tmp_quant{3}(:,1))

figure;hold on
boxplot([tmp_quant{2}(:,2) tmp_quant{2}(:,1) tmp_quant{4}(:,2) tmp_quant{4}(:,1)]) 
% plot(1,tmp_quant{2}(:,2),'k+'); plot(2,tmp_quant{2}(:,1),'k+'); plot(3,tmp_quant{4}(:,2),'k+'); plot(4,tmp_quant{4}(:,1),'k+');

[h,p] = ttest(tmp_quant{2}(:,2), tmp_quant{2}(:,1))
[h,p] = ttest(tmp_quant{4}(:,2), tmp_quant{4}(:,1))


%%
%plot average mean / max act vs average MEAN cfos / Arc

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
        temp_mExp{siteID}(:,tp)=nanmean(ieg_exp_cell{siteID,(tp)},2);
        temp_corr(siteID,tp,1)=corr(temp_mExp{siteID}(:,tp),tmp_mAct{siteID}(:,tp),'rows','complete');
        temp_corr(siteID,tp,2)=corr(temp_mExp{siteID}(:,tp),tmp_maxAct{siteID}(:,tp),'rows','complete');
    end
end

figure;
subplot(2,3,4);hold on
for ind=1:4
    plot(nanmean(temp_mExp{ind},2),nanmean(tmp_maxAct{ind},2),'.')
    ylim([0.995 4.5]); xlim([-0.1 4])
end
title('mean Arc / max act');
for ind=5:9
 subplot(2,3,5);hold on
    plot(nanmean(temp_mExp{ind},2),nanmean(tmp_maxAct{ind},2),'.')
    ylim([0.995 4.5]); xlim([-0.1 4])
end
title('mean cfos / max act'); 
subplot(2,3,6);hold on
%     superbar([nanmean(nanmean(temp_corr(1:4,:,2),2)) nanmean(nanmean(temp_corr(5:9,:,2),2))],'E',[nanSEM(nanmean(temp_corr(1:4,:,2),2)) nanSEM(nanmean(temp_corr(5:9,:,2),2))])
boxplot([[nanmean(temp_corr(1:4,:,2),2); NaN] nanmean(temp_corr(5:9,:,2),2)])
plot(1,nanmean(temp_corr(1:4,:,2),2),'ko')
plot(2,nanmean(temp_corr(5:9,:,2),2),'ko')
%     [r,p]=ttest(temp_corr(1:4,2),temp_corr(5:9,2))
ylim([-0.15 0.6])
subplot(2,3,1);hold on
for ind=1:4
    plot(nanmean(temp_mExp{ind},2),nanmean(tmp_mAct{ind},2),'.')
    ylim([0.995 1.18]); xlim([-0.1 4])
end
title('mean Arc / mean act');
for ind=5:9
 subplot(2,3,2);hold on
    plot(nanmean(temp_mExp{ind},2),nanmean(tmp_mAct{ind},2),'.')
    ylim([0.995 1.18]); xlim([-0.1 4])
end
title('mean cfos / mean act'); 
subplot(2,3,3);hold on
%     superbar([nanmean(nanmean(temp_corr(1:4,:,1),2)) nanmean(nanmean(temp_corr(5:9,:,1),2))],'E',[nanSEM(nanmean(temp_corr(1:4,:,1),2)) nanSEM(nanmean(temp_corr(5:9,:,1),2))])
    boxplot([[nanmean(temp_corr(1:4,:,1),2); NaN] nanmean(temp_corr(5:9,:,1),2)])
plot(1,nanmean(temp_corr(1:4,:,1),2),'ko')
plot(2,nanmean(temp_corr(5:9,:,1),2),'ko')
%     [r,p]=ttest(temp_corr(1:4,2),temp_corr(5:9,2))
ylim([-0.15 0.6])

%%
%plot average mean / max act vs average DIFF cfos / Arc

days=1:7;
tps_exp=1:2:13;
tps_act=2:2:14;
siteIDs=1:9;
Sites={1:4;5:9};

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
        temp_mExp{siteID}(:,tp)=nanmean(ieg_diff_cell{siteID}(:,(tp)),2);
        temp_corr(siteID,tp,1)=corr(temp_mExp{siteID}(:,tp),tmp_mAct{siteID}(:,tp),'rows','complete');
        temp_corr(siteID,tp,2)=corr(temp_mExp{siteID}(:,tp),tmp_maxAct{siteID}(:,tp),'rows','complete');
    end
end

figure;
subplot(2,3,4);hold on
for ind=1:4
    plot(nanmean(temp_mExp{ind},2),nanmean(tmp_maxAct{ind},2),'.')
    ylim([0.995 4.5]); 
end
title('diff Arc / max act');
for ind=5:9
 subplot(2,3,5);hold on
    plot(nanmean(temp_mExp{ind},2),nanmean(tmp_maxAct{ind},2),'.')
    ylim([0.995 4.5]); xlim([-1.5 1.5])
end
title('diff cfos / max act');
subplot(2,3,6);hold on
%     superbar([nanmean(nanmean(temp_corr(1:4,:,2),2)) nanmean(nanmean(temp_corr(5:9,:,2),2))],'E',[nanSEM(nanmean(temp_corr(1:4,:,2),2)) nanSEM(nanmean(temp_corr(5:9,:,2),2))])
    boxplot([[nanmean(temp_corr(1:4,:,2),2); NaN] nanmean(temp_corr(5:9,:,2),2)])
plot(1,nanmean(temp_corr(1:4,:,2),2),'ko')
plot(2,nanmean(temp_corr(5:9,:,2),2),'ko')
%     [r,p]=ttest(temp_corr(1:4,2),temp_corr(5:9,2))
ylim([-0.15 0.6])
subplot(2,3,1);hold on
for ind=1:4
    plot(nanmean(temp_mExp{ind},2),nanmean(tmp_mAct{ind},2),'.')
    ylim([0.995 1.18]); 
end
title('diff Arc / mean act');
for ind=5:9
 subplot(2,3,2);hold on
    plot(nanmean(temp_mExp{ind},2),nanmean(tmp_mAct{ind},2),'.')
    ylim([0.995 1.18]); xlim([-1.5 1.5])
end
title('diff cfos / mean act');
subplot(2,3,3);hold on
%     superbar([nanmean(nanmean(temp_corr(1:4,:,1),2)) nanmean(nanmean(temp_corr(5:9,:,1),2))],'E',[nanSEM(nanmean(temp_corr(1:4,:,1),2)) nanSEM(nanmean(temp_corr(5:9,:,1),2))])
    boxplot([[nanmean(temp_corr(1:4,:,1),2); NaN] nanmean(temp_corr(5:9,:,1),2)])
plot(1,nanmean(temp_corr(1:4,:,2),1),'ko')
plot(2,nanmean(temp_corr(5:9,:,2),1),'ko')
%     [r,p]=ttest(temp_corr(1:4,2),temp_corr(5:9,2))
ylim([-0.15 0.6])



%%
%plot mean ieg expression 
tps_exp=1:2:13;
tmp_exp=[];
figure;hold on
for ind=1:2
    for siteID=Sites{ind}
        cnt=0;
        for tp=1:7
            cnt=cnt+1;
            tmp_exp(siteID,tp,1)=nanmean(ieg_exp_cell{siteID,tp});
            tmp_exp(siteID,tp,2)=nanSEM(ieg_exp_cell{siteID,tp});     
            tmp_act(siteID,tp,1)=nanmean(mean_act_cell{siteID}(:,cnt));
            tmp_act(siteID,tp,2)=nanSEM(mean_act_cell{siteID}(:,cnt));
        end
        
    end   
end
shadedErrorBar(1:7,nanmean(tmp_exp(1:4,:,1)),nanmean(tmp_exp(1:4,:,2)),{'linestyle','-','color','k'})
shadedErrorBar(1:7,nanmean(tmp_exp(5:9,:,1)),nanmean(tmp_exp(5:9,:,2)),{'linestyle','--','color','k'})
ylim([0 2.5]);
figure;hold on
shadedErrorBar(1:7,nanmean(tmp_act(1:4,:,1)),nanmean(tmp_act(1:4,:,2)),{'linestyle','-','color','b'})
shadedErrorBar(1:7,nanmean(tmp_act(5:9,:,1)),nanmean(tmp_act(5:9,:,2)),{'linestyle','--','color','r'})
% ylim([0 2.5])


%%
%plot corr of mean/max act vs mean/diff ieg
days=1:7;
tps_exp=1:2:13;
tps_act=2:2:14;
arc_cells=1:1271;
cfos_cells=1272:3090;

for siteID=1:9
    for tp1=1:7
        for tp2=1:7
            tmp_corr(siteID,tp1,tp2,1)=corr(nanmean(mean_act_cell{siteID}(:,tp1,:),3),ieg_exp_cell{siteID,tp2},'rows','complete','type','pearson');
            tmp_corr(siteID,tp1,tp2,2)=corr(nanmean(max_act_cell{siteID}(:,tp1,:),3),ieg_exp_cell{siteID,tp2},'rows','complete','type','pearson');
        end
    end
end
figure;
subplot(2,2,1);hold on
imagesc(squeeze(nanmean(tmp_corr(1:4,:,:,1))))
set(gca,'clim',[-0.15 0.6]); colorbar; colormap jet; set(gca,'YDir','reverse'); axis tight; box on
subplot(2,2,2);hold on
imagesc(squeeze(nanmean(tmp_corr(5:9,:,:,1))))
set(gca,'clim',[-0.15 0.6]); colorbar; colormap jet; set(gca,'YDir','reverse'); axis tight; box on

subplot(2,2,3);hold on
imagesc(squeeze(nanmean(tmp_corr(1:4,:,:,2))))
set(gca,'clim',[-0.15 0.6]); colorbar; colormap jet; set(gca,'YDir','reverse'); axis tight; box on
subplot(2,2,4);hold on
imagesc(squeeze(nanmean(tmp_corr(5:9,:,:,2))))
set(gca,'clim',[-0.15 0.6]); colorbar; colormap jet; set(gca,'YDir','reverse'); axis tight; box on

x(:,1) = diag(squeeze(nanmean(tmp_corr(1:4,:,:,1))));
x(:,2) = diag(squeeze(nanmean(tmp_corr(5:9,:,:,1))));
x(:,3) = diag(squeeze(nanmean(tmp_corr(1:4,:,:,2))));
x(:,4) = diag(squeeze(nanmean(tmp_corr(5:9,:,:,2))));
for ind=1:4
    [p,h] = ranksum(x(1:3,ind),x(5:7,ind))
end


for siteID=1:9
    for tp1=1:7
        for tp2=1:7
            tmp_corr(siteID,tp1,tp2,1)=corr(nanmean(mean_act_cell{siteID}(:,tp1,:),3),ieg_diff_cell{siteID}(:,(tp2)),'rows','complete','type','pearson');
            tmp_corr(siteID,tp1,tp2,2)=corr(nanmean(max_act_cell{siteID}(:,tp1,:),3),ieg_diff_cell{siteID}(:,(tp2)),'rows','complete','type','pearson');
        end
    end
end
figure;
subplot(2,2,1);hold on
imagesc(squeeze(nanmean(tmp_corr(1:4,:,:,1))))
set(gca,'clim',[-0.15 0.6]); colorbar; colormap jet; set(gca,'YDir','reverse'); axis tight; box on
subplot(2,2,2);hold on
imagesc(squeeze(nanmean(tmp_corr(5:9,:,:,1))))
set(gca,'clim',[-0.15 0.6]); colorbar; colormap jet; set(gca,'YDir','reverse'); axis tight; box on

subplot(2,2,3);hold on
imagesc(squeeze(nanmean(tmp_corr(1:4,:,:,2))))
set(gca,'clim',[-0.15 0.6]); colorbar; colormap jet; set(gca,'YDir','reverse'); axis tight; box on
subplot(2,2,4);hold on
imagesc(squeeze(nanmean(tmp_corr(5:9,:,:,2))))
set(gca,'clim',[-0.15 0.6]); colorbar; colormap jet; set(gca,'YDir','reverse'); axis tight; box on



%%
%Plot ditribution of Arc expression
cnt = 0;
figure;
for day = [1 7]
    cnt = cnt + 1;
    subplot(1,2,cnt)
    tmp_exp = vertcat(vertcat(ieg_exp_cell{1,day}),vertcat(ieg_exp_cell{2,day}),vertcat(ieg_exp_cell{3,day}),vertcat(ieg_exp_cell{4,day}));
    histogram(tmp_exp,[0.9:0.3:14],'FaceColor','k','normalization','probability')
    prc67 = prctile(tmp_exp,67);
    prc33 = prctile(tmp_exp,33);
%     xlim([0.95 1.2])
    ylim([0 0.45])
    line([prc67 prc67],ylim,'color','r','linestyle','--')
    line([prc33 prc33],ylim,'color','b','linestyle','--')
    ylabel('Fraction'); xlabel('Expression'); title(sprintf('arc Day %d',day));
    [h,p] = kstest(tmp_exp)
end
legend('','67% Percentile', '33% Percentile')

%Plot ditribution of cFos expression
cnt = 0;
figure;
for day = [1 7]
    cnt = cnt + 1;
    subplot(1,2,cnt)
    tmp_exp = vertcat(vertcat(ieg_exp_cell{5,day}),vertcat(ieg_exp_cell{6,day}),vertcat(ieg_exp_cell{7,day}),vertcat(ieg_exp_cell{8,day}),vertcat(ieg_exp_cell{9,day}));
    histogram(tmp_exp,[0.9:0.3:14],'FaceColor','k','normalization','probability')
    prc67 = prctile(tmp_exp,67);
    prc33 = prctile(tmp_exp,33);
%     xlim([0.95 1.1])
    ylim([0 0.45])
    line([prc67 prc67],ylim,'color','r','linestyle','--')
    line([prc33 prc33],ylim,'color','b','linestyle','--')
    ylabel('Fraction'); xlabel('Expression'); title(sprintf('c-fos Day %d',day));
    [h,p] = kstest(tmp_exp)
end
legend('','67% Percentile','33% Percentile')

%plot expression within session
tmp_exp=[];
y=[];
s=[];
for siteID=siteIDs
    cnt=0;
    for tp=1:7
        cnt=cnt+1;
        tmp_exp(siteID,:,cnt,1) = nanmean(ieg_exp{siteID,tp},1);
        tmp_exp(siteID,:,cnt,2) = nanSEM(ieg_exp{siteID,tp},1);
    end
end
figure;hold on
y(:,1)=nanmean(bsxfun(@rdivide,nanmean(tmp_exp(1:4,:,:,1),3),nanmean(tmp_exp(1:4,1,:,1),3)));
s(:,1)=nanmean(nanmean(tmp_exp(1:4,:,:,2),3));
shadedErrorBar(1:6,y(:,1),s(:,1),{'color','b'})
y(:,2)=nanmean(bsxfun(@rdivide,nanmean(tmp_exp(5:9,:,:,1),3),nanmean(tmp_exp(5:9,1,:,1),3)));
s(:,2)=nanmean(nanmean(tmp_exp(5:9,:,:,2),3));
shadedErrorBar(1:6,y(:,2),s(:,2),{'color','r'})
line(xlim,[1 1],'color','k')

figure;
superbar([y(1,1) y(6,1); y(1,2) y(6,2)],'e',[s(1,1) s(6,1); s(1,2) s(6,2)])
ylim([0.90 1.1])


%%
%plot tone resp of late tone cells

figure;hold on
sub_win=45:49;
sel_c = cToneCells{7};
clrind=('gyk');
for ind=1:3
    resp_mat=[];
    if ind==1
        resp_mat=tone_respMeanHalf;
    elseif ind==2
        resp_mat=rew_respMeanHalf;
    else
        resp_mat=puff_respMeanHalf;
    end
    mat=[];
    sta=1;
    sto=0;
    for siteID=siteIDs
        sto=sto+size(resp_mat{siteID},1);
        mat(sta:sto,:,1:7) = resp_mat{siteID}(:,:,1:7);
        sta=sta+size(resp_mat{siteID},1);
    end
    subplot(1,2,1);hold on
    plotSEM(nanmean(mat(sel_c,:,2:3),3)' - nanmean(nanmean(mat(sel_c,sub_win,2:3),3),2)','color',clrind(ind),'linestyle','-')
    xlim([45 70])
    ylim([-0.015 0.025])
    ylabel('Change in fluorescence (%)')
    xlabel('Time (s)')
    set(gca,'xtick',50:10:70)
    set(gca,'xticklabel',0:1:2)
    line(xlim,[0 0],'color','k')
    line([50 50],[0 0.025],'color','k')
    title('early')
    
    subplot(1,2,2);hold on
    plotSEM(nanmean(mat(sel_c,:,6:7),3)' - nanmean(nanmean(mat(sel_c,sub_win,6:7),3),2)','color',clrind(ind),'linestyle','--')
    xlim([45 70])
    ylim([-0.015 0.025])
    ylabel('dF/F')
    xlabel('Time (s)')
    set(gca,'xtick',50:10:70)
    set(gca,'xticklabel',0:1:2)
    line(xlim,[0 0],'color','k')
    line([50 50],[0 0.025],'color','k')
    title('late')
end
legend('tone resp','rew resp','puff resp')






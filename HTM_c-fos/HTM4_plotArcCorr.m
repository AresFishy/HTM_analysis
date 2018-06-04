%plot mean act over time
mean_act=[];
figure;hold on
for tp=1:7
    for siteID=1:5
        mean_act(siteID,tp,1) = nanmean(nanmean(act{siteID,tp},2),1);
        mean_act(siteID,tp,2) = nanSEM(nanmean(act{siteID,tp},2),1);
    end
end
% for siteID=1:4
%     shadedErrorBar(1:7,mean_act(siteID,:,1),mean_act(siteID,:,2))
% end
plot(mean_act(:,:,1)','linewidth',2)
errorbar(1:7,nanmean(mean_act(:,:,1),1),nanmean(mean_act(:,:,2),1),'--','color','k')
legend('animal 1','animal 2','animal 3','animal 4','mean+sem');
xlabel('day');
ylabel('change in fluorescence');

%%
%plot mean fos expresion
figure;hold on
for siteID=1:5
    for tp=1:7
        FosExp(siteID,tp,1) = nanmean(nanmean(fosAct{siteID,tp},2));
        FosExp(siteID,tp,2) = nanSEM(nanmean(fosAct{siteID,tp},2));
    end
end

shadedErrorBar(1:7,nanmean(FosExp(:,:,1)),nanmean(FosExp(:,:,2)))
xlabel('tps');
ylabel('change in Arc expression [%]');

%%
% plot curves of high and low fos
fosActmat=[];
for tp=1:7
fosActmat(:,:,tp)=vertcat(fosAct{:,tp});
end
figure;hold on
for ind=1:3
    if ind==1
        sel_c=logical(sel(1,:));
    elseif ind==2
        sel_c=logical(sel(2,:));
    elseif ind==3
        sel_c=logical(sel(3,:) - sel(1,:) - sel(2,:));
    end
    plotSEM(squeeze(nanmean(fosActmat(sel_c,:,:),2))')
end
xlabel('tps');
ylabel('change in fos expression [%]');

%%
%plot pairwise corr for onset act
sel_c=logical(sel(1,:));
figure;
cnt=0;
for tp=[6 7]
    cnt=cnt+1;
    subplot(1,2,cnt);hold on
    imagesc(corr(cOmTrialAct{tp}(sel_c,:),'rows','complete'))
    set(gca,'ydir','reverse');
    axis tight
    colorbar
%     set(gca,'clim',[0 1]);
end

%%
%plot onset resp for days 1:7
figure;
cnt=0;
for tp=1:7
    cnt=cnt+1;
    subplot(2,4,cnt);hold on
    for ind=1:3
    if ind==1
        sel_c=logical(sel(1,:));
    elseif ind==2
        sel_c=logical(sel(2,:));
    elseif ind==3
        sel_c=logical(sel(3,:) - sel(1,:) - sel(2,:));
    end
    plotSEM(cToneAct{1,tp}(sel_c,:)')
    ylim([-0.005 0.035]);
    end
    line([0 30],[0 0],'color','k')
    line([10 10],[0 0.03],'color','k')
    title(['tp ' num2str(tp)])
end
  
%%
%plot onset resp 
figure;
cnt=0;
clrind=('br');
ArcLevel={'high','low'};
mat=cToneAct;
for ind=1
    cnt=cnt+1;
    subplot(1,1,cnt);hold on
    if ind==1
        sel_c=logical(sel(1,:));
    elseif ind==2
        sel_c=logical(sel(2,:));
    elseif ind==3
        sel_c=logical(sel(3,:) - sel(1,:) - sel(2,:));
    end
    av1=[];
    av2=[];
    av1(:,:,1)=mat{1,1}(sel_c,:);
    av1(:,:,2)=mat{1,1}(sel_c,:);

    av2(:,:,1)=mat{1,7}(sel_c,:);
    av2(:,:,2)=mat{1,7}(sel_c,:);
    
    plotSEM(nanmean(av1,3)','linestyle','-','color',clrind(ind))
    plotSEM(nanmean(av2,3)','linestyle','--','color',clrind(ind))
%     ylim([-0.015 0.035]);
    xlim([1 31]);
%     line([0 30],[0 0],'color','k')
%     line([10 10],[0 0.03],'color','k')
    title([num2str(ArcLevel{ind}) ' c-fos, Tone' ])
end

%%
%plot overlap of high/low Arc with responsive cell categories

figure;hold on
for ind=1:4
    if ind==1
        mat=cPuffCells;
    elseif ind==2
        mat=cRewCells;
    elseif ind==3
        mat=cGratCells;
    else
        mat=cToneCells;
    end
    for tp=1:7
        aaa(:,tp,ind) = length(intersect(find(sel(1,:)==1),mat{1,tp}(1,:))) / length(find(sel(1,:)==1));
    end
    plot(aaa(:,:,ind))
end
legend('Puff','Rew','Grat','Tone','location','Northwest');
title('high Arc')
ylim([-0.01 0.35])


%%
%plot overlap of high Arc cells with resp cells on next day
figure;
aaaOver=[];
aaaArc=[];
clrind=('kbmg');
ta_ind=cell2mat(a_ind);
for ind=1:4
    if ind==1
        mat=cPuffCells;
    elseif ind==2
        mat=cRewCells;
    elseif ind==3
        mat=cGratCells;
    else
        mat=cToneCells;
    end
    for tp=1:6
        aaaOver(:,tp,ind,1) = length(intersect(find(ta_ind(:,tp)==1),mat{1,tp+1}(1,:))) / length(find(ta_ind(:,tp)==1));
        aaaArc(:,tp,ind,1) = nanmean(nanmean(ArcCorr(intersect(find(ta_ind(:,tp)==1),mat{1,tp+1}(1,:)),:,tp+1),2),1);
        aaaArc(:,tp,ind,2) = nanmean(nanmean(ArcCorr(intersect(find(ta_ind(:,tp)==1),mat{1,tp+1}(1,:)),:,tp),2),1);
    end
    subplot(1,3,1);hold on
    plot(aaaOver(:,:,ind),'color',clrind(ind))
    ylabel('fraction of high Arc neurons');
    xlabel('day comparison');
    set(gca,'xticklabel',{'1-2','2-3','3-4','4-5','5-6','6-7','7-8'});
    legend('Puff','Rew','Grat','Tone','location','NorthWest');
    title('overlap high Arc neurons with resp cells on next day');
   
    subplot(1,3,2);hold on
    plot(aaaArc(:,:,ind,1),'color',clrind(ind))
    ylabel('Arc expression [a.u.]');
    xlabel('day');
    set(gca,'xticklabel',{'2','3','4','5','6','7','8'});
    legend('Puff','Rew','Grat','Tone','location','NorthEast'); 
    title('Arc level on next day');
    ylim([55 80]);
    
    subplot(1,3,3);hold on
    plot(aaaArc(:,:,ind,2),'color',clrind(ind))
    ylabel('Arc expression [a.u.]');
    xlabel('day');
    set(gca,'xticklabel',{'1','2','3','4','5','6','7'});
    legend('Puff','Rew','Grat','Tone','location','NorthEast'); 
    title('Arc level on actual day');
    ylim([55 80]);
end


%%
%plot diff in Arc overlap of positive and negative reps cells (for every
%day)
figure;
aaaOver=[];
aaaArc=[];
clrind=('kbmg');
ta_ind=cell2mat(a_ind);
for ind=1:4
    if ind==1
        mat=cPuffCells;
        mat2=cnPuffCells;
    elseif ind==2
        mat=cRewCells;
        mat2=cnRewCells;
    elseif ind==3
        mat=cGratCells;
        mat2=cnGratCells;
    else
        mat=cToneCells;
        mat2=cnToneCells;
    end
    for tp=1:6
        aaaOver(:,tp,ind,1) = length(intersect(find(ta_ind(:,tp)==1),mat{1,tp+1}(1,:))) / length(find(ta_ind(:,tp)==1));
        aaaOver(:,tp,ind,2) = length(intersect(find(ta_ind(:,tp)==1),mat2{1,tp+1}(1,:))) / length(find(ta_ind(:,tp)==1));
        aaaDiff(:,tp,ind) = bsxfun(@minus,aaaOver(:,tp,ind,1),aaaOver(:,tp,ind,2));       
    end
    subplot(1,1,1);hold on
    plot(aaaDiff(:,:,ind),'color',clrind(ind))
    ylabel('diff in fraction of high Arc neurons');
    xlabel('day comparison');
    set(gca,'xtick',1:1:6);
    set(gca,'xticklabel',{'1-2','2-3','3-4','4-5','5-6','6-7'});  
    title('overlap in difference of high Arc neurons with pos/neg resp cells on next day');
end
  legend('Puff','Rew','Grat','Tone','location','NorthWest');


%%
%plot diff in Arc overlap of positive and negative reps cells (in
%comparison to high Arc population)
figure;
aaaOver=[];
aaaArc=[];
clrind=('kbmg');
sel_c=logical(sel(1,:));
for ind=1:4
    if ind==1
        mat=cPuffCells;
        mat2=cnPuffCells;
    elseif ind==2
        mat=cRewCells;
        mat2=cnRewCells;
    elseif ind==3
        mat=cGratCells;
        mat2=cnGratCells;
    else
        mat=cToneCells;
        mat2=cnToneCells;
    end
    for tp=1:6
        aaaOver(:,tp,ind,1) = length(intersect(find(sel_c==1),mat{1,tp+1}(1,:))) / length(find(sel_c==1));
        aaaOver(:,tp,ind,2) = length(intersect(find(sel_c==1),mat2{1,tp+1}(1,:))) / length(find(sel_c==1));
        aaaDiff(:,tp,ind) = bsxfun(@minus,aaaOver(:,tp,ind,1),aaaOver(:,tp,ind,2));       
    end
    subplot(1,1,1);hold on
    plot(aaaDiff(:,:,ind),'color',clrind(ind))
    ylabel('diff in fraction of HIGH Arc neurons');
    xlabel('day comparison');
    set(gca,'xtick',1:1:6);
    set(gca,'xticklabel',{'1-2','2-3','3-4','4-5','5-6','6-7'});  
    title('overlap in difference of high Arc neurons with pos/neg resp cells on next day');
end
  legend('Puff','Rew','Grat','Tone','location','NorthWest');













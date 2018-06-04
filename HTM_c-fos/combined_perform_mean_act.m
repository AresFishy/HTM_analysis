performance_tot = vertcat(arc_perform,fos_perform);

totTrialNum = (performance_tot(:,:,1)) + (performance_tot(:,:,2)) + (performance_tot(:,:,3));

figure;hold on
for ind=1:3  
%      plot(nanmean(bsxfun(@rdivide,performance_tot(:,:,ind),totTrialNum)))
plotSEM(bsxfun(@rdivide,performance_tot(:,:,ind),totTrialNum)')
end
hLine = refline(0,0.33);
hLine.Color = 'k';
legend('correct','false','passive')
ylabel('fraction of total trial #')
xlabel('Day')
ylim([0 1])
title('Task Performace')



%%

mean_act_tot = vertcat(mean_act_arc,mean_act_fos);

figure;errorbar(nanmean(mean_act_tot(:,:,1),1),nanmean(mean_act_tot(:,:,2),1))


%%

figure;hold on
errorbar(1:7,nanmean(ArcExp(:,:,1)),nanmean(ArcExp(:,:,2)),'color','k')
errorbar(1:7,nanmean(FosExp(:,:,1)),nanmean(FosExp(:,:,2)),'color','k','linestyle','--')
legend('Arc','c-fos');

%%
% plot curves of high and low Arc
arcActmat=[];
for tp=1:7
arcActmat(:,:,tp)=vertcat(arcAct{:,tp});
end
fosActmat=[];
for tp=1:7
fosActmat(:,:,tp)=vertcat(fosAct{:,tp});
end
figure;hold on
for ind=1:3
    if ind==1
        sel_c=logical(sel_Arc(1,:));
        sel_c1=logical(sel_Fos(1,:));
    elseif ind==2
        sel_c=logical(sel_Arc(2,:));
        sel_c1=logical(sel_Fos(2,:));
    elseif ind==3
        sel_c=logical(sel_Arc(3,:) - sel_Arc(1,:) - sel_Arc(2,:));
        sel_c1=logical(sel_Fos(3,:) - sel_Fos(1,:) - sel_Fos(2,:));
    end
    plotSEM(squeeze(nanmean(arcActmat(sel_c,:,:),2))')
    plotSEM(squeeze(nanmean(fosActmat(sel_c1,:,:),2))','linestyle','--')
end
xlabel('tps');
ylabel('change in IEG expression [%]');










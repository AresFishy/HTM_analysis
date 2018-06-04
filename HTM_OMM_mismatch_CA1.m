siteIDs=1;
c_ae=[];
win_l=50;
win_r=50;
run_thrsh=0.001;
vis_thrsh=0.001;
sit_win=-10;
airp_win=-20;
ps_win=-20;
sub_win=40:49;

% get PS act / #7 in 4th dimension
% ps_act={};
fb_win=1:7500;
for tp=1
    sta=1;
    sto=0;
    for siteID=siteIDs       
        for zl=1:4
            sto=sto+size(proj_meta(siteID).rd(zl,tp).act,1);
            ps_onsets=find(diff(proj_meta(siteID).rd(zl,tp).PS>0.5)==1);
            ps_onsets(ps_onsets<max(win_l,fb_win(1)+1))=[];
            ps_onsets(ps_onsets>min(length(proj_meta(siteID).rd(zl,tp).PS)-win_r-1,fb_win(end)-1))=[];
            ps_onsets(proj_meta(siteID).rd(zl,tp).velM_smoothed(ps_onsets)<run_thrsh)=[];
            ps_onsets(sum(proj_meta(siteID).rd(zl,tp).velM_smoothed(bsxfun(@plus,ps_onsets',[-5:10]))'<run_thrsh)>0)=[];
            tmp_act=[];
            if ~isempty(ps_onsets)
                for ind=1:length(ps_onsets)
                    tmp_act(:,:,ind)=proj_meta(siteID).rd(zl,tp).act(:,ps_onsets(ind)-win_l:ps_onsets(ind)+win_r);
                end
                c_ae(sta:sto,:,tp)=mean(tmp_act,3);
            else
               cn=sto-sta;
               c_ae(sta:sto,:,tp)=NaN(cn+1,101,1);
            end
            sta=sta+size(proj_meta(siteID).rd(zl,tp).act,1);
        end
    end
end


% get PBH act
pbo_win=1:22500;
for tp=2
     sta=1;
     sto=0;
    for siteID=siteIDs    
        for zl=1:4
            sto=sto+size(proj_meta(siteID).rd(zl,tp).act,1);
            ps_onsets=find(diff(proj_meta(siteID).rd(zl,tp).PS>0.5)==1);
            ps_onsets(ps_onsets<max(win_l,pbo_win(1)+1))=[];
            ps_onsets(ps_onsets>min(length(proj_meta(siteID).rd(zl,tp).PS)-win_r-1,pbo_win(end)-1))=[];
            ps_onsets(sum(proj_meta(siteID).rd(zl,tp).AirPuff(bsxfun(@plus,ps_onsets',[airp_win:10]))'>1)>0)=[];
            ps_onsets(sum(proj_meta(siteID).rd(zl,tp).velP_smoothed(bsxfun(@plus,ps_onsets',[-5:-1]))'<vis_thrsh)>0)=[];
%             ps_onsets(sum(proj_meta(siteID).rd(zl,tp).velP_smoothed(bsxfun(@plus,ps_onsets',[1:10]))'>vis_thrsh)>0)=[];
%             ps_onsets(proj_meta(siteID).rd(zl,tp).velP_smoothed(ps_onsets)<run_thrsh)=[];
            ps_onsets(sum(proj_meta(siteID).rd(zl,tp).velM_smoothed(bsxfun(@plus,ps_onsets',[sit_win:10]))'>run_thrsh)>0)=[];
            tmp_act=[];
            tmp_run=[];
            tmp_vis=[];
            if ~isempty(ps_onsets)
                for ind=1:length(ps_onsets)
                    tmp_act(:,:,ind)=proj_meta(siteID).rd(zl,tp).act(:,ps_onsets(ind)-win_l:ps_onsets(ind)+win_r);
%                     tmp_run(:,:,ind)=proj_meta(siteID).rd(zl,tp).velM_smoothed(:,ps_onsets(ind)-win_l:ps_onsets(ind)+win_r);
%                     tmp_vis(:,:,ind)=proj_meta(siteID).rd(zl,tp).velP(:,ps_onsets(ind)-win_l:ps_onsets(ind)+win_r);
                end
                c_ae(sta:sto,:,tp)=mean(tmp_act,3);
%                 pbh_run{siteID}(:,:,tp)=mean(tmp_run,3);
%                 pbh_vis{siteID}(:,:,tp)=mean(tmp_vis,3);
            else
                cn=sto-sta;
               c_ae(sta:sto,:,tp)=NaN(cn+1,101,1);
%                 pbh_run{siteID}(:,:,tp)=NaN(1,101,1);
%                 pbh_vis{siteID}(:,:,tp)=NaN(1,101,1);
            end
            sta=sta+size(proj_meta(siteID).rd(zl,tp).act,1);
        end        
    end    
end



figure;hold on
plotSEM((c_ae(:,:,1) - nanmean(c_ae(:,sub_win,1),2))')
plotSEM((c_ae(:,:,2) - nanmean(c_ae(:,sub_win,2),2))')
% xlim([45 80])
line(xlim,[0 0],'color','k')
line([50 50],[0 0.01],'color','k')



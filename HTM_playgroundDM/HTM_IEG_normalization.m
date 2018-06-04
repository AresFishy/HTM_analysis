function [sel2, sel3, IEG_exp, IEG_diff, IEG_exp_mat, IEG_diff_mat] = HTM_IEG_normalization(proj_meta,siteIDs)


tps_exp=1:2:13;
IEG_exp={};
IEG_exp_tmp={};
IEG_exp_zl_tmp={};

%extract raw image values for each ROI
for siteID=siteIDs
    tp_cnt=0;
    for tp=tps_exp
        tp_cnt=tp_cnt+1;
        for zl=1:4
            if size(proj_meta(siteID).rd(zl,tp).template_sec,3) > 0
                for knd=1:size(proj_meta(siteID).rd(zl,tp).template_sec,3)
                    temp_exp=[];
                    temp_exp=proj_meta(siteID).rd(zl,tp).template_sec(:,:,knd);
                    for ind=1:size(proj_meta(siteID).rd(zl,tp).act,1)
                        IEG_exp_zl_tmp{siteID,zl}(ind,knd,tp_cnt) = nanmean(temp_exp(proj_meta(siteID).rd(zl,tp).ROIinfo(ind).indices));
                    end
                end
            else
                temp_exp=[];
                temp_exp=proj_meta(siteID).rd(zl,tp).template_sec;
                for ind=1:size(proj_meta(siteID).rd(zl,tp).act,1)
                    IEG_exp_zl_tmp{siteID,zl}(ind,1,tp_cnt) = nanmean(temp_exp(proj_meta(siteID).rd(zl,tp).ROIinfo(ind).indices));
                end            
            end   
        end
    end
end


%rearrange expression cell
%set 0 to NaN and calc min/med of all tps
for siteID=siteIDs
    sta=1;
    sto=0;
    for zl=1:4
        sto=sto+size(proj_meta(siteID).rd(zl,1).act,1);
        IEG_exp_tmp{siteID}(sta:sto,:,:) = IEG_exp_zl_tmp{siteID,zl};
        sta=sta+size(proj_meta(siteID).rd(zl,1).act,1);
    end
    IEG_exp_tmp{siteID}(IEG_exp_tmp{siteID}==0)=NaN;
    
    norm_min=nanmin(IEG_exp_tmp{siteID}(:));
    norm_med=nanmedian(IEG_exp_tmp{siteID}(:));
    
    IEG_exp{siteID} = ((IEG_exp_tmp{siteID}) - norm_min) / (norm_med-norm_min);  
end
IEG_exp_mat=cell2mat(IEG_exp');




IEG_diff={};
for siteID=siteIDs
    for tp=1:7
        IEG_diff{siteID}(:,tp) = nansum(diff(IEG_exp{siteID}(:,:,tp),1,2),2);
    end
end
IEG_diff_mat=cell2mat(IEG_diff');



arc_inds=1:1271;
cfos_inds=1272:3090;
sel2=zeros(3090,4);
[V,I]=sort(nanmean(IEG_exp_mat(arc_inds,:),2),'descend');
sel2(I(1:round(length(arc_inds)/10)),1)=1;
[V,I]=sort(nanmean(IEG_exp_mat(cfos_inds,:),2),'descend');
sel2(I(1:round(length(cfos_inds)/10))+1271,2)=1;

[V,I]=sort(nanmean(IEG_exp_mat(arc_inds,:),2),'ascend');
sel2(I(1:round(length(arc_inds)/10)),3)=1;
[V,I]=sort(nanmean(IEG_exp_mat(cfos_inds,:),2),'ascend');
sel2(I(1:round(length(cfos_inds)/10))+1271,4)=1;


sta=1;
sto=0;
sel3_tmp={};
for siteID=siteIDs
    sel3_tmp{siteID}=zeros(size(IEG_exp{siteID},1),4);
    sto=sto+size(IEG_exp{siteID},1);
    if siteID<5
        [V,I]=sort(nanmean(nanmean(IEG_exp{siteID},2),3),'descend');
        sel3_tmp{siteID}(I(1:round(size(IEG_exp{siteID},1)/10)),1)=1;
        [V,I]=sort(nanmean(nanmean(IEG_exp{siteID},2),3),'ascend');
        sel3_tmp{siteID}(I(1:round(size(IEG_exp{siteID},1)/10)),3)=1;
    else
        [V,I]=sort(nanmean(nanmean(IEG_exp{siteID},2),3),'descend');
        sel3_tmp{siteID}(I(1:round(size(IEG_exp{siteID},1)/10)),2)=1;
        [V,I]=sort(nanmean(nanmean(IEG_exp{siteID},2),3),'ascend');
        sel3_tmp{siteID}(I(1:round(size(IEG_exp{siteID},1)/10)),4)=1;
    end
    sta=sta+size(IEG_exp{siteID},1);
end
    
sel3=cell2mat(sel3_tmp');
    
    
    
    
    
    

function [sel, sel2, ieg_diff, ieg_diff_cell, ieg_exp_mat, ieg_exp_cell, norm_val]=HTM_ieg_exp(proj_meta,fig)


siteIDs=1:9;
arcSites=1:4;
cfosSites=5:9;

tps_exp=1:2:14;

ieg_exp={};
ieg_exp_mat=[];

for siteID=siteIDs;
    for tp=tps_exp
        cnt=0;
        for zl=1:4
            [V,~]=sort(reshape(nanmean(proj_meta(siteID).rd(zl,tp).template_sec,3),[1 300000]));
            tmp_norm=median(V(1:30000));
            norm_val(siteID,tp)=tmp_norm;
            for ind=1:size(proj_meta(siteID).rd(zl,tp).act,1)
                cnt=cnt+1;
                if size(proj_meta(siteID).rd(zl,tp).template_sec,3) > 0
                    for knd=1:size(proj_meta(siteID).rd(zl,tp).template_sec,3)
                        tmp_exp=[];
                        tmp_exp=(proj_meta(siteID).rd(zl,tp).template_sec(:,:,knd)); 
                        tmp_exp=nanmean(tmp_exp(proj_meta(siteID).rd(zl,tp).ROIinfo(ind).indices));
                        ieg_exp{siteID,tp}(cnt,knd)=bsxfun(@rdivide,tmp_exp,tmp_norm);
                    end
                else
                    tmp_exp=[];
                    tmp_exp=mean(proj_meta(siteID).rd(zl,tp).template_sec(proj_meta(siteID).rd(zl,tp).ROIinfo(ind).indices));
                    ieg_exp{siteID,tp}(cnt,1)=bsxfun(@rdivide,tmp_exp,tmp_norm);
                end
            end
        end
    end
end

ieg_exp_cell={};
for siteID=siteIDs
    for tp=tps_exp          
        ieg_exp_cell{siteID}(:,tp) = nanmean(ieg_exp{siteID,tp},2);
    end
end
ieg_exp_mat=cell2mat(ieg_exp_cell');



arc_inds=1:1271;
cfos_inds=1272:3090;
sel2=zeros(3090,4);
[V,I]=sort(nanmean(ieg_exp_mat(arc_inds,:),2),'descend');
sel2(I(1:round(length(arc_inds)/10)),1)=1;
[V,I]=sort(nanmean(ieg_exp_mat(cfos_inds,:),2),'descend');
sel2(I(1:round(length(cfos_inds)/10))+1271,2)=1;

[V,I]=sort(nanmean(ieg_exp_mat(arc_inds,:),2),'ascend');
sel2(I(1:round(length(arc_inds)/10)),3)=1;
[V,I]=sort(nanmean(ieg_exp_mat(cfos_inds,:),2),'ascend');
sel2(I(1:round(length(cfos_inds)/10))+1271,4)=1;

perc_val=3.3;
arc_ind={};
for siteID=arcSites
    for tp=tps_exp
        arc_ind{siteID,tp}=zeros(size(ieg_exp{siteID,tp},1),1);
        [B,I]=sort(ieg_exp{siteID,tp}(:,:),'descend');
        arc_ind{siteID,tp}(sort(I(1:round(size(ieg_exp{siteID,tp},1)/perc_val))),1)=1;
    end
end

cfos_ind={};
for siteID=cfosSites
    for tp=tps_exp
        cfos_ind{siteID,tp}=zeros(size(ieg_exp{siteID,tp},1),1);
        [B,I]=sort(ieg_exp{siteID,tp}(:,:),'descend');
        cfos_ind{siteID,tp}(sort(I(1:round(size(ieg_exp{siteID,tp},1)/perc_val))),1)=1;
    end
end

%create category for every neuron depending on arc expression over days
combArcind=cell2mat(arc_ind);
combCFosind=cell2mat(cfos_ind);
ieg_c=zeros(size(combArcind,1)+size(combCFosind,1),1);
tps=1:3;
for ind=1:size(combArcind,1)
    if sum(combArcind(ind,tps),2)==3        %category 1 for high expression on all 2 tps
        ieg_c(ind,1)=1;   
    end
end
cnt=0;
for ind=size(combArcind,1)+1 : size(combArcind,1)+size(combCFosind,1)        
    cnt=cnt+1;
    if sum(combCFosind(cnt,tps),2)==3    %category 2 for low expression on all 2 tps
        ieg_c(ind,1)=2;  
    end
end


sel=zeros(2,size(combArcind,1)+size(combCFosind,1));
for ind=1:2
sel(ind,:)=ieg_c(:,1)==ind;
end
sel(3,:)=1;



%calculate the difference in fos expression per tp
ieg_diff_cell={};
for siteID=siteIDs
    for tp=1:2:14
    ieg_diff_cell{siteID}(:,tp) = bsxfun(@minus,ieg_exp{siteID,tp}(:,end),ieg_exp{siteID,tp}(:,1));   
    end
end
ieg_diff=cell2mat(ieg_diff_cell'); 


if fig
    
end

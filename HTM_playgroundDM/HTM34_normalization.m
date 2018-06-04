function [sel, sel2, sel3, ieg_exp, ieg_diff_cell, ieg_exp_mat, ieg_exp_cell, ieg_diff_mat]=HTM34_normalization(proj_meta,siteIDs)

arcSites=1:4;
cfosSites=5:9;
tps_exp=1:2:14;
ieg_exp={};
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
    
    ieg_exp_tmp_tmp{siteID} = ((IEG_exp_tmp{siteID}) - norm_min) / (norm_med-norm_min);    
end
ieg_exp_mat=cell2mat(ieg_exp_tmp_tmp');


for siteID=siteIDs
    for tp=1:7
        ieg_diff_tmp_tmp{siteID}(:,tp) = bsxfun(@minus,ieg_exp_tmp_tmp{siteID}(:,end-1,tp),ieg_exp_tmp_tmp{siteID}(:,1,tp));
    end
end
ieg_diff_mat=cell2mat(ieg_diff_tmp_tmp');

ieg_exp={};
ieg_exp_cell={};
ieg_diff_cell={};
for siteID=siteIDs
    for tp=1:7
        ieg_exp{siteID,tp}=ieg_exp_tmp_tmp{siteID}(:,:,tp);
        ieg_exp_cell{siteID,tp}=squeeze(nanmean(ieg_exp_tmp_tmp{siteID}(:,:,tp),2));
        ieg_diff_cell{siteID}(:,tp)=ieg_diff_tmp_tmp{siteID}(:,tp);
    end
end



% select high IEG neurons
perc_val=10;
tps_sel=4:5;

arc_inds=1:1271;
cfos_inds=1272:3090;
sel2=zeros(3090,4);
[V,I]=sort(nanmean(nanmean(ieg_exp_mat(arc_inds,:,tps_sel),2),3),'descend');
sel2(I(1:round(length(arc_inds)/perc_val)),1)=1;
[V,I]=sort(nanmean(nanmean(ieg_exp_mat(cfos_inds,:,tps_sel),2),3),'descend');
sel2(I(1:round(length(cfos_inds)/perc_val))+1271,2)=1;

[V,I]=sort(nanmean(nanmean(ieg_exp_mat(arc_inds,:,tps_sel),2),3),'ascend');
sel2(I(1:round(length(arc_inds)/perc_val)),3)=1;
[V,I]=sort(nanmean(nanmean(ieg_exp_mat(cfos_inds,:,tps_sel),2),3),'ascend');
sel2(I(1:round(length(cfos_inds)/perc_val))+1271,4)=1;


sel3_tmp={};
sel3_tmp_tmp=[];
sel3=[];
tps=4:5;
for siteID=siteIDs
    sel3_tmp{siteID}=zeros(size(ieg_exp_cell{siteID},1),1);
    [B,I]=sort(ieg_exp_cell{siteID},'descend');
    sel3_tmp{siteID}(sort(I(1:round(size(sel3_tmp{siteID},1)/perc_val))),1)=1;
    
    [B,I]=sort(ieg_exp_cell{siteID},'ascend');
    sel3_tmp{siteID}(sort(I(1:round(size(sel3_tmp{siteID},1)/perc_val))),2)=1;
end
sel3_tmp_tmp=cell2mat(sel3_tmp');
sel3=zeros(size(sel3_tmp_tmp,1),4);
sel3(arc_inds,1)=sel3_tmp_tmp(arc_inds,1);
sel3(arc_inds,3)=sel3_tmp_tmp(arc_inds,2);
sel3(cfos_inds,2)=sel3_tmp_tmp(cfos_inds,1);
sel3(cfos_inds,4)=sel3_tmp_tmp(cfos_inds,2);



arc_ind={};
for siteID=arcSites
    for tp=1:7
        arc_ind{siteID,tp}=zeros(size(ieg_exp{siteID,tp},1),1);
        [B,I]=sort(nanmean(ieg_exp{siteID,tp}(:,:),2),'descend');
        arc_ind{siteID,tp}(sort(I(1:round(size(ieg_exp{siteID,tp},1)/perc_val))),1)=1;
    end
end

cfos_ind={};
for siteID=cfosSites
    for tp=1:7
        cfos_ind{siteID,tp}=zeros(size(ieg_exp{siteID,tp},1),1);
        [B,I]=sort(nanmean(ieg_exp{siteID,tp}(:,:),2),'descend');
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





% for animal=1:9
%     for tp=1:7
%         meanIEG{animal}(:,tp)=ieg_exp_cell{animal,tp};
%     end
% end
% for animal = 1:9 
%     %Find cells with the highest IEG expression across all days
%     [~,tmpIdx] = sort(nanmean(meanIEG{animal},2),'descend');
%     highIEG{animal} = tmpIdx(1:round(length(meanIEG{animal})*0.1));
%     lowIEG{animal} = tmpIdx(end-round(length(meanIEG{animal})*0.1):end);
%     intIEG{animal} = tmpIdx(round(length(meanIEG{animal})*0.1):end-round(length(meanIEG{animal})*0.1));
%     
%     cHighIEG = [cHighIEG; highIEG{animal}+cellList(animal)];
%     cLowIEG = [cLowIEG; lowIEG{animal}+cellList(animal)];
%     cIntIEG = [cIntIEG; intIEG{animal}+cellList(animal)];
%     
%     if animal < 5
%         cArcCells = [cArcCells; highIEG{animal}+cellList(animal)];
%         cLowArcCells = [cLowArcCells; lowIEG{animal}+cellList(animal)];
%         cIntArcCells = [cIntArcCells; intIEG{animal}+cellList(animal)];
%     else
%         cCfosCells = [cCfosCells; highIEG{animal}+cellList(animal)];
%         cLowCfosCells = [cLowCfosCells; lowIEG{animal}+cellList(animal)];
%         cIntCfosCells = [cIntCfosCells; intIEG{animal}+cellList(animal)];
%     end
% end


%Find cells that are high across all days
% highArcHist =  histogram(vertcat(cArcCells{:,:}),1271);
% highArcConst = find(highArcHist.Values > 6);
% close(gcf)
% highCfosHist =  histogram(vertcat(cCfosCells{:,:}),1819);
% highCfosConst = find(highCfosHist.Values > 6)+1271;
% close(gcf)
% 

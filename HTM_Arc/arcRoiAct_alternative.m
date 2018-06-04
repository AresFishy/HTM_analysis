%get alternative Arc expression
act_exp={};
act_exp_mat=[];
act_exp_cell={};

for siteID=1:4;
    for tp=1:2:16
        cnt=0;
        for zl=1:4
            if siteID==2 & tp==15
                act_exp{siteID,tp}=NaN(487,6);
            else
                for ind=1:size(proj_meta(siteID).rd(zl,tp).act,1)
                    cnt=cnt+1;
                    if size(proj_meta(siteID).rd(zl,tp).template_sec,3) > 0
                        for knd=1:size(proj_meta(siteID).rd(zl,tp).template_sec,3)
                            tmp_exp=[];
                            tmp_exp=(proj_meta(siteID).rd(zl,tp).template_sec(:,:,knd));
                            tmp_exp=nanmean(tmp_exp(proj_meta(siteID).rd(zl,tp).ROIinfo(ind).indices));
                            act_exp{siteID,tp}(cnt,knd)=tmp_exp;
                        end
                    else
                        tmp_exp=[];
                        tmp_exp=mean(proj_meta(siteID).rd(zl,tp).template_sec(proj_meta(siteID).rd(zl,tp).ROIinfo(ind).indices));
                        act_exp{siteID,tp}(cnt,1)=tmp_exp;
                    end
                end
            end
        end
    end
end
for siteID=1:4
    for tp=1:2:16
        act_exp_cell{siteID,tp}=nanmean(act_exp{siteID,tp},2);
    end
end
act_exp_mat=cell2mat(act_exp_cell);



%%
% select lowest and highest 30% of Arc expressing cells within each animal


perc_val=3.3;
a_ind={};
for siteID=1:4
    for tp=1:2:15
        a_ind{siteID,tp}=zeros(size(act_exp{siteID,tp},1),1);
        [B,I]=sort(nanmean(act_exp{siteID,tp}(:,:),2),'descend');
        a_ind{siteID,tp}(sort(I(1:round(size(act_exp{siteID,tp},1)/perc_val))),1)=1;
    end
end

l_ind={};
for siteID=1:4
    for tp=1:2:15
        l_ind{siteID,tp}=zeros(size(act_exp{siteID,tp},1),1);
        [B,I]=sort(nanmean(act_exp{siteID,tp}(:,:),2),'ascend');
        l_ind{siteID,tp}(sort(I(1:round(size(act_exp{siteID,tp},1)/perc_val))),1)=1;
    end
end

%create category for every neuron depending on arc expression over days
combAind=cell2mat(a_ind);
combLind=cell2mat(l_ind);
arc_c=zeros(size(combAind,1),1);
tps=1:3;
for ind=1:size(combAind,1)
    if sum(combAind(ind,tps),2)==3        %category 1 for high expression on all 2 tps
        arc_c(ind,1)=1;     
        
    elseif sum(combLind(ind,tps),2)==3    %category 2 for low expression on all 2 tps
        arc_c(ind,1)=2;  
    end
end


sel=zeros(2,size(combAind,1));
for ind=1:2
sel(ind,:)=arc_c(:,1)==ind;
end
sel(3,:)=1;







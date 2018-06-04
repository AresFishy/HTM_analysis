%Get Arc Expression
arcAct = {};
tmparcAct = {};
for animal = 1:4
    daycnt = 0;
    for day = 1:2:16
        daycnt = daycnt +1;
        if size(proj_meta(animal).rd,2)-day > -1;
            for layer = 1:4;
                for secTmp = 1:size(proj_meta(animal).rd(layer,day).template_sec,3)
                    for rois = 1:length(proj_meta(animal).rd(layer,day).ROIinfo);
                        [roiX, roiY] = ind2sub([400 750],proj_meta(animal).rd(layer,day).ROIinfo(rois).indices);
                        tmparcAct{animal,daycnt,layer}(rois,secTmp) = mean(mean(proj_meta(animal).rd(layer,day).template_sec(roiX,roiY,secTmp)));
                    end
                end
            end
        end
        arcAct{animal,daycnt} = vertcat(tmparcAct{animal,daycnt,:});
    end
end
arcAct{2,8}=NaN(487,6);

% % select lowest and highest 30% of Arc expressing cells
% ArcCorr=[];
% for tp=1:6
%     ArcCorr(:,:,tp) = (vertcat(arcAct{:,tp}));
% end
% 
% perc_val=3.3;
% a_ind=zeros(size(ArcCorr,1),6);
% for tp=1:6
%    [B,I]=sort(nanmean(ArcCorr(:,:,tp),2),'descend');
%    a_ind(sort(I(1:round(size(a_ind,1)/perc_val))),tp)=1;  
% end
% 
% l_ind=zeros(size(ArcCorr,1),6);
% for tp=1:6
%    [B,I]=sort(nanmean(ArcCorr(:,:,tp),2),'ascend');
%    l_ind(sort(I(1:round(size(l_ind,1)/perc_val))),tp)=1; 
% end
% 
% %create category for every neuron depending on arc expression over days
% arc_c=zeros(size(ArcCorr,1),1);
% tps=1:3;
% for ind=1:size(a_ind,1)
%     if sum(a_ind(ind,tps),2)==3         %category 1 for high expression on all 2 tps
%         arc_c(ind,1)=1;     
%         
%     elseif sum(l_ind(ind,tps),2)==3    %category 2 for low expression on all 2 tps
%         arc_c(ind,1)=2;  
%     end
% end


% sel=zeros(2,size(ArcCorr,1));
% for ind=1:2
% sel(ind,:)=arc_c(:,1)==ind;
% end
% sel(3,:)=1;


% select lowest and highest 30% of Arc expressing cells within each animal


perc_val=3.3;
a_ind={};
for siteID=1:4
    for tp=1:8
        a_ind{siteID,tp}=zeros(size(arcAct{siteID,tp},1),1);
        [B,I]=sort(nanmean(arcAct{siteID,tp}(:,:),2),'descend');
        a_ind{siteID,tp}(sort(I(1:round(size(arcAct{siteID,tp},1)/perc_val))),1)=1;
    end
end

l_ind={};
for siteID=1:4
    for tp=1:8
        l_ind{siteID,tp}=zeros(size(arcAct{siteID,tp},1),1);
        [B,I]=sort(nanmean(arcAct{siteID,tp}(:,:),2),'ascend');
        l_ind{siteID,tp}(sort(I(1:round(size(arcAct{siteID,tp},1)/perc_val))),1)=1;
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











%Get Arc Expression Normalized for each recording and animal
arcAct = {};
tmparcAct = {};
tmp2arcAct = {};
for animal = 1:2
    daycnt = 0;
    for day = 1:2:14
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
        %Calculate dF/F for Arc expression by normalizing to median of
        %lowest 8% of cells.
        tmp2arcAct{animal,daycnt} = vertcat(tmparcAct{animal,daycnt,:});
        sortArc = sort(tmp2arcAct{animal,daycnt});
        low8Arc = median(sortArc(1:round(length(sortArc)/12.5),:));
        for tp = 1:6
            arcAct{animal,daycnt}(:,tp) = (tmp2arcAct{animal,daycnt}(:,tp))./low8Arc(tp);
        end
        %Calculate mean Arc expression
        if ~isempty(arcAct{animal,daycnt})
            mArcAct{animal,daycnt} = nanmean(arcAct{animal,daycnt},2);
        else
            mArcAct{animal,daycnt} = NaN(size(arcAct{animal,1},1),1);
        end
        %Calculate the difference in Arc expression across the 6 recordings
        arcDiff{animal,daycnt} = diff(arcAct{animal,daycnt},1,2);
        %Calculate total change in Arc expression
        if ~isempty(arcDiff{animal,daycnt})
            mArcDiff{animal,daycnt} = sum(arcDiff{animal,daycnt},2);
        else
            mArcDiff{animal,daycnt} = NaN(size(arcAct{animal,1},1),1);
        end
    end
end

%Combine the Arc and change in Arc expression across animals
for day = 1:7
    cArcDiff{day} = vertcat(mArcDiff{:,day});
    cArcAct{day} = vertcat(mArcAct{:,day});
end


%  DM
%Selection of cells high or low in Arc across the first 3 days
perc_val=3.3;
a_ind={};
for siteID=1:2
    for tp=1:7
        a_ind{siteID,tp}=zeros(size(arcAct{siteID,tp},1),1);
        [B,I]=sort(nanmean(arcAct{siteID,tp}(:,:),2),'descend');
        a_ind{siteID,tp}(sort(I(1:round(size(arcAct{siteID,tp},1)/perc_val))),1)=1;
    end
end

l_ind={};
for siteID=1:2
    for tp=1:7
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




%%
% define top x % of cells with high Arc expression

cnt=0;
sel2=[];
for knd=[3.33 4 5 6.66 10 20 3.33]
    cnt=cnt+1;
    perc_val=knd;
    a_ind={};
    for siteID=1:4
        for tp=1:7
            a_ind{siteID,tp}=zeros(size(arcAct{siteID,tp},1),1);
            [B,I]=sort(nanmean(arcAct{siteID,tp}(:,:),2),'descend');
            a_ind{siteID,tp}(sort(I(1:round(size(arcAct{siteID,tp},1)/perc_val))),1)=1;
        end
    end
    
    l_ind={};
    for siteID=1:4
        for tp=1:7
            l_ind{siteID,tp}=zeros(size(arcAct{siteID,tp},1),1);
            [B,I]=sort(nanmean(arcAct{siteID,tp}(:,:),2),'ascend');
            l_ind{siteID,tp}(sort(I(1:round(size(arcAct{siteID,tp},1)/perc_val))),1)=1;
        end
    end
    
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
    
    sel2(cnt,:)=sel(1,:);
end
sel2=sel2(1:6,:);
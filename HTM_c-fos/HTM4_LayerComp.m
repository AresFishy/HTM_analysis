function []=HTM4_LayerComp(proj_meta)

cellList;
siteIDs=1:5;


zl_inds=[];
for siteID=siteIDs
    cnt=0;
    for zl=1:4
        cnt=cnt+1;
        zl_inds(siteID,cnt)=size(proj_meta(siteID).rd(zl,1).act,1);
    end
end
        
zl_ind=zeros(1819,2);
for siteID=siteIDs
    zl_ind(cellList(siteID)+1:cellList(siteID)+zl_inds(siteID,1),1)=1;
    zl_ind(cellList(siteID+1)-zl_inds(siteID,4):cellList(siteID+1),2)=1;
end


%%
%plot onset resp 
figure;
cnt=0;
fosLevel={'first','last'};
line_tp={'-','--'};
mat=cRewAct;
for ind=[1 7]
    cnt=cnt+1;
    subplot(1,2,cnt);hold on
        
    sel_c1=logical(zl_ind(:,1));
    sel_c2=logical(zl_ind(:,2));
        
    av1=[];
    av2=[];
    av1(:,:,1)=mat{1,ind}(sel_c1,:);
    av1(:,:,2)=mat{1,ind}(sel_c1,:);

    av2(:,:,1)=mat{1,ind}(sel_c2,:);
    av2(:,:,2)=mat{1,ind}(sel_c2,:);
    
    plotSEM(nanmean(av1,3)','linestyle',line_tp{cnt},'color','b')
    plotSEM(nanmean(av2,3)','linestyle',line_tp{cnt},'color','r')
    ylim([-0.03 0.035]);
    xlim([1 31]);
    line([0 30],[0 0],'color','k')
    line([10 10],[0 0.03],'color','k')
    title([num2str(fosLevel{cnt}) ' day' ])
end




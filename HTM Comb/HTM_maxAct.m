function [max_act_cell, max_act]=HTM_maxAct(proj_meta,siteIDs)


arcSites=1:4;
cfosSites=5:9;
tps_act=2:2:14;


max_act_cell={};
for siteID=siteIDs
    tpcnt=0;    
    for tp=tps_act
        tpcnt=tpcnt+1;    
        sta=1;
        sto=0;
        for zl=1:4 
            sto=sto+size(proj_meta(siteID).rd(zl,tp).act,1);
            tmp_act=proj_meta(siteID).rd(zl,tp).act(:,:);
            frame_cnt=1;
            for stack_ind=1:5
                max_act_cell{siteID}(sta:sto,tpcnt,stack_ind)=max(tmp_act(:,frame_cnt:frame_cnt+4999),[],2);
                frame_cnt=frame_cnt+5000;
            end
            sta=sta+size(proj_meta(siteID).rd(zl,tp).act,1);
        end       
    end
end
        
max_act=cell2mat(max_act_cell');
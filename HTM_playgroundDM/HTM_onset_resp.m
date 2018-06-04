function [grat, tone_onset, tone1, tone2, apuff, ppuff, rewRight, rewLeft, reward]=HTM_onset_resp(proj_meta,siteIDs)

arcSites=1:4;
cfosSites=5:9;
days=1:7;
tps_act=2:2:14;


%grat onset
grat_act={};
win_l=50;
win_r=150;
for siteID=siteIDs
    for tp=tps_act(days)
        sta=1;
        sto=0;
        for zl=1:4
            sto=sto+size(proj_meta(siteID).rd(zl,tp).act,1);
            onset_snip=find(diff(proj_meta(siteID).rd(1,tp).GratID>1)==1);
            onset_snip(onset_snip>size(proj_meta(siteID).rd(zl,tp).act,2)-win_r)=[];
            onset_snip(onset_snip<win_l)=[];
            tmp_act=[]; 
            if ~isempty(onset_snip)
                for ind=1:length(onset_snip)
                    tmp_act(:,:,ind)=proj_meta(siteID).rd(zl,tp).act(:,onset_snip(ind)-win_l:onset_snip(ind)+win_r);
                end
                grat_act{siteID}(sta:sto,:,tp)=mean(tmp_act,3);
            else
                cn=sto-sta;
                grat_act{siteID}(sta:sto,:,tp)=NaN(cn+1,201,1);
            end
            sta=sta+size(proj_meta(siteID).rd(zl,tp).act,1); 
        end
    end
end
            

%tone onset
tone_act={};
tone1_act={};
tone2_act={};
win_l=50;
win_r=150;
for siteID=siteIDs
    for tp=tps_act(days)
        sta=1;
        sto=0;
        for zl=1:4
            sto=sto+size(proj_meta(siteID).rd(zl,tp).act,1);
            onset_snip=find(diff(proj_meta(siteID).rd(1,tp).ToneID>1)==1);
            onset_snip(onset_snip>size(proj_meta(siteID).rd(zl,tp).act,2)-win_r)=[];
            onset_snip(onset_snip<win_l)=[];
            
            onset1_snip=find(diff(proj_meta(siteID).rd(1,tp).ToneID>3)==1);
            onset1_snip(onset1_snip>size(proj_meta(siteID).rd(zl,tp).act,2)-win_r)=[];
            onset1_snip(onset1_snip<win_l)=[];
            
            onset2_snip=onset_snip(~ismember(onset_snip,onset1_snip));
            onset2_snip(onset2_snip>size(proj_meta(siteID).rd(zl,tp).act,2)-win_r)=[];
            onset2_snip(onset2_snip<win_l)=[];
            
            tmp_act=[]; 
            if ~isempty(onset_snip)
                for ind=1:length(onset_snip)
                    tmp_act(:,:,ind)=proj_meta(siteID).rd(zl,tp).act(:,onset_snip(ind)-win_l:onset_snip(ind)+win_r);
                end
                tone_act{siteID}(sta:sto,:,tp)=mean(tmp_act,3);
            else
                cn=sto-sta;
                tone_act{siteID}(sta:sto,:,tp)=NaN(cn+1,201,1);
            end
            
            tmp_act=[]; 
            if ~isempty(onset1_snip)
                for ind=1:length(onset1_snip)
                    tmp_act(:,:,ind)=proj_meta(siteID).rd(zl,tp).act(:,onset1_snip(ind)-win_l:onset1_snip(ind)+win_r);
                end
                tone1_act{siteID}(sta:sto,:,tp)=mean(tmp_act,3);
            else
                cn=sto-sta;
                tone1_act{siteID}(sta:sto,:,tp)=NaN(cn+1,201,1);
            end
            
            tmp_act=[]; 
            if ~isempty(onset2_snip)
                for ind=1:length(onset2_snip)
                    tmp_act(:,:,ind)=proj_meta(siteID).rd(zl,tp).act(:,onset2_snip(ind)-win_l:onset2_snip(ind)+win_r);
                end
                tone2_act{siteID}(sta:sto,:,tp)=mean(tmp_act,3);
            else
                cn=sto-sta;
                tone2_act{siteID}(sta:sto,:,tp)=NaN(cn+1,201,1);
            end
            
            sta=sta+size(proj_meta(siteID).rd(zl,tp).act,1); 
        end
    end
end



%puff onset
apuff_act={};
ppuff_act={};
win_l=50;
win_r=150;
for siteID=siteIDs
    for tp=tps_act(days)
        sta=1;
        sto=0;
        for zl=1:4
            sto=sto+size(proj_meta(siteID).rd(zl,tp).act,1);
            %extract active puff, where animal licked (wrong decision)
            onset_snip=find(diff(proj_meta(siteID).rd(1,tp).AirPuff>1)==1); 
            onset_snip(onset_snip>size(proj_meta(siteID).rd(zl,tp).act,2)-win_r)=[];
            onset_snip(onset_snip<win_l)=[];
            onset_snip_tone=find(diff(proj_meta(siteID).rd(1,tp).AirPuff>1)==1)+40;
            onset_snip(ismember(onset_snip,onset_snip_tone))=[];
            
            %extract passive puff, where animal did not licked (passive)
            onset1_snip=(~ismember(onset_snip,onset_snip_tone));
            onset1_snip(onset1_snip>size(proj_meta(siteID).rd(zl,tp).act,2)-win_r)=[];
            onset1_snip(onset1_snip<win_l)=[];
            tmp_act=[]; 
            if ~isempty(onset_snip)
                for ind=1:length(onset_snip)
                    tmp_act(:,:,ind)=proj_meta(siteID).rd(zl,tp).act(:,onset_snip(ind)-win_l:onset_snip(ind)+win_r);
                end
                apuff_act{siteID}(sta:sto,:,tp)=mean(tmp_act,3);
            else
                cn=sto-sta;
                apuff_act{siteID}(sta:sto,:,tp)=NaN(cn+1,201,1);
            end
            
             tmp_act=[]; 
            if ~isempty(onset1_snip)
                for ind=1:length(onset1_snip)
                    tmp_act(:,:,ind)=proj_meta(siteID).rd(zl,tp).act(:,onset1_snip(ind)-win_l:onset1_snip(ind)+win_r);
                end
                ppuff_act{siteID}(sta:sto,:,tp)=mean(tmp_act,3);
            else
                cn=sto-sta;
                ppuff_act{siteID}(sta:sto,:,tp)=NaN(cn+1,201,1);
            end
            sta=sta+size(proj_meta(siteID).rd(zl,tp).act,1); 
        end
    end
end



%reward onset
rew_act={};
rewL_act={};
rewR_act={};
win_l=50;
win_r=150;
lick_wl=5;
lick_wr=1;
lick_th=0.01;
for siteID=siteIDs
    for tp=tps_act(days)
        sta=1;
        sto=0;
        for zl=1:4
            sto=sto+size(proj_meta(siteID).rd(zl,tp).act,1);
            
            onset1_snip=find(diff(proj_meta(siteID).rd(1,tp).RewardL>1)==1);
            if ~isempty(onset1_snip)
                    onset1_snip(sum(proj_meta(siteID).rd(1,tp).LickL(bsxfun(@plus,onset1_snip',[-lick_wl:lick_wr])))==0)=[];
            end 
            onset1_snip(onset1_snip>size(proj_meta(siteID).rd(zl,tp).act,2)-win_r)=[];
            onset1_snip(onset1_snip<win_l)=[];
            
            onset2_snip=find(diff(proj_meta(siteID).rd(1,tp).RewardR>1)==1);
            if ~isempty(onset2_snip)
                    onset2_snip(sum(proj_meta(siteID).rd(1,tp).LickR(bsxfun(@plus,onset2_snip',[-lick_wl:lick_wr])))==0)=[];
            end           
            onset2_snip(onset2_snip>size(proj_meta(siteID).rd(zl,tp).act,2)-win_r)=[];
            onset2_snip(onset2_snip<win_l)=[];
            
            onset_snip=sort([onset1_snip onset2_snip]);
            onset_snip(onset_snip>size(proj_meta(siteID).rd(zl,tp).act,2)-win_r)=[];
            onset_snip(onset_snip<win_l)=[];
            tmp_act=[]; 
            if ~isempty(onset_snip)
                for ind=1:length(onset_snip)
                    tmp_act(:,:,ind)=proj_meta(siteID).rd(zl,tp).act(:,onset_snip(ind)-win_l:onset_snip(ind)+win_r);
                end
                rew_act{siteID}(sta:sto,:,tp)=mean(tmp_act,3);
            else
                cn=sto-sta;
                rew_act{siteID}(sta:sto,:,tp)=NaN(cn+1,201,1);
            end
            
            tmp_act=[]; 
            if ~isempty(onset1_snip)
                for ind=1:length(onset1_snip)
                    tmp_act(:,:,ind)=proj_meta(siteID).rd(zl,tp).act(:,onset1_snip(ind)-win_l:onset1_snip(ind)+win_r);
                end
                rewL_act{siteID}(sta:sto,:,tp)=mean(tmp_act,3);
            else
                cn=sto-sta;
                rewL_act{siteID}(sta:sto,:,tp)=NaN(cn+1,201,1);
            end
            
            tmp_act=[]; 
            if ~isempty(onset2_snip)
                for ind=1:length(onset2_snip)
                    tmp_act(:,:,ind)=proj_meta(siteID).rd(zl,tp).act(:,onset2_snip(ind)-win_l:onset2_snip(ind)+win_r);
                end
                rewR_act{siteID}(sta:sto,:,tp)=mean(tmp_act,3);
            else
                cn=sto-sta;
                rewR_act{siteID}(sta:sto,:,tp)=NaN(cn+1,201,1);
            end
            sta=sta+size(proj_meta(siteID).rd(zl,tp).act,1); 
        end
    end
end


% %ommision resp
% %(onset is first lick during decision periode)
% om_act={};
% win_l=50;
% win_r=150;
% rein_winL=0;
% rein_winR=20;
% lick_th=-0.01;
% rew_th=0.01;
% puff_th=0.01;
% for siteID=siteIDs
%     for tp=tps_act(7)
%         sta=1;
%         sto=0;
%         for zl=1:4
%             sto=sto+size(proj_meta(siteID).rd(zl,tp).act,1); 
%             %start with tone onset
%             onset_snip=find(diff(proj_meta(siteID).rd(1,tp).ToneID>1)==1)+40;
%             onset_snip(onset_snip>size(proj_meta(siteID).rd(zl,tp).act,2)-win_r)=[];
%             onset_snip(onset_snip<win_l)=[];
%             % check is neither rew or puff was present
%             onset_snip(sum(proj_meta(siteID).rd(1,tp).RewardL(bsxfun(@plus,onset_snip',[rein_winL:rein_winR]))'>rew_th)>0)=[];
%             onset_snip(sum(proj_meta(siteID).rd(1,tp).RewardR(bsxfun(@plus,onset_snip',[rein_winL:rein_winR]))'>rew_th)>0)=[];
%             onset_snip(sum(proj_meta(siteID).rd(1,tp).AirPuff(bsxfun(@plus,onset_snip',[rein_winL:rein_winR]))>puff_th')>0)=[];
%            
%              tmp_act=[];
%              if ~isempty(onset_snip)
%                 for ind=1:length(onset_snip)
%                      %transform onsets to frist lick onset during decision period
%                     tmp_onsetL=onset_snip(find(diff(proj_meta(siteID).rd(1,tp).LickL(bsxfun(@plus,onset_snip(ind)',[rein_winL:rein_winR]))'<lick_th)==-1));
%                     tmp_onsetR=onset_snip(find(diff(proj_meta(siteID).rd(1,tp).LickR(bsxfun(@plus,onset_snip(ind)',[rein_winL:rein_winR]))'<lick_th)==-1));
%                     if ~isempty(tmp_onsetL) & ~isempty(tmp_onsetR)
%                         tmp_onset=min(tmp_onsetL(1),tmp_onsetR(1));
%                     elseif ~isempty(tmp_onsetL)
%                         tmp_onset=tmp_onsetL(1);
%                     elseif ~isempty(tmp_onsetR)
%                         tmp_onset=tmp_onsetR(1);
%                     end
%                     tmp_act(:,:,ind)=proj_meta(siteID).rd(zl,tp).act(:,tmp_onset-win_l:tmp_onset+win_r);
%                 end
%                 om_act{siteID}(sta:sto,:,tp)=mean(tmp_act,3);
%             else
%                 cn=sto-sta;
%                 om_act{siteID}(sta:sto,:,tp)=NaN(cn+1,201,1);
%             end
%             sta=sta+size(proj_meta(siteID).rd(zl,tp).act,1); 
%         end
%     end
% end
% 



grat=[];   tone_onset=[];   tone1=[];   tone2=[];   apuff=[];   ppuff=[];   rewRight=[];    rewLeft=[];    reward=[];     om=[];

grat=cell2mat(grat_act');
tone_onset=cell2mat(tone_act');
tone1=cell2mat(tone1_act');
tone2=cell2mat(tone2_act');
apuff=cell2mat(apuff_act');
ppuff=cell2mat(ppuff_act');
rewRight=cell2mat(rewR_act');
rewLeft=cell2mat(rewL_act');
reward=cell2mat(rew_act');
% om=cell2mat(om_act');







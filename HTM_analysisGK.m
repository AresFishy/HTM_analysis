% load('\\argon.fmi.ch\gkeller.mdrive\AData\_metaData\HTM_3_4_meta.mat')

%%

arc_sites=1:4;
cfos_sites=5:9;

ieg_act={};
% create the arc/cfos activity matrix
for siteID=1:9
    cntIEG=0;
    for tp=1:2:size(proj_meta(siteID).rd,2)
        cntIEG=cntIEG+1;
        for ind=1:size(proj_meta(siteID).rd(1,tp).template_sec,3)
            cell_cnt=0;
            for zl=1:4
                tmp_template=proj_meta(siteID).rd(zl,tp).template_sec(:,:,ind);
                for jnd=1:size(proj_meta(siteID).rd(zl,tp).ROIinfo,2)
                    cell_cnt=cell_cnt+1;
                    ieg_act{siteID}(cell_cnt,ind,cntIEG)=mean(tmp_template(proj_meta(siteID).rd(zl,tp).ROIinfo(jnd).indices));
                end
                
            end
        end
    end
    ieg_act{siteID}=squeeze(mean(ieg_act{siteID}(:,1:end,:),2));
end

neu_act={};
% create the neural activity matrix
for siteID=1:9
    cntNEU=0;
    for tp=2:2:size(proj_meta(siteID).rd,2)
        cntNEU=cntNEU+1;
        neu_act{siteID}(:,:,cntNEU)=act2mat(proj_meta,siteID,tp);
    end
end


%%
ccMax=[];
for tp=1:7
    figure;
    hold on
    tpoffs=0;
    for siteID=1:4
        plot(ieg_act{siteID}(:,tp+tpoffs),max(neu_act{siteID}(:,:,tp),[],2),'.')
        tmp=corrcoef(ieg_act{siteID}(:,tp+tpoffs),max(neu_act{siteID}(:,:,tp),[],2));
        ccMax(tp,siteID)=tmp(2);
    end
    figure;
    hold on
    for siteID=5:9
        plot(ieg_act{siteID}(:,tp+tpoffs),max(neu_act{siteID}(:,:,tp),[],2),'.')
        tmp=corrcoef(ieg_act{siteID}(:,tp+tpoffs),max(neu_act{siteID}(:,:,tp),[],2));
        ccMax(tp,siteID)=tmp(2);
    end
end

ccMean=[];
for tp=1:7
    figure;
    hold on
    tpoffs=0;
    for siteID=1:4
        plot(ieg_act{siteID}(:,tp+tpoffs),mean((neu_act{siteID}(:,:,tp)-1).^1,2),'.')
        tmp=corrcoef(ieg_act{siteID}(:,tp+tpoffs),mean((neu_act{siteID}(:,:,tp)-1).^1,2));
        ccMean(tp,siteID)=tmp(2);
    end
    figure;
    hold on
    for siteID=5:9
        plot(ieg_act{siteID}(:,tp+tpoffs),mean((neu_act{siteID}(:,:,tp)-1).^1,2),'.')
        tmp=corrcoef(ieg_act{siteID}(:,tp+tpoffs),mean((neu_act{siteID}(:,:,tp)-1).^1,2));
        ccMean(tp,siteID)=tmp(2);
    end
end


figure;
hold on
plot(mean(ccMean'),'k')
plot(mean(ccMax'),'r')


figure;
ccArc=ccMax(:,arc_sites);
ccFos=ccMax(:,cfos_sites);
superbar([mean(ccArc(:)) mean(ccFos(:))],'E',[std(ccArc(:))/sqrt(prod(size(ccArc))) std(ccFos(:))/sqrt(prod(size(ccFos)))],'BarWidth',0.5)
ylim([0 0.45])
set(gca,'xtick',[1 2],'xticklabel',{'Arc' 'cFos'})
ylabel('Correlation coefficient')


figure;
superbar([mean(ccMean(:)) mean(ccMax(:))],'E',[std(ccMean(:))/sqrt(prod(size(ccMean))) std(ccMax(:))/sqrt(prod(size(ccMax)))],'BarWidth',0.5)
ylim([0 0.45])
set(gca,'xtick',[1 2],'xticklabel',{'Mean' 'Max'})
ylabel('Correlation coefficient')


% cnt=0;
% for siteID=5:9
%     neu_actM=squeeze(mean(neu_act{siteID}(:,:,1:7),2));
%
%     for ind=1:size(neu_actM,1)
%         cnt=cnt+1;
%         xc(:,cnt)=xcorr(neu_actM(ind,:),ieg_act{siteID}(ind,1:7),'unbiased');
%     end
%
% end



%%
% compute onset responses

winL=50;
winR=150;
stim_resp={};

%Grat onsets
for siteID=1:9
    cntNEU=0;
    for tp=2:2:size(proj_meta(siteID).rd,2)
        snps=[];
        cntNEU=cntNEU+1;
        act=act2mat(proj_meta,siteID,tp);

        trigs=find(diff(proj_meta(siteID).rd(1,tp).GratID>1)==1);
        trigs(trigs<winL)=[];
        trigs(trigs>size(act,2)-winR)=[];
        
        for ind=1:length(trigs)
            snps(:,:,ind)=act(:,trigs(ind)-winL:trigs(ind)+winR);
        end
        
        stim_resp{siteID,1}(:,:,cntNEU)=mean(snps,3);
        
    end
end

%Tone onsets
for siteID=1:9
    cntNEU=0;
    for tp=2:2:size(proj_meta(siteID).rd,2)
        snps=[];
        cntNEU=cntNEU+1;
        act=act2mat(proj_meta,siteID,tp);
        
        trigs=find(diff(proj_meta(siteID).rd(1,tp).ToneID>1)==1);
        trigs(trigs<winL)=[];
        trigs(trigs>size(act,2)-winR)=[];
        
%         % remove trigs of trials where the animal got it wrong
%         puff_times=find(diff(proj_meta(siteID).rd(1,tp).AirPuff>1)==1);
%         trigs(~logical(sum((abs(bsxfun(@minus,trigs',puff_times))<100)')))=[];
        
        for ind=1:length(trigs)
            snps(:,:,ind)=act(:,trigs(ind)-winL:trigs(ind)+winR);
        end
        
        stim_resp{siteID,2}(:,:,cntNEU)=mean(snps,3);
        
    end
end

%Rew onsets
for siteID=1:9
    cntNEU=0;
    for tp=2:2:size(proj_meta(siteID).rd,2)
        snps=[];
        cntNEU=cntNEU+1;
        act=act2mat(proj_meta,siteID,tp);

        trigs=find(diff((proj_meta(siteID).rd(1,tp).RewardL+proj_meta(siteID).rd(1,tp).RewardR)>1)==1);
        trigs(trigs<winL)=[];
        trigs(trigs>size(act,2)-winR)=[];
        
        for ind=1:length(trigs)
            snps(:,:,ind)=act(:,trigs(ind)-winL:trigs(ind)+winR);
        end
        
        stim_resp{siteID,3}(:,:,cntNEU)=mean(snps,3);
        
    end
end

%Puff onsets
for siteID=1:9
    cntNEU=0;
    for tp=2:2:size(proj_meta(siteID).rd,2)
        snps=[];
        cntNEU=cntNEU+1;
        act=act2mat(proj_meta,siteID,tp);

        trigs=find(diff((proj_meta(siteID).rd(1,tp).AirPuff)>1)==1);
        trigs(trigs<winL)=[];
        trigs(trigs>size(act,2)-winR)=[];
        
        for ind=1:length(trigs)
            snps(:,:,ind)=act(:,trigs(ind)-winL:trigs(ind)+winR);
        end
        
        stim_resp{siteID,4}(:,:,cntNEU)=mean(snps,3);
        
    end
end

%%

puff_resp=[];

plot_case=4;
tp=7;

for siteID=1:9
    puff_resp(end+1:end+size(stim_resp{siteID,plot_case},1),:)=stim_resp{siteID,plot_case}(:,:,tp);
end

 [~,sort_ind]=sort(mean(puff_resp(:,53:58),2)-mean(puff_resp(:,45:50),2));


figure;
imagesc(puff_resp(sort_ind,:))
set(gca,'clim',[0.99 1.15])
set(gca,'xtick',[0:10:200],'xticklabel',[-5:15])
xlim([20 120])
xlabel('Time [s]');
ylabel('Neurons');




%%

mresp=[];
fraction_cells=0.2;
early_tps=2:3;
late_tps=6:7;
resp_case=2; % 1 grating 2 tone 3 reward 4 puff


for siteID=1:9
    
%     tmp=mean(stim_resp{siteID,4}(:,:,late_tps),3);
%     [~,sort_ind]=sort(mean(tmp(:,53:58),2)-mean(tmp(:,45:50),2));
    
    [~,sort_ind]=sort(mean(ieg_act{siteID}(:,6:7)'));
    
    
    low_ieg=sort_ind(1:round(length(sort_ind)*fraction_cells));
    high_ieg=sort_ind(end-round(length(sort_ind)*fraction_cells):end);
    med_ieg=sort_ind(round(length(sort_ind)*fraction_cells):end-round(length(sort_ind)*fraction_cells));
    
    for tp=1:7
        mresp(:,siteID,tp,1)=(mean(stim_resp{siteID,resp_case}(high_ieg,:,tp),1));
        mresp(:,siteID,tp,2)=(mean(stim_resp{siteID,resp_case}(low_ieg,:,tp),1));
        mresp(:,siteID,tp,3)=(mean(stim_resp{siteID,resp_case}(med_ieg,:,tp),1));
    end
    
end

mresp(mresp==0)=NaN;

for ind=1:size(mresp,2)
    for jnd=1:size(mresp,3)
        for knd=1:size(mresp,4)
            mresp(:,ind,jnd,knd)=mresp(:,ind,jnd,knd)-mean(mresp(1:10,ind,jnd,knd));
        end
    end
end
           
mresp=mresp*100;


figure;
hold on
plot_sem(nanmean(mresp(:,arc_sites,early_tps,1),3),'r',0,[0.9 0.9 0.9],2)
plot_sem(nanmean(mresp(:,arc_sites,early_tps,2),3),'k',0,[0.9 0.9 0.9],2)
plot_sem(nanmean(mresp(:,arc_sites,early_tps,3),3),'c',0,[0.9 0.9 0.9],2)

plot_sem(nanmean(mresp(:,arc_sites,late_tps,1),3),'r--',0,[0.9 0.9 0.9],2)
plot_sem(nanmean(mresp(:,arc_sites,late_tps,2),3),'k--',0,[0.9 0.9 0.9],2)
plot_sem(nanmean(mresp(:,arc_sites,late_tps,3),3),'c--',0,[0.9 0.9 0.9],2)

axis tight
title('Arc')
set(gca,'xtick',[0:10:200],'xticklabel',[-5:15])
xlim([30 150])
xlabel('Time [s]');
ylim([-0.4 1.5])
ylabel(['dF/F [%]'])

figure;
hold on
plot_sem(nanmean(mresp(:,cfos_sites,early_tps,1),3),'r',0,[0.9 0.9 0.9],2)
plot_sem(nanmean(mresp(:,cfos_sites,early_tps,2),3),'k',0,[0.9 0.9 0.9],2)
plot_sem(nanmean(mresp(:,cfos_sites,early_tps,3),3),'c',0,[0.9 0.9 0.9],2)

plot_sem(nanmean(mresp(:,cfos_sites,late_tps,1),3),'r--',0,[0.9 0.9 0.9],2)
plot_sem(nanmean(mresp(:,cfos_sites,late_tps,2),3),'k--',0,[0.9 0.9 0.9],2)
plot_sem(nanmean(mresp(:,cfos_sites,late_tps,3),3),'c--',0,[0.9 0.9 0.9],2)

axis tight
title('cFos')
set(gca,'xtick',[0:10:200],'xticklabel',[-5:15])
xlim([30 150])
xlabel('Time [s]');
ylim([-0.4 1.5])
ylabel(['dF/F [%]'])


%%
% laerning curve


for siteID=1:9
    tp_cnt=0;
    for tp=2:2:size(proj_meta(siteID).rd,2)
        tp_cnt=tp_cnt+1;
        stim1=find(diff(round(proj_meta(siteID).rd(1,tp).ToneID/1.5)==1)==1);
        stim2=find(diff(round(proj_meta(siteID).rd(1,tp).ToneID/1.5)==2)==1);
        
        stim1(stim1>length(proj_meta(siteID).rd(1,tp).LickR)-40)=[];
        stim2(stim2>length(proj_meta(siteID).rd(1,tp).LickR)-40)=[];
        
        resp1=[];
        for ind=1:length(stim1)
            latR=find(proj_meta(siteID).rd(1,tp).LickR(stim1(ind)+20:stim1(ind)+40)<-0.1,1,'first');
            latL=find(proj_meta(siteID).rd(1,tp).LickL(stim1(ind)+20:stim1(ind)+40)<-0.1,1,'first');
            if isempty(latR)&isempty(latL)
                resp1(ind)=0;
            elseif isempty(latR)
                resp1(ind)=1;
            elseif isempty(latL)
                resp1(ind)=2;
            else
                if latL<latR
                    resp1(ind)=1;
                else
                    resp1(ind)=2;
                end
            end
        end
        
        resp2=[];
        for ind=1:length(stim2)
            latR=find(proj_meta(siteID).rd(1,tp).LickR(stim2(ind)+20:stim2(ind)+40)<-0.1,1,'first');
            latL=find(proj_meta(siteID).rd(1,tp).LickL(stim2(ind)+20:stim2(ind)+40)<-0.1,1,'first');
            if isempty(latR)&isempty(latL)
                resp2(ind)=0;
            elseif isempty(latR)
                resp2(ind)=1;
            elseif isempty(latL)
                resp2(ind)=2;
            else
                if latL<latR
                    resp2(ind)=1;
                else
                    resp2(ind)=2;
                end
            end
        end
        
        perf(tp_cnt,siteID)=(sum(resp1==1)+sum(resp2==2))/(sum(resp1>0)+sum(resp2>0));
        
    end
end

perf(perf==1)=NaN;
perf(perf==0)=NaN;

figure;hold on
plot(perf(1:7,:),'color',[1 1 1]*0.5)
plot_sem(perf(1:7,:),'k',0.5,[1 1 1]*0.6,2)
plot([1 7],[0.5 0.5],'k--')
ylim([0.4 0.9])
set(gca,'ytick',[0.4:0.1:0.9])
ylabel(['Fraction correct']);
xlabel('Time [days]')








































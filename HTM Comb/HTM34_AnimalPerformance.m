%% Task performance

% laerning curve


for siteID=1:9
    tp_cnt=0;
    for tp=2:2:size(proj_meta(siteID).rd,2)
        tp_cnt=tp_cnt+1;
        stim1=find(diff(round(proj_meta(siteID).rd(1,tp).ToneID/1.5)==1)==1);       %tone 1 (6kHz)  - lickL correct
        stim2=find(diff(round(proj_meta(siteID).rd(1,tp).ToneID/1.5)==2)==1);       %tone 2 (11kHz) - lickR correct
        
        stim1(stim1>length(proj_meta(siteID).rd(1,tp).LickR)-40)=[];
        stim2(stim2>length(proj_meta(siteID).rd(1,tp).LickR)-40)=[];
        
        %tone 1 
        resp1=[];
        for ind=1:length(stim1)
            latR=find(proj_meta(siteID).rd(1,tp).LickR(stim1(ind)+20:stim1(ind)+40)<-0.1,1,'first');    %check to which spout the animal licked first after the grace periode of tone 1
            latL=find(proj_meta(siteID).rd(1,tp).LickL(stim1(ind)+20:stim1(ind)+40)<-0.1,1,'first');
            if isempty(latR) & isempty(latL)
                resp1(ind)=0;       %passive animal
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
        
        %tone 2
        resp2=[];
        for ind=1:length(stim2)
            latR=find(proj_meta(siteID).rd(1,tp).LickR(stim2(ind)+20:stim2(ind)+40)<-0.1,1,'first');
            latL=find(proj_meta(siteID).rd(1,tp).LickL(stim2(ind)+20:stim2(ind)+40)<-0.1,1,'first');
            if isempty(latR) & isempty(latL)
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
        %select correct trials (resp1 - 1, resp2 - 2)
        %calculate ratio of rewards to active decisions
        perf(tp_cnt,siteID)=(sum(resp1==1)+sum(resp2==2))/(sum(resp1>0)+sum(resp2>0));
        
    end
end

perf(perf==1)=NaN;
perf(perf==0)=NaN;

figure;hold on
plot(perf(1:7,:),'color',[1 1 1]*0.5)
plot_sem(perf(1:7,:),'k',0.5,[1 1 1]*0.6)
plot([1 7],[0.5 0.5],'k--')
ylim([0.4 0.9])
set(gca,'ytick',[0.4:0.1:0.9])
ylabel(['Fraction correct']);
xlabel('Time [days]')
title('Animal Task Performance')

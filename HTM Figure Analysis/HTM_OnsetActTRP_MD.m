% compute onset responses

winL=50;
winR=150;
tone_respR={};
tone_respP={};

%Tone onsets
for siteID=1:9
    cntNEU=0;
    for tp=2:2:size(proj_meta(siteID).rd,2)
        snpsTR=[];
        snpsTP=[];
        cntNEU=cntNEU+1;
        act=act2mat(proj_meta,siteID,tp);
        
        trigsT=find(diff(proj_meta(siteID).rd(1,tp).ToneID>1)==1);
        trigsR=find(diff((proj_meta(siteID).rd(1,tp).RewardL+proj_meta(siteID).rd(1,tp).RewardR)>1)==1);
        trigsP=find(diff((proj_meta(siteID).rd(1,tp).AirPuff)>1)==1);
        cntR = 1;
        trigsTR = [];
        for ind = 1:length(trigsT)
            cntR = cntR + 1;
            tmpTrigDiff = trigsR - trigsT(ind);
            tmpTrigRange = find(tmpTrigDiff > 0 & tmpTrigDiff < 39);
            if size(tmpTrigRange) == 1;
                trigsTR(cntR) = trigsT(ind);
            end
        end
        
        cntP = 1;
        trigsTP = [];
        for ind = 1:length(trigsT)
            cntP = cntP + 1;
            tmpTrigDiff = trigsP - trigsT(ind);
            tmpTrigRange = find(tmpTrigDiff > 0 & tmpTrigDiff < 39);
            if size(tmpTrigRange) == 1;
                trigsTP(cntP) = trigsT(ind);
            end
        end
        
        trigsTR(trigsTR<winL)=[];
        trigsTR(trigsTR>size(act,2)-winR)=[];
        trigsTP(trigsTP<winL)=[];
        trigsTP(trigsTP>size(act,2)-winR)=[];
        
        for ind=1:length(trigsTR)
            snpsTR(:,:,ind)=act(:,trigsTR(ind)-winL:trigsTR(ind)+winR);
        end
        for ind=1:length(trigsTP)
            snpsTP(:,:,ind)=act(:,trigsTP(ind)-winL:trigsTP(ind)+winR);
        end
        tone_respR{siteID,1}(:,:,cntNEU)=mean(snpsTR,3);
        tone_respP{siteID,1}(:,:,cntNEU)=mean(snpsTP,3);
        
    end
end

tone_respPcomb = {};
tone_respRcomb = {};
for day = 1:7
    tone_respPcomb{day} = [];
    tone_respRcomb{day} = [];
    for animal = 1:9
        tone_respPcomb{day} = [tone_respPcomb{day}; squeeze(tone_respP{animal}(:,:,day))];
        tone_respRcomb{day} = [tone_respRcomb{day}; squeeze(tone_respR{animal}(:,:,day))];
    end
end

%%
for day = 1:7
    subplot(2,4,day)
    plot_sem((tone_respRcomb{day}-mean2(tone_respRcomb{day}(:,39:49)))'-(tone_respPcomb{day}-mean2(tone_respPcomb{day}(:,39:49)))','k',0.3);
    plot_sem((tone_respRcomb{day}(1:1271,:)-mean2(tone_respRcomb{day}(1:1271,39:49)))'-(tone_respPcomb{day}(1:1271,:)-mean2(tone_respPcomb{day}(1:1271,39:49)))','b',0.3);
    plot_sem((tone_respRcomb{day}(1272:3090,:)-mean2(tone_respRcomb{day}(1272:3090,39:49)))'-(tone_respPcomb{day}(1272:3090,:)-mean2(tone_respPcomb{day}(1272:3090,39:49)))','r',0.3);
    ylim([-0.005 0.005])
    xlim([1 80])
    line(xlim,[0 0],'Color','k','LineStyle','--')
    line([50 50],ylim,'Color','k','LineStyle','--')
    line([70 70],ylim,'Color','k','LineStyle','--')
    title(sprintf('Day %d',day))
    ylabel('ToneResp Rew-Puff Trials dF/F')
    xlabel('Frame')
   
end
 legend('','All animals','','Arc animals','','cFos Animals')
%% RUN HTM34_IEG_Act first
for day = 1:7
    subplot(2,4,day)
    plot_sem((tone_respRcomb{day}(cArcCells{day},:)-mean2(tone_respRcomb{day}(cArcCells{day},39:49)))'-(tone_respPcomb{day}(cArcCells{day},:)-mean2(tone_respPcomb{day}(cArcCells{day},39:49)))','b',0.3);
    plot_sem((tone_respRcomb{day}(cCfosCells{day},:)-mean2(tone_respRcomb{day}(cCfosCells{day},39:49)))'-(tone_respPcomb{day}(cCfosCells{day},:)-mean2(tone_respPcomb{day}(cCfosCells{day},39:49)))','r',0.3);
    plot_sem((tone_respRcomb{day}(cLowArcCells{day},:)-mean2(tone_respRcomb{day}(cLowArcCells{day},39:49)))'-(tone_respPcomb{day}(cLowArcCells{day},:)-mean2(tone_respPcomb{day}(cLowArcCells{day},39:49)))','--b',0.3);
    plot_sem((tone_respRcomb{day}(cLowCfosCells{day},:)-mean2(tone_respRcomb{day}(cLowCfosCells{day},39:49)))'-(tone_respPcomb{day}(cLowCfosCells{day},:)-mean2(tone_respPcomb{day}(cLowCfosCells{day},39:49)))','--r',0.3);
    ylim([-0.005 0.01])
    xlim([1 80])
    line(xlim,[0 0],'Color','k','LineStyle','--')
    line([50 50],ylim,'Color','k','LineStyle','--')
    line([70 70],ylim,'Color','k','LineStyle','--')
    title(sprintf('Day %d',day))
    ylabel('ToneResp Rew-Puff Trials dF/F')
    xlabel('Frame')
    
end
legend('','High Arc','','High cFos','','Low Arc','','Low cFos')




function [tone_resp, tone_respMean, tone_respMeanHalf, tone_respPA, tone_respPAMean, tone_respPAMeanHalf,...
          tone_respPP, tone_respPPMean, tone_respPPMeanHalf, tone_respR, tone_respRMean, tone_respRMeanHalf,... 
          puff_resp, puff_respMean, puff_respMeanHalf, puff_respAct, puff_respActMean, puff_respActMeanHalf,...
          rew_resp, rew_respMean, rew_respMeanHalf, rew_respAct, rew_respActMean, rew_respActMeanHalf,...
          grat_resp, grat_respMean, grat_respMeanHalf, lickPuff, lickPuffMean, lickRew, lickRewMean,...
          tone_respComb, tone_respPAComb, tone_respPPComb, tone_respRComb,...
          grat_respComb, puff_respComb, puff_respActComb, rew_respComb, rew_respActComb, lickPuffComb, lickRewComb,...
          tone_respCombHalf, grat_respCombHalf, puff_respCombHalf, rew_respCombHalf] = HTM34_OnsetAct_MD(proj_meta)
    
    
    
% compute onset responses
winL=50;
winR=150;

tone_resp={};
tone_respMean = {};

puff_resp={};
puff_respMean = {};
puff_respAct={};
puff_respActMean = {};

rew_resp={};
rew_respMean = {};

grat_resp={};
grat_respMean = {};

lickPuff = {};
lickRew = {};
%Tone onsets
for siteID=1:9
    cntNEU=0;
    for tp=2:2:size(proj_meta(siteID).rd,2)
        snpsT=[];
        snpsTR = [];
        snpsTPa = [];
        snpsTPp = [];
        snpsP=[];
        snpsPact=[];
        snpsR=[];
        snpsRact=[];
        snpsG = [];
        
        licksP = [];
        licksR = [];
        
        cntNEU=cntNEU+1;
        acttmp=act2mat(proj_meta,siteID,tp);
        
        licks = proj_meta(siteID).rd(1,tp).LickR+proj_meta(siteID).rd(1,tp).LickL;
        trigsTtmp=find(diff(conv(proj_meta(siteID).rd(1,tp).ToneID,[1 1 1])>2)==1);
        trigsP=find(diff((proj_meta(siteID).rd(1,tp).AirPuff)>1)==1);
        trigsR=find(diff((proj_meta(siteID).rd(1,tp).RewardL+proj_meta(siteID).rd(1,tp).RewardR)>1)==1);
        trigsG=find(diff(proj_meta(siteID).rd(1,tp).GratID>1)==1);
        
        trigsTtmp(trigsTtmp<winL)=[];
        trigsTtmp(trigsTtmp>size(acttmp,2)-winR)=[];
        trigsP(trigsP<winL)=[];
        trigsP(trigsP>size(acttmp,2)-winR)=[];
        trigsR(trigsR<winL)=[];
        trigsR(trigsR>size(acttmp,2)-winR)=[];
        trigsG(trigsG<winL)=[];
        trigsG(trigsG>size(acttmp,2)-winR)=[];
        
        trigsTP = [];
        trigsTPa = [];
        trigsTPp = [];
        for ind = 1:length(trigsTtmp)
            if length(find(trigsP-trigsTtmp(ind) > 15 & trigsP-trigsTtmp(ind) < 45)) == 1;
                trigsTP = [trigsTP, trigsTtmp(ind)];
            end
            if length(find(trigsP-trigsTtmp(ind) > 15 & trigsP-trigsTtmp(ind) < 36)) == 1;
                trigsTPa = [trigsTPa, trigsTtmp(ind)];
            elseif length(find(trigsP-trigsTtmp(ind) > 35 & trigsP-trigsTtmp(ind) < 45)) == 1;
                trigsTPp = [trigsTPp, trigsTtmp(ind)];
            end
        end
        
        trigsTR = [];
        for ind = 1:length(trigsTtmp)
            if length(find(trigsR-trigsTtmp(ind) > 15 & trigsR-trigsTtmp(ind) < 45)) == 1;
                trigsTR = [trigsTR, trigsTtmp(ind)];
            end
        end
        
        trigsT = sort([trigsTP,trigsTR]);
        
        for ind=1:length(trigsT)
            snpsT(:,:,ind)=acttmp(:,trigsT(ind)-winL:trigsT(ind)+winR);
        end
        for ind=1:length(trigsTPa)
            snpsTPa(:,:,ind)=acttmp(:,trigsTPa(ind)-winL:trigsTPa(ind)+winR);
        end
        for ind=1:length(trigsTPp)
            snpsTPp(:,:,ind)=acttmp(:,trigsTPp(ind)-winL:trigsTPp(ind)+winR);
        end
        for ind=1:length(trigsTR)
            snpsTR(:,:,ind)=acttmp(:,trigsTR(ind)-winL:trigsTR(ind)+winR);
        end
        tone_resp{siteID,cntNEU}=snpsT;
        tone_respMean{siteID,1}(:,:,cntNEU)=mean(snpsT,3);
        tone_respMeanHalf{siteID,1}(:,:,cntNEU)=mean(snpsT(:,:,1:2:end),3);
        
        if ~isempty(snpsTPa)
            tone_respPA{siteID,cntNEU}=snpsTPa;
            tone_respPAMean{siteID,1}(:,:,cntNEU)=mean(snpsTPa,3);
            tone_respPAMeanHalf{siteID,1}(:,:,cntNEU)=mean(snpsTPa(:,:,1:2:end),3);
        else
            tone_respPA{siteID,cntNEU}= NaN(size(acttmp,1),201,1);
            tone_respPAMean{siteID,1}(:,:,cntNEU)=  NaN(size(acttmp,1),201);
            tone_respPAMeanHalf{siteID,1}(:,:,cntNEU)=  NaN(size(acttmp,1),201);
        end
        
        tone_respPP{siteID,cntNEU}=snpsTPp;
        tone_respPPMean{siteID,1}(:,:,cntNEU)=mean(snpsTPp,3);
        tone_respPPMeanHalf{siteID,1}(:,:,cntNEU)=mean(snpsTPp(:,:,1:2:end),3);
        
        if ~isempty(snpsTR)
            tone_respR{siteID,cntNEU}=snpsTR;
            tone_respRMean{siteID,1}(:,:,cntNEU)=mean(snpsTR,3);
            tone_respRMeanHalf{siteID,1}(:,:,cntNEU)=mean(snpsTR(:,:,1:2:end),3);
        else
            tone_respR{siteID,cntNEU}=NaN(size(acttmp,1),201,1);
            tone_respRMean{siteID,1}(:,:,cntNEU)=NaN(size(acttmp,1),201);
            tone_respRMeanHalf{siteID,1}(:,:,cntNEU)=NaN(size(acttmp,1),201);
        end
        
        for ind=1:length(trigsG)
            snpsG(:,:,ind)=acttmp(:,trigsG(ind)-winL:trigsG(ind)+winR);
        end
        grat_resp{siteID,cntNEU}=snpsG;
        grat_respMean{siteID,1}(:,:,cntNEU)=mean(snpsG,3);
        grat_respMeanHalf{siteID,1}(:,:,cntNEU)=mean(snpsG(:,:,1:2:end),3);
        
        pCnt = 0;
        for ind=1:length(trigsP)
            snpsP(:,:,ind)=acttmp(:,trigsP(ind)-winL:trigsP(ind)+winR);
            licksPtmp = licks(trigsP(ind)-winL:trigsP(ind)+winR);
            if min(licksPtmp(45:51)) < -0.2;
                pCnt = pCnt + 1;
                licksP(:,pCnt) = licksPtmp;
                snpsPact(:,:,pCnt)=acttmp(:,trigsP(ind)-winL:trigsP(ind)+winR);
            end
        end
        puff_resp{siteID,cntNEU}=snpsP;
        puff_respMean{siteID,1}(:,:,cntNEU)=mean(snpsP,3);
        puff_respMeanHalf{siteID,1}(:,:,cntNEU)=mean(snpsP(:,:,1:2:end),3);
        
        rCnt = 0;
        for ind=1:length(trigsR)
            snpsR(:,:,ind)=acttmp(:,trigsR(ind)-winL:trigsR(ind)+winR);
            licksRtmp = licks(trigsR(ind)-winL:trigsR(ind)+winR);
            if min(licksRtmp(45:51)) < -0.2;
                rCnt = rCnt + 1;
                licksR(:,rCnt) = licksRtmp;
                snpsRact(:,:,rCnt)=acttmp(:,trigsR(ind)-winL:trigsR(ind)+winR);
            end
        end
        
        if ~isempty(snpsRact)
            rew_resp{siteID,cntNEU}=snpsR;
            rew_respMean{siteID,1}(:,:,cntNEU)=mean(snpsR,3);
            rew_respMeanHalf{siteID,1}(:,:,cntNEU)=mean(snpsR(:,:,1:2:end),3);
        else
            rew_resp{siteID,cntNEU}=NaN(size(acttmp,1),201,1);
            rew_respMean{siteID,1}(:,:,cntNEU) = NaN(size(acttmp,1),201);
            rew_respMeanHalf{siteID,1}(:,:,cntNEU)=NaN(size(acttmp,1),201);
        end
        
        if ~isempty(snpsPact)
            puff_respAct{siteID,cntNEU}=snpsPact;
            puff_respActMean{siteID,1}(:,:,cntNEU)=mean(snpsPact,3);
            puff_respActMeanHalf{siteID,1}(:,:,cntNEU)=mean(snpsPact(:,:,1:2:end),3);
        else
            puff_respAct{siteID,cntNEU}=NaN(size(acttmp,1),201,1);
            puff_respActMean{siteID,1}(:,:,cntNEU) = NaN(size(acttmp,1),201);
            puff_respActMeanHalf{siteID,1}(:,:,cntNEU)=NaN(size(acttmp,1),201);
        end
        
        
        
        if ~isempty(snpsPact)
            rew_respAct{siteID,cntNEU}=snpsRact;
            rew_respActMean{siteID,1}(:,:,cntNEU)=mean(snpsRact,3);
            rew_respActMeanHalf{siteID,1}(:,:,cntNEU)=mean(snpsRact(:,:,1:2:end),3);
        else
            rew_respAct{siteID,cntNEU}=NaN(size(acttmp,1),201,1);
            rew_respActMean{siteID,1}(:,:,cntNEU) = NaN(size(acttmp,1),201);
            rew_respActMeanHalf{siteID,1}(:,:,cntNEU)=NaN(size(acttmp,1),201);
        end
        
        if ~isempty(licksP)
            lickPuff{siteID,cntNEU}=licksP;
            lickPuffMean{siteID,cntNEU}=mean(licksP,2);
        else
            lickPuff{siteID,cntNEU}=NaN(201,1);
            lickPuffMean{siteID,cntNEU}=NaN(201,1);
        end
        
        if ~isempty(licksR)
            lickRew{siteID,cntNEU}=licksR;
            lickRewMean{siteID,cntNEU}=mean(licksR,2);
        else
            lickRew{siteID,cntNEU}=NaN(201,1);
            lickRewMean{siteID,cntNEU}=NaN(201,1);
        end
        
    end
end

tone_respComb = {};
tone_respPAComb = {};
tone_respPPComb = {};
tone_respRComb = {};

grat_respComb = {};
puff_respComb = {};
puff_respActComb = {};
rew_respComb = {};
rew_respActComb = {};
lickPuffComb = {};
lickRewComb = {};

tone_respCombHalf = {};
grat_respCombHalf = {};
puff_respCombHalf = {};
rew_respCombHalf = {};

for day = 1:7
    tone_respComb{day} = [];
    tone_respPAComb{day} = [];
    tone_respPPComb{day} = [];
    tone_respRComb{day} = [];
    
    grat_respComb{day} = [];
    puff_respComb{day} = [];
    puff_respActComb{day} = [];
    rew_respComb{day} = [];
    rew_respActComb{day} = [];
    lickPuffComb{day} = [];
    lickRewComb{day} = [];
    
    tone_respCombHalf{day} = [];
    grat_respCombHalf{day} = [];
    puff_respCombHalf{day} = [];
    rew_respCombHalf{day} = [];
    for animal = 1:9
        tone_respComb{day} = [tone_respComb{day}; squeeze(tone_respMean{animal}(:,:,day))];
        tone_respPAComb{day} = [tone_respPAComb{day}; squeeze(tone_respPAMean{animal}(:,:,day))];
        tone_respPPComb{day} = [tone_respPPComb{day}; squeeze(tone_respPPMean{animal}(:,:,day))];
        tone_respRComb{day} = [tone_respRComb{day}; squeeze(tone_respRMean{animal}(:,:,day))];
        
        grat_respComb{day} = [grat_respComb{day}; squeeze(grat_respMean{animal}(:,:,day))];
        puff_respComb{day} = [puff_respComb{day}; squeeze(puff_respMean{animal}(:,:,day))];
        puff_respActComb{day} = [puff_respActComb{day}; squeeze(puff_respActMean{animal}(:,:,day))];
        rew_respComb{day} = [rew_respComb{day}; squeeze(rew_respMean{animal}(:,:,day))];
        rew_respActComb{day} = [rew_respActComb{day}; squeeze(rew_respActMean{animal}(:,:,day))];
        lickPuffComb{day} = [lickPuffComb{day}, squeeze(lickPuffMean{animal,day})];
        lickRewComb{day} = [lickRewComb{day}, squeeze(lickRewMean{animal,day})];
        
        tone_respCombHalf{day} = [tone_respCombHalf{day}; squeeze(tone_respMeanHalf{animal}(:,:,day))];
        grat_respCombHalf{day} = [grat_respCombHalf{day}; squeeze(grat_respMeanHalf{animal}(:,:,day))];
        puff_respCombHalf{day} = [puff_respCombHalf{day}; squeeze(puff_respMeanHalf{animal}(:,:,day))];
        rew_respCombHalf{day} = [rew_respCombHalf{day}; squeeze(rew_respMeanHalf{animal}(:,:,day))];
    end
end


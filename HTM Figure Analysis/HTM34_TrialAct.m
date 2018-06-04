% compute onset responses

winL=30;
winR=120;
trial_resp={};
trial_respMean = {};

%Tone onsets
for siteID=1:9
    cntNEU=0;
    for tp=2:2:size(proj_meta(siteID).rd,2)
        snpsTr=[];
        trialID = [];
        cntNEU=cntNEU+1;
        acttmp=act2mat(proj_meta,siteID,tp);     
        trigsTr=find(diff(proj_meta(siteID).rd(1,tp).ToneID>1)==1);
      
        trigsTr(trigsTr<winL+1)=[];
        trigsTr(trigsTr>size(acttmp,2)-winR)=[];

        for ind=1:length(trigsTr)
            snpsTr(:,:,ind)=acttmp(:,trigsTr(ind)-winL:trigsTr(ind)+winR);
            if max(proj_meta(siteID).rd(1,tp).AirPuff(trigsTr(ind)-winL:trigsTr(ind)+winR)) > 1
                trialID(ind) = 0;
            else
                trialID(ind) = 1;
            end
        end
        
        trial_resp{siteID,cntNEU}=snpsTr;
        trial_respID{siteID,cntNEU} = trialID;
        trial_respMean{siteID,1}(:,:,cntNEU)=mean(snpsTr,3);
    end
end
%%
trial_respComb = {};

for day = 1:7
    trial_respComb{day} = [];
    

    for animal = 1:9
        trial_respComb{day} = [trial_respComb{day}; squeeze(trial_respMean{animal}(:,:,day))];
    end
end

%%
%Plot task related activity

figure;
plot_sem(trial_respComb{7}' - mean2(trial_respComb{7}(:,1)),'k');
ylim([-0.001 0.01]); xlim([1 151])
line([11 11],ylim,'color','k','linestyle','--');
line([31 31],ylim,'color','k','linestyle','--');
line([51 51],ylim,'color','k','linestyle','--');
line([71 71],ylim,'color','k','linestyle','--');
line(xlim,[0 0],'color','k','linestyle','--');
ylabel('dF/F');
set(gca,'XTick',[11 21 31 41 51 61 71 81 91 101 111 121 131 141 151],'XTickLabel',{'0','1','2','3','4','5','6','7','8','9','10','11','12','13','14'})
title('Trial Activity')



trialID = {};
popAct = {};
preAct = {};
for day = 1:7
    for animal = 1:9
        %Pre decision 
        popAct{animal,day} = cat(3,puff_respAct{animal,day}, rew_respAct{animal,day});

        if ~isnan(popAct{animal,day})
            trialID{animal,day} = [zeros(size(puff_respAct{animal,day},3),1);ones(size(rew_respAct{animal,day},3),1)];
            preAct{animal,day} = squeeze(mean(popAct{animal,day}(:,40:49,:),2)); %- squeeze(mean(popAct{animal,day}(:,30:39,:),2));
        end
    end
end

performance = [];
for rep = 1:15;
    
    for day = 1:7;
        for animal = 1:9;
            tmpIDs = trialID{animal,day}(1:2:end);
            tmpAct = preAct{animal,day}(:,1:2:end);
            rews = find(tmpIDs == 1);
            puffs = find(tmpIDs == 0);
            minResp = min([length(rews),length(puffs)]);
            IDs = [rews(1:minResp); puffs(1:minResp)];
            if length(IDs) > 10;
                Tree = TreeBagger(50,tmpAct(:,IDs)',tmpIDs(IDs)); %
                
                tmpPredict = Tree.predict(preAct{animal,day}(:,2:2:end)');
                
                Predict = [];
                for ind = 1:length(tmpPredict)
                    Predict(ind) = str2double(tmpPredict{ind});
                end
                
                tmpCon = confusionmat(Predict,trialID{animal,day}(2:2:end));
                tmpPerform = [];
                for jnd = 1:2;
                    tmpPerform(jnd) = tmpCon(jnd,jnd)/sum(tmpCon(jnd,:));
                end
                performance(animal,day,rep) = nanmean(tmpPerform);
            else
                performance(animal,day,rep) = NaN(1,1);
                
            end
                
        end
    end
end



mean_performance = nanmean(performance,3);


figure;
subplot(121);hold on
plotSEM(mean_performance');
ylabel('Performance')
xlabel('Day')
ylim([0.3 0.7]); xlim([1 7])
title('Classification: Reward vs. Puff Last 1 s of Grace Period')
hline = refline([0 0.5])
hline.Color = 'k';

[h,p]=ttest(nanmean(nanmean(performance(:,6:7,:),3),2)-0.5)

% subplot(122)
% perfEarly = mean_performance(:,2:3);
% perfLate = mean_performance(:,6:7);
% 
% bar(1,nanmean(perfEarly(:)),'FaceColor','W','LineStyle','-'); hold on
% bar(2,nanmean(perfLate(:)),'FaceColor','W','LineStyle',':');
% errorbar(1,nanmean(perfEarly(:)),nanstd(perfEarly(:))/sqrt(18),'k');
% errorbar(2,nanmean(perfLate(:)),nanstd(perfLate(:))/sqrt(18),'k');
% ylim([0.3 0.7])
% line(xlim,[0.5 0.5],'Color','k')
% ylabel('Performance');
% legend('Before Learning','After Learning')



%Decode population vector activity in the grace-period to determine
%reward/airpuff
trialID = {};
popAct = {};
preAct = {};
for day = 1:7
    for animal = 1:9
        %Pre decision lick
        %Train on all cells
        popAct{animal,day} = cat(3,tone_respPA{animal,day}, tone_respR{animal,day});

        if ~isnan(popAct{animal,day})
            trialID{animal,day} = [zeros(size(tone_respPA{animal,day},3),1);ones(size(tone_respR{animal,day},3),1)];
            preAct{animal,day} = squeeze(mean(popAct{animal,day}(:,40:49,:),2)); % - squeeze(mean(popAct{animal,day}(:,30:39,:),2));
        end
    end
end

performance = [];
for rep = 1:15;
    
    for day = 1:7;
        for animal = 1:9;
            tmpIDs = trialID{animal,day}(1:2:end);
            tmpAct = preAct{animal,day}(:,1:2:end);
            rews = find(tmpIDs == 1);
            puffs = find(tmpIDs == 0);
            minResp = min([length(rews),length(puffs)]);
            IDs = [rews(1:minResp); puffs(1:minResp)];
            if length(IDs) > 10;
                Tree = TreeBagger(50,tmpAct(:,IDs)',tmpIDs(IDs)); %
                
                tmpPredict = Tree.predict(preAct{animal,day}(:,2:2:end)');
                
                Predict = [];
                for ind = 1:length(tmpPredict)
                    Predict(ind) = str2double(tmpPredict{ind});
                end
                
                tmpCon = confusionmat(Predict,trialID{animal,day}(2:2:end));
                tmpPerform = [];
                for jnd = 1:2;
                    tmpPerform(jnd) = tmpCon(jnd,jnd)/sum(tmpCon(jnd,:));
                end
                performance(animal,day,rep) = nanmean(tmpPerform);
            else
                performance(animal,day,rep) = NaN(1,1);
                
            end
                
        end
    end
end

mean_performance = nanmean(performance,3);
subplot(121)
plotSEM(mean_performance');

[h,p]=ttest(nanmean(nanmean(performance(:,6:7,:),3),2)-0.5)

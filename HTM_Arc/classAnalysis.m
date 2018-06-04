%Classification analysis of reward vs. puff trials using pre-activity

%For reward vs. puff
classWdwAct = {};
trialIDClas = {};
performance = [];
for day = 1:7
    for animal = 1:4
        if ~isempty(act{animal,day})
            tmpAct = trialAct{animal,day}(~isnan(trialID{animal,day}(:,1,1)),:,:); %Get trialID from alignAct script.
            classWdwAct{animal,day} = squeeze(nanmean(tmpAct(:,:,30:40),3));
            trialIDClas{animal,day} = trialID{animal,day}(~isnan(trialID{animal,day}));
        end
    end
end

for day = 1:7;
    for animal = 1:4;
        if ~isempty(act{animal,day}) & ~isempty(trialIDClas{animal,day});
            Tree = TreeBagger(500,classWdwAct{animal,day}(1:2:end,:),num2str(trialIDClas{animal,day}(1:2:end))); %
            
            tmpPredict = Tree.predict(classWdwAct{animal,day}(2:2:end,:));
            
            Predict = [];
            for ind = 1:length(tmpPredict)
                Predict(ind) = str2double(tmpPredict{ind});
            end
            
            tmpCon = confusionmat(Predict,trialIDClas{animal,day}(2:2:end)');
            tmpPerform = [];
            if size(tmpCon,2) > 1
                tmpPerform = sum(diag(tmpCon))/sum(tmpCon(:));
            else
                    tmpPerform = 1;
            end
            performance(animal,day) = mean(tmpPerform);
        end
    end
end

figure;
plotSEM(performance');
ylabel('Performance')
xlabel('Day')
ylim([0 1.1])
title('Treebagger Classification of Reward vs. aPuff frame 30:38')
hline = refline([0 0.5])
hline.Color = 'k';

%%
%For tone 1 vs. tone 2
classWdwAct = {};
trialIDClas = {};
performance = [];
for day = 1:8
    for animal = 1:4
        if ~isempty(act{animal,day})
            tmpAct = [tone1Act{animal,day};tone2Act{animal,day}];
            classWdwAct{animal,day} = squeeze(nanmean(tmpAct(:,:,15:20),3));
            trialIDClas{animal,day} = [zeros(size(tone1Act{animal,day},1),1);ones(size(tone2Act{animal,day},1),1)];
        end
    end
end

for day = 1:8;
    for animal = 1:4;
        if ~isempty(act{animal,day}) & ~isempty(trialIDClas{animal,day});
            Tree = TreeBagger(500,classWdwAct{animal,day}(1:2:end,:),num2str(trialIDClas{animal,day}(1:2:end))); %
            
            tmpPredict = Tree.predict(classWdwAct{animal,day}(2:2:end,:));
            
            Predict = [];
            for ind = 1:length(tmpPredict)
                Predict(ind) = str2double(tmpPredict{ind});
            end
            
            tmpCon = confusionmat(Predict,trialIDClas{animal,day}(2:2:end)');
            tmpPerform = [];
            if size(tmpCon,2) > 1
                tmpPerform = sum(diag(tmpCon))/sum(tmpCon(:));
            else
                    tmpPerform = 1;
            end
            performance(animal,day) = mean(tmpPerform);
        end
    end
end

figure;
plotSEM(performance');
ylabel('Performance')
xlabel('Day')
ylim([0 1.1])
title('Treebagger Classification of Tone1 vs.Tone2 frame 15:20')
hline = refline([0 0.5])
hline.Color = 'k';

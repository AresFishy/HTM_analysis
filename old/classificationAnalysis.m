%Classifier analysis
onsetActWdw = {};
onsetActEleComb = {};
onsetActID = {};
on = 15; %Onset frame
for day = 1:8
    for animal = 1:6
        onsetActEleComb{animal,day} = [];
        onsetActID{animal,day} = [];
        cnt = 0;
        for ele = [3,5]; %Choose which elements to 
            cnt = cnt + 1;
            if ~isempty(onsetAct{animal,day,ele})
                onsetActWdw{animal,day,cnt} = nanmean(onsetAct{animal,day,ele}(:,:,on+5:on+10),3);
                
                onsetActEleComb{animal,day} = [onsetActEleComb{animal,day}, onsetActWdw{animal,day,cnt}];
                onsetActID{animal,day} = [onsetActID{animal,day}; repmat(cnt,size(onsetActWdw{animal,day,cnt},2),1)];
            end
        end
    end
end

%%

%Gratings vs Tones classification
performance = [];
for day = [1:6];
    for animal = 1:6;
        if ~isempty(onsetAct{animal,day})
            tmpID = onsetActID{animal,6};
            tmpID2 = onsetActID{animal,day};
            
            tmpID(tmpID == 1 | tmpID == 3 | tmpID == 5 | tmpID == 6) = 1;
            tmpID(tmpID == 2 | tmpID == 4 | tmpID == 7 | tmpID == 8) = 2;
            
            tmpID2(tmpID2 == 1 | tmpID2 == 3 | tmpID2 == 5 | tmpID2 == 6) = 1;
            tmpID2(tmpID2 == 2 | tmpID2 == 4 | tmpID2 == 7 | tmpID2 == 8) = 2;
            
            Tree = TreeBagger(1000,onsetActEleComb{animal,day}(:,1:2:end)',num2str(tmpID2(1:2:end))); %Use tmpID for training on a single day, else tmpID2, and replace day with number in onsetActEleComb
            
            tmpPredict = Tree.predict(onsetActEleComb{animal,day}(:,2:2:end)');
            
            Predict = [];
            for ind = 1:length(tmpPredict)
                Predict(ind) = str2double(tmpPredict{ind});
            end
            
%             figure;
%             plot(Predict); hold on
%             ylim([0 3])
%             plot(tmpID(2:2:end))
%             set(gca,'clim',[1 80])
%             
%             figure;
%             imagesc(confusionmat(Predict,tmpID(2:2:end)))
            
            tmpCon = confusionmat(Predict,tmpID2(2:2:end));
            tmpPerform = [];
            for jnd = 1:2; 
                tmpPerform(jnd) = tmpCon(jnd,jnd)/sum(tmpCon(jnd,:));
            end
            performance(animal,day) = mean(tmpPerform);
        end
    end
end

performance(6,1) = NaN(1,1);

figure;
plotSEM(performance');
ylabel('Performance')
xlabel('Day')
ylim([0 1])
title('Treebagger Classification of Grating vs. Tone, Day 6 Training')
hline = refline([0 0.5])
hline.Color = 'k';

%%
%Individual elements classification
performance = [];
for day = [1:6];
    for animal = 1:6;
        if ~isempty(onsetAct{animal,day})
            tmpID = onsetActID{animal,6};
            tmpID2 = onsetActID{animal,day};
            
            tmpID(tmpID == 1 | tmpID == 5) = 1;
            tmpID(tmpID == 2 | tmpID == 7) = 2;
            tmpID(tmpID == 3 | tmpID == 6) = 3;
            tmpID(tmpID == 4 | tmpID == 8) = 4;
            
            tmpID2(tmpID2 == 1 | tmpID2 == 5) = 1;
            tmpID2(tmpID2 == 2 | tmpID2 == 7) = 2;
            tmpID2(tmpID2 == 3 | tmpID2 == 6) = 3;
            tmpID2(tmpID2 == 4 | tmpID2 == 8) = 4;
            
            Tree = TreeBagger(1000,onsetActEleComb{animal,6}(:,1:2:end)',num2str(tmpID(1:2:end))); %Use tmpID for training on a single day, else tmpID2
            
            tmpPredict = Tree.predict(onsetActEleComb{animal,day}(:,2:2:end)');
            
            Predict = [];
            for ind = 1:length(tmpPredict)
                Predict(ind) = str2double(tmpPredict{ind});
            end
            
%             figure;
%             plot(Predict); hold on
%             ylim([0 5])
%             plot(tmpID(2:2:end))
%             set(gca,'clim',[1 80])
%             
%             figure;
%             imagesc(confusionmat(Predict,tmpID(2:2:end)))
%             pause
            tmpCon = confusionmat(Predict,tmpID2(2:2:end));
            tmpPerform = [];
            for jnd = 1:4; 
                tmpPerform(jnd) = tmpCon(jnd,jnd)/sum(tmpCon(jnd,:));
            end
            performance(animal,day) = mean(tmpPerform);
        end
    end
end

performance(6,1) = NaN(1,1);

figure;
plotSEM(performance');
ylabel('Correct-False ratio')
xlabel('Day')
ylim([0 1])
title('Treebagger Classification of Element vs. Element - Training Day 6')
hline = refline([0 0.25])
hline.Color = 'k';

%%
%Sequence classification
performance = [];
for day = [1:6];
    for animal = 1:6;
        if ~isempty(onsetAct{animal,day})
            tmpID = onsetActID{animal,day};
            
            tmpID(tmpID == 1 | tmpID == 2) = 1;
            tmpID(tmpID == 3 | tmpID == 4) = 2;
            
            
            Tree = TreeBagger(1000,onsetActEleComb{animal,day}(:,1:2:end)',num2str(tmpID(1:2:end)));
            
            tmpPredict = Tree.predict(onsetActEleComb{animal,day}(:,2:2:end)');
            
            Predict = [];
            for ind = 1:length(tmpPredict)
                Predict(ind) = str2double(tmpPredict{ind});
            end
            
%             figure;
%             plot(Predict); hold on
%             ylim([0 5])
%             plot(tmpID(2:2:end))
%             set(gca,'clim',[1 80])
%             
%             figure;
%             imagesc(confusionmat(Predict,tmpID(2:2:end)))
%             pause
            tmpCon = confusionmat(Predict,tmpID(2:2:end));
            tmpPerform = [];
            for jnd = 1:2; 
                tmpPerform(jnd) = tmpCon(jnd,jnd)/sum(tmpCon(jnd,:));
            end
            performance(animal,day) = mean(tmpPerform);
        end
    end
end

performance(6,1) = NaN(1,1);

figure;
plotSEM(performance');
ylabel('Correct-False ratio')
xlabel('Day')
ylim([0 1])
title('Treebagger Classification of Sequence Using Ele 2&3 vs 7&8')
hline = refline([0 0.5])
hline.Color = 'k';

%%
%Single Element vs Element classification
performance = [];
for day = [1:6];
    for animal = 1:6;
        if ~isempty(onsetAct{animal,day})
            tmpID = onsetActID{animal,day};
            
%             tmpID(tmpID == 2) = 1;
%             tmpID(tmpID == 8) = 2;
            
            
            Tree = TreeBagger(1000,onsetActEleComb{animal,day}(:,1:2:end)',num2str(tmpID(1:2:end)));
            
            tmpPredict = Tree.predict(onsetActEleComb{animal,day}(:,2:2:end)');
            
            Predict = [];
            for ind = 1:length(tmpPredict)
                Predict(ind) = str2double(tmpPredict{ind});
            end
            
%             figure;
%             plot(Predict); hold on
%             ylim([0 5])
%             plot(tmpID(2:2:end))
%             set(gca,'clim',[1 80])
%             
%             figure;
%             imagesc(confusionmat(Predict,tmpID(2:2:end)))
%             pause
            tmpCon = confusionmat(Predict,tmpID(2:2:end));
            tmpPerform = [];
            for jnd = 1:2; 
                tmpPerform(jnd) = tmpCon(jnd,jnd)/sum(tmpCon(jnd,:));
            end
            performance(animal,day) = mean(tmpPerform);
        end
    end
end

performance(6,1) = NaN(1,1);

figure;
plotSEM(performance');
ylabel('Correct-False ratio')
xlabel('Day')
ylim([0 1])
title('Treebagger Classification of Sequence Using Ele 3 vs 5')
hline = refline([0 0.5])
hline.Color = 'k';


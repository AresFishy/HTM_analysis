%Reward vs Puff classification

onsetActWdw = {};
for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            idVec{animal,day} = zeros(size(onsetAct{animal,day},2),1);
            idVec{animal,day}(rew{animal,day}) = 1;
            onsetActWdw{animal,day} = squeeze(nanmean(seqAct{animal,day}(:,:,185:195),3));
        end
    end
end

for day = 1:8;
    for animal = 1:6;
        if ~isempty(act{animal,day})
            Tree = TreeBagger(500,onsetActWdw{animal,day}(:,1:2:end)',num2str(idVec{animal,day}(1:2:end))); %
            
            tmpPredict = Tree.predict(onsetActWdw{animal,day}(:,2:2:end)');
            
            Predict = [];
            for ind = 1:length(tmpPredict)
                Predict(ind) = str2double(tmpPredict{ind});
            end
            
            tmpCon = confusionmat(Predict,idVec{animal,day}(2:2:end));
            tmpPerform = [];
            for jnd = 1:2;
                tmpPerform(jnd) = tmpCon(jnd,jnd)/sum(tmpCon(jnd,:));
            end
            performance(animal,day) = mean(tmpPerform);
        end
    end
end


performance(6,1) = NaN(1,1);
performance(2,7) = NaN(1,1);
performance(2,8) = NaN(1,1);


figure;
plotSEM(performance');
ylabel('Performance')
xlabel('Day')
ylim([0 1.1])
title('Treebagger Classification of Reward vs. Puff frame 185:195')
hline = refline([0 0.5])
hline.Color = 'k';

%%
%Omission vs no-omission classification

onsetActWdw = {};
idVec = {};
for day = 7:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            idVec{animal,day} = zeros(length([om{animal,day}',noOm{animal,day}(1:4:end)]),1);
            idVec{animal,day}(1:length(om{animal,day})) = 1;
            onsetActWdw{animal,day} = squeeze(nanmean(seqAct{animal,day}(:,[om{animal,day}',noOm{animal,day}(1:4:end)],120:130),3));
        end
    end
end

performance = [];
for day = 7:8;
    for animal = 1:6;
        if ~isempty(act{animal,day})
            
            Tree = TreeBagger(500,onsetActWdw{animal,day}(:,1:2:end)',num2str(idVec{animal,day}(1:2:end))); %
            
            tmpPredict = Tree.predict(onsetActWdw{animal,day}(:,2:2:end)');
            
            Predict = [];
            for ind = 1:length(tmpPredict)
                Predict(ind) = str2double(tmpPredict{ind});
            end
            
            tmpCon = confusionmat(Predict,idVec{animal,day}(2:2:end));
            tmpPerform = [];
            for jnd = 1:2;
                tmpPerform(jnd) = tmpCon(jnd,jnd)/sum(tmpCon(jnd,:));
            end
            tmpPerform(isnan(tmpPerform)) = 0;
            performance(animal,day) = mean(tmpPerform);
        end
    end
end


performance(6,1) = NaN(1,1);
performance(2,7) = NaN(1,1);
performance(2,8) = NaN(1,1);


figure;
plotSEM(performance(:,7:8)');
ylabel('Performance')
xlabel('Day')
ylim([0 1.1])
title('Treebagger Classification of Omission vs No Omission Frame 120:130')
hline = refline([0 0.5])
hline.Color = 'k';

%%
%Seq1 vs Sew2 classification

onsetActWdw = {};
idVec = {};

for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            idVec{animal,day} = seqID12{animal,day};
            onsetActWdw{animal,day} = squeeze(nanmean(seqAct{animal,day}(:,:,50:200),3));
        end
    end
end

performance = [];
for day = 1:8;
    for animal = 1:6;
        if ~isempty(act{animal,day})
            [idVecSort,idVecSortIdx] = sort(idVec{animal,day});
            treeAct = onsetActWdw{animal,day}(:,idVecSortIdx);
            
            Tree = TreeBagger(500,treeAct(:,1:2:end)',num2str(idVecSort(1:2:end))); %
            
            tmpPredict = Tree.predict(treeAct(:,2:2:end)');
            
            Predict = [];
            for ind = 1:length(tmpPredict)
                Predict(ind) = str2double(tmpPredict{ind});
            end
            
            tmpCon = confusionmat(Predict,idVecSort(2:2:end));
            tmpPerform = [];
            for jnd = 1:2;
                tmpPerform(jnd) = tmpCon(jnd,jnd)/sum(tmpCon(jnd,:));
            end
            performance(animal,day) = mean(tmpPerform);
        end
    end
end


performance(6,1) = NaN(1,1);
performance(2,7) = NaN(1,1);
performance(2,8) = NaN(1,1);


figure;
plotSEM(performance');
ylabel('Performance')
xlabel('Day')
ylim([0 1.1])
title('Treebagger Classification of Seq1 vs. Seq2 using frame 50:200')
hline = refline([0 0.5])
hline.Color = 'k';

%%
%Reward vs Puff classification using Pupil

onsetActWdw = {};
for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            idVec{animal,day} = zeros(size(onsetAct{animal,day},2),1);
            idVec{animal,day}(rew{animal,day}) = 1;
            onsetActWdw{animal,day} = squeeze(nanmean(seqPupil{animal,day}(:,175:180),2));
        end
    end
end

for day = 1:8;
    for animal = 1:6;
        if ~isempty(act{animal,day})
            Tree = TreeBagger(500,onsetActWdw{animal,day}(1:2:end),num2str(idVec{animal,day}(1:2:end))); %
            
            tmpPredict = Tree.predict(onsetActWdw{animal,day}(2:2:end));
            
            Predict = [];
            for ind = 1:length(tmpPredict)
                Predict(ind) = str2double(tmpPredict{ind});
            end
            
            tmpCon = confusionmat(Predict,idVec{animal,day}(2:2:end));
            tmpPerform = [];
            for jnd = 1:2;
                tmpPerform(jnd) = tmpCon(jnd,jnd)/sum(tmpCon(jnd,:));
            end
            performance(animal,day) = mean(tmpPerform);
        end
    end
end


performance(6,1) = NaN(1,1);
performance(2,7) = NaN(1,1);
performance(2,8) = NaN(1,1);


figure;
plotSEM(performance');
ylabel('Performance')
xlabel('Day')
ylim([0 1.1])
title('Treebagger Classification of Reward vs. Puff Using Pupil frame 175:180')
hline = refline([0 0.5])
hline.Color = 'k';

%%
%Seq1 vs Sew2 classification using Pupil
for wdw = [10:30:130, 180];
    onsetActWdw = {};
    idVec = {};
    
    for day = 1:8
        for animal = 1:6
            if ~isempty(act{animal,day})
                idVec{animal,day} = seqID12{animal,day};
                onsetActWdw{animal,day} = squeeze(nanmean(seqPupil{animal,day}(:,wdw:wdw+10),2));
            end
        end
    end
    
    performance = [];
    for day = 1:8;
        for animal = 1:6;
            if ~isempty(act{animal,day})
                
                Tree = TreeBagger(500,onsetActWdw{animal,day}(1:2:end),num2str(idVec{animal,day}(1:2:end))); %
                
                tmpPredict = Tree.predict(onsetActWdw{animal,day}(2:2:end));
                
                Predict = [];
                for ind = 1:length(tmpPredict)
                    Predict(ind) = str2double(tmpPredict{ind});
                end
                
                tmpCon = confusionmat(Predict,idVec{animal,day}(2:2:end));
                tmpPerform = [];
                for jnd = 1:2;
                    tmpPerform(jnd) = tmpCon(jnd,jnd)/sum(tmpCon(jnd,:));
                end
                performance(animal,day) = mean(tmpPerform);
            end
        end
    end
    
    
    performance(6,1) = NaN(1,1);
    performance(2,7) = NaN(1,1);
    performance(2,8) = NaN(1,1);
    
    str = sprintf('Treebagger Classification of Seq1 vs. Seq2 using Pupil frame %d : %d',wdw,wdw+10)
    figure;
    plotSEM(performance');
    ylabel('Performance')
    xlabel('Day')
    ylim([0 1.1])
    title(str)
    hline = refline([0 0.5])
    hline.Color = 'k';
    
end
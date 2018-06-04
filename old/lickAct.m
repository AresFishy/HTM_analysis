%Get number of licks during the response time

highActComb = {};
lowActComb = {};
seqActHigh = {};
seqActLow = {};
highLick = {};
lowLick = {};
lickCount = {};

for day = 1:8
    for animal = 1:6
        if ~isempty(act{animal,day})
            for on = 1:size(seqLick{animal,day},1)
                lickCount{animal,day}(on) = length(find(diff(seqLick{animal,day}(on,150:180) > 0.1) == 1));
            end
            highLick{animal,day} = find(lickCount{animal,day} > 3);
            lowLick{animal,day} = find(lickCount{animal,day} < 3);
            seqActHigh{animal,day} = squeeze(nanmean(seqAct{animal,day}(:,highLick{animal,day},:),2));
            seqActLow{animal,day} = squeeze(nanmean(seqAct{animal,day}(:,lowLick{animal,day},:),2));
        else
            seqActHigh{animal,day} = NaN(size(act{animal,2},1),200);
            seqActLow{animal,day} = NaN(size(act{animal,2},1),200);
        end
    end
    highActComb{day} = vertcat(seqActHigh{:,day});
    lowActComb{day} = vertcat(seqActLow{:,day});
end

%%
day = 1;
figure;
subplot(121)
plotSEM(highActComb{day}(rewCellsComb{day},:)')
plotSEM(lowActComb{day}(rewCellsComb{day},:)')
title('seq1rew cells')
legend({'Low Lick','High Lick'})
ylabel('dF/F')
xlabel('Frame #')
subplot(122)
plotSEM(highActComb{day}(puffCellsComb{day},:)')
plotSEM(lowActComb{day}(puffCellsComb{day},:)')
title('seq2puff cells')
legend({'Low Lick','High Lick'})
ylabel('dF/F')
xlabel('Frame #')

%%
%Plot lick count vs. onset activity
for day = 1;
    for animal = 1:5
        plot(lickCount{animal,day},squeeze(mean(nanmean(onsetAct{animal,day}(:,:,15:25),3),1)),'.'); hold on
        test = corrcoef(lickCount{animal,day},squeeze(mean(nanmean(onsetAct{animal,day}(:,:,15:25),3),1)));
        testcorr(animal) = test(1,2);
    end
end
ylabel('End Onset Act')
xlabel('Lick Count Frame 150-180')
title('Lick count vs End Onset Act ')
    

%%
%Get scatterplot of reward act vs. lick
cnt = 0;
for day = 1:8 
    for animal = 1:6
        if ~isempty(act{animal,day}) 
            cnt = cnt + 1;
            plot(mean(seqLick{animal,day}(rew{animal,day},180:200),2),squeeze(mean(mean(onsetAct{animal,day}(rewCells{animal,day},rew{animal,day},15:25),1),3)),'.k'); hold on
%             tmpcorr = corrcoef(mean(seqLick{animal,day}(puff{animal,day},180:200),2),squeeze(mean(mean(onsetAct{animal,day}(rewCells{animal,day},puff{animal,day},15:25),1),3)));
%             lickCorrR(cnt) = tmpcorr(1,2);
        end
    end
end
refline([0 0])
line([0 0],get(gca,'ylim'),'color','k')
xlabel('Lick Activity  frame 180:200')
ylabel('Reward Cells Activity  dF/F')
title('Reward vs. Lick Activity - onsetAct Frame Rew Trials 15:25 (185:195)')
    
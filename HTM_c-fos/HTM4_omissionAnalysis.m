%Find omissions
om = {};
noOm = {};
for day = 7
    for animal = 1:5
        [tmpOm{animal,day},~] = find(seqIDsig{animal,day} < 0.35 & seqIDsig{animal,day} > 0.15);
        om{animal,day} = unique(tmpOm{animal,day});
        omSel{animal,day} = om{animal,day}(find(mod(om{animal,day},2) ~= 0));
        om{animal,day} = om{animal,day}(find(mod(om{animal,day},2) == 0));
        [tmpNoOm{animal,day},~] = find(seqIDsig{animal,day} < 2.25 & seqIDsig{animal,day} > 1.75);
        noOm{animal,day} = unique(tmpNoOm{animal,day});
        noOm{animal,day} = noOm{animal,day}(find(mod(noOm{animal,day},2) == 0));
        noOmSel{animal,day} = noOm{animal,day}(find(mod(noOm{animal,day},2) ~= 0));
    end
end

%%
%Find omission responsive cells
for day = 7:8
    for animal = 1:6
        omTestN = [];
        omTestP = [];
        if ~isempty(act{animal,day})
            for cell = 1:size(act{animal,day},1)
                 Aom = mean(onsetActOMS{animal,day}(cell,:,15:25),3); %Tone2 starts at idx 11
                 Bom = mean(onsetActOMS{animal,day}(cell,:,1:10),3); %Tone2 starts at idx 11
                 omTestN(cell) = ttest(Aom,Bom,'Tail','left','alpha',0.01);
                 omTestP(cell) = ttest(Aom,Bom,'Tail','right','alpha',0.01);
            end
            omCellsN{animal,day} = find(omTestN == 1);
            omCellsP{animal,day} = find(omTestP == 1);
        end
    end
    omCellsCombN{day} = [];
    omCellsCombP{day} = [];
    cellVector = [0, 361, 135, 387, 249, 324]; %Number of cells per animal
    for animal = 1:6;
        omCellsCombN{day} = [omCellsCombN{day}, omCellsN{animal,day}+sum(cellVector(1:animal))];
        omCellsCombP{day} = [omCellsCombP{day}, omCellsP{animal,day}+sum(cellVector(1:animal))];
    end
end

%%
%Plot omission responsive cells
figure;
subplot(121)
plotSEM(OnsetActCombOM{7}(omCellsCombP{7},1:40)')
plotSEM(OnsetActCombNoOM{7}(omCellsCombP{7},1:40)')
plotSEM(OnsetActCombOM{7}(omCellsCombN{7},1:40)')
plotSEM(OnsetActCombNoOM{7}(omCellsCombN{7},1:40)')
line([11 11],get(gca,'ylim'),'color','k')
line([21 21],get(gca,'ylim'),'color','k')
title('Omission cell responses day 7')
legend({'N cells NoOmAct','P cells NoOmAct','P cells OmAct','N cells OmAct'})
subplot(122)
plotSEM(OnsetActCombOM{8}(omCellsCombP{8},1:40)')
plotSEM(OnsetActCombNoOM{8}(omCellsCombP{8},1:40)')
plotSEM(OnsetActCombOM{8}(omCellsCombN{8},1:40)')
plotSEM(OnsetActCombNoOM{8}(omCellsCombN{8},1:40)')
line([11 11],get(gca,'ylim'),'color','k')
line([21 21],get(gca,'ylim'),'color','k')
title('Omission cell responses day 8')
legend({'N cells NoOmAct','P cells NoOmAct','P cells OmAct','N cells OmAct'})

%%
for animal = 1:6;
    str = sprintf('Animal %d', animal)
        day = 8;
    subplot(3,2,animal)
    plotSEM(squeeze(mean(onsetAct{animal,day}(rewCellsNeg{animal,day},om{animal,day},:),2))'); hold on
    plotSEM(squeeze(mean(onsetAct{animal,day}(rewCellsNeg{animal,day},noOm{animal,day},:),2))')
    title(str)
    ylabel('dF/F')
    xlabel('Frame #')
    legend({'No Omission','Omission'})
end

%%
omAct = {};
noOmAct = {};
for day = 7:8
    for animal = 1:6;
        if length(rew1Cells{animal,day}) > 2
            omAct{animal,day} = squeeze(mean(mean(onsetAct{animal,day}(rewCellsNeg{animal,day},om{animal,day},15:25),2),3))';
            noOmAct{animal,day} = squeeze(mean(mean(onsetAct{animal,day}(rewCellsNeg{animal,day},noOm{animal,day},15:25),2),3))';
        end
    end
end
omMean = mean([horzcat(omAct{:,7}),horzcat(omAct{:,8})]);
omSTD = std([horzcat(omAct{:,7}),horzcat(omAct{:,8})]) / sqrt(length(rew1CellsComb{day}));
noOmMean = mean([horzcat(noOmAct{:,7}),horzcat(noOmAct{:,8})]);
noOmSTD = std([horzcat(noOmAct{:,7}),horzcat(noOmAct{:,8})]) / sqrt(length(rew1CellsComb{day}));


figure;
bar(1,omMean,'r'); hold on
bar(2,noOmMean,'k')
errorbar(1,omMean,omSTD,'r');
errorbar(2,noOmMean,noOmSTD,'k');
ylabel('dF/F')
legend({'Omission','No Omission'})
title('End OnsetAct dependent on omission')

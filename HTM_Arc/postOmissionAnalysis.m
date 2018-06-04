%Activity following an omission

omRewAct = {};
noOmrewTrials = {};
noomRewAct = {};
cOmRewAct = {};
cNoomRewAct= {};

for day = 7
    for animal = 1:4
        omRewAct{animal,day} = squeeze(nanmean(trialAct{animal,day}(find(diff(trialID{animal,day})==2),rewCells{animal,day},:)));
        noOmrewTrials{animal,day} = setdiff(find(trialID{animal,day} == 1),find(diff(trialID{animal,day})==2));
        noomRewAct{animal,day} = squeeze(nanmean(trialAct{animal,day}(noOmrewTrials{animal,day},rewCells{animal,day},:)));
    end
    cOmRewAct{day} = vertcat(omRewAct{:,day});
    cNoomRewAct{day} = vertcat(noomRewAct{:,day});
end

figure; hold on
plot_sem(cOmRewAct{7}','k',0.5)
plot_sem(cNoomRewAct{7}','r',0.5)



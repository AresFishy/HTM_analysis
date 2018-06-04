%Get rew/puff activity dependent on what happended last
conseqCombR = [];
nonseqCombR = [];
conseqCombP = [];
nonseqCombP = [];

conseqSeqActCombR = {};
nonseqSeqActCombR = {};
conseqSeqActCombP = {};
nonseqSeqActCombP = {};


for day = 1:8
    for animal = 1:6
        conseqR{animal,day} = rew{animal,day}(find(diff(rew{animal,day}) == 1)+1);
        nonseqR{animal,day} = rew{animal,day}(find(diff(rew{animal,day}) ~= 1)+1);
        conseqP{animal,day} = puff{animal,day}(find(diff(puff{animal,day}) == 1)+1);
        nonseqP{animal,day} = puff{animal,day}(find(diff(puff{animal,day}) ~= 1)+1);
        
        conseqR{animal,day} = conseqR{animal,day}(find(mod(conseqR{animal,day},2) == 0)); %Only use trials that are not used for cell selection
        nonseqR{animal,day} = nonseqR{animal,day}(find(mod(nonseqR{animal,day},2) == 0));
        conseqP{animal,day} = conseqP{animal,day}(find(mod(conseqP{animal,day},2) == 0));
        nonseqP{animal,day} = nonseqP{animal,day}(find(mod(nonseqP{animal,day},2) == 0));
        
        if ~isempty(act{animal,day})
            conseqActR{animal,day} = squeeze(nanmean(onsetAct{animal,day}(:,conseqR{animal,day},:),2));
            nonseqActR{animal,day} = squeeze(nanmean(onsetAct{animal,day}(:,nonseqR{animal,day},:),2));
            conseqActP{animal,day} = squeeze(nanmean(onsetAct{animal,day}(:,conseqP{animal,day},:),2));
            nonseqActP{animal,day} = squeeze(nanmean(onsetAct{animal,day}(:,nonseqP{animal,day},:),2));
            
            conseqSeqActR{animal,day} = squeeze(nanmean(seqAct{animal,day}(:,conseqR{animal,day},:),2));
            nonseqSeqActR{animal,day} = squeeze(nanmean(seqAct{animal,day}(:,nonseqR{animal,day},:),2));
            conseqSeqActP{animal,day} = squeeze(nanmean(seqAct{animal,day}(:,conseqP{animal,day},:),2));
            nonseqSeqActP{animal,day} = squeeze(nanmean(seqAct{animal,day}(:,nonseqP{animal,day},:),2));
        else
            conseqActR{animal,day} = NaN(size(act{animal,2},1),31);
            nonseqActR{animal,day} = NaN(size(act{animal,2},1),31);
            conseqActP{animal,day} = NaN(size(act{animal,2},1),31);
            nonseqActP{animal,day} = NaN(size(act{animal,2},1),31);
            
            conseqSeqActR{animal,day} = NaN(size(act{animal,2},1),200);
            nonseqSeqActR{animal,day} = NaN(size(act{animal,2},1),200);
            conseqSeqActP{animal,day} = NaN(size(act{animal,2},1),200);
            nonseqSeqActP{animal,day} = NaN(size(act{animal,2},1),200);
        end
    end
    conseqActCombR{day} = vertcat(conseqActR{:,day});
    nonseqActCombR{day} = vertcat(nonseqActR{:,day});
    conseqActCombP{day} = vertcat(conseqActP{:,day});
    nonseqActCombP{day} = vertcat(nonseqActP{:,day});
    
    conseqSeqActCombR{day} = vertcat(conseqSeqActR{:,day});
    nonseqSeqActCombR{day} = vertcat(nonseqSeqActR{:,day});
    conseqSeqActCombP{day} = vertcat(conseqSeqActP{:,day});
    nonseqSeqActCombP{day} = vertcat(nonseqSeqActP{:,day});
    
    conseqCombR(day) = length(horzcat(conseqR{:,day}));
    nonseqCombR(day) = length(horzcat(nonseqR{:,day}));
    conseqCombP(day) = length(horzcat(conseqP{:,day}));
    nonseqCombP(day) = length(horzcat(nonseqP{:,day}));
    sumSeq(day) = sum([conseqCombR(day)  nonseqCombR(day)  conseqCombP(day)  nonseqCombP(day)]);
end
%%
figure;
subplot(121)
plot(conseqCombR./sumSeq); hold on
plot(nonseqCombR./sumSeq)
refline([0 0.25])
title('Number of Conseq/Nonseq Trials')
legend({'Conseq. Rew','Nonseq. Rew'})
xlabel('Day #')
ylabel('Fraction')
ylim([0 0.5])
xlim([1 8])
subplot(122)
plot(conseqCombP./sumSeq); hold on
plot(nonseqCombP./sumSeq)
refline([0 0.25])
legend({'Conseq. Puff','Nonseq. Puff'})
xlabel('Day #')
ylabel('Fraction')
ylim([0 0.5])
xlim([1 8])
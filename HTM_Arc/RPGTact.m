
g1pAct = {};
g1rAct = {};
g2pAct = {};
g2rAct = {};

t1pAct = {};
t1rAct = {};
t2pAct = {};
t2rAct = {};

cg1pAct = {};
cg1rAct = {};
cg2pAct = {};
cg2rAct = {};

ct1pAct = {};
ct1rAct = {};
ct2pAct = {};
ct2rAct = {};

for day = 1:8
    for animal = 1:4
        if ~isempty(trialAct{animal,day});
            g1pAct{animal,day} = squeeze(nanmean(trialAct{animal,day}(g1pTrial{animal,day},:,:),1));
            g1rAct{animal,day} = squeeze(nanmean(trialAct{animal,day}(g1rTrial{animal,day},:,:),1));
            g2pAct{animal,day} = squeeze(nanmean(trialAct{animal,day}(g2pTrial{animal,day},:,:),1));
            g2rAct{animal,day} = squeeze(nanmean(trialAct{animal,day}(g2rTrial{animal,day},:,:),1));
            
            t1pAct{animal,day} = squeeze(nanmean(trialAct{animal,day}(t1pTrial{animal,day},:,:),1));
            t1rAct{animal,day} = squeeze(nanmean(trialAct{animal,day}(t1rTrial{animal,day},:,:),1));
            t2pAct{animal,day} = squeeze(nanmean(trialAct{animal,day}(t2pTrial{animal,day},:,:),1));
            t2rAct{animal,day} = squeeze(nanmean(trialAct{animal,day}(t2rTrial{animal,day},:,:),1));
        else
            g1pAct{animal,day} = NaN(size(trialAct{animal,1},2),201);
            g1rAct{animal,day} = NaN(size(trialAct{animal,1},2),201);
            g2pAct{animal,day} = NaN(size(trialAct{animal,1},2),201);
            g2rAct{animal,day} = NaN(size(trialAct{animal,1},2),201);
            
            t1pAct{animal,day} = NaN(size(trialAct{animal,1},2),201);
            t1rAct{animal,day} = NaN(size(trialAct{animal,1},2),201);
            t2pAct{animal,day} = NaN(size(trialAct{animal,1},2),201);
            t2rAct{animal,day} = NaN(size(trialAct{animal,1},2),201);
        end
    end
    cg1pAct{day} = vertcat(g1pAct{:,day});
    cg1rAct{day} = vertcat(g1rAct{:,day});
    cg2pAct{day} = vertcat(g2pAct{:,day});
    cg2rAct{day} = vertcat(g2rAct{:,day});
    
    ct1pAct{day} = vertcat(t1pAct{:,day});
    ct1rAct{day} = vertcat(t1rAct{:,day});
    ct2pAct{day} = vertcat(t2pAct{:,day});
    ct2rAct{day} = vertcat(t2rAct{:,day});
end
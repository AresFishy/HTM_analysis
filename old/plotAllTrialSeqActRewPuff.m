%Plot sequence activity for reward cells
for day = 1:8
    seqRewAct = [];
    seqPuffAct = [];
    for animal = 1:6
        if ~isempty(act{animal,day})
            for cell = rewCells{animal,day}
                seqRewAct = [seqRewAct; squeeze(seqAct{animal,day}(cell,rew{animal,day}(2:2:end),:))];
                seqPuffAct = [seqPuffAct; squeeze(seqAct{animal,day}(cell,puff{animal,day}(2:2:end),:))];
            end
        end
    end
    subplot(8,2,day+day-1)
    imagesc(seqRewAct);
    set(gca,'clim',[1 1.5])
    if day == 1
        title('Reward cells on reward trials')
    elseif day == 8
        xlabel('Frame #')
    end
    subplot(8,2,day*2)
    imagesc(seqPuffAct)
    set(gca,'clim',[1 1.5])
    if day == 1
        title('Reward cells on puff trials')
    elseif day == 8
        xlabel('Frame #')
    end
end

%%
%Plot sequence activity for puff cells

for day = 1:8
    seqRewAct = [];
    seqPuffAct = [];
    for animal = 1:6
        if ~isempty(act{animal,day})
            for cell = puffCells{animal,day}
                seqRewAct = [seqRewAct; squeeze(seqAct{animal,day}(cell,rew{animal,day}(2:2:end),:))];
                seqPuffAct = [seqPuffAct; squeeze(seqAct{animal,day}(cell,puff{animal,day}(2:2:end),:))];
            end
        end
    end
    subplot(8,2,day+day-1)
    imagesc(seqPuffAct);
    set(gca,'clim',[1 1.5])
    if day == 1
        title('Puff cells on puff trials')
    elseif day == 8
        xlabel('Frame #')
    end
    subplot(8,2,day*2)
    imagesc(seqRewAct)
    set(gca,'clim',[1 1.5])
    if day == 1
        title('Puff cells on reward trials')
    elseif day == 8
        xlabel('Frame #')
    end
end
%Divide trials based on Puff or Reward
toneP = {};
for day = 1:7
    for animal = 1:9
        for on = 1:length(toneON{animal,day})
            if  length(find(aPuffON{animal,day} - toneON{animal,day}(on) > 2 & ...
                    aPuffON{animal,day} - toneON{animal,day}(on) < 60)) == 1;
                tmpToneP{animal,day}(on) = 1;
            else
                tmpToneP{animal,day}(on) = 0;
            end
        end
        
        for on = 1:length(toneON{animal,day})
            if  length(find(rewON{animal,day} - toneON{animal,day}(on) > 2 & ...
                    rewON{animal,day} - toneON{animal,day}(on) < 60)) == 1;
                tmpToneR{animal,day}(on) = 1;
            else
                tmpToneR{animal,day}(on) = 0;
            end
        end
        toneP{animal,day} = find(tmpToneP{animal,day} == 1);
        toneR{animal,day} = find(tmpToneR{animal,day} == 1);
    end
end

%%
test = [];
for day = 1:7
    for animal = 1:9
        if ~isempty(toneP{animal,day}) & ~isempty(toneR{animal,day})
           test(animal,day,:) = squeeze(mean(mean(toneAct{animal,day}(toneR{animal,day},highIEG{animal,day},:),1),2)) - ...
               squeeze(mean(mean(toneAct{animal,day}(toneP{animal,day},highIEG{animal,day},:),1),2));                
        else
            test(animal,day,:) = NaN(31,1);
        end
    end
end

%%
for day = 1:7
    subplot(2,4,day)
    plot_sem(squeeze(test(5:9,day,:))','r',0.3);
    ylim([-0.005 0.01])
    line(xlim,[0 0],'Color','k','LineStyle','--')
    line([11 11],ylim,'Color','k','LineStyle','--')
    title(sprintf('Day %d',day))
    xlabel('Frame #'); ylabel('Tone Act dF/F Rew-Puff')
end

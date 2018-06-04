%Find High IEG Cells that overlap or don't overlap with stimulus
%responsive cells
iegStimCells = {};
iegNoStimCells = {};

for day = 1:7
    for animal = 1:9
        stimCells = [toneCells{animal,day} rewCells{animal,day} puffCells{animal,day}];
        iegStimCells{animal,day} = intersect(highIEG{animal,day},stimCells);
        iegNoStimCells{animal,day} = setdiff(highIEG{animal,day},stimCells); 
        
        iegStimCellsTotal(animal,day) = length(iegStimCells{animal,day}) / length(highIEG{animal,day});
        iegNoStimCellsTotal(animal,day) = length(iegNoStimCells{animal,day}) / length(highIEG{animal,day});
    end
end

cellL = [0 289 487 195 300 343 394 373 443];
cellList = cumsum(cellL);
cIegStimCells = {};
cIegNoStimCells = {};


for day = 1:7
    cIegStimCells{day} = [];
    cIegNoStimCells{day} = [];
    for animal = 1:9
        cIegStimCells{day} = [cIegStimCells{day}; iegStimCells{animal,day}+cellList(animal)];
        cIegNoStimCells{day} = [cIegNoStimCells{day}; iegNoStimCells{animal,day}+cellList(animal)];
    end
end

figure;
plot_sem(iegStimCellsTotal','k');
plot_sem(iegNoStimCellsTotal','--k');
title('Fraction of IEG Cells')
legend('','Stim Cell Overlapping','','Stim Cell Non-Overlapping')
ylabel('Fraction'); xlabel('Day')

%Plot activity of stim overlapping and non-overlapping high IEG cells
figure;
subplot(131)
plot_sem([tone_respCombHalf{2}(cIegStimCells{2},:); tone_respCombHalf{3}(cIegStimCells{3},:)]','b',0.3,'b')
plot_sem([tone_respCombHalf{2}(cIegNoStimCells{2},:); tone_respCombHalf{3}(cIegNoStimCells{3},:)]','r',0.3,'r')
plot_sem([tone_respCombHalf{6}(cIegStimCells{6},:); tone_respCombHalf{7}(cIegStimCells{7},:)]','--b',0.3,'b')
plot_sem([tone_respCombHalf{6}(cIegNoStimCells{6},:); tone_respCombHalf{7}(cIegNoStimCells{7},:)]','--r',0.3,'r')
ylim([0.99 1.05]); xlim([1 200]);
line(xlim,[1 1],'color','k');
line([51 51],ylim,'color','k','linestyle','--');
title('Tone Onset Response');
ylabel('dF/F'); xlabel('Frame #')

subplot(132)
plot_sem([rew_respCombHalf{2}(cIegStimCells{2},:); rew_respCombHalf{3}(cIegStimCells{3},:)]','b',0.3,'b')
plot_sem([rew_respCombHalf{2}(cIegNoStimCells{2},:); rew_respCombHalf{3}(cIegNoStimCells{3},:)]','r',0.3,'r')
plot_sem([rew_respCombHalf{6}(cIegStimCells{6},:); rew_respCombHalf{7}(cIegStimCells{7},:)]','--b',0.3,'b')
plot_sem([rew_respCombHalf{6}(cIegNoStimCells{6},:); rew_respCombHalf{7}(cIegNoStimCells{7},:)]','--r',0.3,'r')
ylim([0.99 1.05]); xlim([1 200]);
line(xlim,[1 1],'color','k');
line([51 51],ylim,'color','k','linestyle','--');
title('Reward Onset Response')
ylabel('dF/F'); xlabel('Frame #')

subplot(133)
plot_sem([puff_respCombHalf{2}(cIegStimCells{2},:); puff_respCombHalf{3}(cIegStimCells{3},:)]','b',0.3,'b')
plot_sem([puff_respCombHalf{2}(cIegNoStimCells{2},:); puff_respCombHalf{3}(cIegNoStimCells{3},:)]','r',0.3,'r')
plot_sem([puff_respCombHalf{6}(cIegStimCells{6},:); puff_respCombHalf{7}(cIegStimCells{7},:)]','--b',0.3,'b')
plot_sem([puff_respCombHalf{6}(cIegNoStimCells{6},:); puff_respCombHalf{7}(cIegNoStimCells{7},:)]','--r',0.3,'r')
ylim([0.99 1.05]); xlim([1 200]);
line(xlim,[1 1],'color','k');
line([51 51],ylim,'color','k','linestyle','--');
title('Puff Onset Response')
legend('','IegStim Early','','IegNoStim Early','','IegStim Late','','IegNoStim Late','Stim Onset')
ylabel('dF/F'); xlabel('Frame #')

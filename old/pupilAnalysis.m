%Pupil diameter analysis for puff/reward
for day = 1:8;
    for animal = 1:6
        str = sprintf('Animal %d', animal);
        subplot(3,2,animal)
        plotSEM(seqPupil{animal,day}(rew{animal,day},:)','r')
        plotSEM(seqPupil{animal,day}(puff{animal,day},:)','k')
        line([180 180],get(gca,'ylim'),'color','k')
        ylabel('Pupil diameter')
        xlabel('Frame #')
        title(str)
    end
    
end

%%
%Pupil diameter analysis for puff/reward
for day = 1;
    for animal = 1:5
        subplot(3,2,animal)
        str = sprintf('Pupil response - Animal %d',animal);
        plotSEM(seqPupil{animal,day}(puff{animal,day}(1:5),:)','k')
        plotSEM(seqPupil{animal,day}(puff{animal,day}(end-5:end),:)','r')
        legend({'Last 5 puff','First 5 puff'},'location','southwest')
        title(str)
    end
end
        
        %%
        %Pupil diameter analysis for omission
        for day = 7:8;
            for animal = [1,3,4,5,6]
                str = sprintf('Animal %d', animal);
                subplot(3,2,animal)
                plotSEM(seqPupil{animal,day}(om{animal,day},:)','k')
                plotSEM(seqPupil{animal,day}(noOm{animal,day},:)','r')
                line([180 180],get(gca,'ylim'),'color','k')
                ylabel('Pupil diameter')
                xlabel('Frame #')
                title(str)
            end
            
        end
        
        
        %%
        %Get scatterplot of reward act vs. pupil
        cnt = 0;
        for day = 1:8
            for animal = 1:6
                if ~isempty(act{animal,day})
                    cnt = cnt + 1;
                    plot(mean(seqPupil{animal,day}(rew{animal,day},175:180),2),squeeze(mean(mean(onsetAct{animal,day}(rewCells{animal,day},rew{animal,day},15:25),1),3)),'.r'); hold on
                    %             tmpcorrR = corrcoef(mean(seqPupil{animal,day}(rew{animal,day},175:180),2),squeeze(mean(mean(onsetAct{animal,day}(rewCells{animal,day},rew{animal,day},15:25),1),3)));
                    %             pupilCorrR(cnt) = tmpcorrR(1,2);
                    %             tmpcorrP = corrcoef(mean(seqPupil{animal,day}(puff{animal,day},175:180),2),squeeze(mean(mean(onsetAct{animal,day}(puffCells{animal,day},puff{animal,day},15:25),1),3)));
                    %             pupilCorrP(cnt) = tmpcorrP(1,2);
                end
            end
        end
        refline([0 0])
        line([0 0],get(gca,'ylim'),'color','k')
        xlabel('Pupil Activity  frame 175:180')
        ylabel('Rew Cells Activity  dF/F')
        title('Rew vs. Pupil Activity - onsetAct Frame Rew Trials 15:25 (185:195)')
        
        
        
        

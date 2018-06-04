%reward
rewActCor = [];

for day = 1:7
    for animal = 1:4
        if size(rewON{animal,day} > 1)
            rewActCor(animal,day) =  mean(diag(corr(squeeze(nanmean(rewAct{animal,day}(:,:,15:25),3))'),1));
        else
            rewActCor(animal,day) = NaN(1,1);
        end
    end
end

figure; hold on
plot_sem(rewActCor','k',0.5)
title('Trial-to-Trial Correlation of population vector Frame 15:25')
ylabel('Correlation Coefficient')
xlabel('Day')
ylim([0 1])

%Punishment
puffActCor = [];

for day = 1:7
    for animal = 1:4
        if size(aPuffON{animal,day} > 1)
            puffActCor(animal,day) =  mean(diag(corr(squeeze(nanmean(aPuffAct{animal,day}(:,:,15:25),3))'),1));
        else
            puffActCor(animal,day) = NaN(1,1);
        end
    end
end

plot_sem(puffActCor','r',0.5)


%Tone
toneActCor = [];

for day = 1:7
    for animal = 1:4
            toneActCor(animal,day) =  mean(diag(corr(squeeze(nanmean(toneAct{animal,day}(:,:,15:25),3))'),1));
    end
end

plot_sem(toneActCor','g',0.5)
legend('','RewAct','','PuffAct','','ToneAct')
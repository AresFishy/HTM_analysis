toneActCor = [];

for day = 1:8
    for animal = 1:4
        if ~isempty(act{animal,day})
            toneActCor(animal,day) =  corr(squeeze(nanmean(nanmean(tone1Act{animal,day}(:,:,15:25),1),3))',squeeze(nanmean(nanmean(tone2Act{animal,day}(:,:,15:25),1),3))');
        else
            toneActCor(animal,day) = NaN(1,1);
        end
    end
end

figure;
plot_sem(toneActCor')
title('tone1Act vs tone2Act correlation of population vector')
ylabel('Correlation Coefficient')
xlabel('Day')
ylim([0 1])


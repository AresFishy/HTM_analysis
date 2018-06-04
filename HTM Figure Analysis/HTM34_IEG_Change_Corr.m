%Correlation of Arc and c-fos expression across days
IegChangeCorArc = [];
for animal = 1:9
    for day1 = 1:7
        for day2 = 1:7
            IegChangeCor(day1,day2,animal) = corr(mIegDiff{animal,day1},mIegDiff{animal,day2});
        end
    end
end


subplot(121)
imagesc(squeeze(mean(IegChangeCor(:,:,1:4),3)));
colormap jet;
set(gca,'clim',[0 1])
title('Arc Change Correlation')

subplot(122)
imagesc(squeeze(mean(IegChangeCor(:,:,5:9),3)));
colormap jet;
set(gca,'clim',[0 1])
title('Arc Change Correlation')

%%
for animal = 1:9
    offDia = tril(IegChangeCor(:,:,animal),-1);
    offDia = offDia(offDia ~= 0);
    changeCor(animal,:) = offDia;
    changeCorTest(animal) = signrank(changeCor(animal,:));
end

plot(changeCorTest);
line(xlim,[0.05 0.05])
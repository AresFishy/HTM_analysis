%Overlap from day to day in high IEG cells

%For Arc Cells
for day = 1:6
    for animal = 1:4
        hArcOverlap(animal,day) = length(intersect(highIEG{animal,day},highIEG{animal,day+1})) / length(highIEG{animal,day});
        iArcOverlap(animal,day) = length(intersect(intIEG{animal,day},intIEG{animal,day+1})) / length(intIEG{animal,day});
        lArcOverlap(animal,day) = length(intersect(lowIEG{animal,day},lowIEG{animal,day+1})) / length(lowIEG{animal,day});
    end
    for animal = 5:9
        hCfosOverlap(animal-4,day) = length(intersect(highIEG{animal,day},highIEG{animal,day+1})) / length(highIEG{animal,day});
        iCfosOverlap(animal-4,day) = length(intersect(intIEG{animal,day},intIEG{animal,day+1})) / length(intIEG{animal,day});
        lCfosOverlap(animal-4,day) = length(intersect(lowIEG{animal,day},lowIEG{animal,day+1})) / length(lowIEG{animal,day});  end
end
%%
figure;
plot_sem(hArcOverlap','b',0.3,[0.5 0.5 1]);
plot_sem(iArcOverlap','--b',0.3,[0.5 0.5 1]);
plot_sem(lArcOverlap',':b',0.3,[0.5 0.5 1]);

plot_sem(hCfosOverlap','r',0.3,[1 0.5 0.5]);
plot_sem(iCfosOverlap','--r',0.3,[1 0.5 0.5]);
plot_sem(lCfosOverlap',':r',0.3,[1 0.5 0.5]);
ylim([0 1]);
ylabel('Fraction'); xlabel('Day');
title('IEG Expression Stability')
set(gca,'XTick',[1:6],'XTickLabel',{'+1','+2','+3','+4','+5','+6'})
legend('','High Arc','','Mid Arc','','Low Arc','','High c-Fos','','Mid c-Fos','','Low c-Fos')
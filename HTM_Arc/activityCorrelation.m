%Calculate activity correlations across trials for a population vector

 for day = 1:7; 
     for animal = 1:4
         if ~isempty(rewTrialAct{animal,day}) & size(rewTrialAct{animal,day},1) > 1;
            rewActCor(animal,day) =  mean(diag(corrcoef(squeeze(mean(rewTrialAct{animal,day},2))'),1));
         else
             rewActCor(animal,day) = NaN(1,1);
         end
         if size(aPuffTrialAct{animal,day},1) > 1;
            puffActCor(animal,day) =  mean(diag(corrcoef(squeeze(mean(aPuffTrialAct{animal,day},2))'),1));
         else
             puffActCor(animal,day) = NaN(1,1);
         end
     end
 end
 
 figure; hold on
 plot_sem(rewActCor','k',0.5)
 plot_sem(puffActCor','r',0.5)
 title('Population vector correlation of following reward or puff trials ')
 ylabel('Correlation')
 xlabel('Day')
 
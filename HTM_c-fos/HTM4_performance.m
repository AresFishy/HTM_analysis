%DM
%Performance score
animals=1:5;

correct = [];
false = [];
rate = [];
passive = [];

for day = 1:7
    for animal = animals
        correct(animal,day) = length(rewON{animal,day});
        false(animal,day) = length(aPuffON{animal,day});
        passive(animal,day) = length(pPuffON{animal,day});
        rate(animal,day) = correct(animal,day)./(correct(animal,day)+false(animal,day)+passive(animal,day));
    end
end

fos_perform(:,:,1)=correct;
fos_perform(:,:,2)=false;
fos_perform(:,:,3)=passive;

figure;hold on
% plot(rate'); hold on
% plot(nanmean(rate),'.-k');
totTrialNum=correct+false+passive;
for ind=1:3
    if ind==1
        mat=correct;
    elseif ind==2
        mat=false;
    else
        mat=passive;   
    end
    plot(nanmean(bsxfun(@rdivide,mat,totTrialNum)))
% plotSEM(bsxfun(@rdivide,mat,totTrialNum)')
end
hLine = refline(0,0.33);
hLine.Color = 'k';
legend('correct','false','passive')
ylabel('fraction of total trial #')
xlabel('Day')
ylim([0 1])
title('Task Performace')


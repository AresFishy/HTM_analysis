%DM
%Performance score

correct = [];
false = [];
rate = [];
passive = [];

for day = 1:7
    for animal = 1:9
        correct(animal,day) = length(rewON{animal,day});
        false(animal,day) = length(aPuffON{animal,day});
        passive(animal,day) = length(pPuffON{animal,day});
        rate(animal,day) = correct(animal,day)./(correct(animal,day)+false(animal,day)+passive(animal,day));
    end
end


figure;plotSEM(rate')

arc_perform=[];

arc_perform(:,:,1)=correct;
arc_perform(:,:,2)=false;
arc_perform(:,:,3)=passive;


figure;hold on
% plot(rate'); hold on
% plot(nanmean(rate),'.-k');
totTrialNum=correct+false;
for ind=2:3
    if ind==1
        cp_licks=correct+false;
        mat=cp_licks;         
    elseif ind==2
        mat=correct;        
    elseif ind==3
        mat=false;          
    else
         mat=passive;          
    end
     plot(nanmean(bsxfun(@rdivide,mat,totTrialNum)))
% plotSEM(bsxfun(@rdivide,mat,totTrialNum)')
end
% hLine = refline(0,0.33);
% hLine.Color = 'k';
% legend('correct behavior','false behavior')
ylabel('fraction of lick trials')
xlabel('Day')
ylim([0 1])
title('Task Performace')

figure;plotSEM(bsxfun(@rdivide,correct,false)')
line(xlim,[1 1],'color','k')
ylabel('ratio correct vs false behavior')
xlabel('day')


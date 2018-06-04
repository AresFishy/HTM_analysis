figure;
subplot(121)
for day=1:7
    plot_sem(tone_respComb{day}'-mean2(tone_respComb{day}(:,40:49)),[day/10 day/10 day/10],0.3)
end
xlim([45 70])
line([55 55],ylim,'color','b','linestyle','--')
line([65 65],ylim,'color','r','linestyle','--')
line([70 70],ylim,'color','r','linestyle','--')
line(xlim,[0 0],'color','k','linestyle','--')
line([51 51],ylim,'color','k','linestyle','--')
ylabel('dF/F'); xlabel('Frame')
title('Tone Response')
legend('','Day 1-7')

subplot(122)
maxAmp23 = max([tone_respComb{2}(:,51:70); tone_respComb{3}(:,51:70)],[],2)-mean2([tone_respComb{2}(:,40:49); tone_respComb{3}(:,40:49)]);
maxAmp67 = max([tone_respComb{6}(:,51:70); tone_respComb{7}(:,51:70)],[],2)-mean2([tone_respComb{6}(:,40:49); tone_respComb{7}(:,40:49)]);

meanTail23 = mean([tone_respComb{2}(:,65:70); tone_respComb{3}(:,65:70)],2)-mean2([tone_respComb{2}(:,40:49); tone_respComb{3}(:,40:49)]);
meanTail67 = mean([tone_respComb{6}(:,65:70); tone_respComb{7}(:,65:70)],2)-mean2([tone_respComb{7}(:,40:49); tone_respComb{7}(:,40:49)]);

bar(1,mean(maxAmp67) / mean(maxAmp23),'b'); hold on
bar(2,mean(meanTail67) / mean(meanTail23),'r'); hold on
title('Day 2&3 vs day 6&7')
legend('Max Ratio','Mean Tail Ratio')


%Plot population onset activity
for day = 1:8;
    plotSEM(OnsetActComb{day}')
end

ylim([0 0.02])
line([11 11],get(gca,'ylim'),'color','k')
legend({'Day1','Day2','Day3','Day4','Day5','Day6','Day7','Day8'})
title('Population End Onset Activity')
xlabel('Frame #')
ylabel('dF/F')
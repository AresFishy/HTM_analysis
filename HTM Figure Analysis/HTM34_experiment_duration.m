%Imaging duration

exp_time = [52 55 61 51 51 52 51;
 57 50 54 60 55 53 53;
 72 59 59 51 52 53 49;
 52 50 48 51 51 49 50;
 59 54 51 62 51 52 49;
 54 50 50 50 51 60 50;
 54 54 51 50 51 52 52;
 64 50 51 55 54 54 55;
 53 49 52 52 61 71 54];

histogram(exp_time,[min(exp_time(:))-5:2:max(exp_time(:))+5],'normalization','probability','FaceColor','k');
ylim([0 0.35]);
line([mean(exp_time(:)) mean(exp_time(:))],ylim,'Color','k','LineStyle','--')
legend('Experiment Duration','Mean')
ylabel('Fraction of training sessions')
xlabel('Time [min]')

mean(exp_time(:))
std(exp_time(:))
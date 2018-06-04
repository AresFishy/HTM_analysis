%Plot cell examples

%Stimulus   Animal  Day     Cell
%Reward     2       5       16
%Puff       2       5       38
%Tone       2       5       99
animal = 2;
day = 5;
cell = 98;

figure;
subplot(211)
imagesc(squeeze(rewAct{animal,day}(:,cell,:)));
set(gca,'clim',[0 0.5])
line([10 10],ylim,'color','r')
title(sprintf('Tone Activity - Animal %d Day %d Cell %d',animal,day,cell))
subplot(212)
plot_sem(squeeze(rewAct{animal,day}(:,cell,:))');
axis tight;
ylim([-0.05 0.3])
line([10 10],ylim,'color','k','LineStyle','--')
line(xlim,[0 0],'color','k','LineStyle','--')

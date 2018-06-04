%Plot cell examples

%Stimulus   Animal  Day     Cell
%Reward     2       6       117
%Puff       2       6       233
%Tone       2       6       354
animal = 2;
day = 6;
cell = 117;

figure;
subplot(211)
imagesc(squeeze(rewAct{animal,day}(:,cell,:)));
set(gca,'clim',[0 1])
line([10 10],ylim,'color','r')
title(sprintf('Tone Activity - Animal %d Day %d Cell %d',animal,day,cell))
subplot(212)
plot_sem(squeeze(rewAct{animal,day}(:,cell,:))');
axis tight;
ylim([-0.05 1])
line([10 10],ylim,'color','k','LineStyle','--')
line(xlim,[0 0],'color','k','LineStyle','--')

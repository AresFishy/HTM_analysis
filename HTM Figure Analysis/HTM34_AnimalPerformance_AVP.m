%Plot Animal Task Performance

figure;
% plot(anbeh','k'); hold on
for day = 1:7
    for animal = 1:9
       anbeh(animal,day) = size(rew_respAct{animal,day},3) / (size(rew_respAct{animal,day},3)+size(puff_respAct{animal,day},3));
    end
end
ylim([0.4 0.9])
plot_sem(anbeh','b',0.5);
line(xlim,[0.5 0.5],'color','k','LineStyle','--')
ylabel('Performance');
xlabel('Day')
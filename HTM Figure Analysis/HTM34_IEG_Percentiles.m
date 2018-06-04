%Plot ditribution of Arc expression
cnt = 0;
figure;
for day = [1,7]
    cnt = cnt + 1;
    subplot(1,2,cnt)
    histogram(vertcat(ieg_exp_cell{1:4,tps_exp(day)}),[0.9:0.0025:1.9],'FaceColor','k','normalization','probability')
    prc67 = prctile(vertcat(ieg_exp_cell{1:4,tps_exp(day)}),67);
    prc33 = prctile(vertcat(ieg_exp_cell{1:4,tps_exp(day)}),33);
    ylim([0 0.2])
    line([prc67 prc67],ylim,'color','r','linestyle','--')
    line([prc33 prc33],ylim,'color','b','linestyle','--')
    ylabel('Fraction'); xlabel('Expression'); title(sprintf('arc Day %d',day));
end
legend('','67% Percentile', '33% Percentile')

%Plot ditribution of cFos expression
cnt = 0;
figure;
for day = [1,7]
    cnt = cnt + 1;
    subplot(1,2,cnt)
    histogram(vertcat(ieg_exp_cell{5:9,tps_exp(day)}),[0.9:0.0025:1.4],'FaceColor','k','normalization','probability')
    prc67 = prctile(vertcat(ieg_exp_cell{5:9,tps_exp(day)}),67);
    prc33 = prctile(vertcat(ieg_exp_cell{5:9,tps_exp(day)}),33);
    ylim([0 0.2])
    line([prc67 prc67],ylim,'color','r','linestyle','--')
    line([prc33 prc33],ylim,'color','b','linestyle','--')
    ylabel('Fraction'); xlabel('Expression'); title(sprintf('c-fos Day %d',day));
end
legend('','67% Percentile','33% Percentile')


%%

%Test for log-normality

for day = 1:7
    for animal = 1:9
        ntest(animal,day) = kstest(reallog(vertcat(mIegAct{animal,day})));
    end
end
imagesc(ntest)
xlabel('Day'); ylabel('Animal')
set(gca,'clim',[0 1])




%Performance score

correct = [];
false = [];
rate = [];
passive = [];

for day = 1:7
    for animal = 1:4
        correct(animal,day) = length(rewON{animal,day});
        false(animal,day) = length(aPuffON{animal,day});
        rate(animal,day) = correct(animal,day)./(correct(animal,day)+false(animal,day));
    end
end

figure;
plot(rate'); hold on
plot(nanmean(rate),'.-k');
hLine = refline(0,0.5);
hLine.Color = 'k';
legend('Animal 1','Animal 2','Animal 3','Animal 4','Mean','Chance Level')
ylabel('Performance / Fraction Correct')
xlabel('Day')
ylim([0 1])
title('Task Performace')


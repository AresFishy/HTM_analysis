%Plot Arc dynamics
for day = 1:7
    for animal = 1:4
        if animal == 1;
            a = 'k';
        elseif animal == 2;
            a = 'r';
        elseif animal == 3;
            a = 'b';
        elseif animal == 4;
            a = 'g';
        end
        plot([1:6]+6*(day-1),mean(arcAct{animal,day},1),a); hold on
    end
    legend('Animal 1','Animal 2','Animal 3','Animal 4')
end
ylabel('Arc Level')
xlabel('Session')
title('Arc Expression Dynamics')

%Plot change in Arc dynamics
figure;
for day = 1:7
    for animal = 1:4
        if animal == 1;
            a = 'k';
        elseif animal == 2;
            a = 'r';
        elseif animal == 3;
            a = 'b';
        elseif animal == 4;
            a = 'g';
        end
        plot([1:5]+5*(day-1),mean(arcDiff{animal,day},1),a); hold on
    end
    legend('Animal 1','Animal 2','Animal 3','Animal 4')
end
ylabel('Change in Arc Level')
xlabel('Session')
title('Change in Arc Expression Dynamics')

%Plot Median Arc change
figure;
for day = 1:7;
    for animal = 1:4
        h(animal,day) = median(mArcDiff{animal,day});
    end
end

plot_sem(h','k');
title('Median Arc Change')
ylabel('Arc Change')
xlabel('Day')

%Plot  Arc level
figure;
for day = 1:7;
    for animal = 1:4
        h(animal,day) = median(mArcAct{animal,day});
    end
end

plot_sem(h','k');
title('Median Arc Level')
ylabel('Arc Level')
xlabel('Day')
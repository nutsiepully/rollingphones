
plot(baztrain(find(Ytrain == 2), :))
walking_baz = baztrain(find(Ytrain == 2), :);
plot(walking_baz(:))
sitting_baz = baztrain(find(Ytrain == 4), :);
hold on
plot(sitting_baz(:), 'r')
walkdown_baz = baztrain(find(Ytrain == 3), :);
plot(walkdown_baz(:), 'g')
walk_baz = baztrain(find(Ytrain == 1), :);
plot(walk(:), 'k')
plot(walk_baz(:), 'k')
stand_baz = baztrain(find(Ytrain == 5), :);
plot(stand_baz(:), 'y')
help plot
lay_baz = baztrain(find(Ytrain == 6), :);
plot(lay_baz(:), 'c')

subplot


C = {'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6]};

subs_test = unique(subject_test);
figure; hold on;
for i = 1:length(subs_test)
    plot(Ytest(find(subject_test == subs_test(i))), C{i});
end

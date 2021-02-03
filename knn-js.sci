

function z = manhattan_distance(a, b)
    v = abs(a - b);
    z = sum(v);
endfunction

function z = s_mode(a)
    counts = [];
    for i = 1:length(a),
        indexes_in_counts = find(counts(:, 1) == a(i));
        amount_in_counts = length(indexes_in_counts);
        if amount_in_counts == 0 then
            indexes = find(a == a(i));
            occurences = length(indexes);
            counts = [counts; [a(i) occurences]];
        end
    end
    [m, index] = max(counts(:, 2));
    z = counts(index, 1);
endfunction


function z = knn(training_data, classification_data, row, k)
    n = [];
    for i = 1:length(training_data(:, 1)),
        distance = manhattan_distance(row, training_data(i, :));
        if length(n(:, 1)) < k then
            n = [n; i distance];
        else
            [u, index] = max(n(:, 2));
            if distance < u then
                n = [n(1:index-1, :); [i distance]; n(index+1:$, :)];
            end
        end,
    end
    classes = classification_data(n(:, 1));
    z = s_mode(classes);
endfunction



loadmatfile('ed-p01.mat');

predictions = [];
for i = 1:length(TestData(:, 1)),
    predictions(i) = knn(GlassData, GlassClasses, TestData(i, :), 4);
end
disp(predictions);

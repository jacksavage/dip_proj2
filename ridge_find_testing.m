row = [0 0 1 0 0 1 1 1 1 0 0 0 2 1 2 2 0 0 0 1 2 3 2 2 1 0 0 1 1 1 3 0 1 1 1 3 1 1 0 3 3 3 3 1];
ridge = ridge_scan(row);
ridge(row == max(row(:))) = 1;

% plot it
stem(row, 'MarkerSize', 3); hold on; 
x = 1:length(ridge);
scatter(x(ridge>0),row(ridge>0)); legend('row', 'out');

clear;
clc;

load(['mul_sources3.mat']);

view_nums = size(data,1);
cluster_nums = max(labels);

option.lambda1 = 10.^-3;
option.lambda2 = 1;
option.lambda3 = 0.1;
option.sdim = {80,80,80};
option.cdim = cluster_nums;
option.numClust = cluster_nums;
option.Maxitems = 100;
for iter = 1:30
    tic;
    [U] = OMC_DR(data,option,iter);
    time(iter) = toc;
    pred_labels = vec2lab(U');
    result_cluster = ClusteringMeasure(labels, pred_labels);
    nmi(iter) = result_cluster(2);
    acc(iter) = result_cluster(1);
    purity(iter) = result_cluster(3);
    ARI(iter) = result_cluster(4);
end

best_nmi = mean(nmi);
best_results.nmi = mean(nmi);
best_results.nmi_std = std(nmi);
best_results.acc = mean(acc);
best_results.acc_std = std(acc);
best_results.purity = mean(purity);
best_results.purity_std = std(purity);
best_results.ARI = mean(ARI);
best_results.ARI_std = std(ARI);
best_results.option = option;
best_results.time = mean(time);


function corrected_mask = magia_roi_correction(original_mask,meanpet_image)

if(ischar(original_mask))
    V = spm_vol(original_mask);
    original_mask = spm_read_vols(V);
end
if(ischar(meanpet_image))
    V = spm_vol(meanpet_image);
    meanpet_image = spm_read_vols(V);
end

num_clusters = 3;

roi_idx = find(original_mask);
X = meanpet_image(roi_idx);

Z = linkage(X,'ward');
c = cluster(Z,'maxclust',num_clusters);

cluster_mean_signals = zeros(num_clusters,1);
idx = cell(num_clusters,1);
for j = 1:num_clusters
    idx{j} = roi_idx(c == j);
    cluster_mean_signals(j) = mean(meanpet_image(idx{j}));
end

[~,min_idx] = min(cluster_mean_signals);
corrected_mask = zeros(size(meanpet_image));
idx(min_idx) = [];
for j = 1:num_clusters-1
    corrected_mask(idx{j}) = 1;
end

end
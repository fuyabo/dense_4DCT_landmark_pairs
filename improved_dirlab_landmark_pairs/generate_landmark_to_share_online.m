% to generate landmark only datasets to upload to github

for p = 1:10
    pp = int2str(p);
    fn = ['../../case' pp '.mat'];
    data = load(fn);
    voxelsize = data.voxelsize;
    s = voxelsize(3)/voxelsize(1);
    
    fn = ['../cases_300_improved_landmarks/case' pp '.mat'];
    data = load(fn);
    landmark_dirlab = data.landmark_gt;
    landmark_new = data.landmark_improved_gt;
    landmark_changed_idx = data.landmark_changed_idx;
    landmark_dirlab_EE = landmark_dirlab(:, 2:4);
    landmark_dirlab_EI = landmark_dirlab(:, 6:8);
    
    landmark_new_EE = landmark_new(:, 2:4);
    landmark_new_EI = landmark_new(:, 6:8);
    % rescale
    landmark_dirlab_EE(:, 3) = landmark_dirlab_EE(:, 3)/s;
    landmark_dirlab_EI(:, 3) = landmark_dirlab_EI(:, 3)/s;
    
    landmark_new_EE(:, 3) = landmark_new_EE(:, 3)/s;
    landmark_new_EI(:, 3) = landmark_new_EI(:, 3)/s;
    % round to one significant
    landmark_dirlab_EE = round(landmark_dirlab_EE, 1);
    landmark_dirlab_EI = round(landmark_dirlab_EI, 1);
    
    landmark_new_EE = round(landmark_new_EE, 1);
    landmark_new_EI = round(landmark_new_EI, 1);
    
    data = struct;
    data.landmark_EE = landmark_dirlab_EE;
    data.landmark_dirlab_EI = landmark_dirlab_EI;
    data.landmark_new_EI = landmark_new_EI;
    data.landmark_changed_idx = landmark_changed_idx;
    save(['./case' pp '.mat'], '-struct', 'data');
    
end
% FLIC joint
% 1 nose
% 2 neck (interpolated)
% 3 right shoulder
% 4 right elbow
% 5 right wrist
% 6 right hip
% 7 left shoulder
% 8 left elbow
% 9 left wrist
% 10 left hip
startup;

reference_joints_pair = [6, 7];     % right shoulder and left hip (from observer's perspective)
% symmetry_joint_id(i) = j, if joint j is the symmetry joint of i (e.g., the left
% shoulder is the symmetry joint of the right shoulder).
symmetry_joint_id = [2,1,7,8,9,10,3,4,5,6];
joint_name = {'Head', 'Shou', 'Elbo', 'Wris', 'Hip'};

symmetry_part_id = [1,2,5,6,3,4];
part_name = {'Head', 'Torso', 'U.arms', 'L.arms'};

%% Evaluate FLIC (Observer Centric)
load('gt/flic-joints-test-oc.mat', 'joints'); % load original FLIC labels
eval_name = 'FLIC-OC';

% eval PCP
load('results/FLIC/pred_sticks_flic_oc.mat', 'pred');
gt_sticks = keypoints2sticks(joints);
eval_pcp(pred, gt_sticks, symmetry_part_id, part_name, eval_name);

% eval PCK
load('results/FLIC/pred_keypoints_flic_oc.mat', 'pred');
eval_pck(pred, joints, symmetry_joint_id, joint_name, eval_name);

% eval PDJ
eval_pdj(pred, joints, reference_joints_pair, symmetry_joint_id, joint_name, eval_name);
% PARSE joint
% 1	Left ankle
% 2	Left knee
% 3	Left hip
% 4	Right hip
% 5	Right knee
% 6	Right ankle
% 7	Left wrist
% 8	Left elbow
% 9	Left shoulder
% 10	Right shoulder
% 11	Right elbow
% 12	Right wrist
% 13	Neck 
% 14	Head top
startup;

reference_joints_pair = [6, 7];     % right shoulder and left hip (from observer's perspective)
% symmetry_joint_id(i) = j, if joint j is the symmetry joint of i (e.g., the left
% shoulder is the symmetry joint of the right shoulder).
symmetry_joint_id = [2,1,7,8,9,10,3,4,5,6];
joint_name = {'Head', 'Shou', 'Elbo', 'Wris', 'Hip'};

symmetry_part_id = [1,2,5,6,3,4];
part_name = {'Head', 'Torso', 'U.arms', 'L.arms'};

%% Evaluate FLIC (Observer Centric)
load('gt/flic-joints-test-oc.mat', 'joints'); % load original parse labels
eval_name = 'FLIC-OC';

% eval PCP
load('results/FLIC/pred_sticks_flic_oc.mat', 'pred');
eval_pcp(pred, joints, symmetry_part_id, part_name, eval_name);

% eval PCK
load('results/FLIC/pred_keypoints_flic_oc.mat', 'pred');
eval_pck(pred, joints, symmetry_joint_id, joint_name, eval_name);

% eval PDJ
eval_pdj(pred, joints, reference_joints_pair, symmetry_joint_id, joint_name, eval_name);
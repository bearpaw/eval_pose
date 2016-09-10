% LSP joint
% 1	Right ankle
% 2	Right knee
% 3	Right hip
% 4	Left hip
% 5	Left knee
% 6	Left ankle
% 7	Right wrist
% 8	Right elbow
% 9	Right shoulder
% 10	Left shoulder
% 11	Left elbow
% 12	Left wrist
% 13	Neck
% 14	Head top
startup;

reference_joints_pair = [3, 10];     % right shoulder and left hip (from observer's perspective)
% symmetry_joint_id(i) = j, if joint j is the symmetry joint of i (e.g., the left
% shoulder is the symmetry joint of the right shoulder).
symmetry_joint_id = [6,5,4,3,2,1,12,11,10,9,8,7,14,13];
joint_name = {'Ankle', 'Knee', 'Hip', 'Wris', 'Elbo', 'Shou', 'Head'};

% symmetry_part_id(i) = j, if part j is the symmetry part of i (e.g., the left
% upper arm is the symmetry part of the right upper arm).
symmetry_part_id = [4,3,2,1,8,7,6,5,9,10];
part_name = {'L.legs', 'U.legs', 'L.arms', 'U.arms', 'Head', 'Torso'};
%% Evaluate LSP (Observer Centric)
load('gt/lsp-joints-OC.mat', 'joints');
joints = joints(1:2,:,1001:end);
eval_name = 'LSP-OC';

% eval PCP
load('results/LSP/pred_sticks_lsp_oc.mat', 'pred');
gt_sticks = keypoints2sticks(joints);
eval_pcp(pred, gt_sticks, symmetry_part_id, part_name, eval_name);

% eval PCK
load('results/LSP/pred_keypoints_lsp_oc.mat', 'pred');
eval_pck(pred, joints, symmetry_joint_id, joint_name, eval_name);

% eval PDJ
eval_pdj(pred, joints, reference_joints_pair, symmetry_joint_id, joint_name, eval_name);

%% Evaluate LSP (Person Centric)
load('gt/lsp-joints-PC.mat', 'joints');
joints = joints(1:2,:,1001:end);
eval_name = 'LSP-PC';

% eval PCP
load('results/LSP/pred_sticks_lsp_pc.mat', 'pred');
gt_sticks = keypoints2sticks(joints);
eval_pcp(pred, gt_sticks, symmetry_part_id, part_name, eval_name);

% eval PCK
load('results/LSP/pred_keypoints_lsp_pc.mat', 'pred');
eval_pck(pred, joints, symmetry_joint_id, joint_name, eval_name);

% eval PDJ
eval_pdj(pred, joints, reference_joints_pair, symmetry_joint_id, joint_name, eval_name);

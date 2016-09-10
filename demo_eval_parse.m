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

reference_joints_pair = [3, 10];     % right shoulder and left hip (from observer's perspective)
% symmetry_joint_id(i) = j, if joint j is the symmetry joint of i (e.g., the left
% shoulder is the symmetry joint of the right shoulder).
symmetry_joint_id = [6,5,4,3,2,1,12,11,10,9,8,7,14,13];
joint_name = {'Ankle', 'Knee', 'Hip', 'Wris', 'Elbo', 'Shou', 'Head'};

% symmetry_part_id(i) = j, if part j is the symmetry part of i (e.g., the left
% upper arm is the symmetry part of the right upper arm).
symmetry_part_id = [4,3,2,1,8,7,6,5,9,10];
part_name = {'L.legs', 'U.legs', 'L.arms', 'U.arms', 'Head', 'Torso'};
%% Evaluate PARSE (Person Centric)
load('gt/parse-labels.mat', 'ptsAll'); % load original parse labels
joints = permute(ptsAll, [2 1 3]);
joints = joints(:,:,101:305);
eval_name = 'PARSE-PC';

% eval PCP
load('results/PARSE/pred_sticks_parse_pc.mat', 'pred');
gt_sticks = keypoints2sticks(joints);
eval_pcp(pred, gt_sticks, symmetry_part_id, part_name, eval_name);

% eval PCK
load('results/PARSE/pred_keypoints_parse_pc.mat', 'pred');
eval_pck(pred, joints, symmetry_joint_id, joint_name, eval_name);

% eval PDJ
eval_pdj(pred, joints, reference_joints_pair, symmetry_joint_id, joint_name, eval_name);
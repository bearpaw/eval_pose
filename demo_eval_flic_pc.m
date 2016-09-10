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

% prepare groundtruth annotation

joint_order = [13, 14, 17, 4, 5, 6, 10, 1, 2, 3, 7];
np = length(joint_order);

flic_anno = load('~/Data/dataset/FLIC/examples.mat', 'examples');
flic_anno = flic_anno.examples;
test_frs_pos = find([flic_anno.istest] == 1); % testing frames for positive
% ------------------ original images -------------------
joints = zeros(2, np, length(test_frs_pos));
cnt = 1;
for ii = test_frs_pos
  clc; fprintf('%4d | %4d\n', ii, length(test_frs_pos));
  fr = flic_anno(ii);
  joints(:, :, cnt) = fr.coords(1:2,joint_order);
  cnt = cnt + 1;
end


reference_joints_pair = [4, 11];     % right shoulder and left hip (from observer's perspective)
% symmetry_joint_id(i) = j, if joint j is the symmetry joint of i (e.g., the left
% shoulder is the symmetry joint of the right shoulder).
symmetry_joint_id = [2,1,3,8,9,10,11,4,5,6,7];
joint_name = {'Eyes', 'Nose', 'Shou', 'Elbo', 'Wris', 'Hip'};

symmetry_part_id = [1,2,5,6,3,4];
part_name = {'Head', 'Torso', 'U.arms', 'L.arms'};

%% Evaluate FLIC (Person Centric)
eval_name = 'FLIC-OC';

predfile = '/home/wyang/code/pose/fb.resnet.torch.pose/checkpoints/flic_s8_mean/pred_best.h5';
preds = hdf5read(predfile,'preds');

% eval PCK
load('results/FLIC/pred_keypoints_flic_oc.mat', 'pred');
eval_pck(preds, joints, symmetry_joint_id, joint_name, eval_name);

% % eval PDJ
% eval_pdj(preds, joints, reference_joints_pair, symmetry_joint_id, joint_name, eval_name);
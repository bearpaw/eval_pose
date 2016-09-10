% MPII Cooking joint
% 1	neck
% 2	bottom torso
% 3	right shoulder
% 4	left shoulder
% 5	right elbow
% 6	left elbow
% 7	right wrist
% 8	left wrist
% 9	right hand
% 10	left hand
% 11	bottom head
% 12	top head
%
% MPII cooking has no `hip` annotations and cannot use the PDJ and PCK 
% evaluation measure
% It also has no head bounding box, hence can not use the PCKh protocal
% Match the released results available at
% http://datasets.d2.mpi-inf.mpg.de/MPIICookingActivities/poseChallenge-1.1.zip
% 
% Wei YANG
% Sep 10, 2016
clc;
startup;

reference_joints_pair = [3, 10];     % right shoulder and left hip (from observer's perspective)
% symmetry_joint_id(i) = j, if joint j is the symmetry joint of i (e.g., the left
% shoulder is the symmetry joint of the right shoulder).
symmetry_joint_id = [6,5,4,3,2,1,12,11,10,9,8,7,14,13];
joint_name = {'Ankle', 'Knee', 'Hip', 'Wris', 'Elbo', 'Shou', 'Head'};

% symmetry_part_id(i) = j, if part j is the symmetry part of i (e.g., the left
% upper arm is the symmetry part of the right upper arm).
symmetry_part_id = [1,3,2,5,4,6];
part_name = {'Torso', 'U.arms', 'L.arms', 'Head' };
%% Evaluate MPII cooking 
load('gt/mpii-cooking.mat', 'joints');
eval_name = 'MPII-cooking';

% eval PCP
load('results/mpii-cooking/Rohrbach_cvpr12.mat', 'pred');
gt_sticks = keypoints2sticks_mpii_cooking(joints);
pred_sticks = keypoints2sticks_mpii_cooking(pred);
eval_pcp(pred_sticks, gt_sticks, symmetry_part_id, part_name, eval_name);


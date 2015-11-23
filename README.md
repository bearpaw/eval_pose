# Evaluation Scripts for Human Pose Estimation

This package includes three widely used evaluation protocal for the task of human pose estimation. 
* 	Strict Percentage of Correct Parts (PCP): 
 	PCP measures the rate of correctly detected limbs: a limb is considered as correctly detected if the distances between detected limb endpoints and groundtruth limb endpoints are within half of the limb length ([Ferrari et al. CVPR’08]). We implement the strict version of PCP in this package.

* 	Percentage of Detected Joints (PDJ):
 	PDJ measures the detection rate of joints, where a joint is considered as detected if the distance between the predicted joint and the ground-truth joint is less than a fraction of torso diameter. The torso diameter is defined as the distance between left shoulder and right hip of each ground-truth pose ([Sapp et al. CVPR’13]).

* 	


	

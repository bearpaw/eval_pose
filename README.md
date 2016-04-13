# End-to-End Learning of Deformable Mixture of Parts and Deep Convolutional Neural Networks for Human Pose Estimation

Pose estimation results on the [LSP](http://www.comp.leeds.ac.uk/mat4saj/lsp.html) [1] dataset, the [FLIC](http://vision.grasp.upenn.edu/cgi-bin/index.php?n=VideoLearning.FLIC) [2] dataset, and the [Image Parse](http://www.cs.cmu.edu/~deva/papers/parse/index.html) [3] dataset for the following paper. 
> Wei Yang, Wanli Ouyang, Hongsheng Li, Xiaogang Wang. "End-to-End Learning of Deformable Mixture of Parts and Deep Convolutional Neural Networks for Human Pose Estimation". In CVPR, 2016.

## Instruction
Please run `demo_eval_DATASETNAME.m` to evaluate a specific dataset. `DATASETNAME` can be `lsp`, `flic` or `parse`.

## Acknowledgement
The evaluation code for the PCP and the PCK measurements are from a widely used version from the [MPII Human Pose Dataset](http://human-pose.mpi-inf.mpg.de/#related_benchmarks). The code for the PDJ measurement is from [Chen and Yuille, NIPS'14](http://www.stat.ucla.edu/~xianjie.chen/projects/pose_estimation/pose_estimation.html)

## Citation

	@InProceedings{yang2016end,
	  Title 		= {End-to-End Learning of Deformable Mixture of Parts and Deep Convolutional Neural Networks for Human Pose Estimation},
	  Author 		= {Yang, Wei and Ouyang, Wanli and Li, Hongsheng and Wang, Xiaogang},
	  Booktitle 	= {CVPR},
	  Year 			= {2016}
	}


## References
1. S. Johnson and M. Everingham. *Clustered pose and nonlinear appearance models for human pose estimation*. In BMVC, 2010. 
2. B. Sapp and B. Taskar. *Modec: Multimodal decomposable models for human pose estimation*. In CVPR, 2013.
3. D. Ramanan. *Learning to parse images of articulated objects.* In NIPS, 2006. 
	

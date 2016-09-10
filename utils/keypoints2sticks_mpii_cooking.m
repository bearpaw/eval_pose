function sticks = keypoints2sticks_mpii_cooking(keypoints)


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
  % The canonical part stick order:
  % 1 Right Lower Arm
  % 2 Right Upper Arm  
  % 3 Left Upper Arm 
  % 4 Left Lower Arm 
  % 5 Torso
  % 6 Head
  
  sticks = zeros(2,12,size(keypoints,3));   
  sticks(:,1:2,:) = [keypoints(:,1,:) keypoints(:,2,:)];   % torso
  sticks(:,3:4,:) = [keypoints(:,3,:) keypoints(:,5,:)]; % right-upper-arm    
  sticks(:,5:6,:) = [keypoints(:,4,:) keypoints(:,6,:)]; % left-upper-arm
  sticks(:,7:8,:) = [keypoints(:,5,:) keypoints(:,7,:)]; % right-fore-arm
  sticks(:,9:10,:) = [keypoints(:,6,:) keypoints(:,8,:)]; % left-fore-arm
  sticks(:,11:12,:) = [keypoints(:,11,:) keypoints(:,12,:)]; % head
end
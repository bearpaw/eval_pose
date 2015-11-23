function sticks = keypoints2sticks(keypoints)
joint_n = size(keypoints, 2);

if joint_n == 14 % LSP and PARSE
  % The canonical part stick order:
  % 1 Right Lower Leg
  % 2 Right Upper Leg  
  % 3 Left Upper Leg 
  % 4 Left Lower Leg 
  % 5 Right Lower Arm
  % 6 Right Upper Arm  
  % 7 Left Upper Arm 
  % 8 Left Lower Arm 
  % 9 Torso
  % 10 Head
  sticks = zeros(2,20,size(keypoints,3));
  sticks(:,1:2,:) = keypoints(:,1:2,:);
  sticks(:,3:4,:) = keypoints(:,2:3,:);
  sticks(:,5:6,:) = keypoints(:,4:5,:);
  sticks(:,7:8,:) = keypoints(:,5:6,:);
  sticks(:,9:10,:) = keypoints(:,7:8,:);
  sticks(:,11:12,:) = keypoints(:,8:9,:);
  sticks(:,13:14,:) = keypoints(:,10:11,:);
  sticks(:,15:16,:) = keypoints(:,11:12,:);
  sticks(:,17:18,:) = keypoints(:,13:14,:);
  sticks(:,19,:) = mean(keypoints(:,3:4,:),2);
  sticks(:,20,:) = mean(keypoints(:,9:10,:),2);
else % FLIC
  % The canonical joint order:
  % 1 Nose
  % 2 Neck
  % 3 Left shoulder (from observer's perspective)
  % 4 Left elbow
  % 5 Left wrist
  % 6 Left hip
  % 7 Right shoulder
  % 8 Right elbow
  % 9 Right wrist
  % 10 Right hip
  %
  % The canonical part stick order:
  % 1 Torso
  % 2 Head
  % 3 Left Upper Arm
  % 4 Left Lower Arm
  % 5 Right Upper Arm
  % 6 Right Lower Arm  
  stick_no = 6;
  sticks = zeros(2,stick_no*2,size(keypoints,3));
  
  sticks(:,1:2,:)   = [keypoints(:, 2, :), (keypoints(:, 6, :) + keypoints(:, 10, :))/2];         % Torso
  sticks(:,3:4,:)   = [keypoints(:, 1, :), keypoints(:, 2, :)];                                % Head
  sticks(:,5:6,:)   = [keypoints(:, 3, :), keypoints(:, 4, :)];                                % Left Upper Arm
  sticks(:,7:8,:)   = [keypoints(:, 4, :), keypoints(:, 5, :)];                                % Left Lower Arm
  sticks(:,9:10,:)  = [keypoints(:, 7, :), keypoints(:, 8, :)];                                % Right Upper Arm
  sticks(:,11:12,:) = [keypoints(:, 8, :), keypoints(:, 9, :)];                                % Right Lower Arm
end
end
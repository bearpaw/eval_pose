function [accs, range] = eval_pdj(pred, joints, reference_joints_pair, symmetry_joint_id, joint_name, eval_name)
% Evaluate Percentage of Detected Joints (PDJ)
assert(numel(reference_joints_pair) == 2);
show_joint_ids = find(symmetry_joint_id >= 1:numel(symmetry_joint_id)); 
range = 0:0.01:0.5;

% im = zeros(500, 500, 3);
% imshow(im); hold on;
% for i = 1:14
%   plot(joints(1, i, 2), joints(2, i, 2), 'Marker','o','MarkerFaceColor','red'); hold on; pause;
% end
% close;

num = size(pred, 3);
assert(num >= 1);
% the number of joints
joint_n = size(joints, 2);

scale = zeros(1, num);
for ii = 1:num
  scale(ii) = norm( joints(:,reference_joints_pair(1), ii) ...
    - joints(:,reference_joints_pair(2), ii) );
end

dists = zeros(num, joint_n);
for ii = 1:num
  dists(ii,:) = sqrt(sum( (pred(:, :, ii) - joints(:,:,ii)).^2, 1 ));
  dists(ii,:) = dists(ii,:) / scale(ii);
end

accs = zeros(numel(range), joint_n);
for ii = 1:numel(range)
  accs(ii,:) = mean(dists <= range(ii),1);
end

accs = (accs + accs(:,symmetry_joint_id)) / 2;
accs = accs(:, show_joint_ids);
% print
fprintf('-------------- PDJ Evaluation ---------------\n')
fprintf('Joints    '); fprintf('& %s ', joint_name{:}); fprintf('\n');
sample_pdj_thresholds = [0.1, 0.2, 0.3, 0.4];
for ii = 1:length(sample_pdj_thresholds)
  t = sample_pdj_thresholds(ii);
  idx = (range == t);
  fprintf('PDJ@%.2f  ', t); fprintf('& %.1f ', accs(idx,:)*100); fprintf('\n');
end
% plot
line_width = 2;
p_color = {'g','y','b','r','c','k','m'};
% visualize
figure; hold on; grid on;
for ii = 1:numel(show_joint_ids)
  plot(range, accs(:, ii), p_color{mod(ii, numel(p_color))+1}, 'linewidth', line_width);
end
leg_str = cell(numel(show_joint_ids), 1);
for ii = 1:numel(show_joint_ids)
  leg_str{ii} = sprintf('%s', joint_name{ii});
end
h_leg = legend(leg_str, 'FontSize', 12);
set(h_leg, 'location', 'southeast', 'linewidth', 1);

axis([range(1),range(end), 0, 1]);
set(gca,'ytick', 0:0.1:1);
set(gca, 'linewidth', 1);
% --- titles
xlabel('Normalized Precision Threshold') % x-axis label
ylabel('Detection Rate') % y-axis label

title([eval_name ' PDJ']);
hold off;

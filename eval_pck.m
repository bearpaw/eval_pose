function eval_pck(pred, joints, symmetry_joint_id, joint_name, name)
% implementation of PCK measure,
% as defined in [Sapp&Taskar, CVPR'13].
% torso height: ||left_shoulder - right hip||
range = 0:0.01:0.2;
show_joint_ids = (symmetry_joint_id >= 1:numel(symmetry_joint_id));

% compute distance to ground truth joints
dist = get_dist_pck(pred,joints(1:2,:,:));

% compute PCK
pck_all = compute_pck(dist,range);
pck = pck_all(end, :);
pck(1:end-1) = (pck(1:end-1) + pck(symmetry_joint_id))/2;
% plot results
pck = [pck(show_joint_ids) pck(end)];
fprintf('------------ PCK Evaluation: %s -------------\n', name);
fprintf('Parts '); fprintf('& %s ', joint_name{:}); fprintf('& Mean\n');
fprintf('PCK   '); fprintf('& %.1f  ', pck); fprintf('\n');

auc = area_under_curve(scale01(range),pck_all(:,end));
%     plot(range,pck(:,end),'color',p.colorName,'LineStyle','-','LineWidth',3);
fprintf('%s, AUC: %1.1f\n', name, auc);

% -------------------------------------------------------------------------
function dist = get_dist_pck(pred,gt)

assert(size(pred,1) == size(gt,1) && size(pred,2) == size(gt,2) && size(pred,3) == size(gt,3));

dist = nan(1,size(pred,2),size(pred,3));

for imgidx = 1:size(pred,3)
  
  % torso diameter
  if size(gt, 2) == 14
    refDist = norm(gt(:,10,imgidx) - gt(:,3,imgidx));
  elseif size(gt, 2) == 10 % 10 joints FLIC
    refDist = norm(gt(:,7,imgidx) - gt(:,6,imgidx));
  elseif size(gt, 2) == 11 % 11 joints FLIC
    refDist = norm(gt(:,4,imgidx) - gt(:,11,imgidx));
  else
    error('Number of joints should be 14 or 10 or 11');
  end
  
  % distance to gt joints
  dist(1,:,imgidx) = sqrt(sum((pred(:,:,imgidx) - gt(:,:,imgidx)).^2,1))./refDist;
  
end


% -------------------------------------------------------------------------
function pck = compute_pck(dist,range)

pck = zeros(numel(range),size(dist,2)+1);

for jidx = 1:size(dist,2)
  % compute PCK for each threshold
  for k = 1:numel(range)
    pck(k,jidx) = 100*mean(squeeze(dist(1,jidx,:))<=range(k));
  end
end

% compute average PCK
for k = 1:numel(range)
  pck(k,end) = 100*mean(reshape(squeeze(dist(1,:,:)),size(dist,2)*size(dist,3),1)<=range(k));
end

% -------------------------------------------------------------------------
function auc = area_under_curve(xpts,ypts)

if nargin == 1
  ypts = xpts;
  xpts = (1:size(ypts,2))/size(ypts,2);
end

a = min(xpts);
b = max(xpts);
%remove duplicate points
[ignore,I,J] = unique(xpts);
xpts = xpts(I);
ypts = ypts(I);
if length(xpts) < 2; auc = NaN; return; end
myfun = @(x)(interp1(xpts,ypts,x));
auc = quadgk(myfun,a,b);
function eval_pcp(pred, gt_sticks, symmetry_part_id, part_name, name)
show_part_ids = find(symmetry_part_id >= 1:numel(symmetry_part_id));
% evaluate strict PCP
range = 0.5;
% compute distance to ground truth joints
dist = getDistPCP(pred,gt_sticks);

% compute PCP
pcp = computePCP(dist,range);

% plot results
pcp(1:end-1) = (pcp(1:end-1) + pcp(symmetry_part_id))/2;
print_pcp(pcp, show_part_ids, part_name, name);


% -------------------------------------------------------------------------
function dist = getDistPCP(pred,gt_sticks)
% assert(size(gt_sticks,2) == 20);
assert(size(pred,1) == size(gt_sticks,1) && size(pred,2) == size(gt_sticks,2) && size(pred,3) == size(gt_sticks,3));

dist = nan(1,size(pred,2),size(pred,3));

for imgidx = 1:size(pred,3)
  for jidx = 1:size(gt_sticks,2)/2
    jidx1 = 2*(jidx-1)+1;
    jidx2 = 2*(jidx-1)+2;
    % distance to gt endpoints
    dist(1,jidx1,imgidx) = norm(gt_sticks(:,jidx1,imgidx) - pred(:,jidx1,imgidx))/norm(gt_sticks(:,jidx1,imgidx) - gt_sticks(:,jidx2,imgidx));
    dist(1,jidx2,imgidx) = norm(gt_sticks(:,jidx2,imgidx) - pred(:,jidx2,imgidx))/norm(gt_sticks(:,jidx1,imgidx) - gt_sticks(:,jidx2,imgidx));
  end
end

% -------------------------------------------------------------------------
function [pcp, match] = computePCP(dist,range)
pcp = zeros(numel(range),size(dist,2)/2+1);
matchAll = zeros(numel(range),size(dist,2)/2*size(dist,3));
match = cell(1, size(dist,2)/2);
for jidx = 1:size(dist,2)/2
  % compute PCP for each threshold
  jidx1 = 2*(jidx-1)+1;
  jidx2 = 2*(jidx-1)+2;
  for k = 1:numel(range)
    match{jidx} = squeeze(dist(1,jidx1,:))<=range(k) & squeeze(dist(1,jidx2,:)<=range(k));
    pcp(k,jidx) = 100*mean(match{jidx});
    matchAll(k,size(dist,3)*(jidx-1)+1:size(dist,3)*(jidx)) = match{jidx};
  end
end
% compute average PCP
for k = 1:numel(range)
  pcp(k,end) = 100*mean(matchAll(k,:));
end
    
% -------------------------------------------------------------------------
function print_pcp(pcp, show_part_ids, part_name, name)
pcp = [pcp(show_part_ids) pcp(end)];
fprintf('------------ strict PCP Evaluation: %s -------------\n', name);
fprintf('Parts      '); fprintf('& %s ', part_name{:}); fprintf('& Mean\n');
fprintf('strict PCP '); fprintf('& %.1f  ', pcp); fprintf('\n');
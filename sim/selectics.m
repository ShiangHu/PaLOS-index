function ic = selectics
% SELECTICS review the ic type ratios and select the most typical noisey ics
% based on the artifacts.log

mulse = struct('name',{'MC27','MC03','MC05'},'idx',{35 20 23},'type','mulse');

channel = struct('name',{'MC14','MC01','MC01'},'idx',{22 27 45},'type','channel');

eye = struct('name',{'MC11','MC16','MC19','MC14','MC05','MC27','MC29'},'idx',{42 1 3 3 2 1 2},'type','eye');

other = struct('name',{'MC05','MC10','MC01','MC03','MC03'},'idx',{12 10 32 25 30},'type','other');

ic = struct('mulse',mulse,'channel',channel,'eye',eye,'other',other);

end
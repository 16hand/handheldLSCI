imagefiles = dir('*.PNG'); 
nfiles = length(imagefiles);    % Number of files found
figure(1)
C = imread(imagefiles(1).name);
max_contrast = max(C(:));
imagesc(C);
colormap(jet);caxis([0 max_contrast]);colorbar();

roi = drawrectangle('Color','r');
posi = roi.Position;
% C_cropped = C(posi(2):posi(2)+posi(4),posi(1):posi(1)+posi(3));
% figure (1)
% imagesc(C_cropped)
%cmean = mean(C_cropped(:));

C_cropped = [];
for ii=1:nfiles
   C = imread(imagefiles(ii).name);
   C_cropped = C(posi(2):posi(2)+posi(4),posi(1):posi(1)+posi(3));
   C_max_cropped(ii) = max(C_cropped(:));
   C_min_cropped(ii) = min(C_cropped(:));

end
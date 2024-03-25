v = VideoWriter('perfused_handhold_LSCI.avi');%to be created
open(v);
vidObj = VideoReader('perfused_handhold_part1.avi');


while hasFrame(vidObj)
    vidFrame = readFrame(vidObj);
    img = double(vidFrame(:,:,2));
    %img = img(120:170,85:95); % devas
    %img = img(150:155,90:100); % vas
    kernel = ones(3,3);%These dimensions are arbitrary
    Nk = sum(kernel(:));
    mu_img = filter2(kernel,img,'valid')/Nk;
    img_sq = filter2(kernel,img.^2,'valid');
    sig_img = sqrt((img_sq-Nk*mu_img.^2)/(Nk-1));
    C = sig_img./mu_img;
    tiledlayout(1,2)
    set(gcf,'units','normalized','position',[0 0 1 1])
    %Top plot
    nexttile
    ax1 = nexttile(1);
    imagesc(C);
    colormap(ax1,jet);caxis([0 0.4]);
    colorbar();
    title('Perfused Channel Speckle Contrast');
    size_img=size(img);
    
    
    
    %Bottom plot
    nexttile
    ax2 = nexttile(2);
    imagesc(C);
    colormap(ax2,jet);caxis([0 0.4]);
    colorbar();
    title('Patient8 pre Speckle Contrast thresholded');
    pause(1/500);
    %pause(1/vidObj.FrameRate);
    frame = getframe(gcf);
    writeVideo(v,frame);
    Cmean_overt = [Cmean_overt;mean(C(:))];
    Cstd_overt = [Cstd_overt;std(C(:))];
    Cmax_overt = [Cmax_overt;max(C(:))];
    Cmin_overt = [Cmin_overt;min(C(:))];
    
end



close(v);close all;
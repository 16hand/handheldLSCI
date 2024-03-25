v = VideoWriter('06.11.2023_lscioverheadWL_patient7_vascularized_cropped.avi');%to be created
open(v);
vidObj = VideoReader('prelsic.avi');
Cmean_overt = [];
Cstd_overt = [];
while hasFrame(vidObj)
    vidFrame = readFrame(vidObj);
    img = double(vidFrame(:,:,2));
    %img = img(100:150,60:110); % devas
    img = img(70:180,70:130); % vas
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
    title('Patient7 pre Speckle Contrast');
    size_img=size(img);
    for ii = 1:size_img(1)-2
        for jj = 1:size_img(2)-2
            if C(ii,jj) < 0.025 || C(ii,jj) > 0.35
                C(ii,jj)=0.125;
            end
        end
    end
    %Bottom plot
    nexttile
    ax2 = nexttile(2);
    imagesc(C);
    colormap(ax2,jet);caxis([0 0.4]);
    colorbar();
    title('Patient7 pre Speckle Contrast thresholded');
    pause(1/500);
    %pause(1/vidObj.FrameRate);
    frame = getframe(gcf);
    writeVideo(v,frame);
    Cmean_overt = [Cmean_overt;mean(C(:))];
    Cstd_overt = [Cstd_overt;std(C(:))];
end

cmean_vas = Cmean_overt;
cstd_vas = Cstd_overt;

close(v);close all;
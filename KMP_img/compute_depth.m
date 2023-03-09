function [Mapy] = compute_depth(path)
dispR = [64 256];
Mapy=cell(1,5);
for ind=1:5
    cesta1=[path,'\im',num2str(ind),'\im0.png'];
    cesta2=[path,'\im',num2str(ind),'\im1.png'];
    img1 = im2double(rgb2gray(imread(cesta1)));
    img2 = im2double(rgb2gray(imread(cesta2)));
%     gamma=2;
%     img1 = img1^gamma;
%     img2 = img2^gamma;
    dispMap = disparityBM(img1,img2,'DisparityRange',dispR,'UniquenessThreshold',1,'BlockSize',19,'ContrastThreshold',0.1,'DistanceThreshold',400,'TextureThreshold',0.001);
    dispMap=double(dispMap);
    dispMap(isnan(dispMap))=0;

    dispMap=medfilt2(dispMap,[11,11]);
%     figure
%     subplot(211)
%     imshow(img1)
%     subplot(212)
%     imshow(img2)
%     figure
%     imshow(dispMap,dispR)
%     colormap jet

    cesta3=[path,'\im',num2str(ind),'\calib.txt'];
    info=readcell(cesta3);
    f=str2num(info{1,2});
    f=f(1);
    doffs=info{3,2};
    b=info{4,2};
    pomoc=(f*b)./(dispMap+doffs);
    pomoc(pomoc==max(max(pomoc)))=0;
    Mapy{1,ind}=pomoc;
%     figure
%     imshow(Mapy{1,ind})
end
end
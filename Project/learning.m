function learning

img=imread('F:\Car_Dataset\12 (11).jpg');

f=imresize(img,[400 NaN]);
g=rgb2gray(f);
% it remove the noise and it apply the mediam filtering 
 g=medfilt2(g,[3 3]); 
%  imdilate increase the white portion it check weather the neighbooring
%  elemnt is zero or one depending on it ,it increase the white optin it
%  mean it crease 1 in matrix.while imerode increase the 0 in the image.
se=strel('disk',1);
gi=imdilate(g,se);
ge=imerode(g,se);
% it subtract the two matrix it mean it subtratct the white potion from the
% black potion.
gdiff=imsubtract(gi,ge);

%  sets the values of amin and amax to the minimum and maximum values in A.
gdiff=mat2gray(gdiff);
%  apply filter
gdiff=conv2(gdiff,[1 1;1 1]);
% it adjust all the values having range 0.5 to 0.7 to 0 and 1 and 0.1 is
% gama value which decide weather the mapping i learning or not.
gdiff=imadjust(gdiff,[0.5 0.7],[0 1],0.1);

%  it convert non zero values to 1 and all zeros to 0.
B=logical(gdiff);
figure,imshow(B);
[ a1, b1]=size(B);
%  it increase the balck potion in the image.
er=imerode(B,strel('line',100,0));
%  it subtract the image
out1=imsubtract(B,er);
%  it fill the holes beween the any potion of image.
F=imfill(out1,'holes');
% applies a specific morphological operation to the binary image BW.
H=bwmorph(F,'thin',1);
imshowpair(img,H,'montage'); figure; 
H=imerode(H,strel('line',5,90));
final=bwareaopen(H,50);
imshow(final);
  [L Ne] = bwlabel(final);
propied = regionprops(final,'BoundingBox','image');

 dimensions={};
 
for n =1:size(propied,1)
    dimensions{n} = propied(n).Image;
     rectangle('position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2);
end
for i=1:length(dimensions)
   [r c]=size(dimensions{i});
   if r>=35 && r<=45
       if c>=20 && c<=27
            figure; imshow(dimensions{i});
       end
   end
       
end
    
    % allImages=[];
%     for n=1:Ne 
%         Idx = L==n;
%         [r c] = find(Idx==true)       
%         n1 = Idx(min(r):max(r),min(c):max(c));
%         imwrite(n1,['a' num2str(n) '.bmp']);
%         allImages = [allImages n];
% %         imshow(n1);figure;
%     end
% %       for i = 1:size(allImages,1)
% %           imwrite(n1,['a' num2str(n) '.bmp']);
% %       end
end
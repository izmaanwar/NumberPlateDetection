
img=imread('F:\Car_Dataset\27 (5).jpg');

%f=imresize(img,[400 NaN]);
f=img;
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

[ a1, b1]=size(B);
%  it increase the balck potion in the image.
er=imerode(B,strel('line',100,0));
%  it subtract the image
out1=imsubtract(B,er);
%  it fill the holes beween the any potion of image.
F=imfill(out1,'holes');
% applies a specific morphological operation to the binary image BW.
H=bwmorph(F,'thin',1);
%imshowpair(img,H,'montage'); figure; 
%H=imerode(H,strel('line',5,90));

final=bwareaopen(H,50);
final=imerode(final,strel('rectangle',[20 20]));
imshow(final);
[L ne]=bwlabel(final);
propied=regionprops(L,'BoundingBox');
for pl=1:ne
    
    co=propied(pl).BoundingBox;
   rectangle('Position',co,'EdgeColor','g','LineWidth',2);
end
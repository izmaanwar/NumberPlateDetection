function flag=bill(imgSrc)
Inputimage=imgSrc;
figure(1)
imshow(Inputimage);

title('INPUT IMAGE WITH NOISE')
origImage=Inputimage;
s=1;

%% Convert to gray scale
if size(Inputimage,3)==3 % RGB image
 Inputimage=rgb2gray(Inputimage);
end
%try 

%Inputimage=imgaussfilt( Inputimage ,2); 

%% Convert to binary image
Inputimage=imerode(Inputimage,strel('rectangle',[5 5]));
threshold = graythresh(Inputimage);
Inputimage =im2bw(Inputimage,threshold);
%Step 4 : To remove all Boundary connected Objects which are less than 30 pixels
%figure,
%imshow(Inputimage);

Iimage=bwareafilt(Inputimage,[7000 900000]);

figure,imshow(Iimage);
hold on;
Inputimage=Iimage;
[L ne]=bwlabel(Iimage);
propied=regionprops(L,'BoundingBox');
s1=1;
str='';
for pl=1:ne
    
    co=propied(pl).BoundingBox;
    if(co(3)>200 && co(3)<1800 && co(4)>100 && co(4)<700 )         
   rectangle('Position',co,'EdgeColor','g','LineWidth',2);
   
%         tempImage= imcrop(Iimage,co);
%         
%       tempImage=edge(tempImage,'canny');
        copyOriginalImage=origImage;
        
%       figure;imshow(copyOriginalImage);
       copyOriginalImageRot=(imcrop(copyOriginalImage,co));
       
       Newimg=copyOriginalImageRot;
        threshold = graythresh(Newimg);
        Newimg =~im2bw(Newimg,threshold);
        [L1 Ne]=bwlabel(Newimg);
        
        propied1=regionprops(L1,'BoundingBox');
        [r2,c2]=size(L1);
let='';
year='';
f=L1;
tempImage=[];
for q=1:size(propied1,1)

   rect=propied1(q).BoundingBox;
   
  %rectangle('Position',rect,'EdgeColor','g','LineWidth',2);
   
  if(ceil(rect(1))<c2-c2/10 && rect(3)>20&&rect(4)>30&& rect(3)<500 && rect(4)<200)%rect(3)>20 && rect(3)<500&& rect(4)>50 && rect(4)<200)
   tempImage= f==q;
J = imcrop(Newimg,rect) ;
%figure,imshow(J);
J = conv2(uint8(J), ones(5)/5^2, 'same');

img=imresize(J,[42 24]);
if(ceil(rect(1))>c2-c2/4)
year=strcat(year,readLetter(img));      
else   
let=strcat(let,readLetter(img));
end
  end
end
let
if strlength(let)>4
Num = regexp(let,'\d');
str2=let(Num);
Num=regexp(let,'[A-Z]+');
 str1=let(Num);
s1=2;
str3=str1+"  "+str2+" "+year;
if(strlength(str)<strlength(str3))
    str=str3;
end
end
    end
end
if(s1==2)
    fid = fopen('noPlate.txt', 'wt'); % This portion of code writes the number plate
    fprintf(fid,'%s\n',str);      % to the text file, if executed a notepad file with the
    fclose(fid);                      % name noPlate.txt will be open with the number plate written.
    winopen('noPlate.txt')
    flag=1;
else
% fid = fopen('noPlate.txt', 'wt'); % This portion of code writes the number plate
 %   fprintf(fid,'%s\n',"Error Pic not clear");      % to the text file, if executed a notepad file with the
  %  fclose(fid);                      % name noPlate.txt will be open with the number plate written.
   % winopen('noPlate.txt')
   flag=0;

end

function flag=extractChar(imgSrc)
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
for pl=4:4
    
    co=propied(pl).BoundingBox;
    if(co(3)>200 && co(3)<1800 && co(4)>100 && co(4)<700 )         
   rectangle('Position',co,'EdgeColor','g','LineWidth',2);
   
        tempImage= imcrop(Iimage,co);
        
   %   tempImage=edge(tempImage,'canny');
    %    copyOriginalImage=origImage;
        
%       figure;imshow(copyOriginalImage);
     %  copyOriginalImageRot=(imcrop(copyOriginalImage,co));
      
se=strel('rectangle',[1 2]);
      tempImage=imfill(tempImage,'holes');
      tempImage=imopen(tempImage,se);
       se=strel('rectangle',[50 40]);
    
      tempImage=imclose(tempImage,se);
      
      h = fspecial('motion', 20, 30);
      tempImage=imfilter(tempImage,h);
      
       [X,Y]=find(tempImage==1);
      %blurring image
       windowSize = 51;
kernel = ones(windowSize) / windowSize ^ 2;
      blurryImage = conv2(single(tempImage), kernel, 'same');
        binaryImage = blurryImage > 0.5; % Rethreshold
  tempImage=blurryImage;
      figure,imshow(tempImage);
      %finding Corners
       C=corner(tempImage,'Harris');
      [r,c]=size(tempImage);
      
      orig=zeros(r,c);
      hold on
        
      plot(C(:,1),C(:,2),'r')
      C
      co=vertcat(propied(pl).BoundingBox);
      bbox=[];
      ymin=ceil(co(1));%reminding there y is working as x
      ymax=ymin+ceil(co(3));% should use y x for row col in matlab
      xmin=ceil(co(2));
      xmax=xmin+ceil(co(4));
           [s,s1]=size(C);
      point(1)=ymin;
      point(2)=xmin;
      [topLeft,C]=minDistPoint(point,C,s);
      point(1)=ymax;
      point(2)=xmin;
      [topRight,C]=minDistPoint(point,C,s);
      point(1)=ymin;
      point(2)=xmax;
     [bottomLeft,C]=minDistPoint(point,C,s);
     point(1)=ymax;
     point(2)=xmax;
     [bottomRight,C]=minDistPoint(point,C,s);
      
      pin=[topLeft(1) topRight(1) bottomLeft(1) bottomRight(1);topLeft(2) topRight(2) bottomLeft(2) bottomRight(2)]
      pout=[1 500 1 500;1 1 250 250]
      if(topLeft(1)>topRight(1)||topRight(1)-topLeft(1)<200||topRight(1)-topLeft(1)>1000)
          disp("ec");
          continue;
          
      end
      if(topLeft(2)>bottomLeft(2)||bottomLeft(2)-topLeft(2)<50||bottomLeft(2)-topLeft(2)>500)
          disp("ec1");
          continue;
      end
       if(topRight(2)>bottomRight(2)||bottomRight(2)-topRight(2)<50||bottomRight(2)-topRight(2)>500)
          disp("ec2");
           continue;
       end
       if(bottomLeft(1)>bottomRight(1)||bottomRight(1)-bottomLeft(1)<200||bottomRight(1)-bottomLeft(1)>1000)
          disp("ec3");
           continue;
      end
      
      
    rectangle('Position',co,'EdgeColor','g','LineWidth',2);
     
    H=homography_solve(pin,pout);
    t=projective2d(H');
    [img2] = imwarp(tempImage, t);
    
    d=[topLeft(1) topLeft(2) 1];
    d=abs(inv(H))*d'
    d=ceil(d/d(3))
    
    img2=im2bw(img2);
   % figure,imshow(img2);
    
    [idx,u,v]=find(img2==1);
    
    if(isempty(u)||isempty(v))
        continue;
    end
    
    [img3] = imwarp(origImage, t);
%    figure,imshow(img3);
    
    img3=imcrop(img3,[min(u) min(idx) 600 350]);
   % figure,imshow(img3);
    
	 Newimg=img3;
    %    threshold = graythresh(Newimg);


	  
     %  Newimg=copyOriginalImageRot;
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
   
  rectangle('Position',rect,'EdgeColor','g','LineWidth',2);
   
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
end
function [I,C]=minDistPoint(Bpoint,Cpoints,s)
    d=inf;
    I=[];
     g=0;
      for i=1:s
        X=[Bpoint(1),Bpoint(2);Cpoints(i,1),Cpoints(i,2)];
        dist=pdist(X,'euclidean');
        if(dist<d)
            d=dist;
            I(1)=Cpoints(i,1);
            I(2)=Cpoints(i,2);
            g=i;
        end
                
      end
      if(g~=0)
          Cpoints(g,1)=1;
          Cpoints(g,2)=1;
      end
      C=Cpoints;
end
function v = homography_solve(pin, pout)
% HOMOGRAPHY_SOLVE finds a homography from point pairs
%   V = HOMOGRAPHY_SOLVE(PIN, POUT) takes a 2xN matrix of input vectors and
%   a 2xN matrix of output vectors, and returns the homogeneous
%   transformation matrix that maps the inputs to the outputs, to some
%   approximation if there is noise.
%
%   This uses the SVD method of
%   http://www.robots.ox.ac.uk/%7Evgg/presentations/bmvc97/criminispaper/node3.html
% David Young, University of Sussex, February 2008
if ~isequal(size(pin), size(pout))
    error('Points matrices different sizes');
end
if size(pin, 1) ~= 2
    error('Points matrices must have two rows');
end
n = size(pin, 2);
if n < 4
    error('Need at least 4 matching points');
end
% Solve equations using SVD
x = pout(1, :); y = pout(2,:); X = pin(1,:); Y = pin(2,:);
rows0 = zeros(3, n);
rowsXY = -[X; Y; ones(1,n)];
hx = [rowsXY; rows0; x.*X; x.*Y; x];
hy = [rows0; rowsXY; y.*X; y.*Y; y];
h = [hx hy];
if n == 4
    [U, ~, ~] = svd(h);
else
    [U, ~, ~] = svd(h, 'econ');
end
v = (reshape(U(:,9), 3, 3)).';
end

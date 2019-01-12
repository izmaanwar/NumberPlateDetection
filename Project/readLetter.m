function letter=readLetter(snap)
%READLETTER reads the character fromthe character's binary image.
%   LETTER=READLETTER(SNAP) outputs the character in class 'char' from the
%   input binary image SNAP.

load NewTemplates % Loads the templates of characters in the memory.
comp=[ ];
for n=1:length(NewTemplates)
    sem=corr2(NewTemplates{1,n},snap); % Correlation the input image with every image in the template for best matching.
    comp=[comp sem]; % Record the value of correlation for each template's character.
end
letter='';
if(max(comp)>0.50)
vd=find(comp==max(comp)); % Find the index which correspond to the highest matched character.
vd
%*-*-*-*-*-*-*-*-*-*-*-*-*-
% Accodrding to the index assign to 'letter'.
% Alphabets listings.
if isequal(vd,1) || isequal(vd,2) || isequal(vd,3)|| isequal(vd,4)
    letter='A';
elseif isequal(vd,5) || isequal(vd,6) || isequal(vd,7)|| isequal(vd,8)|| isequal(vd,9)||isequal(vd,10)
    letter='B';
elseif isequal(vd,11)
    letter='C';
elseif isequal(vd,12) || isequal(vd,13)
    letter='D';
elseif isequal(vd,14) || isequal(vd,15) || isequal(vd,16)|| isequal(vd,17)
    letter='E';
elseif isequal(vd,18) || isequal(vd,19) || isequal(vd,20)
    letter='F';
elseif isequal(vd,21)
    letter='G';
elseif isequal(vd,22)
    letter='H';
elseif isequal(vd,23)
    letter='I';
elseif isequal(vd,24)
    letter='J';
elseif isequal(vd,25)
    letter='K';
elseif isequal(vd,26)||isequal(vd,27)||isequal(vd,28)||isequal(vd,29)||isequal(vd,30)
    letter='L';
elseif isequal(vd,31)
    letter='M';
elseif isequal(vd,32)
    letter='N';
elseif isequal(vd,33) || isequal(vd,34)
    letter='O';
elseif isequal(vd,35) || isequal(vd,36)
    letter='P';
elseif isequal(vd,37) || isequal(vd,38)
    letter='Q';
elseif isequal(vd,39) || isequal(vd,40)
    letter='R';
elseif isequal(vd,41)
    letter='S';
elseif isequal(vd,42)
    letter='T';
elseif isequal(vd,43)
    letter='U';
elseif isequal(vd,44)
    letter='V';
elseif isequal(vd,45)
    letter='W';
elseif isequal(vd,46)
    letter='X';
elseif isequal(vd,47)
    letter='Y';
elseif isequal(vd,48)
    letter='Z';
    %*-*-*-*-*
% Numerals listings.
elseif isequal(vd,49) || isequal(vd,50) || isequal(vd,51) || isequal(vd,52)|| isequal(vd,53)
    letter='1';
elseif isequal(vd,54) || isequal(vd,55) || isequal(vd,56)||isequal(vd,57)
    letter='2';
elseif isequal(vd,58)||isequal(vd,59)
    letter='3';
elseif isequal(vd,60) || isequal(vd,61)||isequal(vd,62)
    letter='4';
elseif isequal(vd,63)||isequal(vd,64)|| isequal(vd,65)|| isequal(vd,66)||isequal(vd,67)
    letter='5';
elseif isequal(vd,68) || isequal(vd,69) || isequal(vd,70) || isequal(vd,71)
    letter='6';
elseif isequal(vd,72) || isequal(vd,73)|| isequal(vd,74)
    letter='7';
elseif isequal(vd,75) || isequal(vd,76)||isequal(vd,77)||isequal(vd,78)
    letter='8';
elseif isequal(vd,79) || isequal(vd,80) || isequal(vd,81) || isequal(vd,82)|| isequal(vd,83)
    letter='9';
elseif isequal(vd,84)
    letter='1';
elseif isequal(vd,85)||isequal(vd,86)||isequal(vd,87)
    letter='';
else
    letter='0';
end
end
end
%CREATE TEMPLATES
%Letter
A=imread('A.bmp');A1=imread('A1.bmp');
A2=imread('A2.bmp');
B=imread('B.bmp');B3=imread('B3.bmp');
B1=imread('B1.bmp');B2=imread('B2.bmp');
B4=imread('b4.bmp');
C=imread('C.bmp');D=imread('D.bmp');
E=imread('E.bmp');
E1=imread('E1.bmp');F=imread('F.bmp');
G=imread('G.bmp');H=imread('H.bmp');
I=imread('I.bmp');J=imread('J.bmp');
K=imread('K.bmp');L=imread('L.bmp');
M=imread('M.bmp');N=imread('N.bmp');
O=imread('O.bmp');P=imread('P.bmp');
Q=imread('Q.bmp');R=imread('R.bmp');
S=imread('S.bmp');T=imread('T.bmp');
U=imread('U.bmp');V=imread('V.bmp');
W=imread('W.bmp');X=imread('X.bmp');
Y=imread('Y.bmp');Z=imread('Z.bmp');
Afill=imread('fillA.bmp');
Bfill=imread('fillB.bmp');
Dfill=imread('fillD.bmp');
Ofill=imread('O.bmp');
Pfill=imread('fillP.bmp');
Qfill=imread('Q.bmp');
Rfill=imread('fillR.bmp');
LL=imread('LL.bmp');
L1=imread('L1.bmp');
L3=imread('L3.bmp');
L4=imread('L4.bmp');

EE=imread('EE.bmp');
EEE=imread('EEE.bmp');
FF=imread('FF.bmp');
F2=imread('F2.bmp');

%Number
one=imread('1.bmp');one1=imread('11.bmp');
one2=imread('12.bmp');one3=imread('13.bmp');
one4=imread('14.bmp');one5=imread('15.bmp');
two=imread('2.bmp');
two1=imread('21.bmp');
two2=imread('22.bmp');
two3=imread('23.bmp');
three=imread('3.bmp');three1=imread('31.bmp');
four=imread('4.bmp');four1=imread('41.bmp');
five=imread('5.bmp');five1=imread('51.bmp');
five2=imread('52.bmp');five3=imread('53.bmp');five4=imread('54.bmp');
six=imread('6.bmp');
six1=imread('61.bmp');
seven2=imread('72.bmp');seven1=imread('71.bmp');
seven=imread('7.bmp');eight=imread('8.bmp');
eight1=imread('81.bmp');eight2=imread('82.bmp');
nine=imread('9.bmp'); zero=imread('0.bmp');
zero2=imread('02.bmp');
zero1=imread('01.bmp');
zerofill=imread('0.bmp');
fourfill=imread('fill4.bmp');
sixfill=imread('fill6.bmp');
sixfill2=imread('fill6_2.bmp');
eightfill=imread('fill8.bmp');
nine1=imread('91.bmp');nine2=imread('92.bmp');
ninefill=imread('fill9.bmp');
ninefill2=imread('fill9_2.bmp');

%noise
noise=imread('noise.bmp');
noise1=imread('noise1.bmp');
noise2=imread('noise2.bmp');
%*-*-*-*-*-*-*-*-*-*-*-
letter=[A A1 A2 Afill B Bfill B1 B4 B2 B3 C D Dfill E E1 EE EEE F FF F2 G H I J K L L1 LL L3 L4 M...
    N O Ofill P Pfill Q Qfill R Rfill S T U V W X Y Z];

number=[one one1 one2 one3 one4 two two1 two2 two3 three three1 four four1 fourfill five five1 five2 ...
    five3 five4 six six1 sixfill sixfill2 seven seven1 seven2 eight eight2 eight1 eightfill nine nine2 ninefill ...
    nine1 ninefill2 one5 noise noise1 noise2 zero zerofill zero1 zero2 ];

character=[letter number];
[i,m]=size(character);
NewTemplates=mat2cell(character,42,[24 24 24 24 24 24 24 24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24 24 24 24 24]);
save ('NewTemplates','NewTemplates')
clear all
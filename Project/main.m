%create_templates
clear All

Image=imread('F:\Car_Dataset\20 (3).jpg');

flag=bill(Image);
if(flag==0)
   f_new_rotation(Image);
end
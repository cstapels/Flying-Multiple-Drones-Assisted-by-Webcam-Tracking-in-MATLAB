function [leftImage, rightImage] = updateImage(myCam)
% Takes in the camera object and create a new snap shot image
% and then split it into left and right images, which are returned by the
% function.

myShot=snapshot(myCam);
leftImage = myShot(1:480,1:floor(size(myShot,2)/2),:);
rightImage = myShot(1:480,floor(size(myShot,2)/2):size(myShot,2),:);

end

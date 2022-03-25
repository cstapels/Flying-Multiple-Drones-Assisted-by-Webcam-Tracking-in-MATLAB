%get the first two drones that are found and make them into ryze objects
myCopters = ryzelist;
drone1 = ryze(myCopters.IPAddress(1));
drone2 = ryze(myCopters.IPAddress(2));

% Initialize the figures.
threshold = 20;
myCam = webcam(1);
myShot = snapshot(myCam);
t = tiledlayout(1,2);
t.TileSpacing = 'compact';
ax1 = nexttile(t,1);
ax2 = nexttile(t,2);
% Split the first image to give the figure sizes.
myShotLeft = myShot(1:480,1:floor(size(myShot,2)/2),:);
myShotRight = myShot(1:480,floor(size(myShot,2)/2):size(myShot,2),:);
im1 = imshow(myShotLeft,'Parent',ax1);
im2 = imshow(myShotRight,'Parent',ax2);
tx1 = text(ax1,70,-20,"Start 1");
tx2 = text(ax2,70,-20, "Start 2");
picSize=[size(myShot,2),size(myShot,1)];

pause(1); % Get balls ready.

for b = 1:1000
    drawnow
    [leftImage, rightImage] = updateImage(myCam);
    % Device 1
    [myYR,myXR,im1.CData,bwR] = myTrackballC(leftImage,threshold,2);
    [drone1,text1] = updateDrone(drone1,myXR,myYR,picSize);
    %Device 2
    [myYL,myXL,im2.CData,bwL] = myTrackballC(rightImage,threshold,2);
    [drone2,text2] = updateDrone(drone2,myXL,myYL,picSize);
    pause(0.2);
end





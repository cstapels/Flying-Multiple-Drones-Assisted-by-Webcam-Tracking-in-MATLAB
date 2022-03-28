function [device, moves] = updateDrone(device, posX, posY, area)
% Update the drone move commands based on the location of the bal in the image.
% The device, calculated ball location from the image , and the size of the image are provided as imputs
% Moves are used to update the display, and the device is returned since
% the status of the obj3ect is modified by the function.

moveX = 0;
moveY = 0;
moves = '';
if device.State ~= "landed"
    % consider Left and right moves, use distance from center
    distX = posX - area(1) / 4;
    distY = area(2) / 2 - posY;

    if (abs(distX) / area(1)) > (1/16)
        moveX = distX / abs(distX); % Normalize, preserve sign
    end
    if (abs(distY) / area(2)) > (1/4)
        moveY = distY / abs(distY); % Normalize, preserve sign
    end

    if (abs(moveX) > 0) || (abs(moveY) > 0)
        move(device,[0,-moveX,-moveY],'WaitUntilDone',false);
    end
    moves = sprintf("%d X, %d Y ",-moveX,-moveY);
end

if (device.State == "landed")
    if posY < (1/12 * area(2) )
        moves='Take Off!';
        device.takeoff;
    end
end

if (device.State ~= "landed")
    if posY > (11/12 * area(2) )
        disp('land' + string(posY));
        moves = 'land';
        device.land;
    end

end

end

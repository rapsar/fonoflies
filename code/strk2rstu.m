function [rstu] = strk2rstu(strk)
%STRK2RSTU Transform streaks into an array of 
%   distance (r) stereo (s) time (t) duration (u)
%
%   r - distance of first coordinate, in meter
%   s - stereo panning (indicating angle), between -1 and 1
%   t - start time, in frames
%   u - streak duration, in frames
%
%   currently assumes streaks consists of xyzt coordinates; may modify for
%   2d data (using brightness, for instance)
%
% RS, 04/2023
% github.com/rapsar/fonoflies

% initialize
rstu = zeros(strk.nStreaks,4);

% for each streak...
for i=1:length(strk.xyzts)

    xyzt = strk.xyzts{i};

    r = vecnorm(xyzt(1,1:3)); 
    s = cos(atan2(xyzt(1,2),xyzt(1,1))); 
    t = xyzt(1,4); 
    u = xyzt(end,4)-xyzt(1,4)+1;

    rstu(i,:) = [r s t u];

end

% sort by start time, then duration
rstu = sortrows(rstu,[3 4]);


end

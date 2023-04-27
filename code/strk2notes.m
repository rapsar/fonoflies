function [notes] = strk2notes(strk,strFrame,endFrame,frameRate)
%STRK2NOTES Transform streaks into a sequence of notes
%   Truncates array, normalizes times, add random pitches
%
%   inp:    strk cell array
%           start time in frame number
%           end time in frame array
%           frame rate (optional; default: 30fps)
%
%   out:    notes array
%           [distance pan time(s) duration(s) randPitches frameNumber]
%
% RS, 4/2023
% github.com/rapsar/fonoflies

% set frameRate to 30fps if no input
if nargin < 4
    frameRate = 30;
end

% streaks to rstu array
rstu = strk2rstu(strk);

% extract corresponding rows
f = (rstu(:,3) >=strFrame) & (rstu(:,3) <= endFrame);
notes = rstu(f,:);
nn = size(notes,1);

% add random/semirandom notes in col 5
notes(:,5) = pitch(nn);

% keep original frame numbers in col 6
notes(:,6) = notes(:,3); 

% convert absolute to relative time
notes(:,3) = notes(:,3)-notes(1,3)+1;

% converts frame times into seconds
notes(:,3:4) = notes(:,3:4)/frameRate;

% plot histogram for checking
n = histcounts(notes(:,6)-notes(1,6)+1,'BinMethod','integers');
figure, plot(n)

end


function p = pitch(nn)
% sets random pitches to each row
% --customizable--

p = randi([60 80],nn,1);

end

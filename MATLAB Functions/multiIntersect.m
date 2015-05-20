%% intersectedArray = multiIntersect(varargin)
% Intersects multiple arrays
%
% Created by Murty V P S Dinavahi 28/09/2015
%

function intersectedArray = multiIntersect(varargin)
    intersectedArray = intersect(varargin{1},varargin{2});
    for iNum = 3:nargin
        intersectedArray = intersect(intersectedArray,varargin{iNum});
    end
end
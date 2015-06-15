function color_map = buildColormap(markerPositions, markerColors)
% color_map = buildColormap(markerPositions, markerColors)
% 
% Creates a colormap with the specified marker colors at the specified
% marker positions, linearly interpolating RGB values in between.  The
% number of colors in the colormap is determined by the last index in
% markerPositions.
% 
% markerPositions -- This should be a sorted list of integer indexes
%   specifying the location of each marker color.  The last value in this
%   array determines the total number of colors in the colormap.
% markerColors -- This is a Nx3 matrix, where N is equal to the length of
%   markerPositions.  Each specifies the RGB values for the color, where
%   0.0 is the min and 1.0 is the max.
%
% For example, to build a colormap with 101 colors that goes from red to
% black to green:
%   redBlackGreenCmap = buildColormap([1,51,101], [1,0,0; 0,0,0; 0,1,0]);
% And to apply it:
%   colormap(greedBlackRedCmap);

if length(markerPositions) ~= size(markerColors, 1)
	error('the length of markerPositions should be equal to the number of rows in markerColors');
end

color_map = zeros(markerPositions(end), 3);

% colors before first marker
for i = 1:markerPositions(1)
	color_map(i,:) = markerColors(1,:);
end

% colors between markers
for i = 1 : length(markerPositions)-1
	distance = markerPositions(i+1) - markerPositions(i);
	for j = 1 : distance
		color_map(markerPositions(i)+j, :) = ...
			markerColors(i,:) * (1 - j/distance) + ...
			markerColors(i+1,:) * j / distance;
	end
end

end


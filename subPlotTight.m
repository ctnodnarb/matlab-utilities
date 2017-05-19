function h = subPlotTight(m, n, p, subplotSpace, plotSpace)

% h = subPlotTight(m, n, p, subplotSpace, plotSpace)
%
% h = subPlotTight(m, n, p, space) -- This is a shortcut for 
%	subPlotTight(m, n, p, [space, space, 0, 0], [0, 0, space, space]),
%	which creates even spacing between all the subplots and all the edges
%	of the figure.  Note that 'space' must be a scalar.  If a value is
%	still passed for plotSpace, it will be used.
%
% This function is similar to Matlab's subplot() function, but allows you
% to specify the spacing around each subplot and around the figure as a
% whole.  It creates an axes object at the specified location and returns
% its handle.
% 
% Note that the spacing may need to be adjusted to make room for labels,
% titles, etc, depending on the size of the figure and number of subplots.
%
% Parameters:
%	m -- The number of rows of subplots.
%	n -- The number of columns of subplots.
%	p -- The index of the plot to create, starting with the top left
%		subplot at index 1 and numbering them as you move to the right, and
%		then down to the next row.
%	subplotSpace -- The amount of space (in normalized units) to place
%		around each subplot.  The format is [left, bottom, right, top].  
%		Defaults to [0.05, 0.05, 0.00, 0.00].  If an empty value like [] is
%		passed in, the default values will be used.
%	plotSpace -- The amount of space (in normalized units) to place around
%		the outside of the figure.  The format is [left, bottom, right,
%		top].  Defaults to [0.00, 0.00, 0.05, 0.05].  If an empty value 
%		like [] is passed in, the default values will be used.
	
	subplotM = m - floor((p-1)/n);
	subplotN = mod((p-1), n) + 1;
	
	if ~exist('subplotSpace', 'var') || isempty(subplotSpace)
		subplotSpace = [0.05, 0.05, 0.00, 0.00];
	elseif numel(subplotSpace) == 1
		space = subplotSpace;
		subplotSpace = [space, space, 0, 0];
		if ~exist('plotSpace', 'var') || isempty(plotSpace)
			plotSpace = [0, 0, space, space];
		end
	end
	if ~exist('plotSpace', 'var') || isempty(plotSpace)
		plotSpace = [0, 0, 0.05, 0.05];
	end
	
	plotLeft = plotSpace(1);
	plotBottom = plotSpace(2);
	plotRight = 1 - plotSpace(3);
	plotTop = 1 - plotSpace(4);
	
	subplotWidth = (plotRight - plotLeft - n*(subplotSpace(1) + subplotSpace(3))) / n;
	subplotHeight = (plotTop - plotBottom - m*(subplotSpace(2) + subplotSpace(4))) / m;
	
	h = axes('Position', [ ...
		plotLeft + subplotSpace(1) * subplotN + (subplotWidth + subplotSpace(3)) * (subplotN-1), ...
		plotBottom + subplotSpace(2) * subplotM + (subplotHeight + subplotSpace(4)) * (subplotM-1), ...
		subplotWidth, ...
		subplotHeight]);
	
end
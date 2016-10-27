
function useLatex(fontSize, fontName, useLatex)
% useLatex(axesFontSize, textFontSize)
%
% Sets defaults for all axes, text, and legend objects to use the LaTeX
% interpreter.
%
% Parameters:
%   fontSize (OPTIONAL) - If specified, sets the default font size.  To
%		remove a previously set default font size, pass 'remove'.
%   fontName (OPTIONAL) - If specified, sets the default font name.  To
%		remove a previously set default font name, pass 'remove'.
%	useLatex (OPTIONAL, default true) - If true, sets the default
%		interpreter for figures (text objects, axes tick label objects, and
%		legend objects) to 'latex'.  If false, removes those settings.

if ~exist('useLatex', 'var') && ~isempty(useLatex)
	useLatex = true;
end

if exist('fontSize', 'var') && ~isempty(fontSize)
	set(groot, 'defaultAxesFontSize', fontSize);
	set(groot, 'defaultTextFontSize', fontSize);
	set(groot, 'defaultLegendFontSize', fontSize);
end

if exist('fontName', 'var') && ~isempty(fontName)
	set(groot, 'defaultAxesFontName', fontName);
	set(groot, 'defaultTextFontName', fontName);
	set(groot, 'defaultLegendFontName', fontName);
end

if useLatex
	set(groot, 'defaultTextInterpreter', 'latex');
	set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
	set(groot, 'defaultLegendInterpreter', 'latex');
else
	set(groot, 'defaultTextInterpreter', 'remove');
	set(groot, 'defaultAxesTickLabelInterpreter', 'remove');
	set(groot, 'defaultLegendInterpreter', 'remove');
end


end

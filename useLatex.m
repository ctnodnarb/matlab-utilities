
function useLatex(fontSize, fontName)
% useLatex(axesFontSize, textFontSize)
%
% Sets defaults for all axes, text, and legend objects to use the LaTeX
% interpreter.
%
% Parameters:
%   fontSize (OPTIONAL) - If specified, sets the default font size.
%   fontName (OPTIONAL) - If specified, sets the default font name.

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

set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');


end

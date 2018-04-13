function printVectorSvg(fileName, figureSize, units, extraSpace, figHandle)
	% printVectorSvg(fileName, figureSize, units, extraSpace, figHandle)
	%
	% Outputs a svg of the figure where all the extra whitespace has been
	% cropped out.  The paper size in the svg will match the size of the
	% figure as well.  Note that having a suptitle in the figure seems to
	% mess up the part of this function that sets tight margins.
	%	fileName - The name of the pdf file to create, e.g. 'fig.svg'
	%	figureSize - The size of the figure, e.g. [6.5 4]
	%	units - The units used for figureSize, e.g. 'inches'
	%	extraSpace - Optional parameter.  The amount of extra space (in
	%		normalized units) to put on the left, bottom, right, and top
	%		sides of the graph.  Use this if something is getting cut off.
	%		The format is [leftSpace, bottomSpace, rightSpace, topSpace].
	%		So, [.1, .1, .1, .1] would put 10% extra space on all sides.
	%		If [] is passed in, the default [0 0 0 0] will be used.
	%	figHandle - Optional parameter.  The handle to the figure to output
	%		to a pdf.  If omitted, gcf will be used.
	
	if(nargin < 4 || isempty(extraSpace))
		extraSpace = [0 0 0 0];
	end	
	if(nargin < 5)
		figHandle = gcf;
	end
	
	% Store the old state so it can be restored
	axisHandle = get(figHandle, 'CurrentAxes');
	oldLooseInset = get(axisHandle, 'LooseInset');
	oldPaperUnits = get(figHandle, 'PaperUnits');
	oldPaperSize = get(figHandle, 'PaperSize');
	oldPaperPositionMode = get(figHandle, 'PaperPositionMode');
	oldPaperPosition = get(figHandle, 'PaperPosition');
	oldRenderer = get(figHandle, 'renderer');
	
	% Modify any patches in the figure so that they will render correctly.
	% The painters renderer does not support RGB color coded patches, so we
	% need to change them to use a color map so that they render correctly.
	% This section of code is based on Robbie Andrew's rgb2cm function.
	patches = findall(figHandle,'Type','patch');
	if(~isempty(patches))
		numPatches = numel(patches);
		cMap = colormap;
		oldCMap = cMap;
		
		% Freeze the color axis limits (CLim) so that we don't mess up the
		% coloring of patches that used the 'scaled' CDataMapping
		oldCLimMode = get(axisHandle, 'CLimMode');
		set(axisHandle, 'CLimMode', 'manual');
		
		j = size(cMap, 1) + 1;
		oldFaceVertexCData = cell(1, numPatches);
		oldCDataMapping = cell(1, numPatches);
		for i = 1:numPatches
			c = get(patches(i), 'FaceVertexCData');
			
			% FaceVertexCData will be #faces X 3 if using RGB colors
			if(size(c,2) == 3)
				oldFaceVertexCData{i} = c;
				oldCDataMapping{i} = get(patches(i), 'CDataMapping');
				cMap = [cMap; c];
				n = size(c,1);
				set(patches(i), 'CDataMapping', 'direct')
				set(patches(i), 'FaceVertexCData', j+(0:n-1)');
				j = j+n;
			end
			
% 			cDataMapping = get(patches(i), 'CDataMapping');
% 			if strcmpi('direct', cDataMapping)
			
		end
		colormap(cMap)
	end
	
	
	
	% Eliminate extra whitespace in the figure
	set(axisHandle, 'LooseInset', get(axisHandle, 'TightInset') + extraSpace);

	% Set up the paper size / position
	set(figHandle, 'PaperUnits', units);
	set(figHandle, 'PaperSize', figureSize);    % Set to final desired size here as well as 2 lines below
	set(figHandle, 'PaperPositionMode', 'manual');
	set(figHandle, 'PaperPosition', [0 0 figureSize]);

	% To guarantee vector graphics output (doesn't support transparency though)
	set(figHandle, 'renderer', 'painters');

	% Output the figure
	print(figHandle, '-dsvg', fileName);
	
	% Restore patches to their previous color configuration
	if(~isempty(patches))
		colormap(oldCMap);
		set(axisHandle, 'CLimMode', oldCLimMode);
		for i = 1:numPatches
			if(~isempty(oldFaceVertexCData{i}))
				set(patches(i), 'CDataMapping', oldCDataMapping{i});
				set(patches(i), 'FaceVertexCData', oldFaceVertexCData{i});
			end
		end
	end
	
	% Restore previous state
	set(axisHandle, 'LooseInset', oldLooseInset);
	set(figHandle, 'PaperUnits', oldPaperUnits);
	set(figHandle, 'PaperSize', oldPaperSize);
	set(figHandle, 'PaperPositionMode', oldPaperPositionMode);
	set(figHandle, 'PaperPosition', oldPaperPosition);
	set(figHandle, 'renderer', oldRenderer);
end
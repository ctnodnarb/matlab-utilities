# matlab-utilities

Utility functions I have found useful in Matlab.  Includes functions to export figures to pdf / png (handy for inclusion in LaTeX documents), clear the workspace without clearing breakpoints, walking a directory and its subdirectories to find all the files that match a glob (i.e. `*.txt`), and constructing custom colormaps.


## buildColormap.m

`color_map = buildColormap(markerPositions, markerColors)`

Constructs a Matlab colormap given a list of control point indices and colors, linearly interpolating RGB values between control points.

* `markerPositions` A list of integer indices (in ascending order) specifying the locations of the control points.
* `markerColors` An Nx3 matrix of RGB colors specifying the color at each control point, where N is equal to the length of `markerPositions`.
* `returns` An Mx3 matrix of RGB colors, where M is equal to `markerPositions(end)` (the largest index given).

Example:

```matlab
% Construct a colormap with 101 colors going from red to black to green
cm = buildColormap([1 51 101], [1 0 0; 0 0 0; 0 1 0]);
% Apply the colormap to a random figure
x = 2 * rand(10) - 1;
imagesc(x);
colormap(cm);
```


## clearAll.m

Running this script is equivalent to running `close all` and `clear all`, except that it preserves any breakpoints that have been set.  This is useful if you want to clear everything out at the beginning of a program, but also want to be able to set breakpoints to debug that program.

Usage:

```matlab
clearAll;
```


## getGitInfo.m

`[commitHash, commitMsg] = getGitInfo()`

Returns the commit hash, first line of the commit message, and git status string for the HEAD commit of the current Git repository.


## printRasterPdf.m

`printRasterPdf(fileName, figureSize, units, dpi, extraSpace, figHandle)`

Exports the current (or specified) figure to a pdf file as a rasterized image.  It attempts to crop off all the extra whitespace surrouding the figure so that it is easier to include in other documents.

* `fileName` The name / path of the file to export the figure to (it should end in .pdf).
* `figureSize` The size of the figure, formatted as `[width, height]`.
* `units` The units of the figure size, e.g. `'inches'` or `'in'`.  Any unit that Matlab recognizes will work.
* `dpi` (Optional, default 300)  The resolution of the output in dots per inch.  The default value
  will also be used if `[]` or `0` are passed in.
* `extraSpace` (Optional, default `[0,0,0,0]`)  The amount of extra space (in normalized units) to 
  include on the left, bottom, right, and top of the image.  This can be used to fix the output if 
  something is getting cut off on one of the edges of the image.  For example, passing 
  `[.1, .1, .1, .1]` would include 10% extra space on all sides of the plot.  If `[]` is passed in, 
  the default value will be used.
* `figHandle` (Optional, defaults to the current figure).  The handle of the figure to export.  

Example: 

```matlab
% Construct a random plot
imagesc(rand(10));
% Export to a rasterized pdf file
printRasterPdf('example.pdf', [4,3], 'in');
```


## printRasterPng.m

`printRasterPng(fileName, figureSize, units, dpi, extraSpace, figHandle)`

Exports the current (or specified) figure as a png image file.  It attempts to crop off all the extra whitespace surrouding the figure so that it is easier to include in other documents.

* `fileName` The name / path of the file to export the figure to (it should end in .pdf).
* `figureSize` The size of the figure, formatted as `[width, height]`.
* `units` The units of the figure size, e.g. `'inches'` or `'in'`.  Any unit that Matlab recognizes will work.
* `dpi` (Optional, default 300).  The resolution of the output in dots per inch.  The default value will also be used if `[]` or `0` are passed in.
* `extraSpace` (Optional, default `[0,0,0,0]`).  The amount of extra space (in normalized units) to include on the left, bottom, right, and top of the image.  This can be used to fix the output if something is getting cut off on one of the edges of the image.  For example, passing `[.1, .1, .1, .1]` would include 10% extra space on all sides of the plot.  If `[]` is passed in, the default value will be used.
* `figHandle` (Optional, defaults to the current figure).  The handle of the figure to export.

Example:

```matlab
% Construct a random plot
imagesc(rand(10));
% Export to a rasterized pdf file
printRasterPng('example.pdf', [4,3], 'in');
```


## printVectorPdf.m

`printVectorPdf(fileName, figureSize, units, extraSpace, figHandle)`

Exports the current (or specified) figure to a pdf file using vector graphics.  It attempts to crop off all the extra whitespace surrouding the figure so that it is easier to include in other documents.  In some cases, vector graphics do not render correctly (e.g. intersecting 3d patches), in which case `printRasterPdf` can be used instead.

* `fileName` The name / path of the file to export the figure to (it should end in .pdf).
* `figureSize` The size of the figure, formatted as `[width, height]`.
* `units` The units of the figure size, e.g. `'inches'` or `'in'`.  Any unit that Matlab recognizes will work.
* `extraSpace` (Optional, default `[0,0,0,0]`) The amount of extra space (in normalized units) to include on the left, bottom, right, and top of the image.  This can be used to fix the output if something is getting cut off on one of the edges of the image.  For example, passing `[.1, .1, .1, .1]` would include 10% extra space on all sides of the plot.  If `[]` is passed in, the default value will be used.
* `figHandle` (Optional, defaults to the current figure) The handle of the figure to export.

Example:

```matlab
% Construct a random plot
imagesc(rand(10));
% Export to a rasterized pdf file
printVectorPdf('example.pdf', [4,3], 'in');
```


## subPlotTight.m

`h = subPlotTight(m, n, p, subplotSpace, plotSpace)`

This function is similar to Matlab's subplot() function, but allows you to specify the spacing around each subplot and around the figure as a whole.  It creates an axes object at the specified location (index into the grid of subplots) and returns its handle.

Note that the spacing may need to be adjusted to make room for labels, titles, etc, depending on the size of the figure and number of subplots.

* `m` The number of rows of subplots.
* `n` The number of columns of subplots.
* `p` The index of the plot to create, starting with the top left subplot at index 1 and numbering 
  them as you move to the right, and then down to the next row.
* `subplotSpace` The amount of space (in normalized units) to place around each subplot.  The format 
  is [left, bottom, right, top].  Defaults to [0.05, 0.05, 0.00, 0.00].  If an empty value like [] is 
  passed in, the default values will be used.
% `plotSpace` The amount of space (in normalized units) to place around the outside of the figure.  
  The format is [left, bottom, right, top].  Defaults to [0, 0, 0.05, 0.05].  If an empty value like 
  [] is passed in, the default values will be used.


## useLatex.m

`useLatex(fontSize, fontName, useLatex)`

Sets defaults in `groot` (Matlab's root graphical object) so that all text, ticklabel, and legend
objects will use the LaTeX interpreter.  If a font size and/or font name are specified, defaults are
set for those as well.

* `fontSize` (Optional) If specified, sets the default font size for axes, text, and legend objects.
  To remove a previously set value, set this to `'remove'`.
* `fontName` (Optional) If specified, sets the default font name for axes, text, and legend objects.
  To remove a previously set value, set this to `'remove'`.
* `useLatex` (Optional, default `True`) If true, sets the default interpreter for axes, ticklabel, and
  legend objects to `'latex'`.  If false, removes those settings.


## walkDirectory.m

`entries = walkDirectory(directory, pattern, type)`

Returns a cell array containing the paths to every file in the specified directory and its subdirectories that matches the specified pattern (glob or regexp).

* `directory` The path to the directory to search through.
* `pattern` The pattern specifying which files to find.  Can be a glob (for example, `*.txt` to find all text files) or a regexp, as specified by the type parameter.
* `type` (Optional, default `'glob'`) The type of pattern to use when doing the match.  Can be `'glob'`, `'regexp'`, or `'regexpi'` (case-insensitive regular expression).
* `returns` An Nx1 cell array of strings specifying the paths to each file, where N is the number of files found.

Example:

```matlab
% Find all .m files in the current directory
matlabFiles = walkDirectory('.', '*.m');
```


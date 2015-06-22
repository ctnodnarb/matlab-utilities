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


## printRasterPdf.m

`printRasterPdf(fileName, figureSize, units, dpi, extraSpace, figHandle)`

Exports the current (or specified) figure to a pdf file as a rasterized image.  It attempts to crop off all the extra whitespace surrouding the figure so that it is easier to include in other documents.

* `fileName` The name / path of the file to export the figure to (it should end in .pdf).
* `figureSize` The size of the figure, formatted as `[width, height]`.
* `units` The units of the figure size, e.g. `'inches'` or `'in'`.  Any unit that Matlab recognizes will work.
* `dpi` Optional parameter (defaults to 300).  The resolution of the output in dots per inch.  The default value will also be used if `[]` or `0` are passed in.
* `extraSpace` Optional parameter (defaults to `[0,0,0,0]`).  The amount of extra space (in normalized units) to include on the left, bottom, right, and top of the image.  This can be used to fix the output if something is getting cut off on one of the edges of the image.  For example, passing `[.1, .1, .1, .1]` would include 10% extra space on all sides of the plot.  If `[]` is passed in, the default value will be used.
* `figHandle` Optional parameter (defaults to the current figure).  The handle of the figure to export.

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
* `dpi` Optional parameter (defaults to 300).  The resolution of the output in dots per inch.  The default value will also be used if `[]` or `0` are passed in.
* `extraSpace` Optional parameter (defaults to `[0,0,0,0]`).  The amount of extra space (in normalized units) to include on the left, bottom, right, and top of the image.  This can be used to fix the output if something is getting cut off on one of the edges of the image.  For example, passing `[.1, .1, .1, .1]` would include 10% extra space on all sides of the plot.  If `[]` is passed in, the default value will be used.
* `figHandle` Optional parameter (defaults to the current figure).  The handle of the figure to export.

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
* `extraSpace` Optional parameter (defaults to `[0,0,0,0]`).  The amount of extra space (in normalized units) to include on the left, bottom, right, and top of the image.  This can be used to fix the output if something is getting cut off on one of the edges of the image.  For example, passing `[.1, .1, .1, .1]` would include 10% extra space on all sides of the plot.  If `[]` is passed in, the default value will be used.
* `figHandle` Optional parameter (defaults to the current figure).  The handle of the figure to export.

Example:

```matlab
% Construct a random plot
imagesc(rand(10));
% Export to a rasterized pdf file
printVectorPdf('example.pdf', [4,3], 'in');
```


## walkDirectory.m

`entries = walkDirectory(directory, pattern)`

Returns a cell array containing the paths to every file in the specified directory and its subdirectories that matches the specified pattern (glob).

* `directory` The path to the directory to search through.
* `pattern` A file glob pattern specifying which files to find.  For example, `*.txt` to find all text files.
* `returns` A 1xN cell array of strings specifying the paths to each file, where N is the number of files found.

Example:

```matlab
% Find all .m files in the current directory
matlabFiles = walkDirectory('.', '*.m');
```


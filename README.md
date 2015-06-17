# matlab-utilities

Utility functions I have found useful in Matlab.  Includes functions to export figures to pdf / png (handy for inclusion in LaTeX documents), clear the workspace without clearing breakpoints, walking a directory and its subdirectories to find all the files that match a glob (i.e. `*.txt`), and constructing custom colormaps.


## buildColormap.m

`color_map = buildColormap(markerPositions, markerColors);`

Constructs a Matlab colormap given a list of control point indices and colors, linearly interpolating RGB values between control points.

* `markerPositions` -- A list of integer indices (in ascending order) specifying the locations of the control points.
* `markerColors` -- An Nx3 matrix of RGB colors specifying the color at each control point, where N is equal to the length of `markerPositions`.
* `Returns` -- An Mx3 matrix of RGB colors, where M is equal to `markerPositions(end)` (the largest index given).

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

todo


## printRasterPdf.m

todo


## printRasterPng.m

todo


## printVectorPdf.m

todo


## walkDirectory.m

todo

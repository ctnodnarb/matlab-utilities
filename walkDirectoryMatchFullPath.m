function entries = walkDirectoryMatchFullPath(directory, regexPattern, caseSensitive)
% entries = walkDirectory(directory, pattern, type)
%
% Walks through the folder structure of a directory and returns the
% paths to all the files that match the given pattern.  The return
% value is a cell array containing strings.
%
% For example, to return the paths to all the txt files in the current
% directory and its subdirectories:
%	walk('.', '*.txt')
%
% Parameters:
%	directory - The path to the directory to walk through.
%	pattern - The pattern to match.
%	caseSensitive - Optional, default true.  Whether or not the regex 
%		should be case sensitive.

if nargin < 3
	caseSensitive = true;
end

% Get a list containing the folder and all its subfolders.
if regexp(computer, '^GLNX.*')
	% Linux separates paths with colons
	directoriesToSearch = strsplit(genpath(directory), ':');
else
	% Windows separates paths with semicolons
	directoriesToSearch = strsplit(genpath(directory), ';');
end

% directories_to_search should now be a cell array containing a list of
% the specified directory and ALL of its subdirectories, with the final
% element being an empty string.  Loop through all those directories
% (excluding the final exmpty string at the end) and gather all the file
% names that match the pattern.
entries = [];
for i = 1:length(directoriesToSearch)-1
	folder = directoriesToSearch{i};
	dirEntries = dir(folder);
	fileNames = {dirEntries.name};
	fullPaths = arrayfun(@fullfile, ...
		repmat({folder}, numel(fileNames), 1), ...
		fileNames');
	if caseSensitive
		matches = ~cellfun(@isempty, regexpi(fullPaths, regexPattern));
	else
		matches = ~cellfun(@isempty, regexp(fullPaths, regexPattern));
	end
	entries = [entries; ...
		fullPaths(matches)];
end

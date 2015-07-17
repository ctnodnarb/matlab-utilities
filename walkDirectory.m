function entries = walkDirectory(directory, pattern, type)
% entries = walkDirectory(directory, pattern)
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
%	type - Optional.  Can be 'glob' (default), 'regexp', or 'regexpi'.  
%		Specifies the type of pattern to match.  Note that this only 
%		matches against the name of the file within the subdirectory, not 
%		the full path of the subdirectory going to the file.

if nargin < 3 || strcmpi(type, 'glob')
	useRegex = false;
elseif strcmpi(type, 'regexp')
	useRegex = true;
	caseInsensitive = false;
elseif strcmpi(type, 'regexpi')
	useRegex = true;
	caseInsensitive = true;
else
	error('Unrecognized pattern type.  Should be "glob", or "regexp", or "regexpi".');
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
	if useRegex
		dirEntries = dir(folder);
		fileNames = {dirEntries.name};
		if caseInsensitive
			matches = ~cellfun(@isempty, regexpi(fileNames, pattern));
		else
			matches = ~cellfun(@isempty, regexp(fileNames, pattern));
		end
		entries = [entries; ...
			arrayfun(@fullfile, ...
			repmat({folder}, sum(matches), 1), ...
			fileNames(matches)')];
	else % Use glob
		dirEntries = dir(fullfile(folder, pattern));
		if ~isempty(dirEntries)
			entries = [entries; ...
				arrayfun(@fullfile, ...
				repmat({folder}, length(dirEntries), 1), ...
				{dirEntries.name}')];
		end
	end
end

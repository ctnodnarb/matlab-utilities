function entries = walkDirectory(directory, pattern)
% entries = walkDirectory(directory, pattern)
%
% Walks through the folder structure of a directory and returns the
% paths to all the files that match the given pattern.  The return
% value is a cell array containing strings.
%
% For example, to return the paths to all the txt files in the current
% directory and its subdirectories:
%	walk('.', '*.txt')

% Get a list containing the folder and all its subfolders.
if regexp(computer, '^GLNX.*')
	% Linux separates paths with colons
	directories_to_search = strsplit(genpath(directory), ':');
else
	% Windows separates paths with semicolons
	directories_to_search = strsplit(genpath(directory), ';');
end

% directories_to_search should now be a cell array containing a list of
% the specified directory and ALL of its subdirectories, with the final
% element being an empty string.  Loop through all those directories
% (excluding the final exmpty string at the end) and gather all the file
% names that match the pattern.
entries = [];
for i = 1:length(directories_to_search)-1
	folder = directories_to_search{i};
	dir_entries = dir(fullfile(folder, pattern));
	if ~isempty(dir_entries)
		entries = [entries; arrayfun(@fullfile, ...
				repmat({folder}, length(dir_entries), 1), ...
				{dir_entries.name}')];
	end
end

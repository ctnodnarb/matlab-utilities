
function makeFolderPath(folderPath)
% makeFolderPath(folderPath)
%
% Creates the folder(s) specified by folderPath if they don't already
% exist.

	% Handle Linux or Windows style file separators
	folderPath = strrep(folderPath, '/', '\');
	
	tokens = strsplit(folderPath, '\');
	for i = 1:numel(tokens)
		partialPath = fullfile(tokens{1:i});
		if ~exist(partialPath, 'dir')
			mkdir(partialPath);
		end
	end
	
end
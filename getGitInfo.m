function [commitHash, commitMsg, gitStatus, varargout] = getGitInfo(includeDiffs)
% [commitHash, commitMsg, gitStatus] = getGitInfo()
% [commitHash, commitMsg, gitStatus, diffs] = getGitInfo(true)
%
% For the HEAD commit in the current Git repository, this function returns
% the hash, the first line of the commit message, and the string generated
% by running 'git status'.  If the current folder is not part of a Git
% repository, it returns 'Not a Git repository' for the hash and empty
% strings for the message and status.
%
% If you pass true in for the includeDiffs parameter, then the fourth
% output argument (diffs) will be a cell array containing the git diff 
% string for each modified file.
	
	[commandReturnValue, gitInfoString] = system( ...
		'git rev-list --format=%s --max-count=1 HEAD');
	if commandReturnValue ~= 0
		commitHash = 'Not a Git repository';
		commitMsg = '';
		gitStatus = '';
		return;
	end
	
	gitInfoLines = strsplit(gitInfoString, '\n');
	commitHash = gitInfoLines{1}(8:end);
	commitMsg = gitInfoLines{2};
	[~, gitStatus] = system('git status');
	
	if exist('includeDiffs', 'var') && includeDiffs
		
		[~, rootFolder] = system('git rev-parse --show-toplevel');
		rootFolder = strtrim(rootFolder);
		
		[~, outputString] = system('git diff --name-only');
		modifiedFiles = strsplit(strtrim(outputString));
		
		nModifiedFiles = numel(modifiedFiles);
		diffs = cell(nModifiedFiles, 2);
		for idx = 1 : nModifiedFiles
			[~, outputString] = system(['git diff ' fullfile(rootFolder,modifiedFiles{idx})]);
			diffs{idx} = outputString;
		end
		
		varargout{1} = diffs;
	end
end

function [commitHash, commitMsg, gitStatus, varargout] = getGitInfo()
% [commitHash, commitMsg, gitStatus] = getGitInfo()
% [commitHash, commitMsg, gitStatus, diffs] = getGitInfo()
%
% For the HEAD commit in the current Git repository, this function returns
% the hash, the first line of the commit message, and the string generated
% by running 'git status'.  If the current folder is not part of a Git
% repository, it returns 'Not a Git repository' for the hash and empty
% strings for the message and status.
%
% If you include a fourth output argument (diffs), then it will be a cell 
% array containing the git diff string for each modified file.
	
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
	
	if nargout > 3
		
		[~, rootFolder] = system('git rev-parse --show-toplevel');
		rootFolder = strtrim(rootFolder);
		
		[~, outputString] = system('git diff --name-only');
		if isempty(outputString)
			modifiedFiles = {};
		else
			modifiedFiles = strsplit(strtrim(outputString));
		end
		
		nModifiedFiles = numel(modifiedFiles);
		diffs = cell(nModifiedFiles, 1);
		for idx = 1 : nModifiedFiles
			[~, outputString] = system(['git diff ' fullfile(rootFolder,modifiedFiles{idx})]);
			diffs{idx} = outputString;
		end
		
		varargout{1} = diffs;
	end
end

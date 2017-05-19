function [commitHash, commitMsg, gitStatus] = getGitInfo()
% [commitHash, commitMsg] = getGitInfo()
%
% For the HEAD commit in the current Git repository, this function returns
% the hash, the first line of the commit message, and the string generated
% by running 'git status'.  If the current folder is not part of a Git
% repository, it returns 'Not a Git repository' for the hash and empty
% strings for the message and status.
	
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
end

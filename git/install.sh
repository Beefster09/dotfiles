#!/usr/bin/env bash

# Don't ask ssh password all the time
if [ "$(uname -s)" = "Darwin" ]; then
	git config --global credential.helper osxkeychain
else
	git config --global credential.helper cache
fi

# better diffs
if command -v diff-so-fancy >/dev/null 2>&1; then
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
fi

# use sublime-merge as mergetool
if command -v code >/dev/null 2>&1; then
	git config --global merge.tool sublime-merge
	git config --global mergetool.sublime-merge.cmd "/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge $MERGED"
fi

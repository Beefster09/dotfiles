#!/bin/zsh
GOPATH="$(go env GOPATH)"
if [[ "$PATH" != *$GOPATH/bin* ]]; then
	export PATH="$GOPATH/bin:$PATH"
fi

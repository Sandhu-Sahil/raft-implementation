#!/bin/bash
set -ex

if ! command -v go &> /dev/null; then
    sudo apt-get update
    sudo apt-get install golang-go
fi

go vet ./...
staticcheck ./...

logfile=/tmp/raftlog

go clean -testcache

go test -v -race -run . ./testing |& tee ${logfile}

# go run ../tools/raft-testlog-viz/main.go < ${logfile}
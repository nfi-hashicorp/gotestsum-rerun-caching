#!/bin/bash
set -ex

export GOCACHE=$(mktemp -d)
trap 'rm -rf "$GOCACHE"' EXIT

: "expect this to rerun TestPassesRarely a few times, then pass"
gotestsum --rerun-fails=10 --format=testname --packages="." --debug 

: "expect this to fail"
! go test -json github.com/nfi-hashicorp/gotestsum-rerun-caching || exit 1

: "expect this to pass because it has a cached positive result for these flags, from the rerun"
go test -json -test.run=^TestPassesRarely$ github.com/nfi-hashicorp/gotestsum-rerun-caching

: "expect this to fail even though it is functionally equivalent"
! go test -json -test.run=^[T]estPassesRarely$ github.com/nfi-hashicorp/gotestsum-rerun-caching || exit 1
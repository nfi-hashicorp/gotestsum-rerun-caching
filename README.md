# gotestsum-rerun-caching

Demonstrates the somewhat surprising behavior that a test result of a package passing all of its tests, but requiring `gotestsum` reruns, does not get cached.

```bash
% export GOCACHE=$(mktemp -d); gotestsum --rerun-fails=10 --format=testname --packages="./..."  -- . ; go test -v . ; rm -rf "$GOCACHE"
PASS TestAlwaysPasses (0.00s)
=== RUN   TestPassesRarely
--- FAIL: TestPassesRarely (0.00s)
FAIL TestPassesRarely (0.00s)
FAIL .

DONE 2 tests, 1 failure in 3.025s

=== RUN   TestPassesRarely
--- FAIL: TestPassesRarely (0.00s)
FAIL TestPassesRarely (re-run 1) (0.00s)
FAIL .

DONE 2 runs, 3 tests, 2 failures in 3.306s

=== RUN   TestPassesRarely
--- FAIL: TestPassesRarely (0.00s)
FAIL TestPassesRarely (re-run 2) (0.00s)
FAIL .

DONE 3 runs, 4 tests, 3 failures in 3.573s

=== RUN   TestPassesRarely
--- FAIL: TestPassesRarely (0.00s)
FAIL TestPassesRarely (re-run 3) (0.00s)
FAIL .

DONE 4 runs, 5 tests, 4 failures in 3.858s

=== RUN   TestPassesRarely
--- FAIL: TestPassesRarely (0.00s)
FAIL TestPassesRarely (re-run 4) (0.00s)
FAIL .

DONE 5 runs, 6 tests, 5 failures in 4.124s

=== RUN   TestPassesRarely
--- FAIL: TestPassesRarely (0.00s)
FAIL TestPassesRarely (re-run 5) (0.00s)
FAIL .

DONE 6 runs, 7 tests, 6 failures in 4.407s

=== RUN   TestPassesRarely
--- FAIL: TestPassesRarely (0.00s)
FAIL TestPassesRarely (re-run 6) (0.00s)
FAIL .

DONE 7 runs, 8 tests, 7 failures in 4.686s

=== RUN   TestPassesRarely
--- FAIL: TestPassesRarely (0.00s)
FAIL TestPassesRarely (re-run 7) (0.00s)
FAIL .

DONE 8 runs, 9 tests, 8 failures in 4.989s

PASS TestPassesRarely (re-run 8) (0.00s)
PASS .

=== Failed
=== FAIL: . TestPassesRarely (0.00s)

=== FAIL: . TestPassesRarely (re-run 1) (0.00s)

=== FAIL: . TestPassesRarely (re-run 2) (0.00s)

=== FAIL: . TestPassesRarely (re-run 3) (0.00s)

=== FAIL: . TestPassesRarely (re-run 4) (0.00s)

=== FAIL: . TestPassesRarely (re-run 5) (0.00s)

=== FAIL: . TestPassesRarely (re-run 6) (0.00s)

=== FAIL: . TestPassesRarely (re-run 7) (0.00s)

DONE 9 runs, 10 tests, 8 failures in 5.269s
=== RUN   TestAlwaysPasses
--- PASS: TestAlwaysPasses (0.00s)
=== RUN   TestPassesRarely
--- FAIL: TestPassesRarely (0.00s)
FAIL
FAIL    github.com/nfi-hashicorp/gotestsum-rerun-caching        0.116s
FAIL
```
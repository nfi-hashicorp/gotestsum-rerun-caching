# gotestsum-rerun-caching

Demonstrates the somewhat surprising behavior that a test result of a package passing all of its tests, but requiring `gotestsum` reruns, does not get cached.

```bash
 % ./repro.sh 
...
+ : 'expect this to rerun TestPassesRarely a few times, then pass'
+ gotestsum --rerun-fails=10 --format=testname --packages=. --debug
exec: [go test -json .]
go test pid: 5928
PASS TestAlwaysPasses (0.00s)
=== RUN   TestPassesRarely
--- FAIL: TestPassesRarely (0.00s)
FAIL TestPassesRarely (0.00s)
FAIL .

DONE 2 tests, 1 failure in 2.502s

...

exec: [go test -json -test.run=^TestPassesRarely$ github.com/nfi-hashicorp/gotestsum-rerun-caching]
go test pid: 6176
PASS TestPassesRarely (re-run 2) (0.00s)
PASS .

=== Failed
=== FAIL: . TestPassesRarely (0.00s)

=== FAIL: . TestPassesRarely (re-run 1) (0.00s)

DONE 3 runs, 4 tests, 2 failures in 3.057s
+ : 'expect this to fail'
+ go test -json github.com/nfi-hashicorp/gotestsum-rerun-caching
...
{..."Output":"FAIL\tgithub.com/nfi-hashicorp/gotestsum-rerun-caching\t0.114s\n"}
{..."Action":"fail","Elapsed":0.115}
+ : 'expect this to pass because it has a cached positive result for these flags, from the rerun'
+ go test -json '-test.run=^TestPassesRarely$' github.com/nfi-hashicorp/gotestsum-rerun-caching
...
{..."Output":"ok  \tgithub.com/nfi-hashicorp/gotestsum-rerun-caching\t(cached)\n"}
{..."Action":"pass",...,"Elapsed":0}
+ : 'expect this to fail even though it is functionally equivalent'
+ go test -json '-test.run=^[T]estPassesRarely$' github.com/nfi-hashicorp/gotestsum-rerun-caching
...
{..."Output":"FAIL\tgithub.com/nfi-hashicorp/gotestsum-rerun-caching\t0.113s\n"}
{..."Action":"fail","Elapsed":0.113}
...
```

# QuantumRedlock

Run Redis and make sure that REDIS_HOST and REDIS_PORT are set.

Run one or more nodes:

```
%> iex --name one@127.0.0.1 -S mix
%> iex --name two@127.0.0.1 -S mix
...
```

Two jobs are set to run every minute.
The first job is set to run on multiple nodes. You'll see output for each running node.
The second job is set to run only on one node. You'll see output on one node and the others will have a debug statement saying they couldn't get a lock.

**Annoying Bits**

Because we wrap a job in a behaviour, we have to pass in all arguments to the function as an array.
This is because of the way Quantum works where it calls the given function with the arity of the number of elements in the args argument.

```
{QuantumRedlock.Jobs.Foo, :run_once, [...]}
                                       ↑
                                      args
```

We always have an arity of one.
If you want more arguments, you have to pass in a list.
If your job doesn't need any parameters, you still have to pass in some kind of argument.
E.g., `[nil]` or `[[]]`.

**Risks**

Nodes appear to be greedy.
If a job is set to run every minute and you have three nodes, the same node will almost always run that job.
This is probably due to timing conditions holding across runs.
I.e., if node X gets the lock on run Y because its clock is faster, it will most likely get the lock on run Z.

One way to mitigate this would be distribute jobs across nodes.
But, that would entail running distributed Elixir; if we are going to do that, we would be better off using a real job runner.

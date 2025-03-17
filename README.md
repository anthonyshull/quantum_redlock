# QuantumRedlock

Run Redis and make sure that REDIS_HOST and REDIS_PORT are set.

Run one or more nodes:

```
%> iex --name one@127.0.0.1 -S mix
%> iex --name two@127.0.0.1 -S mix
...
```

Three jobs are set to run every minute.
The first job is set to run on multiple nodes.
You'll see output for each running node.
The other two jobs are set to run only on one node.
You'll see output on one node and the others will have a debug statement saying they couldn't get a lock.

**Requirements**

We want a simple way to run *scheduled* jobs written in Elixir.
We want to be able to run jobs one of two ways: on one and only one node or on each and every node.

Our nodes are not clustered; they don't know about each other.
Because we don't have a relational database can't use Oban.
We do have Redis, but it runs in cluster mode and Flume doesn't support cluster mode.

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
But, that would entail running distributed Elixir.
Quantum does have a way to run jobs on a random node, but you would still need some kind of lock to prevent multiple runs.

# Chapter 8: State Sharing Concurrency

## State sharing model
The state-shared concurrent model is a computational model in which cells that are variable variables are added to the declarative concurrent model. On the other hand, in the previous chapter, Message Concurrency, we added a port, which is also a kind of variable variable, to the declarative concurrency model. Since variable variables are used, these can be collectively called a stateful concurrency model, but in reality the programming styles of both are completely different. The state sharing concurrency model handles programs in which multiple threads access shared data in parallel, and the message transfer concurrency model handles multi-agent programs.

If the stateful concurrency is handled as it is, it becomes necessary to handle the enormous program execution path that can be caused by thread interleaving. As one way to avoid this, there was message transmission parallelism in the previous chapter. In this chapter, we mitigate shared data by building large atomic actions using various abstractions.

## Atomic action
To construct an abstraction of atomic actions, we use operations whose atomicity is guaranteed by the semantics of the language. If it is Oz, the statement `{Exchange C Old New}` that binds the old value of the cell variable C to Old and assigns the new value New to C is atomically executed. In addition to this, we use the property of the dataflow variable that "when trying to use an unbound value, wait until bound". For example, you can use it to build a queue that can be called in parallel as a data abstraction, and then use this parallel queue to implement a monitor.

### Lock
Lock is an abstraction of this kind. The lock controls one thread to be put in at once for the critical region (Critical Region/Section) where the shared data is accessed. When one thread is executing the dangerous area, another thread is made to wait at its entrance. A lock is created with `L={NewLock}`, and a dangerous area is enclosed with `lock L then <stmt> end`. It doesn't matter how many particular locks are scattered across the program area. In this case, it is advisable to enter a different dangerous area (enclosed by the same lock L) from a certain dangerous area by calling a procedure. Such a lock is called a reentrant lock.

### monitor
Locking is an important abstraction, but it's not enough. For example, assume there is a fixed length buffer. Suppose there is a thread trying to put a value in it and a thread trying to get it out. These buffer operations must be done atomically. Perhaps one thread retrieves a value and wants to wait in the middle of a critical area (until another thread populates the buffer) if the buffer has no value. When this happens, you need to temporarily release the lock (for another thread that fills in the value). There is a monitor as such a mechanism. Like the lock, the monitor decides the exit and entrance, but in the middle of the process, `wait` to release the lock temporarily, or `notify` and restart the thread that has been `wait` again. It enables cooperative operation of shared threads.

### Transaction
Another concept that was introduced for databases in another abstraction is the transaction. A transaction is an operation that satisfies ACID, that is, atomicity (Atomic), consistency (Consistency), isolation (Isolation), and durability (Durability). Solitary is also called serializability. Durability is also called Persistence. ACI and D have slightly different perspectives. Aside from the database, what is needed for general-purpose concurrent programming is ACI, which is called a lightweight transaction (hereinafter simply transaction). The motivations for this kind of thing are to let the transaction system clean up on exceptions, write fault-tolerant applications, and avoid deadlocks in concurrent programs (due to system guarantees).

Implementation of transactions... [TODO].
Keywords: lock-based concurrency control / timestamp-based concurrency control / optimistic scheduling / pessimistic scheduling / two-phase locking

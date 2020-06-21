# Chapter 11: Distributed Programming

## Distributed system classification
This chapter deals with open distributed systems. This is a more general distributed system than cluster computing, as follows.
-Memory shared multiprocessor --Distributed --> Distributed memory multiprocessor --Partial failure --> Distributed memory multiprocessor with partial failure --Openness --> Open distributed system
  -For example, large-scale high-performance computing is programming on a super computer, which is a "distributed memory multiprocessor with partial failure", not an open distributed system.

## Programming on distributed systems
-Question: Is distributed programming just one kind of parallel programming, so can conventional techniques of concurrent programming still be used?
-Answer: It's not so simple for the following reasons.
  -Since the process is different, the address space is also different. Data needs to be converted and transferred.
  -Network performance is limited. Extremely slow compared to the calculation operation.
  -Some resources are biased such that they can only be used on specific machines.
  -Partially non-functional (network or machine failure).
  -Open distributed systems have security and naming issues.

## Network transparency
-Assume ideal case: 1) network is fast, 2) resources are available everywhere, 3) all computers are up and running without failure, and 3) all users trust each other To do. No matter how normal concurrent programming is divided into distributed systems, it can be guaranteed by the system that it will run as it did in the original case.
-Keeping this simplicity, I want to deal well with non-ideal cases. This is a research question that has yet to be resolved, but I will touch on a corner of it. You need to consider the following.
  -Network Awareness :: In order to adjust the network performance while keeping the program correct, it is necessary to understand to some extent how to use the network (Awareness). More specifically, network operations need to be small and predictable (?).
  -Openness :: What to do to combine independent computations. Dynamic typing is relatively easy.
  -Working with localized resources :: For example, if you have a server that does some work and returns results, the client may want to work with the server's resources (such as files). It is necessary to be able to specify such.
  -Failure detection :: It is necessary to be able to detect and repair failures from application programs. One could think of building an abstraction that uses redundancy to hide failures.
  -There are other issues such as security, naming, resource management, and fault tolerance abstraction, which we will not cover here.

## Specific example of being network transparent
For example, suppose that process A has `X=the_value(text: "It is a ...", author: "Tom")`. If there is a reference Y to this variable in process B, you can check `the_value(text: "It is a ...", author: "Tom")` with `{Browse Y}`. The same applies because procedures and functions are also values. As another example, if process A has a variable X that is not bound as `declare X`, and process B also has a reference Y to this variable (ie, X and Y refer to the same thing semantically). To do. If process X sets `X=100`, then process B also binds Y to 100. Similarly, a cell variable (so-called “variable” in a procedural language, etc.), which is an entity with a state, also affects all processes if its content value is changed.

Tickets are a simple mechanism for passing an initial reference between processes. Ticket T that represents a reference to variable X by setting `T={Connection.offer X}` in a certain process (specifically, a character string such as `oz-ticket://192.168.0.3:9000/h7413698#0` ) Is generated. If another process receives this ticket in some way and makes `Y={Connection.take T}`, Y refers to the same language entity as X.

## How linguistic entities are distributed
Each language entity has a home process. By default, this home process is the process in which the entity was created. For each language entity such as number, record, procedure, data flow variable, cell, etc., the distribution protocol of how to distribute is clearly defined in a simple form.

For example, roughly, a stateless entity has its value immutable, so a copy is sent (cached) to each process that needs it. Stateful entities have several protocols: quiescent state (remains in the original process), mobile state (moves to another process), invalidation (optimization). The default distribution protocol for objects is mobile. In the mobile state, the objects themselves are cached in each process, and the state updater (of course, only one at a time) moves between processes as needed.

The GC works in cooperation with the local GC of each process and the distributed GC that counts remote references with weights. In addition, it has a time lease mechanism that discovers failures that can be considered permanent and GCs the related entities.

## Partial failure
The most common types of failures are permanent process failures and network inoperability. The failure model of the Mozart system handles and detects these two types. The failure model defines various distributed failures that occur in the system by means of a failure detection mechanism of how they are reflected in the language.

Process failures are permanent and are represented by `permFail`. In general, process failures cannot be detected on the WAN (e.g. Internet), only on the LAN. On the other hand, network inactivity is considered temporary (`tempFail`). I think it is being restored. This is not a time-out. tempFail informs the application that there is a network problem, not the end of the connection. This allows the application to deal with it faster (eg by connecting to another server).

When it comes to design, failure localization should be considered from the beginning of application design. At that time, there is a basic trade-off between synchronous/asynchronous failure detection and a bound mechanism. For example, if the failure detection is synchronous, the localization mechanism can be simple, but performance will be degraded. This is similar to the trade-off between optimistic and pessimistic concurrency control. Failure localization is one way to build an abstraction that handles all failures internally. Hopefully you can completely hide it. The next best option is to narrow the interface between processes (like the messaging style). In contrast, processing in the state sharing style of distributed systems is difficult.

## Security
Being safe is an overall property. Any weakness in any part of the system will be exploited. Furthermore, it's not absolutely safe, so you can only increase the effort to make it seem unworthy to the body trying to break security. Security issues appear at each layer of a distributed system. Application, language, language implementation, OS, network, hardware.

## construction
Developing a distributed application is a two-step process. First, do not divide the process, then divide the process and add geographical and performance constraints.

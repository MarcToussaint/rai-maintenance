## Graph

The `Graph` data structure started out rather normal, as a typical
graph data structure where nodes are _any-type_ (their value can be of
any C++ type). As nodes also have a `key`, the data structure was also
an any-type dictionary (as in Python). This turned out so useful that
it is now used equally as dictionary, as graph, or a mix of
both. Further, a node can have a sub-graph (or sub-dictionary) as
value, making the data structure hierarchical and ideal to represent
XML or YAML kind of data. I use this data structure to read XML, YAML,
JSON. The `.g` file format is one-to-one with the Graph data structure
and is the only file format used in `rai` (for configuration files,
kinematic model descriptions, logic, factor graphs, optimization
problems, etc).

<!--
Our graph syntax is a bit different to standard conventions. Actually,
our graph could be called a \emph{key-value hierarchical hyper graph}:
nodes can play the role of normal nodes, or hypernodes (=edges or
factors/cliques) that connect other nodes. Every node also has a set
of keys (or tags, to retrieve the node by name) and a typed value
(every node can be of a different type). This value can also be a
graph, allowing to represent hierarchies of graphs and subgraphs.
\begin{itemize}
\item A graph is a set of nodes
\item Every node has three properties:
\begin{items}
\item A tuple of \textbf{keys} (=strings)
\item A tuple of \textbf{parents} (=references to other nodes)
\item A typed \textbf{value} (the type may differ for every node)
\end{items}
\end{itemize}
Therefore, depending on the use case, such a graph could represent
just a key-value list, an 'any-type' container (container of things of
varying types), a normal graph, a hierarchical graph, or an xml data
structure.
-->

The best way to understand the `Graph` class is to first understand the file format, which clarifies what is actually represented. Here is the `example.g` from `test/Core/graph`, hopefully the comments are self-explanatory:
```
## a trivial graph (all boolean-typed nodes)
x            # a 'vertex': key=x, value=true, parents=none
y            # another 'vertex': key=y, value=true, parents=none
(x y)        # an 'edge': key=none, value=true, parents=x y
x            # key=x, value=true, parents=none
y            # key=y, value=true, parents=none
(x y)        # key=none, value=true, parents=x y
(-1 -2)      # key=none, value=true, parents=the previous and the y-node

## nodes with Graph value: hierarchical
node A { color:blue }         # keys=node A, value=<Graph>, parents=none
node B { color:red, value:5 } # keys=node B, value=<Graph>, parents=none
edge C(A B) { width:2 }       # keys=edge C, value=<Graph>, parents=A B
hyperedge(A B C) : 5          # keys=hyperedge, value=5, parents=A B C

## standard value types
a:string      # rai::String (except for keywords 'true' and 'false' and 'Mod' and 'Include')
b:"STRING"    # rai::String
c:'file.txt'  # rai::FileToken (with RELATIVE path; creates file pointer on parsing)
d:-0.1234     # double
e:[1 2 3 0.5] # rai::arr
g!            # bool (default: true, !means false)
h:true        # bool
i:false       # bool
j:{ a:0 }     # sub-Graph (special: does not require a '=')

## parsing: : {..} (..) , and \n are separators for parsing key-value-pairs
b0:false b1 b2, b3() b4   # 4 boolean nodes with keys 'b0', 'b1 b2', 'b3', 'b4'
k:{ a, b:0.2 x:"hallo"     # sub-Graph with 6 nodes
  y
  z():filename.org x }

## special Node Keys

## editing: after reading all nodes, the Graph takes all Edit nodes, deletes the Edit tag, and calls a edit()
## this example will modify/append the respective attributes of k
Edit k { y:false, z:otherString, b:7, c:newAttribute }

## including
Include : 'example_include.g'   # first creates a normal FileToken node then opens and includes the file directly

## any types
trans:<t(10 0 0)>  # trans is initially untyped; becomes types when accessed first in the code

## strange notations
a()       # key=a, value=true, parents=none
()        # key=none, value=true, parents=none
[1 2 3 4] # key=none, value=rai::arr, parents=none
```

Subgraphs may contain nodes can have parents from the containing
graph, or from other subgraphs of the containing graph. Some methods
of the @Graph@ class (to find nodes by key or type) allow to specify
whether also nodes in subgraphs or parentgraphs are to be
searched. This connectivity across (sub)-graphs e.g. allows to
represent logic knowledge bases.

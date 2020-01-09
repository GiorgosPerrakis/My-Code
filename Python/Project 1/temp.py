import pprint

def read_weighted_graph_wm(filename):
    graph = {}
    weights = {}
    with open(filename) as input_file:
        for line in input_file:
            parts = line.split()
            [n1, n2, w] = [ int (x) for x in line.split() ]
            if n1 not in graph:
                graph[n1] = []
            if n2 not in graph:
                graph[n2] = []
            graph[n1].append(n2)
            weights[(n1, n2)] = w
    return (graph, weights)


def topological_sort(g):

    positions = []
    visited = [ False for v in g.keys() ]

    num_nodes = len(g.keys())

    for i in range(num_nodes):
        if not visited[i]:
            dfs(g, i, positions, visited)

    return(positions)

def dfs(g, node, positions, visited):

    visited[node] = True
    for v in g[node]:
        if not visited[v]:
            dfs(g, v, positions, visited)
    positions.insert(0, node)


def add_source_sink(g):

    to_nodes = { u for v in g.keys() for u in g[v] }
    no_previous = g.keys() - to_nodes
    no_next = { v for v in g.keys() if len(g[v]) == 0 }
    # Get the number of nodes in the graph.
    num_nodes = len(g.keys())
    source = num_nodes
    g[source] = [ v for v in no_previous ] # all zero weights
    num_nodes += 1
    sink = num_nodes
    g[sink] = [ ]
    for node in no_next:
        g[node].append(sink) # all zero weights
    return (source, sink)

def critical_path(g, w):
    source, sink = add_source_sink(g)
    n = len(g.keys())
    pred = [ -1 for x in range(n) ] # list of predecessors in critical path
    dist = [ -1 for x in range(n) ] # list of distances to nodes

    dist[source] = 0 # correct distance to source to 0
    tsorted = topological_sort(g)
    for u in tsorted:
        for v in g[u]:
            if dist[v] < dist[u] + w.get((u, v), 0):
                dist[v] = dist[u] + w.get((u, v), 0)
                pred[v] = u
    return (pred, dist)

g, w = read_weighted_graph_wm('tm.txt')
pred, dist = critical_path(g, w)
print('pred', pred)
print('dist', dist)
print('length', len(pred))

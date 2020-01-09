import argparse
import pprint
import copy

parser = argparse.ArgumentParser()
parser.add_argument("filename", help="name of input file")
parser.add_argument("bias_parameter", type=float, help="bias parameter")
parser.add_argument("start_node", help="start node")
parser.add_argument("end_node", help="end node")

args = parser.parse_args()

g = {}
w = {}

with open(args.filename) as graph_input:
    for line in graph_input:
        nodes = [str(x) for x in line.split()]
        nodes[2] = int(nodes[2])

        if len(nodes) != 3:
            continue
        if nodes[0] not in g:
            g[nodes[0]] = []
        if nodes[1] not in g:
            g[nodes[1]] = []
        g[nodes[0]].append(nodes[1])
        g[nodes[1]].append(nodes[0])
        w[(nodes[0], nodes[1])] = nodes[2]

visited = {}

path = []
paths = []
temp_path = []

for k in g.keys():
    visited[k] = False

def dfs_stack(g, node, end):

    visited[node] = True
    path.append(node)
    temp_path = path[:]

    if (node == end):
        i = 0
        cost = 0
        while i < (len(temp_path)-1):
            cost = cost + w.get((temp_path[i], temp_path[i+1]), 0)
            i = i + 1
        temp_path.append(cost)
        paths.append(temp_path)
    else:
        for v in g[node]:
            if not visited[v]:
                dfs_stack(g, v, end)
    path.pop()
    visited[node] = False

def find_min_path(p):
    #min_cost = 1000000000
    tp = p[0]
    min_cost = tp[-1]
    for k in p:
        temp = k[-1]
        if (temp < min_cost):
            min_cost = temp
    for path_list in p:
        if (path_list[-1] == min_cost):
            return (path_list[0:(len(path_list)-1)], path_list[-1])

dfs_stack(g, args.start_node, args.end_node)

min_path,min_cost = find_min_path(paths)
print (min_path, min_cost)

temp_paths = copy.deepcopy(paths)
final_list = []

def function():
    for x,path_list in enumerate(paths):
        new_cost = w.get((path_list[0], path_list[1]), 0)
        if(x == 0):
            final_list.append(path_list[0])
        del(path_list[0])
        temp = path_list[0]
        for k,l in enumerate(path_list):
            if(k != 0 and k != (len(path_list)-1)):
                new_cost = new_cost + w.get((temp, l), 0) * args.bias_parameter
                temp = l
        path_list[-1] = int(new_cost)

    temp_path, temp_cost = find_min_path(paths)

    for i,t in enumerate(paths):
        if (t[0] != temp_path[0]):
            #print(t[0])
            del(paths[i])

while (len(paths) > 1):
    function()

def cmp(a, b):
    return (a > b) - (a < b)

for f in paths:
    for w in f[0:len(f)-1]:
        final_list.append(w)

for k in temp_paths:
    n = cmp(k, final_list)
    if(n == 1):
        print(final_list, k[-1])

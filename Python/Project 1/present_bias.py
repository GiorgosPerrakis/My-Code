import argparse, copy

parser = argparse.ArgumentParser()                                              # parameters for the input
parser.add_argument("filename", help="name of input file")
parser.add_argument("bias_parameter", type=float, help="bias parameter")
parser.add_argument("start_node", help="start node")
parser.add_argument("end_node", help="end node")

args = parser.parse_args()

g = {}                                                                          # dictionary for the main graph
w = {}                                                                          # second dictionary for the graph of costs

with open(args.filename) as graph_input:                                        # open file that was given from input
    for line in graph_input:
        nodes = [str(x) for x in line.split()]                                  # read each line and split it
        nodes[2] = int(nodes[2])                                                # the first two elements are strings
                                                                                # and the third is integer
        if len(nodes) != 3:
            continue
        if nodes[0] not in g:                                                   # if node doesn't exist then create it
            g[nodes[0]] = []
        if nodes[1] not in g:
            g[nodes[1]] = []

        g[nodes[0]].append(nodes[1])                                            # insert values to the dictionaries
        w[(nodes[0], nodes[1])] = nodes[2]

visited = {}                                                                    # dictionary for the visited nodes

path = []                                                                       # list where we keep the current path
paths = []                                                                      # list of lists where we keep all the paths
temp_path = []

for k in g.keys():                                                              # in the beginning we haven't visited any node
    visited[k] = False

def dfs_function(g, node, end):                                                 # function with which we navigate the graphs and
                                                                                # find all the paths and the cost for each path
    visited[node] = True
    path.append(node)
    temp_path = path[:]                                                         # copy the path list to a temp list

    if (node == end):                                                           # when we reach the end of a path
        i = 0
        cost = 0
        while i < (len(temp_path)-1):                                           # we calculate the cost
            cost = cost + w.get((temp_path[i], temp_path[i+1]), 0)
            i = i + 1
        temp_path.append(cost)                                                  # we keep the cost to the last element of
        paths.append(temp_path)                                                 # the path list
    else:
        for v in g[node]:
            if not visited[v]:
                dfs_function(g, v, end)                                         # with recursion we navigate the neighbor nodes
    path.pop()
    visited[node] = False

def find_min_path(paths):                                                       # function that finds the minimum path
    min_path = paths[0]
    min_cost = min_path[-1]
    for k in paths:
        temp = k[-1]
        if (temp < min_cost):
            min_cost = temp
    for path_list in paths:                                                     # go through the lists with the paths
        if (path_list[-1] == min_cost):                                         # and find the path with the minimum cost
            return (path_list[0:(len(path_list)-1)], path_list[-1])             # tha was calculated before

dfs_function(g, args.start_node, args.end_node)                                 # call dfs_function and give the parameters
                                                                                # that were given from input
min_path, min_cost = find_min_path(paths)

print (min_path, min_cost)                                                      # print minimum path and cost

temp_paths = copy.deepcopy(paths)                                               # keep a copy of our paths and costs

final_list = []                                                                 # initialization of our final list
final_cost = 0                                                                  # and final cost

while(paths[0][0] != args.end_node):                                            # loop until we arrive to the last element
    for path_list in paths:
        new_cost = w.get((path_list[0], path_list[1]), 0)                       # the real cost from the first two nodes
        if (path_list[0] not in final_list):                                    # if the node doesn't exist in the final list
            final_list.append(path_list[0])                                     # then add it
        del(path_list[0])                                                       # delete the first element of each path
        temp = path_list[0]
        for k,l in enumerate(path_list):                                        # calculate the cost for the rest nodes
            if(k != 0 and k != (len(path_list)-1)):                             # considering the bias parameter
                new_cost = new_cost + w.get((temp, l), 0) * args.bias_parameter
                temp = l
        path_list[-1] = int(new_cost)                                           # update the cost of the path

    temp_path, temp_cost = find_min_path(paths)                                 # find the minimum path and its cost
    final_list.append(temp_path[0])                                             # add the path to the final list

    i = 0
    counter = 0
    temp_length = len(paths)                                                    # keep the length of paths list to a temp
                                                                                # variable because it is going to change
    while (i < temp_length):                                                    # loop through paths list and delete all the
        if (paths[counter][0] != temp_path[0]):                                 # paths that we are not going to follow
            del(paths[counter])
            counter = counter - 1
        counter = counter + 1
        i = i + 1

for k in temp_paths:                                                            # loop through the initial paths list and
    tem = k[0:len(k)-1]                                                         # and find the cost of the path that he is
    if(tem == final_list):                                                      # going to follow
        print(final_list, k[-1])

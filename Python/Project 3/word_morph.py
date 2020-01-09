from collections import deque                                                   # libraries that i use
import argparse
import Levenshtein
import sys
import time

parser = argparse.ArgumentParser()                                              # parameters for input
parser.add_argument("dictionary", help="name of dictionary")
parser.add_argument("start_word", help="start word")
parser.add_argument("target_word", help="target word")

args = parser.parse_args()

class BKTree:                                                                   # class with functions related to the bk tree
    def __init__(bk):                                                           # function that initializes the root node
        bk.root = None

    def BKTreeInsert(bk, word):                                                 # function that inserts a new node to the BK tree
        if bk.root is None:
            bk.root = (word, {})                                                # in the beginning the root node doesn't have children
            return

        node = bk.root

        while (len(node) != 0):                                                 # loop while bk tree in not empty
            node_word = node[0]                                                 # get the word
            children = node[1]
            distance = Levenshtein.distance(word, node_word)
            node = children.get(distance)                                       # and the children

            if node is None:                                                    # if the node doesn't exist then create it
                children[distance] = (word, {})
                break

            node_word = node[0]
            children = node[1]

    def BKTreeSearch(bk, word):                                                 # function that takes a word as input and find all the words in the dictionary which
        results = set()                                                         # have levenshtein distance equals to 1
        to_check = deque([bk.root])

        while (len(to_check) != 0):                                             # loop while the queue is not empty
            node = to_check.popleft()                                           # dequeue one node
            node_word = node[0]
            children = node[1]
            distance = Levenshtein.distance(word, node_word)

            if distance == 1:                                                   # if the levenshtein distance is 1 then add the node to the set
                results.add((distance, node_word))

            l = distance - 1
            h = distance + 1

            for d, child in children.items():                                   # do the same for the children nodes
                if((l <= d) and (d <= h)):
                    to_check.append(child)
        return results

def dijkstra(nodes, start):                                                     # function that finds the shortest path from one word to all the others
    MAX_INT = sys.maxsize
    num_nodes = len(nodes)

    dist = [ MAX_INT for v in nodes ]                                           # list that has all the distances
    dist[nodes.index(start)] = 0
    pred = [ -1 for v in nodes ]                                                # list that has the previous nodes

    pq = dist[:]                                                                # priority queue that help us find which node to visit next

    while num_nodes != 0:                                                       # loop through all the words of the dictionary
        u = pq.index(min(pq))                                                   # get the minimum distance from the queue
        pq[u] = MAX_INT
        num_nodes -= 1

        for (w, v) in bk.BKTreeSearch(nodes[u]):                                # loop through the words that have distance equal to one
            index = nodes.index(v)
            if dist[u] != MAX_INT and dist[index] > dist[u] + w:                # if we find a better path we change it
                dist[index] = dist[u] + w
                pred[index] = u
                num = Levenshtein.distance(v, args.target_word)                 # we find the levenshtein distance between the current word and the target word
                pq[index] = dist[index] + num                                   # and we add it to the priority queue

    return (pred, dist)                                                         # return the list with the previous nodes and the list with the distances


def get_path(pred, t):                                                          # function that gets as input the list with the previous nodes and finds the path
    path = []
    while t != -1:
        path.append(t)
        t = pred[t]

    return path[::-1]


with open(args.dictionary) as input_dictionary:                                 # open input file
    start = time.time()
    bk = BKTree()                                                               # create a BK tree
    word_list = []

    for word in input_dictionary:                                               # read input file
        word = word.rstrip('\n')
        bk.BKTreeInsert(word)                                                   # send every word to a function which creates the BK tree

        word_list.append(word)                                                  # create a list which contains all the words of the dictionary

    pred, dist = dijkstra(word_list, args.start_word)                           # call a function to find the path

    path = get_path(pred, word_list.index(args.target_word))                    # get the path from the related function
    a = []
    if(len(path) == 1):                                                         # if there is no path then we print only the start word
        print(args.start_word)
    else:                                                                       # else we print the path with the correct format
        for h in path:
            a.append(word_list[h])
        print(', '.join(a))

    end = time.time()
    print(end - start)

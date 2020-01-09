import argparse, csv, copy, pprint, timeit

parser = argparse.ArgumentParser()
parser.add_argument("filename", help="name of input file")

args = parser.parse_args()

table = []
total_elapsed = 0
start = timeit.default_timer()

with open(args.filename) as square_input:                                       #open file and read input

    csv.register_dialect('myDialect', delimiter = ',', skipinitialspace=True)
    file = csv.reader(square_input, dialect='myDialect')

    for row in file:
        x = [int(i) for i in row]
        if(x != []):
            table.append(x)

transversals = [[]]
limit = len(table[0])
counter = 0

def loop():                                                                     #functions loop() and compare() calculate all the transversals
    global temp
    for i,t in enumerate(table):
        temp = [[t[0], i, 0]]
        compare(1)
        temp[:] = []

def compare(column):
    global counter, limit
    for row_index,row in enumerate(table):
        flag = True
        for k in temp:
            if(k[0] == row[column]):
                flag = False
                break
            elif(k[1] == row_index):
                flag = False
                break

        if(flag == True):
            temp.append([row[column], row_index, column])
            if(column == limit - 1):
                for l in temp:
                    transversals[counter].append(l[0])
                del temp[-1]
                transversals.append([])
                counter = counter + 1
            column = column + 1
            if(column < limit):
                compare(column)
                del temp[-1]
            column = column - 1

def function(trans_index, temp_counter):                                        #this function choose the right transversals
    global break_flag, temp_parameter, new_transversals, end_flag
    break_flag = True

    for trans in transversals[trans_index:]:
        temp_counter = temp_counter + 1
        if(trans[0] == transversals[temp_counter][0] + 1):
            if(temp_index[-1] != transversals[temp_counter][0]):
                temp_parameter = kk[-1] + 1
                del new_transversals[-1]
                del temp_index[-1]
                del kk[-1]
                break_flag = False
                break

        flag2 = True
        for j in new_transversals:
            if(trans[0] == j[0]):
                flag2 = False
                break
        if(flag2 == False):
            continue

        flag = True
        for s in range(0, len(transversals[0])):
            for k in new_transversals:
                if(trans[s] == k[s]):
                    flag = False
                    break
            if(flag == False):
                break

        if(flag == True):
            new_transversals.append(trans)
            temp_index.append(trans[0])
            kk.append(temp_counter + 1)
            if(trans[0] == transversals[len(transversals)-1][0]):
                end_flag = True
    return 0

def check_if_true(greek_latin):                                                 #function to check if my solution is correct
    check = True
    for i in greek_latin:
        for t, j in enumerate(i):
            for k in i[t+1:]:
                if(j[0] == k[0] or j[1] == k[1]):
                    check = False
    for i in range(0, len(greek_latin[0])):
        for t, j in enumerate(greek_latin):
            for k in greek_latin[t+1:]:
                if(j[i][0] == k[i][0] or j[i][1] == k[i][1]):
                    check = False
    print("check",check)

loop()
del transversals[-1]

transversals.sort(key=lambda x: x[0])

if(transversals != []):
    new_transversals = [transversals[0]]
    temp_index = [transversals[0][0]]
    kk = [0]
    flag = True
    flag2 = True
    temp_parameter = 0
    end_flag = False
    none = function(1, -1)

    while(1):
        if(break_flag == False):
            none = function(temp_parameter, temp_parameter - 2)
        if(end_flag == True):
            break

    latin = copy.deepcopy(table)

    for n in new_transversals:
        for p in range(0, len(table[0])):
            for index,l in enumerate(table):
                if(l[p] == n[p]):
                    latin[index][p] = n[0]
                    break
        final_latin = []
        temp_list = []
        for w in range(0, len(latin)):
            temp_list[:] = []
            for z in range(0, len(latin)):
                temp_list.append((table[w][z], latin[w][z]))
            tt = copy.copy(temp_list)
            final_latin.append(tt)

    #check_if_true(final_latin)

    pp = pprint.PrettyPrinter(width = 110)
    pp.pprint(final_latin)
else:
    print([])

end = timeit.default_timer()
total_elapsed = end - start
print(total_elapsed / 60, "minutes")

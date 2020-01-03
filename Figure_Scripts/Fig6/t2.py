with open('fig6_na_removed.csv') as r:
    lines = r.readlines()
r.close()

rowNum = len(lines)

new_high_rep_csv = "ParentId, Reputation, Votes\n"
new_low_rep_csv = "ParentId, Reputation, Votes\n"


# Skip first line, header line
for i in range(1, rowNum-1):

    current_row = lines[i].strip('\n')
    next_row = lines[i+1].strip('\n')

    current_row_sp = current_row.split(',')
    next_row_sp = next_row.split(',')

    # If two lines from same question
    if current_row_sp[0] == next_row_sp[0]:

        # TODO
        # Consider this part, if reputation is missing
        # We skip this pair
        if current_row_sp[1] == '':
            i += 2
            continue
        elif next_row_sp[1] == '':
            i += 1
            continue

        current_row_rep = int(current_row_sp[1].strip('"'))
        next_row_rep = int(next_row_sp[1].strip('"'))

        # If two reputations are equal
        if current_row_rep == next_row_rep:
            i += 2
            continue

        # min reputation in pair
        temp_min = min(current_row_rep, next_row_rep)

        # If lower value in lower rep range
        if (temp_min in range(75, 125)):

            # If first row is lower:
            if temp_min == current_row_rep:

                new_low_rep_csv += current_row_sp[0] + ',' + \
                                   str(current_row_rep) + ',' + \
                                   current_row_sp[2] + '\n'

                new_high_rep_csv += next_row_sp[0] + ',' + \
                                   str(next_row_rep) + ',' + \
                                   next_row_sp[2] + '\n'
                i += 1

            elif temp_min == next_row_rep:

                new_low_rep_csv += next_row_sp[0] + ',' + \
                                   str(next_row_rep) + ',' + \
                                   next_row_sp[2] + '\n'

                new_high_rep_csv += current_row_sp[0] + ',' + \
                                   str(current_row_rep) + ',' + \
                                   current_row_sp[2] + '\n'

                i += 1
            else:
                print('Error')

with open('HighRep.csv', 'w') as w1:
    w1.write(new_high_rep_csv)
w1.close()

with open('LowRep.csv', 'w') as w2:
    w2.write(new_low_rep_csv)


w2.close()
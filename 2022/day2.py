f = open('day2.txt', 'r')
lines = f.readlines()

def normalize(v):
    if v == 'A': return 'r'
    if v == 'B': return 'p'
    if v == 'C': return 's'
    if v == 'X': return 'r'
    if v == 'Y': return 'p'
    if v == 'Z': return 's'

def iwon(them, me):
    # rock beats scissors
    # paper beats rock
    # scissors beats paper
    print "them " + them + " me " + me
    if (them=='r' and me == 's') or (them=='p' and me == 'r') or(them=='s' and me == 'p'):
        # they won
        return 0
    if (me=='r' and them == 's') or (me=='p' and them == 'r') or(me=='s' and them == 'p'):
        # i won
        return 6
    # tie
    return 3

score = 0
for line in lines:
    them = line[0]
    me = line[2]
    result = iwon(normalize(them), normalize(me))
    print "result %d" % result
    if me == 'X': result += 1
    if me == 'Y': result += 2
    if me == 'Z': result += 3
    score += result
    print "score %d" % score

print score




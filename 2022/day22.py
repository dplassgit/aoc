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
    # me:X : need to lose, Y: draw, Z: win
    if me == 'Y':
        # Need to tie
        return (3, them)
    if me == 'X':
        # need to lose
        if them=='r':
            return (0, 's')
        if them=='p':
            return (0, 'r')
        if them=='s':
            return (0, 'p')
    # need to win
    if them=='r':
        return (6, 'p')
    if them=='p':
        return (6, 's')
    if them=='s':
        return (6, 'r')

score = 0
for line in lines:
    them = line[0]
    me = line[2]
    pair = iwon(normalize(them), me)
    print "result %d, %s" % (pair)
    result = pair[0]
    newme = pair[1]
    if newme == 'r': result += 1
    if newme == 'p': result += 2
    if newme == 's': result += 3
    score += result
    print "score %d" % score

print score




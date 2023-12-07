f = open('day7.txt', 'r')
lines = f.readlines()
lines = [line.strip() for line in lines]

cards="AKQT98765432J"
# cards, bid, type
hands = [[line.split()[0], int(line.split()[1]), 0] for line in lines]
#for hand in hands: print(hand)

for hand in hands:
    h=[0]*13
    js = 0 # joker count
    for card in hand[0]:
        ci = cards.find(card)
        if card == 'J':
            js = js + 1
        h[ci]+=1
    h.sort(reverse=True)
    t = 0 # type
    if h[0] == 5: # 5 of a kind
        t=7
    elif h[0] == 4: # 4 of a kind
        t=6
    elif h[0] == 3 and h[1] == 2: # full house
        t = 5
    elif h[0] == 3 : # 3 of a kind
        t = 4
    elif h[0] == 2 and h[1] == 2: # 2 pair
        t = 3
    elif h[0] == 2: # 1 pair
        t = 2
    else:
        t = 1
    # BUT WHAT ABOUT JOKERS?!
    if js>0:
        ot=t
        if t == 7:
            pass
        # 4 of a kind -> 5 of a kind
        elif t==6: 
            t=7
        # full house -> 5 of a kind (e.g., QQQJJ or QQJJJ)
        elif t== 5:
            t = 7
        # 3 of a kind -> 4 of a kind (QQQJx or JJJQx
        elif t == 4:
            t = 6
        # 2 pair -> full house or 4 of a kind (QQTTJ or QQJJx)
        elif t == 3 and js==1:
            # QQTTJ:
            t=5 # full house
        elif t == 3 and js==2:
            # QQTJJ:
            t=6 # 4 of a kind
        # 2 pair -> QQJJx -> 4 of a kind
        elif t == 3:
            t=6
        # 1 pair -> 3 of a kind (QQJ23 or JJ234)
        elif t==2: 
            t=4
        else: # nothing, now we have one pair
            t = 2
    hand[3] = t
    #print(hand)
    #print(h)
    #print(t)

print("\nAnalyzed")
for hand in hands: print(hand)

# return 1 for left>right, -1 for left < right.
def compare(left, right):
    if left[3] > right[3]:
        return 1
    if left[3] < right[3]:
        return -1
    # now compare individual cards
    for (a, b) in zip(left[0], right[0]):
        ai = cards.find(a)
        bi = cards.find(b)
        if ai != bi:
            # they're different. want to return > 0 if ai is "better" than (i.e. LOWER THAN) 
            return bi-ai
    return 0


# now do a fancy sort. Note, can't use hands.sort because I'm not smart enough.
for i in range(0, len(hands)):
    for j in range(i+1, len(hands)):
        if compare(hands[i], hands[j]) > 0:
            # wrong order
            temp = hands[i]
            hands[i] = hands[j]
            hands[j] = temp
print("\nSorted")
for hand in hands: print(hand)

answer = 0
rank = 1
for hand in hands:
    answer = answer + hand[1] * rank
    rank = rank + 1

print("Day 7: %d" % answer)


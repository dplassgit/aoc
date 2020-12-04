import io

f = open("d4.txt", "r")

data=[]
required=['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
valid=0

passport = []
for line in f:
    line=line.strip()
    if len(line) == 0:
        # end of previous passport
        missing = [k for k in required if k not in passport]
        if not missing or missing == ['cid']:
            valid = valid + 1
        print missing, passport
        passport = []
    else:
        fields=line.split(' ')
        for field in fields:
            kv=field.split(':')
            passport.append(kv[0])
        #print line,fields,passport

print valid
    

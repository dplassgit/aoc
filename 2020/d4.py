import io
import re

f = open("d4.txt", "r")

data=[]
required=['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
eyes=['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']
numvalid=0

passport = {}
for line in f:
    line=line.strip()
    if len(line) == 0:
        # end of previous passport
        missing = [k for k in required if k not in passport]
        print missing, passport
        if not missing:
            # no missing fields.
            valid=True
            byr = int(passport['byr'])
            valid = valid and (byr >= 1920 and byr <= 2002)
            print "valid after byr", valid
            iyr = int(passport['iyr'])
            valid = valid and (iyr >= 2010 and iyr <= 2020)
            print "valid after iyr", valid
            eyr = int(passport['eyr'])
            valid = valid and (eyr >= 2020 and eyr <= 2030)
            print "valid after eyr", valid
            hgt = passport['hgt']
            units = hgt[-2:]
            if units == 'cm':
                cms = int(hgt[:-2])
                valid = valid and (cms >= 150 and cms <= 193)
            elif units == 'in':
                ins = int(hgt[:-2])
                valid = valid and (ins >= 59 and ins <= 76)
            else:
                valid = False
            print "valid after hgt", valid
            hcl = passport['hcl']
            valid = valid and (re.match('^#[a-f0-9]{6}$', hcl) is not None)
            print "valid after hcl", valid
            ecl = passport['ecl']
            valid = valid and (ecl in eyes)
            print "valid after ecl", valid
            pid = passport['pid']
            valid = valid and (re.match('^[0-9]{9}$', pid) is not None)
            print "valid after pid", valid
            if valid:
                numvalid = numvalid + 1

        passport = {}
    else:
        fields=line.split(' ')
        for field in fields:
            kv=field.split(':')
            if kv[0] != 'cid':
                passport[kv[0]] = kv[1]
        #print line,fields,passport

print numvalid
    

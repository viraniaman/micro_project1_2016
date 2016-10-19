import random
f = open('alu_text.txt', 'w')

def tobitstring(num):
    a = str(bin(num))[2:]
    while(len(a) < 16):
        a = "0"+a
    return a

#testing addition

for i in xrange(100):
    a = random.randrange(0,65536)
    b = random.randrange(0,65536)
    c = a + b
    c %= 65536
    f.write("00 "+tobitstring(a)+" "+tobitstring(b)+" "+tobitstring(c)+"\n")  

#testing nand

for i in xrange(100):
    a = random.randrange(0,65536)
    b = random.randrange(0,65536)
    c = ~(a&b)
    c %= 65536
    f.write("01 "+tobitstring(a)+" "+tobitstring(b)+" "+tobitstring(c)+"\n")  


#testing leftshift

for i in xrange(100):
    a = random.randrange(0,65536)
    b = random.randrange(0,65536)
    c = a << 7
    c %= 65536;
    f.write("10 "+tobitstring(a)+" "+tobitstring(b)+" "+tobitstring(c)+"\n")  

#testing subtraction

for i in xrange(100):
    a = random.randrange(0,65536)
    b = random.randrange(0,65536)
    c = a - b
    c %= 65536;
    f.write("11 "+tobitstring(a)+" "+tobitstring(b)+" "+tobitstring(c)+"\n")  


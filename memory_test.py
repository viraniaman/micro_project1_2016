f = open('memory_text.txt', 'w')

def tobitstring(num):
    a = str(bin(num))[2:]
    while(len(a) < 16):
        a = "0"+a
    return a

for i in xrange(50):
    f.write(tobitstring(i)+" "+tobitstring(i+1)+"\n")


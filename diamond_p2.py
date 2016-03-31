import time
import random


def timer(totalTime,increment):
    currentTime = time.time();
    x = 0;
    while x<=totalTime:
        print "Time Elapsed: ", x , "s ||  Check: ", time.time() - currentTime, "s";
        x=x+2;
        time.sleep(increment);

def drawDiamond(numDiamonds, verticalSize, string1, string2, stable):
    h = 1;
    v = 1;
    newString = "";
    horizontalSize = verticalSize*2-3;
    
    if stable == 1:
        while len(newString)<horizontalSize+5:
            if h%2==0:
                newString = newString + string1;
            elif h%2!=0:
                newString = newString + string2;
            h=h+1;
    elif stable != 1:
        while len(newString)<horizontalSize+5:
            if h%(random.randint(1,3))==0:
                newString = newString + string1;
            elif h%(random.randint(1,3))!=0:
                newString = newString + string2;
            h=h+1;
    c=0;
    
    l = [];
    empty = "";
    while len(empty) < horizontalSize/2:
        empty = empty + " ";
        
    while v<verticalSize:
        newerString = newString[horizontalSize/2-c:horizontalSize/2+c:1];
        newestString = empty[c::] + newerString  + empty[c::];
        l.append(newestString);
        j = 0;
        for j in range(0,numDiamonds):
            print l[c],
        print "";
        v=v+1;
        c=c+1;
    
    
    c=c-1;
    
    while c>=0:
        j=0;
        for j in range(0,numDiamonds):
            print l[c],
        print "";
        c=c-1;

def main():
    #timer(10,2);
    drawDiamond(4,14,"T","G",0);

main();
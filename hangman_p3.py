import sys;
import random;

wordBank = [];
wordBank.append("TELEVISION");
wordBank.append("CABLE");
wordBank.append("CALL");
wordBank.append("QUALITY");
wordBank.append("COMMAND");
wordBank.append("CENTER");
wordBank.append("EXIT");
wordBank.append("HEADLINE");
wordBank.append("STUDIO");
wordBank.append("PROMPTER");
wordBank.append("AMPLIFIER");

tries = 6;
pos = 0;

word = wordBank[random.randint(0,len(wordBank)-1)];
gotten = "";
guessed = "";
hangman = [];
hangman.append("""  ______
  |    |     
  |     
  |     
  |     
  |
__|____""");

hangman.append("""  ______ 
  |    |     
  |    O 
  |     
  |  
  |     
__|____""");

hangman.append("""  ______ 
  |    |     
  |    O 
  |    |  
  |     
  |     
__|____""");

hangman.append("""  ______ 
  |    |     
  |   \O 
  |    |  
  |     
  |     
__|____""");

hangman.append("""  ______ 
  |    |     
  |   \O/ 
  |    |  
  |     
  |     
__|____""");

hangman.append("""  ______ 
  |    |     
  |   \O/ 
  |    |  
  |   / 
  |     
__|____""");

hangman.append("""  ______ 
  |    |     
  |   \O/ 
  |    |  
  |   / \ 
  |     
__|____""");

def cls():
    print("");
    print("---------------------");
    print("---------------------");
    print("");

def printWord():
    cls();
    print(hangman[pos]);
    t = 0;
    print("Word: ", end =' ');
    for t in range(0, len(guessedWord)):
        print(guessedWord[t], end=' ')
    print("");
    print("Guessed: " , guessed);
    
j = 0;
guessedWord = [];
for j in range(0,len(word)):
    guessedWord.append("_");
    
while tries > 0:
    printWord();
    guess = input("Guess a letter: ");
    guess = guess.upper();
    
    if guess in word and guess not in gotten:
        gotten = gotten + guess;
        guessed = guessed + guess;
        i=0;
        for i  in range(0,len(word)):
            if guess == word[i]:
                guessedWord[i] = guess;
        cls();

        print("Got a letter!!");
    
    elif guess in gotten or guess in guessed:
        cls();
        print("Letter already picked! Try again!");
        
    elif len(guess) != 1 or guess.isalpha() == False:
        cls();
        print("Invalid input! Try again!");
    
    else:
        cls();
        print("Letter not found..");
        guessed = guessed + guess;
        tries = tries - 1;
        pos = pos+1;
    
    if any("_" in s for s in guessedWord) == False:
        printWord()
        print("");
        print("=*=*=*=*=*=*=*=*=*=*=*=*");
        print("=*=*=*=*=*=*=*=*=*=*=*=*");
        print("=*=*=*=*=*=*=*=*=*=*=*=*");
        print("=*=*=*  YOU WIN  *=*=*=*");
        print("=*=*=*=*=*=*=*=*=*=*=*=*");
        print("=*=*=*=*=*=*=*=*=*=*=*=*");
        print("=*=*=*=*=*=*=*=*=*=*=*=*");
        sys.exit();
        
if tries == 0:
    printWord()
    print("");
    print("=.=.=.=.=.=.=.=.=.=.=.=.=");
    print("=.=.=.=.=.=.=.=.=.=.=.=.=");
    print("=.=.=.=.=.=.=.=.=.=.=.=.=");
    print("=.=.=.  GAME OVER  .=.=.=");
    print("=.=.=.=.=.=.=.=.=.=.=.=.=");
    print("=.=.=.=.=.=.=.=.=.=.=.=.=");
    print("=.=.=.=.=.=.=.=.=.=.=.=.=");
    print("");
    print("Winning Word: " , word);
    sys.exit();
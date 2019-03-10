
# sudo apt-get install libedit-dev
lambdalisp : repl.c mpc.c
	gcc mpc.c repl.c -o lambdalisp  -ledit -lm -Wall 

# for extra portability include
# -std=c99 

clean :
	rm *.o lambdalisp

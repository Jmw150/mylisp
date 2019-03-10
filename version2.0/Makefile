
# uses library libedit-dev
lambdalisp : repl.c mpc.c
	gcc mpc.c repl.c -o lambdalisp  -ledit -lm -Wall -g


clean :
	rm *.o lambdalisp

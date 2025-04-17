
all: debug 

debug: test main

test: FORCE
	lua $(wildcard test/*.lua)

main: 
	lua main.lua

FORCE: 


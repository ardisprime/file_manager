
TEST_FILES = $(wildcard test/*.lua)

all: debug 

debug: test main

test: $(TEST_FILES)

test/%.lua: FORCE
	lua $@

main: 
	lua main.lua

FORCE: 


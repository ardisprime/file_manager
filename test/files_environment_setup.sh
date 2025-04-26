#!/bin/sh

directory="tmp_dir"
file="tmp_file"

if test ! -d $directory 
then
  mkdir $directory
fi 

if test ! -e "${directory}/${file}" 
then
  touch "${directory}/${file}" 
fi 


#!/bin/bash

less test1.txt
read junk
petit --hash test1.txt
read junk
petit --hash test3.txt
read junk
petit --wordcount test1.txt
read junk
petit --sgraph test1.txt

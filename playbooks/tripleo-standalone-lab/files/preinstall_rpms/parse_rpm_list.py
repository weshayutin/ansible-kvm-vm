#!/usr/bin/python

from rpmUtils.miscutils import splitFilename


# print out only the rpm name, ignoring the x.y.z versions etc.
filepath = "rpm-list.txt"
f = open(filepath, "r")
for x in f:
    (n, v, r, e, a) = splitFilename(x)
    print(n)
    

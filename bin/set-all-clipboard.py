#!/usr/bin/env python3

import sys
import os

from threading import Thread

inp = sys.stdin.read()

def myfunc(cmd):
    p = os.popen("xsel -i -%s" % (i, ), "w")
    p.write(inp)
    p.close()

threads = []
for i in ["p", "s", "b"]:
    t = Thread(target=myfunc, args=(i,))
    t.start()
    threads.append(t)

for thread in threads:
    thread.join()

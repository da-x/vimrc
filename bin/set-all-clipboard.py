#!/usr/bin/env python3

import sys
import os

from threading import Thread

inp = sys.stdin.read()

def ssh_cb():
    if os.getenv("SSH_CUSTOM_CALLBACK"):
        p = os.popen("ssh-cb try-clipboard-set", "w")
        p.write(inp)
        res = p.close()
        if res is None:
            sys.exit(0)

# Try ssh_cb first
ssh_cb()

# Otherwise, fallback
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

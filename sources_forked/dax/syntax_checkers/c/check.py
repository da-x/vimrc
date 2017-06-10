#!/usr/bin/env python

import sys
import os

path = os.path.abspath(sys.argv[1])
os.system("pac --direct %s" % (path, ))

import sys
import time

for i in range(2):
  sys.stdout.write('stdout '+str(i)+"\n")
  time.sleep(3)
  sys.stderr.write('stderr '+str(i)+"\n")
  time.sleep(3)

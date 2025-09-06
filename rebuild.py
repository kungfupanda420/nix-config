#!/run/current-system/sw/bin/python
import os
import sys

os.chdir("/etc/nixos")
os.system("git add *")
msg=""
if len(sys.argv)>=2:
    msg=sys.argv[1]
else:
    print("Enter commit message")
    exit()
os.system(f'git commit -m "{msg}"')
os.system("git push origin main")
os.system("nixos-rebuild switch")

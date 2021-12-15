import os
import platform    # For getting the operating system name
import subprocess  # For executing a shell command

FNULL = open(os.devnull, 'w')

def ping(host):
    """
    Returns True if host (str) responds to a ping request.
    Remember that a host may not respond to a ping (ICMP) request even if the host name is valid.
    """

    # Building the command. Ex: "ping -c 1 google.com"
    command = ['ping', '-c', '1', '-w', '1', host]

#return subprocess.call(command, stdout=subprocess.DEVNULL) == 0
    return subprocess.call(command) == 0

if __name__ == '__main__':
    	print(ping('8.8.8.8'))

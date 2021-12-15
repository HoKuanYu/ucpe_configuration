import time
from subprocess import Popen, PIPE

def map():
    p = Popen(['docker', 'exec', '-i', 'controller', 'bash', '-c', '$INSTALL_DIR/bin/beerocks_cli'], stdin=PIPE, stdout=PIPE)
    p.stdin.write('bml_conn_map'.encode())
    time.sleep(2)
    out, err = p.communicate()
    with open('map', 'w') as log:
        log.write(out.decode('utf-8'))

if __name__ == '__main__':
    while True:
        map()

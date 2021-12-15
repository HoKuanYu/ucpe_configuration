import re
import dump_map

def gen_nodes():
    dump_map.map()
    nodes = []
    with open('map', 'r') as f:
        for line in f.readlines():
            #print(line)
            if 'IRE' not in line or 'ip' not in line:
              continue
            #print(line)
            ip = re.findall( r'[0-9]+(?:\.[0-9]+){3}', line)
            print(ip)
            nodes.append(ip[0].split('.')[3])
            if len(nodes) == 4:
              break
    print(nodes)
    return nodes

if __name__ == "__main__":
    gen_nodes()

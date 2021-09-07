#!/bin/bash
TYPE=$1
case $TYPE in
"master") docker start shinobi
          docker start ospos
          docker restart mysql
          exit 0
 ;;
"backup") docker stop shinobi
          docker stop ospos
          exit 0
 ;;
esac
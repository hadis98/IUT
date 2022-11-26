#!/bin/bash

TC="sudo /sbin/tc"

# interface traffic will leave on
IF=lo

DST_PORT="4040 0xffff"

U32="$TC filter add dev $IF protocol ip parent 1: prio 1 u32"
create () {
  echo "== SHAPING INIT =="

  # create the root qdisc
  $TC qdisc add dev $IF root handle 1: prio

  echo "$@"
  $TC qdisc add dev $IF parent 1:3 handle 30: netem $@

  $U32 match ip dport $DST_PORT flowid 1:3

  echo "== SHAPING DONE =="
}

# run clean to ensure existing tc is not configured
clean () {
  echo "== CLEAN INIT =="
  $TC qdisc del dev $IF root
  echo "== CLEAN DONE =="
}

clean
create "$@" 



#!/bin/bash
chunks=''
chunkNo=1

while true
do
    upstream="UPSTREAM_${chunkNo}"
    upstreamServer="UPSTREAM_SERVER_${chunkNo}"
    if [ -z  "${!upstream}" ] | [ -z  "${!upstreamServer}" ]; then break; fi

    chunk=$(</etc/nginx/nginx-chunk.conf)
    chunk="${chunk//@@@upstream@@@/${!upstream}}"
    chunk="${chunk//@@@server@@@/${!upstreamServer}}"

    chunks="$chunks $chunk"
    ((chunkNo++))
done

base=$(</etc/nginx/nginx-base.conf)
base="${base/@@@nginx-chunks@@@/$chunks}"
echo $base > /etc/nginx/nginx.conf
#!/bin/bash
set -e

# Remove old server PID if exists
rm -f tmp/pids/server.pid

exec "$@"

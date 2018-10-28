#!/bin/bash

set -e
echo "Denodo Exe Path= `env|grep -i exe` "

echo "Starting Denodo Engine ..."
/bin/bash -c "${PRODUCT_EXE}"

#Extra line added in the script to run all command line arguments
exec "$@";

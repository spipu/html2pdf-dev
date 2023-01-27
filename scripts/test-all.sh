#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

if [[ -d "../results" ]]; then
  rm -rf ../results
fi
mkdir -p ../results

./test-5.6.sh
./test-7.0.sh
./test-7.1.sh
./test-7.2.sh
./test-7.3.sh
./test-7.4.sh
./test-8.0.sh
./test-8.1.sh
./test-8.2.sh
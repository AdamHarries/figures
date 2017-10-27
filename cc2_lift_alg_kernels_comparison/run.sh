#!/bin/sh

pushd data
./refresh_data.sh
popd

python3 algorithmcomparison.py


R --no-save < build_graph.R

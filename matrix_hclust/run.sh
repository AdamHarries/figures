#!/bin/sh

pushd data
./refresh_data.sh
popd

python3 matrixcorrelation.py data/spmv.csv

R --no-save < hclust.R
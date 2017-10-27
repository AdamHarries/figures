#!/bin/sh

mysql -B -us1467120 -paiamaRNGOOG -h phantom.inf.ed.ac.uk s1467120 < query.sql > results.csv
# wc -l abs_times.csv
R --no-save < build_graph.R

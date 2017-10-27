# import pymysql

import pandas
import time
import matplotlib.pyplot as plt
plt.style.use('ggplot')

resfile="data/comparison.csv"

print("Loading data:")
print("Loading spmvdata...")
spmvdata = pandas.DataFrame.from_csv("data/spmv.csv", sep="\t")

# print("Loading ssspdata...")
# ssspdata = pandas.DataFrame.from_csv("data/sssp.csv", sep="\t")

# print("Loading bfsdata...")
# bfsdata = pandas.DataFrame.from_csv("data/bfs.csv", sep="\t")

# print("Loading pagerankdata...")
# pagerankdata = pandas.DataFrame.from_csv("data/pagerank.csv", sep="\t")

# group the dataset by all four factors that we care about, find the median of each group, and reset the index
# print("Calculating medians:")
# print("spmv...")
# spmv_medians = spmvdata.groupby(['kernel', 'matrix', 'global', 'local'])[['time']].median().reset_index()
# print("sssp...")
# sssp_medians = ssspdata.groupby(['kernel', 'matrix', 'global', 'local'])[['time']].median().reset_index()
# print("bfs...")
# bfs_medians = bfsdata.groupby(['kernel', 'matrix', 'global', 'local'])[['time']].median().reset_index()
# print("pagerank...")
# pagerank_medians = pagerankdata.groupby(['kernel', 'matrix', 'global', 'local'])[['time']].median().reset_index()

# calculate the best values for each set
spmv_best = spmvdata.loc[spmvdata.groupby(['matrix'])['time'].idxmin()].sort_values("time")
print(spmv_best)
# sssp_best = sssp_medians.groupby(['matrix'])[['time']].min().reset_index()
# bfs_best = bfs_medians.groupby(['matrix'])[['time']].min().reset_index()
# pagerank_best = pagerank_medians.groupby(['matrix'])[['time']].min().reset_index()

# combination = pandas.concat([spmv_best, sssp_best, bfs_best, pagerank_best], keys=["spmv", "sssp", "bfs", "pr"]).reset_index()

# del combination['level_1']
# combination = combination.rename(index=str, columns={'level_0': "algorithm"})

# combination.to_csv(resfile, sep="\t", columns=["matrix", "time"], header=["matrix", "time"], index=False)


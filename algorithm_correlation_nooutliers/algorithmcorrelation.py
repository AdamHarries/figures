import pymysql

import pandas
import time
import matplotlib.pyplot as plt
plt.style.use('ggplot')

resfile="data/correlation.csv"

print("Loading data:")
print("Loading spmvdata...")
spmvdata = pandas.DataFrame.from_csv("data/spmv.csv", sep="\t")

print("Loading ssspdata...")
ssspdata = pandas.DataFrame.from_csv("data/sssp.csv", sep="\t")

print("Loading bfsdata...")
bfsdata = pandas.DataFrame.from_csv("data/bfs.csv", sep="\t")

print("Loading pagerankdata...")
pagerankdata = pandas.DataFrame.from_csv("data/pagerank.csv", sep="\t")

# group the dataset by all four factors that we care about, find the median of each group, and reset the index
print("Calculating medians:")
print("spmv...")
spmv_medians = spmvdata.groupby(['kernel', 'matrix', 'global', 'local'])[['time']].median().reset_index()
print("sssp...")
sssp_medians = ssspdata.groupby(['kernel', 'matrix', 'global', 'local'])[['time']].median().reset_index()
print("bfs...")
bfs_medians = bfsdata.groupby(['kernel', 'matrix', 'global', 'local'])[['time']].median().reset_index()
print("pagerank...")
pagerank_medians = pagerankdata.groupby(['kernel', 'matrix', 'global', 'local'])[['time']].median().reset_index()

# calculate the best values for each set
spmv_best = spmv_medians.groupby(['matrix'])[['time']].min().reset_index()
sssp_best = sssp_medians.groupby(['matrix'])[['time']].min().reset_index()
bfs_best = bfs_medians.groupby(['matrix'])[['time']].min().reset_index()
pagerank_best = pagerank_medians.groupby(['matrix'])[['time']].min().reset_index()

combination = pandas.concat([spmv_best, sssp_best, bfs_best, pagerank_best], keys=["spmv", "sssp", "bfs", "pr"]).reset_index()

del combination['level_1']
combination = combination.rename(index=str, columns={'level_0': "algorithm"})

print("Pivoting")
pvt = combination.pivot(index="matrix", columns="algorithm", values="time")

print("Dumping to CSV")
pvt.to_csv(resfile, sep='\t')

# # merge the datasets
# print("Merging datasets.")
# spmv_sssp_merge = pandas.merge(spmv_medians, sssp_medians,on=["kernel", "matrix", "global", "local"], how="outer", suffixes=["a","b"])
# spmv_bfs_merge = pandas.merge(spmv_medians, bfs_medians,on=["kernel", "matrix", "global", "local"], how="outer", suffixes=["a","b"])
# spmv_pagerank_merge = pandas.merge(spmv_medians, pagerank_medians,on=["kernel", "matrix", "global", "local"], how="outer", suffixes=["a","b"])

# def correlate(df):
# 	return df["timea"].corr(df["timeb"])

# 	# return df.ix[:, 'timea':'timeb'].corr()

# print("Correlating.")

# # Do some matrix correlations
# spmv_sssp_correlation = spmv_sssp_merge.groupby(["kernel"]).apply(correlate)
# spmv_bfs_correlation = spmv_bfs_merge.groupby(["kernel"]).apply(correlate)
# spmv_pagerank_correlation = spmv_pagerank_merge.groupby(["kernel"]).apply(correlate)

# print(spmv_sssp_correlation)
# print(spmv_bfs_correlation)
# print(spmv_pagerank_correlation)

# spmv_sssp_correlation.to_csv("results/spmv_sssp_corr.csv", sep="\t")
# spmv_bfs_correlation.to_csv("results/spmv_bfs_corr.csv", sep="\t")
# spmv_pagerank_correlation.to_csv("results/spmv_pagerank_corr.csv", sep="\t")

# def plotcorrelation(correlation_series, filename):
# 	correlation_series.plot(kind="bar", figsize=(35, 25))
# 	fig = plt.gcf()
# 	fig.subplots_adjust(bottom=0.4)
# 	plt.legend(loc="lower left")
# 	plt.savefig(filename)
# 	plt.clf()



# merged_correlation = pandas.concat([spmv_sssp_correlation, spmv_bfs_correlation, spmv_pagerank_correlation], axis=1).rename(columns={0:"sssp", 1:"bfs", 2:"pagerank"})

# merged_correlation.plot(kind="bar", figsize=(35, 25))
# fig = plt.gcf()
# fig.subplots_adjust(bottom=0.4)
# plt.legend(loc="lower left")
# plt.savefig("all_kernel_correlations.png")

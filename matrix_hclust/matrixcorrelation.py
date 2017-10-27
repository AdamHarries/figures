import sys
import pymysql
import pandas
import time
import matplotlib.pyplot as plt
plt.style.use('ggplot')

dataset = sys.argv[1] # Get first argument as name of datset file
resfile = dataset.replace(".csv", "_correlation.csv")

print("Loading data from file " + dataset)
rawdata = pandas.DataFrame.from_csv(dataset, sep="\t")


# group the dataset by all four factors that we care about, find the median of each group, and reset the index
print("calculating medians, grouped by [kernel, matrix, global, local]")
medians_kngl = rawdata.groupby(['kernel', 'matrix', 'global', 'local'])[['time']].median().reset_index()

# calculate the best values for each set
print("calculating best of medians, grouped by [kernel, matrix]")
best_km = medians_kngl.groupby(['kernel', 'matrix'])[['time']].min().reset_index()

print("Pivot the table, index='kernel', columns='matrix', values='time'")
pvt = best_km.pivot(index="kernel", columns="matrix", values="time")

print("Dumping to CSV")
pvt.to_csv(resfile, sep='\t')
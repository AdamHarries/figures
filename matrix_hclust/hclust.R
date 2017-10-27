library("corrplot")
library("ggplot2")
library("PerformanceAnalytics")
data <- read.csv("data/spmv_correlation.csv", sep="\t", row.names=1)

data <- data[complete.cases(data), ]


res <- cor(data)

res

# compute 1-correlation for heirachical clustering

invcorr <- 1-res

invcorr

dis <- as.dist(invcorr)

# dis



clusters <- hclust(dis)

png(height=600, width=800, file="matrix_clusters.png")
# chart.Correlation(data, histogram=FALSE, pch=19)

plot(clusters)

# corrplot(res, type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)
# corrplot(res)

dev.off()
     
# ggsave("plot.pdf", width = 25, height = 8, limitsize=FALSE)
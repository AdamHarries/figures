library("corrplot")
library("ggplot2")
library("PerformanceAnalytics")
data <- read.csv("data/spmv_correlation.csv", sep="\t", row.names=1)

data 

res <- cor(data)

res

png(height=6000, width=6000, file="matrix_correlation.png")
chart.Correlation(data, histogram=FALSE, pch=19)

# corrplot(res, type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)
# corrplot(res)

dev.off()
     
# ggsave("plot.pdf", width = 25, height = 8, limitsize=FALSE)
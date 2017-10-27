library(ggplot2)
library(reshape)
library(RColorBrewer)
library(scales)
library(dplyr)

filename <- "./data/comparison.csv"

print(filename)
data <- read.csv(file=filename,sep="\t")

rbPal <- colorRampPalette(c('green','blue'))
ygPal <- colorRampPalette(c('yellow','red'))


dat <- data.frame(data, stringsAsFactors=FALSE)
dat$id <- seq.int(nrow(dat))
# dat$label <- paste(paste(dat$matrix, dat$variance, sep=" --- "),paste(dat$kernel,dat$params, sep=" --- "),sep="\n")
dat$matrix <- reorder(dat$matrix, dat$id)
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
r <- rf(10)
colors<-c("#586E75", "#268BD2", "#DC322F", "#859901")

# dat

# dat$kernel <- factor(dat$kernel, levels = dat$kernel)


# ggplot(dat, aes(reorder(
#       paste(paste(matrix, variance, sep=" --- "),paste(kernel, params, sep=" --- "),sep="\n")
#    , dat$variance, function(x)-length(x)) , ratio, fill=ratio )) + 
# paste(paste(matrix, variance, sep=" --- "),paste(kernel, params, sep=" --- "),sep="\n")
ggplot(dat, aes(
       matrix, time, 
      fill=algorithm ), factor(id)) + 
   # facet_wrap(~algorithm, scales = "free", ncol = 1) + 

   geom_bar(stat="identity", position="dodge") +
   # scale_y_log10() + 
   # geom_hline(aes(yintercept=1.5), color="gray", linetype="dashed") +
   # geom_hline(aes(yintercept=1), color="black", linetype="dashed") +
   # geom_hline(aes(yintercept=0.9), color="gray", linetype="dashed") +
   # geom_text(aes(label=round(time, digits=2), sep="\n", collapse=""), position=position_dodge(width=0.9), vjust=-0.25)+
   
   theme(axis.text.x = element_text(angle = 80, hjust = 1, size=25, , color=c('#708284'))) + 
   theme(axis.text.y = element_text(size=25, color=c('#708284'))) + 
   theme(axis.title.x = element_text(size=35, color=c('#819090'))) +
   theme(axis.title.y = element_text(size=35, color=c('#819090'))) + 
   
   theme(plot.background = element_rect(fill = c('#0B2B36'))) + 
   theme(panel.background = element_rect(fill = c('#073642'))) + 
   ylab("Absolute runtime") +
   xlab("Input graph") +
   theme(legend.position = "right") +
   theme(legend.direction = "vertical") +
   theme(panel.grid = element_blank()) +
   theme(legend.background = element_rect(fill = c('#0B2B36'))) +
   # theme(legend.title = element_text(size=25, color=c('#819090'))) +
   theme(legend.title = element_blank()) +
   theme(legend.text = element_text(size=25, color=c('#819090'))) +
   theme(plot.title = element_blank()) +
   theme(panel.border = element_blank()) +
   scale_fill_manual(values=colors, 1:2)

 
     
ggsave("plot.pdf", width = 25, height = 15, limitsize=FALSE)
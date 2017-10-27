library(ggplot2)
library(reshape)
library(RColorBrewer)
library(scales)
library(dplyr)

filename <- "./results.csv"

print(filename)
data <- read.csv(file=filename,sep="\t")

rbPal <- colorRampPalette(c('green','blue'))
ygPal <- colorRampPalette(c('yellow','red'))


dat <- data.frame(data, stringsAsFactors=FALSE)
dat$id <- seq.int(nrow(dat))
dat$matrix <- reorder(dat$matrix, dat$id)
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
r <- rf(10)
colors<-c("green", "blue", "red", "purple")

ggplot(dat, aes(
       matrix, ratio, 
      fill=c('#B58901') ), factor(id)) + 
   # facet_wrap(~framework, scales = "free", ncol = 1) + 

   geom_bar(stat="identity", position="dodge") +
   # scale_y_log10() + 
   # geom_hline(aes(yintercept=1.5), color="black", linetype="dashed") +
   geom_hline(aes(yintercept=1), color="white", linetype="dashed") +
   # geom_hline(aes(yintercept=0.5), color="black", linetype="dashed") +
   # geom_text(aes(label=round(ratio, digits=2), sep="\n", collapse=""), position=position_dodge(width=0.9), vjust=-0.25)+
   
   theme(axis.text.x = element_text(angle = 80, hjust = 1, size=25, , color=c('#708284'))) + 
   theme(axis.text.y = element_text(size=25, color=c('#708284'))) + 
   theme(axis.title.x = element_text(size=35, color=c('#819090'))) +
   theme(axis.title.y = element_text(size=35, color=c('#819090'))) + 
   
   theme(plot.background = element_rect(fill = c('#0B2B36'))) + 
   theme(panel.background = element_rect(fill = c('#073642'))) + 
   ylab("Performance relative to cuSPARSE") +
   xlab("Input graph") +
   theme(legend.position = "none") +
   theme(plot.title = element_blank()) +
   theme(panel.grid = element_blank()) +
   theme(panel.border = element_blank())
   # scale_fill_manual(name="Framework", values=setNames(colors, 1:2))

 
     
ggsave("plot.pdf", width = 25, height = 15, limitsize=FALSE)
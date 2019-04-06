

setwd("D:\\MAJORBIO\\project\\lidonghua")

setwd("F:\\MAJORBIO\\project\\lidonghua")

library(ggplot2)
library(grid)
library(gridExtra)

pi1<-read.table("1.windowed.pi",sep="\t",head=TRUE)
pi2<-read.table("2.windowed.pi",sep="\t",head=TRUE)
fst<-read.table("1-2.windowed.weir.fst",sep="\t",head=TRUE)

pi1$win<-paste(pi1$CHROM,pi1$BIN_START,pi1$BIN_END)
pi2$win<-paste(pi2$CHROM,pi2$BIN_START,pi2$BIN_END)
fst$win<-paste(fst$CHROM,fst$BIN_START,fst$BIN_END)
win<-intersect(intersect(pi1$win,pi2$win),fst$win)
pi<-data.frame(chr=pi1$CHROM[pi1$win %in% win],pos1=pi1$BIN_START[pi1$win %in% win],pos2=pi1$BIN_END[pi1$win %in% win],pi1=pi1$PI[pi1$win %in% win],pi2=pi2$PI[pi2$win %in% win],fst=fst$WEIGHTED_FST[fst$win %in% win])
pi$theta=pi$pi1/pi$pi2
pi$fst[pi$fst < 0]=0

l1<-pi$fst;l2<-pi$theta;
library(R.matlab)
writeMat("lmpi.mat",l1=l1,l2=l2)

#write.table(file=paste(opt$out,"detail",sep="."),row.names=FALSE,pi);
#write.table(file=paste(opt$out,"detail.select",sep="."),row.names=FALSE,subset(pi,(pi$theta < quantile(pi$theta,probs=0.05) | pi$theta > quantile(pi$theta,probs=0.95)) & pi$fst > quantile(pi$fst,probs=0.95) ));



empty<-ggplot()+theme(panel.background=element_blank())

hist_top<-ggplot()+theme_bw()+
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black",size = 1, 
                                                                     linetype = "solid"),axis.text.x = element_blank(),axis.ticks.x=element_blank(),
        axis.text.y = element_text(size=13,face = "bold", color = "black"))


hist_top<-hist_top+geom_histogram(aes(pi$theta[pi$theta >= quantile(pi$theta,probs=0.95)],y=100*(..count.. /sum(..count..))),colour='green',fill='green',binwidth=0.01)
hist_top<-hist_top+geom_histogram(aes(pi$theta[pi$theta <= quantile(pi$theta,probs=0.05)],y=100*(..count.. /sum(..count..))),colour='blue',fill='blue',binwidth=0.01)
hist_top<-hist_top+geom_histogram(aes(pi$theta[pi$theta > quantile(pi$theta,probs=0.05) & pi$theta < quantile(pi$theta,probs=0.95)],y=100*(..count.. /sum(..count..))),colour='gray',fill='gray',binwidth=0.01)
hist_top<-hist_top+theme(axis.title.x = element_blank(), axis.text.x = element_blank(),axis.ticks.x = element_blank())+theme(panel.background=element_blank())+ylab("Pi Ratio distribution")
hist_top<-hist_top+geom_vline(aes(xintercept=quantile(pi$theta,probs=0.95)),linetype=5,col="black")
hist_top<-hist_top+geom_vline(aes(xintercept=quantile(pi$theta,probs=0.05)),linetype=5,col="black")

hist_top+geom_line(cu)+scale_y_continuous("cu",sec.axis = sec_axis(~ .*1))

hist_top+scale_y_continuous("cu",sec.axis = sec_axis(~ .*1))
                          
a<-pi$theta[pi$theta >= quantile(pi$theta,probs=0.95)]
b<-pi$theta[pi$theta <= quantile(pi$theta,probs=0.05)]
c<-pi$theta[pi$theta > quantile(pi$theta,probs=0.05) & pi$theta < quantile(pi$theta,probs=0.95)]

lmpi<-data.frame(
  sex=factor(rep(c(1, 2,3), c(length(a),length(b),length(c)))),
  weight=c(a,b,c)
)

# Change histogram plot fill colors by groups
par(mar=c(5, 4, 4, 6) + 0.1)
h<-ggplot(lmpi, aes(weight,cu, fill=sex, color=sex)) 

h<-h+theme_bw() + 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(), axis.line = element_line(colour = "black",size = 1, 
  linetype = "solid"),axis.text.x = element_blank(),axis.ticks.x=element_blank(),
  axis.text.y = element_text(size=13,face = "bold", color = "black"))+
  geom_histogram(aes(y=100*(..count.. /sum(..count..))),binwidth = 0.01,position="identity")

h<-h+geom_vline(aes(xintercept=quantile(pi$theta,probs=0.95)),linetype=5,col="black")
h<-h+geom_vline(aes(xintercept=quantile(pi$theta,probs=0.05)),linetype=5,col="black")
h<-h+theme(legend.position="none")
h<-h+labs(element_text(size=15,face = 'bold'))+ylab("Frequency (%)")+xlab("")
h

hist_top+geom_point(aes(pi$theta,y=cumsum(100*(..count.. /sum(..count..)))))+scale_y_continuous(sec.axis = sec_axis(~ .*1))

hist_top+geom_point(mapping = aes(x = weight, y = cu))+scale_y_continuous(sec.axis = sec_axis(~ .*1))

par(mar=c(5, 4, 4, 6) + 0.1)

fre<-hist(pi$theta,breaks = 100770)
frep<-(fre$counts/sum(fre$counts))*100
cu<-c(0,cumsum(fre$counts/sum(fre$counts))*100)

a<-fre$breaks[fre$breaks <= quantile(fre$breaks,probs=0.05)]
b<-fre$breaks[fre$breaks > quantile(fre$breaks,probs=0.05) & fre$breaks < quantile(fre$breaks,probs=0.95)]
c<-fre$breaks[fre$breaks >= quantile(fre$breaks,probs=0.95)]

frepb<-fre$breaks

lmpi<-data.frame(
  sex=factor(rep(c(1, 2,3), c(length(a),length(b),length(c)))),
  weight=c(a,b,c),cu,frepb,frep
)

barplot(frep)
par(new=TRUE)
plot(cu)


h+scale_y_continuous(sec.axis = sec_axis(~.cumsum(100*(..count.. /sum(..count..)))))
                                          
plot(cu, pch=15,  xlab="", ylab="", 
     axes=FALSE, type="b", col="black")
## a little farther out (line=4) to make room for labels
mtext("Cell Density",side=4,col="red",line=4) 
axis(4, col="red",col.axis="red",las=1)


par(new=TRUE)
ggplot(lmpi, aes(x=weight)) +theme_bw()+
  stat_bin(aes(y=cumsum(100*(..count.. /sum(..count..)))),binwidth = 0.01,geom="line",color="green")
  
h+ stat_bin(aes(y=cumsum(100*(..count.. /sum(..count..)))),binwidth = 0.01,geom="line",color="green")

lk<-stat_bin(aes(y=cumsum(100*(..count.. /sum(..count..)))),binwidth = 0.01,geom="line",color="green")



d<-pi$fst[pi$fst >= quantile(pi$fst,probs=0.95)]
e<-pi$fst[pi$fst <= quantile(pi$fst,probs=0.95)]

fi<-hist(pi$fst,breaks =100770 )
fip<-fi$count/sum(fi$count)
fib<-fi$breaks



lmpip<-data.frame(
  sex=factor(rep(c("d", "e"), c(length(e),length(d)))),
  weight=c(d,e)
)

par(mar=c(5, 4, 4, 6) + 0.1)

h<-ggplot(lmpip, aes(x=weight, fill=sex, color=sex)) 
h<-h+theme_bw() + 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),coord_flip()+
        panel.grid.minor = element_blank(),axis.line = element_line(colour = "black",size = 1, 
                                                                     linetype = "solid"),axis.text.x = element_blank(),axis.ticks.x=element_blank(),
        axis.text.y = element_text(size=13,face = "bold", color = "black"))+
  geom_histogram(aes(y=100*(..count.. /sum(..count..))),binwidth = 0.01,position="identity")

h<-h+geom_vline(aes(xintercept=quantile(pi$theta,probs=0.95)),linetype=5,col="black")
h<-h+geom_vline(aes(xintercept=quantile(pi$theta,probs=0.05)),linetype=5,col="black")
h<-h+theme(legend.position="none")
h<-h+labs(element_text(size=15,face = 'bold'))+ylab("Frequency (%)")+xlab("")
h

par(new=TRUE)


hist_right<-ggplot()+theme_bw()
hist_right<-hist_right+geom_histogram(aes(pi$fst[pi$fst >= quantile(pi$fst,probs=0.95)]),colour='orange',fill='orange',binwidth=0.01)
hist_right<-hist_right+geom_histogram(aes(pi$fst[pi$fst <= quantile(pi$fst,probs=0.95)]),colour='gray',fill='gray',binwidth=0.01)
hist_right<-hist_right+theme(axis.title.y=element_blank())+theme(panel.background=element_blank())+coord_flip()+xlab("Fst distribution")
hist_right<-hist_right+geom_vline(aes(xintercept=quantile(pi$fst,probs=0.95)),linetype=5,col="black")+ylab("Fst Count")


hist_right

scatter<-ggplot()+theme_bw()
scatter<-scatter+geom_point(aes(pi$theta[pi$theta > quantile(pi$theta,probs=0.05) & pi$theta < quantile(pi$theta,probs=0.95)],pi$fst[pi$theta > quantile(pi$theta,probs=0.05) & pi$theta < quantile(pi$theta,probs=0.95)]),colour='gray',fill='gray')
scatter<-scatter+geom_point(aes(pi$theta[pi$theta < quantile(pi$theta,probs=0.05) & pi$fst < quantile(pi$fst,probs=0.95)],pi$fst[pi$theta < quantile(pi$theta,probs=0.05) & pi$fst < quantile(pi$fst,probs=0.95)]),colour='gray',fill='gray')
scatter<-scatter+geom_point(aes(pi$theta[pi$theta < quantile(pi$theta,probs=0.05) & pi$fst > quantile(pi$fst,probs=0.95)],pi$fst[pi$theta < quantile(pi$theta,probs=0.05) & pi$fst > quantile(pi$fst,probs=0.95)]),colour='blue',fill='blue')
scatter<-scatter+geom_point(aes(pi$theta[pi$theta > quantile(pi$theta,probs=0.95) & pi$fst < quantile(pi$fst,probs=0.95)],pi$fst[pi$theta > quantile(pi$theta,probs=0.95) & pi$fst < quantile(pi$fst,probs=0.95)]),colour='gray',fill='gray')
scatter<-scatter+geom_point(aes(pi$theta[pi$theta > quantile(pi$theta,probs=0.95) & pi$fst > quantile(pi$fst,probs=0.95)],pi$fst[pi$theta > quantile(pi$theta,probs=0.95) & pi$fst > quantile(pi$fst,probs=0.95)]),colour='green',fill='green')
scatter<-scatter+theme(panel.background=element_blank())+xlab("Pi Ratio Distribution")+ylab("Fst Distribution")
scatter<-scatter+geom_hline(aes(yintercept=quantile(pi$fst,probs=0.95)),linetype=5,col="black")
scatter<-scatter+geom_vline(aes(xintercept=quantile(pi$theta,probs=0.95)),linetype=5,col="black")
scatter<-scatter+geom_vline(aes(xintercept=quantile(pi$theta,probs=0.05)),linetype=5,col="black")


#pdf(paste(opt$out,"pdf",sep="."));
grid.arrange(hist_top, empty, scatter, hist_right, ncol=2,
             nrow=2, widths=c(4,1), heights=c(1,4))

#dev.off()
#png(paste(opt$out,"png",sep="."));
grid.arrange(hist_top, empty, scatter, hist_right, ncol=2, nrow=2,
             widths=c(4,1), heights=c(1,4))
#dev.off()

hist_top+geom_histogram(aes(y=(..count.. /sum(..count..)), 
                            pi$theta[pi$theta >= quantile(pi$theta,probs=0.95)]),colour='green',fill='green',binwidth=0.01)


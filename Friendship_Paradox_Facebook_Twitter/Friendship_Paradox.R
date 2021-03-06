
require(graphics)
library(igraph)
library(ggplot2)
pdf('Desktop/facebook_friend_paradox.pdf')
facebook_graph<-read.graph('Desktop/mln.graphml', format='graphml')
name<-V(facebook_graph)$name
friend_count<-V(facebook_graph)$friend_count
FB_frame<-data.frame(name=name, friend_count=friend_count, color='blue') 
summary(FB_frame)
FB_frame<-na.omit(FB_frame)
summary(FB_frame)
max_friends<-max(FB_frame$friend_count)
summary(max_friends)
class(max_friends)
num_friends<-length(FB_frame$friend_count)
summary(num_friends)
class(num_friends)
dev_f<-as.integer(sd(FB_frame$friend_count)+0.5)
summary(dev_f)
class(dev_f)
mean_f<-as.integer(mean(FB_frame$friend_count)+0.5)
summary(mean_f)
class(mean_f)
median_f<-as.integer(median(FB_frame$friend_count)+0.5)
summary(median_f)
class(median_f)
summary(FB_frame)
temp<-data.frame(name='Michael Nelson', friend_count=num_friends, color='red')
FB_frame<-rbind(FB_frame, temp)
summary(FB_frame)
num_friends<- num_friends + 1
summary(num_friends)
FB_frame$name<-factor(FB_frame$name, levels=FB_frame[order(FB_frame$friend_count), 'name'])
ggplot(FB_frame, aes(x=name, y=friend_count, colour=color)) + geom_bar(stat='identity') + coord_flip()+ theme(axis.text=element_text(size=3.5), legend.position='none')+xlab('Friend Count')+ylab('Friends')+ggtitle('Freindship Paradox')+annotate('text', x= c(90, 85, 80, 75, 70, 65, 60, 55), y=2000, label=c('Mean: ', mean_f,'Median: ', median_f, 'Stan Dev: ',  dev_f, 'Total Friends: ', num_friends-1) )
dev.off()


require(graphics)
pdf('Desktop/Twitter_Friend_Paradox.pdf')
twit_frame<-read.table('Desktop/twitter_follow.txt', sep='\t', header=TRUE)
twit_frame<-na.omit(twit_frame)
twit_frame$color<-'blue'
twit_frame$size<-0.01

max_followers<-max(twit_frame$followers)
summary(max_followers)
class(max_followers)
num_followers<-length(twit_frame$followers)
summary(num_followers)
class(num_followers)
dev_f<-as.integer(sd(twit_frame$followers)+0.5)
summary(dev_f)
class(dev_f)
mean_f<-as.integer(mean(twit_frame$followers)+0.5)
summary(mean_f)
class(mean_f)
median_f<-as.integer(median(twit_frame$followers)+0.5)
summary(median_f)
class(median_f)
summary(twit_frame)
temp<-data.frame(screen_name='phonedude_mln', followers=num_followers, color='red', size=0.5)
twit_frame<-rbind(twit_frame, temp)
summary(twit_frame)
num_followers<- num_followers + 1
summary(num_followers)
twit_frame$screen_name<-factor(twit_frame$screen_name, levels=twit_frame[order(twit_frame$followers), 'screen_name'])

ggplot(twit_frame, aes(x=screen_name, y=followers, colour=color, size=size)) + geom_bar(stat='identity') + coord_flip()+ theme(axis.text=element_text(size=0.01), axis.text.x=element_text(size=10), legend.position='none')+xlab('Followers')+ylab('Follower Count')+ggtitle('Freindship Paradox on Twitter')+annotate('text', x= c(500, 480, 460, 440, 425, 410, 395, 380), y=50000, label=c('Mean: ', mean_f,'Median: ', median_f, 'Stan Dev: ',  dev_f, 'Total Followers: ', num_followers-1) )
dev.off()


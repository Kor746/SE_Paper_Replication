High_rep <- read.csv("/Users/admin/Documents/Queens_Masters_Courses/CISC880/Assignment/Figure_scripts/Fig6/HighRep.csv")
Low_rep <- read.csv("/Users/admin/Documents/Queens_Masters_Courses/CISC880/Assignment/Figure_scripts/Fig6/LowRep.csv")

df <- cbind(High_rep, Low_rep[2:3])
colnames(df)[2:5] <- c("High_reputation", "High_Votes", "Low_reputation", "Low_Votes")



df_sorted <- df[order(df$High_reputation),]

#sample <- as.vector(count(df_sorted$High_reputation)[1])
sample <- unique((df_sorted$High_reputation))


df_avg <- data.frame(Highrep=0, HighVotes=0, LowVotes=0)
for (i in sample){
  temp = df[df$High_reputation == i, ]
  if (nrow(temp) != 0){
    temp_add = data.frame(Highrep=i, HighVotes=mean(temp$High_Votes), LowVotes=mean(temp$Low_Votes))
    df_avg = rbind.data.frame(df_avg, temp_add)
  }else{
    print(i)
    break
  }
}
df_avg = df_avg[2:nrow(df_avg),]


# In total 2646 rows
# sample points
mean_y_high <- c()
mean_y_low <- c()
#sp <- seq(2,5,0.5)
sp <- c(2, 2.1, 2.4, 2.7, 2.9, 3.1, 3.2, 3.3, 3.5, 3.6,  3.8, 4, 4.2, 4.6, 5, 5.2)
for(i in 1:length(sp)-1){
  group = df_avg[df_avg$Highrep > 10^sp[i] & df_avg$Highrep < 10^sp[i+1], ]
  mean_y_high[i] = mean(group$HighVotes)
  mean_y_low[i] = mean(group$LowVotes)
}

plot(sp[2:length(sp)-1], log(mean_y_low), pch=15, lwd=2,xlab = "High-rep reputation", ylab = "Number of votes", xlim=c(1,5),ylim = c(0.6,1.8),type = 'o',axes = FALSE, xaxs ="i", yaxs= "i",cex.lab = 1.2)
axis(side = 2, at = seq(0.6,1.8, by = 0.3), line = NA, tcl = 0.8, lwd = 2, las = 1)
axis(side = 1, at = seq(1,5, by = 1), line = NA, tcl = 0.8, lwd = 2)
axis(side = 3, at = seq(1,5, by= 1), tcl = 0.8, labels = FALSE, lwd = 2)
axis(side = 4, at = seq(0.6,1.8, by = 0.3), tcl = 0.8, labels = FALSE, lwd = 2)

lines(sp[2:length(sp)-1], log(mean_y_low),lwd=2, col = "blue")
points(sp[2:length(sp)-1], log(mean_y_low), lwd=2,col = "blue", pch=16)
lines(sp[2:length(sp)-1], log(mean_y_high), lwd=2,col = "red")
points(sp[2:length(sp)-1], log(mean_y_high), lwd=2,col = "red", pch=15)
box(lty = 'solid',col = 'black',lwd = 4)

legend("topleft", legend=c('High-rep','Low-rep'),
       pch=c(15,16), col=c('red','blue'), box.lwd= 3)

plot(x1,y1, ylim = c(1,3), xlim = c(1,11), type = 'n', xlab = 'Number of answers', ylab = 'Votes per answer', axes = FALSE, xaxs ="i", yaxs= "i",cex.lab = 1.2)
axis(side = 2, at = seq(1,3, by = 0.5), line = NA, tcl = 0.8, lwd = 2, las = 1)
axis(side = 1, at = seq(1,11, by = 2), line = NA, tcl = 0.8, lwd = 2)
axis(side = 3, at = seq(1,11, by= 2), tcl = 0.8, labels = FALSE, lwd = 2)
axis(side = 4, at = seq(1,3, by = 0.5), tcl = 0.8, labels = FALSE, lwd = 2)
lines(x1,y1,col='blue',at = NULL, lwd=3)
box(lty = 'solid',col = 'black',lwd = 4)


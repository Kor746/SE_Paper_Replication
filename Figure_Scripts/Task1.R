require("RMySQL")
# library(beanplot)
# library(magicaxis)
# library(effsize)


con <- dbConnect(MySQL(),
                 user="root",
                 dbname="stackoverflow2010", host="localhost")

        


rs <- dbSendQuery(con,'SELECT p.Id as Question, a.Id as Answer, a.OwnerUserId AS User_Id, TIME_TO_SEC(TIMEDIFF(a.CreationDate,p.CreationDate)) AS AnswerDelay
				FROM Posts as p INNER JOIN AnswerView as a ON p.Id = a.ParentId
                               WHERE p.PostTypeId = 1 
                               AND a.PostTypeId = 2
                               AND p.AnswerCount = 3
                               GROUP BY Question, Answer
                               ORDER BY Question, AnswerDelay ASC;')
on.exit(dbDisconnect(con))
rs2 <- dbSendQuery(con, 'SELECT AccountId, Reputation FROM users;')
df_answer_delay <- fetch(rs, n=-1)
df_user_reputation <- fetch(rs2, n=-1)


rs3 <- dbSendQuery(con, 'Select AnswerCount, AVG(Cast(FavoriteCount AS DECIMAL(4,3))) AS Avg_num_fav
FROM posts
                   Where PostTypeId = 1
                   AND Score = 5
                   GROUP BY AnswerCount;
                   ')
df_fav_num_answer <- fetch(rs3, n=-1)
x <- seq(1,11,by=2)
y1 <- df_fav_num_answer$Avg_num_fav[[2]]
y2 <- df_fav_num_answer$Avg_num_fav[[3]]
y3 <- df_fav_num_answer$Avg_num_fav[[4]]
y4 <- df_fav_num_answer$Avg_num_fav[[5]]
y5 <- df_fav_num_answer$Avg_num_fav[[6]]
y6 <- df_fav_num_answer$Avg_num_fav[[7]]
y <- c(y1,y2,y3,y4,y5,y6)

plot(x,log(y),ylim=c(0,1.2), xlim=c(1,6), type = "n", xlab = "# of answers on question", ylab = "Avg # of favorites")
lines(x,log(y),col="blue",lwd=2)


x1 <- seq(1,11, by=2)
y1 <- c(1.229, 1.313, 1.509, 1.837, 2.348, 3.153)


plot(x1,y1, ylim = c(1,3), xlim = c(1,11), type = 'n', xlab = 'Number of answers', ylab = 'Votes per answer', axes = FALSE, xaxs ="i", yaxs= "i",cex.lab = 1.2)
axis(side = 2, at = seq(1,3, by = 0.5), line = NA, tcl = 0.8, lwd = 2, las = 1)
axis(side = 1, at = seq(1,11, by = 2), line = NA, tcl = 0.8, lwd = 2)
axis(side = 3, at = seq(1,11, by= 2), tcl = 0.8, labels = FALSE, lwd = 2)
axis(side = 4, at = seq(1,3, by = 0.5), tcl = 0.8, labels = FALSE, lwd = 2)
lines(x1,y1,col='blue',at = NULL, lwd=3)
box(lty = 'solid',col = 'black',lwd = 4)

timerank1 <- c(389.0)
timerank_x <- seq(1,5)
plot(timerank_x, timerank1)
lines(timerank_x,timerank1)


plot(x1,y1, ylim = c(1,3), xlim = c(1,11), type = 'l', xlab = 'Number of answers', ylab = 'Votes per answer', axes = FALSE, xaxs ="i", yaxs= "i",cex.lab = 1.2)
axis(side = 2, at = seq(1,3, by = 0.5), line = NA, tcl = 0.8, lwd = 2, las = 1)
axis(side = 1, at = seq(1,11, by = 2), line = NA, tcl = 0.8, lwd = 2)
axis(side = 3, at = seq(1,11, by= 2), tcl = 0.8, labels = FALSE, lwd = 2)
axis(side = 4, at = seq(1,3, by = 0.5), tcl = 0.8, labels = FALSE, lwd = 2)
lines(x1,y1,col='blue',at = NULL, lwd=3)
box(lty = 'solid',col = 'black',lwd = 4)


x <- seq(1,5)
t2 <- c(21.540213,  17.634394)
t3 <- c(22.108197, 19.068070, 15.748479)
t4 <- c(24.399118,20.606933,16.914721,13.492889)
t5 <- c(27.877163,22.290868,20.242009,15.938886,12.409891)

plot(x,t5, type='o',cex=1.5,pch=17,at=NULL, col='yellow',lwd=3,xlab='Time-rank of answer', ylab='Average reputation won per answer', axes = FALSE, xaxs ="i", yaxs="i", cex.lab = 1.2, xlim=c(1,5), ylim=c(9,30))
points(seq(1,2),t2, cex=1.5,type= 'o', col='red', at = NULL,lwd=3,pch=16)
points(seq(1,3),t3, cex=2,type= 'o', col='blue', at = NULL,lwd=3,pch=18)
points(seq(1,4),t4, cex=1.5,type= 'o', col='green', at = NULL,lwd=3, pch=15)
axis(side = 1, at = seq(1,5, by = 1), line = NA, tcl = 0.8, lwd = 2)
axis(side = 2, at = seq(10,30, by = 5), line = NA, tcl = 0.8, lwd = 2,las=1)
axis(side = 3, at = seq(1,5, by = 1), tcl = 0.8, line = NA,labels = FALSE, lwd = 2)
axis(side = 4, at = seq(10,30, by = 5), tcl = 0.8, line = NA,labels = FALSE, lwd = 2)
box(lty = 'solid', col = 'black', lwd = 4)

legend("topright", legend=c('2 ans','3 ans','4 ans','5 ans'), mar(mgp=c(1,2)),
       pch=c(16,18,15,17), col=c('red','blue','green','yellow'), box.lwd= par('lwd'))


df_new <- log(df_avg)
df_avg %>%
  group_by(Rating) %>%      # group your data based on the variable Rating
  arrange(desc(One_Year_Return)) %>%     # order in descending order the variable One_Year_Return
  slice(1)



# acuracyQuertile = c(73, 74, 74, 75)
# baselineAcuracy = c(59, 63, 65, 68)
# 
# aucQuertile = c(82, 83, 84, 85)
# baselineQuertile = c(60, 61, 64, 66)

# acuracyHalf = c(63, 64, 66, 65)
# acuracyHalfBaseline = c(57, 59, 62, 63)
# 
# aucHalf = c(71, 72, 73, 73)
# aucHalfBaseline = c(57, 58, 60, 61)

#for 9a1
par(mar=c(3,5,3,1))
 data <- structure(list(W= c(59, 73), X=c(63, 74), Y=c(65, 74), Z = c(68,75)), .Names = c("1 hour", "3 hours", "1 day", "3 days"), class = "data.frame", row.names = c(NA, -2L))
 colours <- c("red", "gold")
 
 barplot(xpd=FALSE,axes=FALSE,las=1,tcl=0.6,as.matrix(data), main="", width = c(0.5,0.5), ylab = "Accuracy", cex.lab = 1.5, cex.main = 1, beside=TRUE, col=colours, ylim=c(50,78))
 axis(side=2,tcl=0.6,las=1,seq(50,78, by=4))
 legend("topleft", legend= c("Baseline","S8"), pch=c(15,15), col=colours, box.lwd=2,cex=0.8)
 box(lty = 'solid',col = 'black',lwd = 4)
 
#for 9a2
 data <- structure(list(W= c(60, 82), X=c(61, 83), Y=c(64, 84), Z = c(66,85)), .Names = c("1 hour", "3 hours", "1 day", "3 days"),class = "data.frame", row.names = c(NA, -2L))
 colours <- c("red", "gold")
 data <- as.matrix(data)/100
 barplot(data,main="",xpd=FALSE,width = c(0.5,0.5), ylab = "AUC", cex.lab = 1.5, cex.main = 1, beside=TRUE, col=colours, axes = FALSE, ylim=c(0.50,0.90),tcl=0.6,las=1)
 axis(side=2,tcl=0.6,las=1,seq(0.50,0.90, by=0.05))
 legend('topleft', legend=c('Baseline','S8'), cex=0.8,
        pch=c(15,15),col=colours,box.lwd=2)
 box(lty = 'solid',col = 'black',lwd = 4)
# legend("topleft", c("Baseline","S8"), cex=1.3, bty="n", fill=colours)

#for 9b1
 data <- structure(list(W= c(57, 63), X=c(59, 64), Y=c(62, 66), Z = c(63, 65)), .Names = c("1 hour", "3 hours", "1 day", "3 days"), class = "data.frame", row.names = c(NA, -2L))
 colours <- c("red", "gold")
 data <- as.matrix(data)
 
 barplot(data,main="", xpd=FALSE,width = c(0.5,0.5),axes=FALSE, ylab = "Accuracy", cex.lab = 1.5, cex.main = 1, beside=TRUE, col=colours, ylim=c(50,68),tcl=0.6,las=1)
 axis(side=2, tcl=0.6, las=1, seq(50,68, by=3))
 legend('topleft', c("Baseline","S8"), cex=0.8, pch=c(15,15),col=colours,box.lwd=2)
 box(lty = 'solid',col = 'black',lwd = 4) 
#for 9b2
data <- structure(list(W= c(57, 71), X=c(58, 72), Y=c(60, 73), Z = c(61,73)), .Names = c("1 hour", "3 hours", "1 day", "3 days"), class = "data.frame", row.names = c(NA, -2L))
colours <- c("red", "gold")
data <- as.matrix(data)/100
barplot(axes=FALSE,xpd=FALSE,data, main="", width = c(0.5,0.5), ylab = "AUC", cex.lab = 1.5, cex.main = 1, beside=TRUE, col=colours, ylim=c(0.50,0.74))
axis(side=2, tcl=0.6, las=1, seq(0.5,0.74, by=0.04))
legend("topleft", c("Baseline","S8"), cex=0.8, pch=c(15,15),col=colours,box.lwd=2)
box(lty = 'solid',col = 'black',lwd = 4) 


##
if ("car" %in% installed.packages() == FALSE) {
  install.packages("car")
}

library(car)

Firms <- Ornstein
##

View(Firms)

print(nrow(Firms))
print(ncol(Firms))
print(colnames(Firms))

sum(is.na.data.frame(Firms)) ## => Нет пустых записей

subset.data.frame(Firms, assets >= 10000 & assets <= 20000)
subset.data.frame(Firms, interlocks <= 30)
subset.data.frame(Firms, nation == "CAN" & sector == "TRN")

Firms$log_assets <- log(Firms$assets);

plot(Firms$log_assets, 
     type = "o", 
     pch = 1, 
     cex = I(0.1), 
     col = "red")
# 7. пропущенных значений нет
library(foreign)
write.dta(Firms,"Firms.dta")

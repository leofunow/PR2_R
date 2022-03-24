install.packages(c("dplyr", "readr", "stringr"))

data <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")

head(data)
View(data)
str(data)

COVID_19_metadata <- data[,1:4]
# Добавим столбцы к датафрейму

COVID_19_metadata$Country.Province <- paste(COVID_19_metadata$Country.Region, 
                                            COVID_19_metadata$Province.State,
                                            sep = ":")
COVID_19_metadata$Sum_ills <- rowSums(data[, -(1:4)])
COVID_19_metadata$Mean_ills <- apply(X = data[, -(1:4)], # Данные
                                     MARGIN = 1,            # Измерения
                                     FUN = mean)            # Функция
COVID_19_metadata$Std_ills <- apply(X = data[, -(1:4)], # Данные
                                    MARGIN = 1,            # Измерения
                                    FUN = sd)            # Функция
COVID_19_metadata <- COVID_19_metadata[, c(5,3,4,6:8)]
View(COVID_19_metadata)


COVID19_dates <- data[,5:796]
COVID19_dates$Country.Province <- COVID_19_metadata$Country.Province
COVID19_dates <- COVID19_dates[, c(793, 2:792)]
COVID19_dates <- t(COVID19_dates)

str(COVID19_dates)
colnames(COVID19_dates) <- COVID19_dates[1,]
COVID19_dates <- COVID19_dates[2:792,]

temp <- as.Date(substring(rownames(COVID19_dates),2),"%m.%d.%y")
format(temp, "%Y-%m-%d")
rownames(COVID19_dates) <- as.character(temp)
rownames(COVID19_dates)
View(COVID19_dates)

dir.create("data_output", showWarnings = FALSE)

write.csv(COVID_19_metadata,"data_output/data_output.csv")

install.packages('xlsx')
library(xlsx)
write.xlsx(COVID_19_metadata,"data_output/data_output.xlsx")

write.table(COVID_19_metadata,"data_output/data_output.txt")

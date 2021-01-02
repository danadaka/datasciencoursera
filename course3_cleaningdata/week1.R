library(data.table)
library(openxlsx)
library(XML)

##------------------------------------------------------------------------------

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(url = fileurl, 
              destfile = "./data/uscommunities.csv")

uscom <- fread("./data/uscommunities.csv")

uscom24 <- uscom[VAL==24]

uscom24[, .N]
uscom[, .N, by = VAL]

DT <- uscom

system.time(mean(DT[DT$SEX==1,]$wgtp15))

##------------------------------------------------------------------------------

f <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

download.file(url = f,
              destfile = "./data/naturalgas.xlsx")

dat <- read.xlsx("./data/naturalgas.xlsx", rows = 18:23, cols = 7:15, )

sum(dat$Zip*dat$Ext,na.rm=T)

##------------------------------------------------------------------------------
  
f3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

rest <- xmlTreeParse(sub("s", "", f3), useInternal = TRUE)

rootNode <- xmlRoot(rest)

zips <- 
  xpathSApply(rootNode, "//zipcode", xmlValue)

length(zips[zips == 21231])


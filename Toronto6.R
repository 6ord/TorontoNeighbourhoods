# Review big dataset as whole. will need to transpose, make several tables, since all categories merged together
# Individual review of Topics in Categories
# Is heirarchy Category, Topic, Characteristic - or - Category, Characteristic, Topic?
# Individual review of Characteristics in Topics
# Concise. Too many columns! What's not done by CREA? Labour
# 
source("Toronto6_gw.R")

# Toronto6_Groundwork loads data and functions

# rm(list=ls())

#QUick check count of unique values under heading
col.hierarchy(profiles2016$Category,profiles2016$Topic)
col.subnames(profiles2016$Topic,profiles2016$Characteristic,"Occupation - National Occupational Classification (NOC) 2016")

test <- t(profiles2016[which(profiles2016$Category=="Labour"),])
View(test)
write.csv(test, "test.csv",row.names = FALSE)

#isolate Labour Category
LabourData <- profiles2016[which(profiles2016$Category=="Labour"),]
#
# OR
# 
# LabourData <- split(profiles2016,profiles2016$Category)$Labour
#
# Remove index, Category, Data Source, Toronto total
rownames(LabourData) <- c()
LabourData$Category <- NULL
LabourData$Data.Source <- NULL
LabourData$City.of.Toronto <- NULL

#breakout Topic data frames
LabourStatus   <- LabourData[which(LabourData$Topic==as.character(unique(LabourData$Topic)[1])),]
LabourActivity <- LabourData[which(LabourData$Topic==as.character(unique(LabourData$Topic)[2])),]
WorkerClass    <- LabourData[which(LabourData$Topic==as.character(unique(LabourData$Topic)[3])),]
WorkerOccup    <- LabourData[which(LabourData$Topic==as.character(unique(LabourData$Topic)[4])),]
LabourIndustry <- LabourData[which(LabourData$Topic==as.character(unique(LabourData$Topic)[5])),]
LabourPlace    <- LabourData[which(LabourData$Topic==as.character(unique(LabourData$Topic)[6])),]

LabourTables <- list(LabourStatus,
                LabourActivity,
                WorkerClass,
                WorkerOccup,
                LabourIndustry,
                LabourPlace)
#Cleanup
rm(LabourStatus,
   LabourActivity,
   WorkerClass,
   WorkerOccup,
   LabourIndustry,
   LabourPlace)

# OR split, however element names not friendly. Some Topic names are very long.
# Prefer above method
# 
# LabourTables <- split(LabourData,LabourData$Topic)
# 
# However above gave a List of 49 elements. Expecting 6.

class(LabourTables)

#moved to lapply below
#rownames(LabourTables) <- c()

View(LabourTables[[2]])
class(LabourTables[[2]]$Agincourt.North)

LabourTables <- lapply(LabourTables, function(x){
                                      x["Topic"] <- NULL
                                      rownames(x) <- c()
                                      x}
                      )

#Transpose!!
t.LabourTables <- lapply(LabourTables,t)

View(t.LabourTables[[2]])


# Test retrieving col/row values, move logic into lapply
# as.character(t.LabourTables[[1]][1,])
# test <- cbind("nhoods"=as.character(rownames(t.LabourTables[[1]])),t.LabourTables[[1]])
t.LabourTables <- lapply(t.LabourTables, function(x){
                                      fields <- as.character(x[1,])
                                      colnames(x) <- fields
                                      x <- cbind("neighbourhood"=as.character(rownames(x)),x)
                                      x <- x[-1,]
                                      rownames(x) <- c()
                                      x}
                        )

#Export csv Files
myTableNames <- c("LabourStatus",
                  "LabourActivity",
                  "WorkerClass",
                  "WorkerOccup",
                  "LabourIndustry",
                  "LabourPlace")

for(i in 1:length(t.LabourTables)){
  write.csv(t.LabourTables[[i]],paste(myTableNames[i],".csv",sep=""),row.names = FALSE)
}

# listname$element[column]
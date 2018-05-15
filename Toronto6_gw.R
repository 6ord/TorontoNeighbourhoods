
rm(list=ls())
print("Starting...")
#Load Files
orig.profiles2016 <- read.csv("C:/Users/trunk/Downloads/BigData/Toronto_Project/2016_neighbourhood_profiles.csv"
                         ,stringsAsFactors = FALSE
                         )

profiles2016 <- orig.profiles2016

for(i in 1:nrow(profiles2016)){
  for(j in 5:ncol(profiles2016)){
    if(grepl('\\d\\,\\d{3}',profiles2016[i,j])){
      profiles2016[i,j] <- as.numeric(gsub(',','',profiles2016[i,j]))
    } else if(grepl('\\d\\%$',profiles2016[i,j])){
      profiles2016[i,j] <- as.numeric(gsub('%','',profiles2016[i,j]))/100
    } else
      profiles2016[i,j] <- as.numeric(profiles2016[i,j])
  }
}

rm(i)
rm(j)

#Build Functions
col.hierarchy <- function (x,y){
  # Output number of subcategories per category
  # x is parent category, y is child
  # example: list number of subcategories y per category x
  subs <- NULL
  for (i in 1:length(unique(x))){
    subs[i] <- length(unique(y[x==unique(as.character(x))[i]]))
  }
  data.frame(Category=as.character(unique(x)),numSubcategories=subs)
}

col.subnames <- function (x,y,z){
  # Output subcategories for given category
  # x is category, y is desired subcategories to be listed, z is which category
  # example: list subcategory y's where Category x equals z
  unique(as.character(y)[x==z])
}

print("Done")




# f.test <- as.factor(c('1,234,567','3.08%')) 
# grepl('\\d\\,\\d{3}',f.test[1])
# grepl('\\d\\%$',f.test[2])
# 
# View(profiles2016)
# View(m.profiles2016)
# str(m.profiles2016)
# 
# as.numeric(gsub('%','',as.character(f.test[2])))/100

# prettyNum('1,000,000',big.mark=',')

# for(i in 1:nrow(profiles2016)){
#   for(j in 5:ncol(profiles2016)){
#     if(grepl('\\d\\,\\d{3}',profiles2016[i,j])){
#       profiles2016[i,j] <- as.numeric(gsub(',','',profiles2016[i,j]))
#     } else if(grepl('\\d\\%$',profiles2016[i,j])){
#       profiles2016[i,j] <- as.numeric(gsub('%','',profiles2016[i,j]))/100
#     } else
#       profiles2016[i,j] <- as.numeric(profiles2016[i,j])
#   }
# }
# 
# 
# 
# for(i in 1:nrow(profiles2016)){
#   for(j in 5:ncol(profiles2016)){
#     if(grepl('\\d\\,\\d{3}',as.character(profiles2016[i,j]))){
#       profiles2016[i,j] <- as.numeric(gsub(',','',as.character(profiles2016[i,j])))
#     } else if(grepl('\\d\\%$','3.08%',as.character(profiles2016[i,j]))){
#       profiles2016[i,j] <- as.numeric(gsub('%','',as.character(profiles2016[i,j])))/100
#     } else
#       profiles2016[i,j] <- as.numeric(profiles2016[i,j])
#   }
# }

#View(profiles2016)

# data.frame(Categories = length(unique(profiles2016$Category))
#            ,Topics = length(unique(profiles2016$Topic))
#            ,DataSources = length(unique(profiles2016$Data.Source))
#            ,Characteristics = length(unique(profiles2016$Characteristic))
#       )

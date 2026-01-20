# RUN lib_import.R first
### ------------- importing velocity data ----------------------------------------------- BEGIN
print("reading velocities")
print("* * * * * * * Part 1 * * * * * * * *")
velocity_data_path <- "../data/part1/velocity"

# G ------------------------------------------
file.name <- 'G.xlsx'

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="7m")
tmp.df["depth"] <- 7
df.G <- tmp.df

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="10m")
tmp.df["depth"] <- 10
df.G <- rbind.fill(df.G,tmp.df)

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="15m")
tmp.df["depth"] <- 15
df.G <- rbind.fill(df.G,tmp.df)

### data on velocity updated 20.06.2023 ###
tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="25m")
tmp.df["depth"] <- 25
df.G <- rbind.fill(df.G,tmp.df)


df.G["point"] <- "GF"
df.G["kelp"] <- FALSE
# H ------------------------------------------
file.name <- 'H.xlsx'

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="7m")
tmp.df["depth"] <- 7
df.H <- tmp.df

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="10m")
tmp.df["depth"] <- 10
df.H <- rbind.fill(df.H,tmp.df)

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="15m")
tmp.df["depth"] <- 15
df.H <- rbind.fill(df.H,tmp.df)

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="25m")
tmp.df["depth"] <- 25
df.H <- rbind.fill(df.H,tmp.df)

df.H["point"] <- "H"
df.H["kelp"] <- FALSE

# S1 ------------------------------------------
file.name <- 'S1.xlsx'

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="7m")
tmp.df["depth"] <- 7
df.S1 <- tmp.df

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="10m")
tmp.df["depth"] <- 10
df.S1 <- rbind.fill(df.S1,tmp.df)

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="15m")
tmp.df["depth"] <- 15
df.S1 <- rbind.fill(df.S1,tmp.df)

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="25m")
tmp.df["depth"] <- 25
df.S1 <- rbind.fill(df.S1,tmp.df)

df.S1["point"] <- "S1"
df.S1["kelp"] <- (df.S1$depth < 20) # at depth 20+ there are no kelps
# S2 ------------------------------------------
file.name <- 'S2.xlsx'

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="7m")
tmp.df["depth"] <- 7
df.S2 <- tmp.df

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="10m")
tmp.df["depth"] <- 10
df.S2 <- rbind.fill(df.S2,tmp.df)

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="15m")
tmp.df["depth"] <- 15
df.S2 <- rbind.fill(df.S2,tmp.df)

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="25m")
tmp.df["depth"] <- 25
df.S2 <- rbind.fill(df.S2,tmp.df)

df.S2["point"] <- "S2"
df.S2["kelp"] <- (df.S2$depth < 10) # at depth 20+ there are no kelps


# creating final velocity data frame
df.v <- bind_rows(df.G,df.H,df.S1,df.S2)
rm(list=c('df.G','df.H','df.S1','df.S2','tmp.df'))

# data adjustement
colnames_velocity_original <- colnames(df.v)
colnames_velocity_new <- c("date_time","speed","heading","velocityN","velocityE","depth","point","kelp")
colnames(df.v) <- colnames_velocity_new

df.v["date_time"] <- as.POSIXct(df.v[["date_time"]] , origin="1899-12-30", tz="GMT",format="%m/%d/%Y %H:%M")

df.v["depth"] <- as.factor(df.v[["depth"]])
df.v["point"] <- as.factor(df.v[["point"]])
df.v["kelp"] <- as.factor(df.v[["kelp"]])

print("cleaning velocity dataframe")
#warning("not removing S1 depth 15 - it was UPDATED 20.06.2023")
df.v <-  df.v[df.v$speed<200 & # remove all obs with recorded speed >= 200cm/s
              !(df.v$point=="S1" & df.v$depth=='15') &  
              !(df.v$point=="S1" & df.v$speed>50),]


print("* * * * * * * Part 2 * * * * * * * *")
# rm(list=c('velocity_data_path'))
velocity_data_path2 <- "../data/part2/velocity2"

# G ------------------------------------------
file.name <- 'G.xlsx'

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path2,file.name,sep="/"),sheet="7m")
tmp.df["depth"] <- 7
df.G <- tmp.df

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path2,file.name,sep="/"),sheet="10m")
tmp.df["depth"] <- 10
df.G <- rbind.fill(df.G,tmp.df)

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path2,file.name,sep="/"),sheet="15m")
tmp.df["depth"] <- 15
df.G <- rbind.fill(df.G,tmp.df)

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path2,file.name,sep="/"),sheet="25m")
tmp.df["depth"] <- 25
df.G <- rbind.fill(df.G,tmp.df)


df.G["point"] <- "GF"
df.G["kelp"] <- FALSE
# H ------------------------------------------
file.name <- 'H.xlsx'

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path2,file.name,sep="/"),sheet="7m")
tmp.df["depth"] <- 7
df.H <- tmp.df

# no data for H10
#tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="10m")
#tmp.df["depth"] <- 10
#df.H <- rbind.fill(df.H,tmp.df)

# no data for H15
#tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path,file.name,sep="/"),sheet="15m")
#tmp.df["depth"] <- 15
#df.H <- rbind.fill(df.H,tmp.df)

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path2,file.name,sep="/"),sheet="25m")
tmp.df["depth"] <- 25
df.H <- rbind.fill(df.H,tmp.df)

df.H["point"] <- "H"
df.H["kelp"] <- FALSE

# S1 ------------------------------------------
file.name <- 'S1.xlsx'

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path2,file.name,sep="/"),sheet="7m")
tmp.df["depth"] <- 7
df.S1 <- tmp.df

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path2,file.name,sep="/"),sheet="10m")
tmp.df["depth"] <- 10
df.S1 <- rbind.fill(df.S1,tmp.df)

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path2,file.name,sep="/"),sheet="15m")
tmp.df["depth"] <- 15
df.S1 <- rbind.fill(df.S1,tmp.df)

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path2,file.name,sep="/"),sheet="25m")
tmp.df["depth"] <- 25
df.S1 <- rbind.fill(df.S1,tmp.df)

df.S1["point"] <- "S1"
df.S1["kelp"] <- (df.S1$depth < 20) # at depth 20+ there are no kelps
# S2 ------------------------------------------
file.name <- 'S2.xlsx'

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path2,file.name,sep="/"),sheet="7m")
tmp.df["depth"] <- 7
df.S2 <- tmp.df

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path2,file.name,sep="/"),sheet="10m")
tmp.df["depth"] <- 10
df.S2 <- rbind.fill(df.S2,tmp.df)

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path2,file.name,sep="/"),sheet="15m")
tmp.df["depth"] <- 15
df.S2 <- rbind.fill(df.S2,tmp.df)

tmp.df <-  openxlsx::read.xlsx(paste(velocity_data_path2,file.name,sep="/"),sheet="25m")
tmp.df["depth"] <- 25
df.S2 <- rbind.fill(df.S2,tmp.df)

df.S2["point"] <- "S2"
df.S2["kelp"] <- (df.S2$depth < 10) # at depth 20+ there are no kelps

# gathering data into one dataset
df.v2 <- bind_rows(df.G,df.H,df.S1,df.S2)
rm(list=c('df.G','df.H','df.S1','df.S2','tmp.df'))

colnames_velocity_original2 <- colnames(df.v2)
colnames_velocity_new2 <- c("date_time","speed","heading","velocityN","velocityE","depth","point","kelp")
colnames(df.v2) <- colnames_velocity_new2

# creating POSIX date time format - this data source has different data format than the first one
df.v2["date_time"] <-  lubridate::round_date( # round to seconds to avoid HH:04:59 instead HH:05:00
                                as.POSIXct(df.v2[["date_time"]]*24.*3600.,origin="1899-12-30",tz = "UTC"))
df.v2["depth"] <- as.factor(df.v2[["depth"]])
df.v2["point"] <- as.factor(df.v2[["point"]])
df.v2["kelp"] <- as.factor(df.v2[["kelp"]])

print("removing imroper values form v2")
df.v2[df.v2$point=="GF" & df.v2$depth==25,"speed"] <- NA


print("creating month-year factor for df.v and df.v2")

# creating month-year factor for df.velocity
# date entity spans
mmin <- 1
mmax <- 12

ymin <- 2021
ymax <- 2023

wmin <- 1
wmax <- 53

# creating the order vector of the variable
m.yr.order <- c() # contains the month and the year for example: Jan 21 or Feb 22, etc
w.yr.order <- c() # contains the week of the year (iso) and the year for example: W23-21, W1-22, etc.
for (y in ymin:ymax){
    for (m in mmin:mmax){
       m.yr.order <- c(m.yr.order,paste(substr(month.name[m],1,3),substr(as.character(y),3,4),sep=""))
    }
    
    for (w in wmin:wmax){
       w.yr.order <- c(w.yr.order,paste("W",w,"-",substr(as.character(y),3,4),sep=""))
    }
}

# --------- df.v -----------------
mth <- month(df.v$date_time)
yr <- year(df.v$date_time)
wk <- week(df.v$date_time)
 
m.yr.factor <- factor(paste(substr(month.name[mth],1,3),substr(as.character(yr),3,4),sep=""),levels=m.yr.order,ordered=TRUE)
w.yr.factor <- factor(paste("W",wk,"-",substr(as.character(yr),3,4),sep=""),levels=w.yr.order,ordered=TRUE)

df.v <- cbind(cbind(df.v,m.yr.factor),w.yr.factor)
rm(list=c('mth','yr','wk','m.yr.factor','w.yr.factor'))
# --------- df.v2 -----------------
mth2 <- month(df.v2$date_time)
yr2 <- year(df.v2$date_time)
wk2 <- week(df.v2$date_time)

m.yr.factor2 <- factor(paste(substr(month.name[mth2],1,3),substr(as.character(yr2),3,4),sep=""),levels=m.yr.order,ordered=TRUE)
w.yr.factor2 <- factor(paste("W",wk2,"-",substr(as.character(yr2),3,4),sep=""),levels=w.yr.order,ordered=TRUE)

df.v2 <- cbind(cbind(df.v2,m.yr.factor2),w.yr.factor2)
colnames(df.v2) <- colnames(df.v)

rm(list=c('mth2','yr2','wk2','m.yr.factor2','w.yr.factor2'))

print("Finished creating df.v and df.v2 data frames.")

print("Creatng merged data frame: df.v.merged")

df.limit.dates <- df.v %>% group_by(point,depth) %>% summarize(max(date_time))

df.tmp <- df.v
for (i in 1:nrow(df.limit.dates)){
   pt <- df.limit.dates[[i,"point"]]
   dpth <- df.limit.dates[[i,"depth"]]
   max.date <-  df.limit.dates[[i,"max(date_time)"]]
    
   condition <- df.v2$point==pt & df.v2$depth==dpth & df.v2$date_time > max.date
   df.tmp <- rbind(df.tmp,df.v2[condition,]) 
}
df.v.merged <- df.tmp
df.tmp <- NULL


# removing improper velociy values
df.v.merged[df.v.merged$point=="GF" & df.v.merged$depth==25 & df.v.merged$date_time < as.POSIXct("2021-08-16 00:00:01 UTC",origin="1899-12-30",tz = "UTC"),"speed"] <- NA
df.v.merged[df.v.merged$point=="GF" & df.v.merged$depth==25 & df.v.merged$m.yr.factor=="Aug22","speed"] <- NA


df.v.merged[df.v.merged$point=="GF" & df.v.merged$depth==25 &  df.v.merged$date_time > max(df.v$date_time),"velocityN"] <- NA
df.v.merged[df.v.merged$point=="GF" & df.v.merged$depth==25 & df.v.merged$date_time < as.POSIXct("2021-08-16 00:00:01 UTC",origin="1899-12-30",tz = "UTC"),"velocityN"] <- NA
df.v.merged[abs(df.v.merged$velocityN) > 125 & !is.na(df.v.merged$velocityN),"velocityN"] <- NA 
df.v.merged[abs(df.v.merged$velocityE) > 125 & !is.na(df.v.merged$velocityE),"velocityE"] <- NA 
#df.v.merged[df.v.merged$point=="GF" & df.v.merged$depth==25 ,"velocityN"] <- NA

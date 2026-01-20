# RUN lib_import.R first
### ------------- importing chemical and physical data ----------------------------------------------- BEGIN
print("importing physical and chemical data")
print("* * * * * * * Part 1 * * * * * * * *")
data_path <- "../data/part1/fluorymetr wyniki"

### ------------- importing G data -----------------------------------------------
file.name <- 'G_no kelps_results_updated.xlsx'

# 7m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="7m_G")
tmp.df["depth"] <- 7
df.G <- tmp.df
# 10m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="10m_G")
tmp.df["depth"] <- 10
df.G <- rbind.fill(df.G,tmp.df)
# 15m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="15m_G")
tmp.df["depth"] <- 15
df.G <- rbind.fill(df.G,tmp.df)
# 20m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="20m_G")
tmp.df["depth"] <- 20
df.G <- rbind.fill(df.G,tmp.df)
# 25m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="25m_G")
tmp.df["depth"] <- 25
df.G <- rbind.fill(df.G,tmp.df)

# data adjustment

df.G["kelp"] <- FALSE # no kelp at all depths
df.G["point"] <- "GF"

### ------------- importing H data -----------------------------------------------
file.name <- 'H_no kelps_results_updated.xlsx'
# 7m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="7m_H")
tmp.df["depth"] <- 7
df.H <- tmp.df
# 10m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="10m_H")
tmp.df["depth"] <- 10
df.H <- rbind.fill(df.H,tmp.df)
# 15m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="15m_H")
tmp.df["depth"] <- 15
df.H <- rbind.fill(df.H,tmp.df)
# 20m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="20m_H")
tmp.df["depth"] <- 20
df.H <- rbind.fill(df.H,tmp.df)
# 25m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="25m_H")
tmp.df["depth"] <- 25
df.H <- rbind.fill(df.H,tmp.df)

# data adjustment
df.H["kelp"] <- FALSE # no kelp at all depths
df.H["point"] <- "H"

### ------------- importing S1 data -----------------------------------------------
file.name <- 'S1_kelps_results_updated.xlsx'
# 7m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="7m_S1")
tmp.df["depth"] <- 7
df.S1 <- tmp.df
# 10m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="10m_S1")
tmp.df["depth"] <- 10
df.S1 <- rbind.fill(df.S1,tmp.df)
# 15m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="15m_S1")
tmp.df["depth"] <- 15
df.S1 <- rbind.fill(df.S1,tmp.df)
# 20m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="20m_S1")
tmp.df["depth"] <- 20
df.S1 <- rbind.fill(df.S1,tmp.df)
# 25m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="25m_S1")
tmp.df["depth"] <- 25
df.S1 <- rbind.fill(df.S1,tmp.df)

# data adjustment
df.S1["kelp"] <- (df.S1$depth < 15) # at depth 15+ there are no kelps
df.S1["point"] <- "S1"
### ------------- importing S2 data -----------------------------------------------
file.name <- 'S2_kelps_results_updated.xlsx'
# 7m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="7m_S2")
tmp.df["depth"] <- 7
df.S2 <- tmp.df
# 10m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="10m_S2")
tmp.df["depth"] <- 10
df.S2 <- rbind.fill(df.S2,tmp.df)
# 15m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="15m_S2")
tmp.df["depth"] <- 15
df.S2 <- rbind.fill(df.S2,tmp.df)
# 20m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="20m_S2")
tmp.df["depth"] <- 20
df.S2 <- rbind.fill(df.S2,tmp.df)
# 25m
tmp.df <-  openxlsx::read.xlsx(paste(data_path,file.name,sep="/"),sheet="25m_S2")
tmp.df["depth"] <- 25
df.S2 <- rbind.fill(df.S2,tmp.df)

# data adjustment
df.S2["kelp"] <- (df.S2$depth < 10) # at depth 10+ there are no kelps
df.S2["point"] <- "S2"
### ------------- changing column names -----------------------------------------------
# short column names

# Lp.	Date Time, GMT+02:00	ES [μS/cm]	Temp [°C]	Light intensity [Lux]	O2 [mg/L]	pH	Water level [kPa]	Chlorophyll a [ppb]	Red Chl [RFUB]	Turbidity [NTU]	upd.Temp [°C]	DO [%]	upd.Chlorophyll a [ppb]	upd.Red Chl [RFUB]	upd.Turbidity [NTU]	upd.pH	upd.Light intensity [Lux]	Salinity [ppm]	Sensor depth [m]

colnames_new <- c("ix","date_time","ec","temp","light","oxygen","pH","water_level",
                  "chlorophyll.a","chlorophyll.red","turbidity",
                  "temp.upd","do","chlorophyll.a.upd","chlorophyll.red.upd","turbidity.upd",
                  "pH.upd","light.upd","salinity.upd","sensor.depth",
                  "depth","kelp","point")

feat_labels <- c(NA,"date time","EC [μS/cm]","T [°C]","Light [Lux]","Oxygen [mg/L]","pH [-]",NA,
                  NA,NA,NA,NA,NA,"Chlorophyll A [ppb]","Chlorophyll red [RFUB]","Turbidity [NTU]",
                  "pH [-]","Light [Lux]","Salinity [ppm]","Sensor depth [m]",NA,NA,NA)

# stroing the original colanmes
colnames.G <- colnames(df.G)
colnames.H <- colnames(df.H)
colnames.S1 <- colnames(df.S1)
colnames.S2 <- colnames(df.S2)

# changing to simple column names

colnames(df.G) <- colnames_new
colnames(df.H) <- colnames_new
colnames(df.S1) <- colnames_new
colnames(df.S2) <- colnames_new



### ------------- binding all to one df -----------------------------------------------
df.all <- bind_rows(df.G,df.H,df.S1,df.S2)
rm(list=c('df.G','df.H','df.S1','df.S2','tmp.df'))

# final data adjustement

df.all["date_time"] <- as.POSIXct(df.all[["date_time"]] * (60*60*24) , origin="1899-12-30", tz="GMT") # adjust the date from double to date format

df.all["point"] <- as.factor(df.all[["point"]])
df.all["depth"] <- as.factor(df.all[["depth"]])
df.all["kelp"] <- as.factor(df.all[["kelp"]])

# data adjustment


#head(df.all)
print("* * * * * * * Part 2 * * * * * * * *")
data_path2 <- "../data/part2/fluorymetr wyniki2"

### ------------- importing G data -----------------------------------------------
file.name <- 'G_no kelps_results2.xlsx'
# 7m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="7m_G")
tmp.df["depth"] <- 7
df.G <- tmp.df
# 10m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="10m_G")
tmp.df["depth"] <- 10
df.G <- rbind.fill(df.G,tmp.df)
# 15m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="15m_G")
tmp.df["depth"] <- 15
df.G <- rbind.fill(df.G,tmp.df)
# 20m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="20m_G")
tmp.df["depth"] <- 20
df.G <- rbind.fill(df.G,tmp.df)
# 25m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="25m_G")
tmp.df["depth"] <- 25
df.G <- rbind.fill(df.G,tmp.df)

# data adjustment

df.G["kelp"] <- FALSE # no kelp at all depths
df.G["point"] <- "GF"

### ------------- importing H data -----------------------------------------------
file.name <- 'H_no kelps_results2.xlsx'
# 7m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="7m_H")
tmp.df["depth"] <- 7
df.H <- tmp.df
# 10m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="10m_H")
tmp.df["depth"] <- 10
df.H <- rbind.fill(df.H,tmp.df)
# 15m - empty
#tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="15m_H")
#tmp.df["depth"] <- 15
#df.H <- rbind.fill(df.H,tmp.df)
# 20m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="20m_H")
tmp.df["depth"] <- 20
df.H <- rbind.fill(df.H,tmp.df)
# 25m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="25m_H")
tmp.df["depth"] <- 25
df.H <- rbind.fill(df.H,tmp.df)

# data adjustment
df.H["kelp"] <- FALSE # no kelp at all depths
df.H["point"] <- "H"

### ------------- importing S1 data -----------------------------------------------
file.name <- 'S1_kelps_results2.xlsx'
# 7m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="7m_S1")
tmp.df["depth"] <- 7
df.S1 <- tmp.df
# 10m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="10m_S1")
tmp.df["depth"] <- 10
df.S1 <- rbind.fill(df.S1,tmp.df)
# 15m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="15m_S1")
tmp.df["depth"] <- 15
df.S1 <- rbind.fill(df.S1,tmp.df)
# 20m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="20m_S1")
tmp.df["depth"] <- 20
df.S1 <- rbind.fill(df.S1,tmp.df)
# 25m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="25m_S1")
tmp.df["depth"] <- 25
df.S1 <- rbind.fill(df.S1,tmp.df)

# data adjustment
df.S1["kelp"] <- (df.S1$depth < 15) # at depth 15+ there are no kelps
df.S1["point"] <- "S1"

### ------------- importing S2 data -----------------------------------------------
file.name <- 'S2_kelps_results2.xlsx'
# 7m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="7m_S2")
tmp.df["depth"] <- 7
df.S2 <- tmp.df
# 10m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="10m_S2")
tmp.df["depth"] <- 10
df.S2 <- rbind.fill(df.S2,tmp.df)
# 15m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="15m_S2")
tmp.df["depth"] <- 15
df.S2 <- rbind.fill(df.S2,tmp.df)
# 20m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="20m_S2")
tmp.df["depth"] <- 20
df.S2 <- rbind.fill(df.S2,tmp.df)
# 25m
tmp.df <-  openxlsx::read.xlsx(paste(data_path2,file.name,sep="/"),sheet="25m_S2")
tmp.df["depth"] <- 25
df.S2 <- rbind.fill(df.S2,tmp.df)

# data adjustment
df.S2["kelp"] <- (df.S2$depth < 10) # at depth 10+ there are no kelps
df.S2["point"] <- "S2"


colnames.G.2 <- colnames(df.G)
colnames.H.2 <- colnames(df.H)
colnames.S1.2 <- colnames(df.S1)
colnames.S2.2 <- colnames(df.S2)

colnames(df.G) <- colnames_new
colnames(df.H) <- colnames_new
colnames(df.S1) <- colnames_new
colnames(df.S2) <- colnames_new

df.all2 <- bind_rows(df.G,df.H,df.S1,df.S2)
rm(list=c('df.G','df.H','df.S1','df.S2','tmp.df'))

df.all2["date_time"] <- as.POSIXct(df.all2[["date_time"]] * (60*60*24) , origin="1899-12-30", tz="GMT") # adjust the date from double to date format

df.all2["point"] <- as.factor(df.all2[["point"]])
df.all2["depth"] <- as.factor(df.all2[["depth"]])
df.all2["kelp"] <- as.factor(df.all2[["kelp"]])
## ------------- importing chemical and physical data ----------------------------------------------- END


print("creating month-year factor for df.all and df.all2")

mmin <- 1
mmax <- 12

ymin <- 2021
ymax <- 2023

wmin <- 1
wmax <- 53

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
#m.yr.order


mth <- month(df.all$date_time)
yr <- year(df.all$date_time)
wk <- week(df.all$date_time)
m.yr.factor <- factor(paste(substr(month.name[mth],1,3),substr(as.character(yr),3,4),sep=""),levels=m.yr.order,ordered=TRUE)
w.yr.factor <- factor(paste("W",wk,"-",substr(as.character(yr),3,4),sep=""),levels=w.yr.order,ordered=TRUE)

df.all <- cbind(cbind(df.all,m.yr.factor),w.yr.factor)

mth2 <- month(df.all2$date_time)
yr2 <- year(df.all2$date_time)
wk2 <- week(df.all2$date_time)
m.yr.factor2 <- factor(paste(substr(month.name[mth2],1,3),substr(as.character(yr2),3,4),sep=""),levels=m.yr.order,ordered=TRUE)
w.yr.factor2 <- factor(paste("W",wk2,"-",substr(as.character(yr2),3,4),sep=""),levels=w.yr.order,ordered=TRUE)

df.all2 <- cbind(cbind(df.all2,m.yr.factor2),w.yr.factor2)
colnames(df.all2) <- colnames(df.all)

print("Finished creating df.all and df.all2 data frames.")

print("Creating merged dataframe df.merged")

# choose elements starting at the end of the previous timeseries end
df.limit.dates <- df.all %>% group_by(point,depth) %>% summarize(max(date_time))

df.tmp <- df.all
for (i in 1:nrow(df.limit.dates)){
   pt <- df.limit.dates[[i,"point"]]
   dpth <- df.limit.dates[[i,"depth"]]
   max.date <-  df.limit.dates[[i,"max(date_time)"]]
    
   condition <- df.all2$point==pt & df.all2$depth==dpth & df.all2$date_time >max.date
   df.tmp <- rbind(df.tmp,df.all2[condition,]) 
}
df.merged <- df.tmp

#warning("Some features were updated in the first part of the dataset. Therefore check columns compatibility before analyses.")
#done

# cleaning wrong oxygen values - 
condition <- df.merged$point=="GF" & df.merged$depth==20 & df.merged$m.yr.factor > "Dec22"
df.merged[condition,"oxygen"] <- NA

# cleaning wrong temperature values
condition <- df.merged$point=="GF" & df.merged$depth==20 & df.merged$m.yr.factor >= "Apr23"
df.merged[condition,"temp"] <- NA

# cleaning wrong oxygen values
condition <-(df.merged$m.yr.factor %in% c("Jul22","Aug22","Aug23")) & (!is.na(df.merged$temp) & df.merged$temp > 10)
df.merged[condition,"temp"] <- NA

# cleaning wrong pH values
condition <- df.merged$point=="GF" & df.merged$depth==20 & df.merged$m.yr.factor >= "Apr23" | (!is.na(df.merged$pH) & df.merged$pH < 5.0)
df.merged[condition,"pH"] <- NA

condition <- !is.na(df.merged$pH) & df.merged$pH < 7.7
df.merged[condition,"pH"] <- NA

# cleaning wrong light values
condition <- !is.na(df.merged$light) & (df.merged$light > 4000)
df.merged[condition,"light"] <- NA


# removing zeros ec
condition <- !is.na(df.merged$ec) & (df.merged$ec <= 0)
df.merged[condition,"ec"] <- NA


#####################################################
# chemical data cleaning
cn <- colnames(df.merged)
cn[match("point",cn)] <- "site"
colnames(df.merged) <- cn

p.atm <- 984 # [hPa] #- avg atmospheric pressure in Svalbard
g <- 9.83 # m/s^2 #- gravitational acceleration in the north of the Earth
rho <- 1028 #kg/m^3

df.merged$water.depth <- (1000*df.merged$water_level - 100*p.atm)/(rho*g)

# water depth data cleaning
pt <- "GF" # ---------------------------------------------------------------------------------
dpth <- "7" # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
cond <- (df.merged$site==pt & df.merged$depth==dpth & !is.na(df.merged$water.depth))
cond2 <- df.merged$water.depth <=7.5 | df.merged$water.depth>=10
df.merged$water.depth[cond & cond2] <- NA

dpth <- "25" # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
cond <- (df.merged$site==pt & df.merged$depth==dpth & !is.na(df.merged$water.depth))
cond2 <- df.merged$water.depth <=25 
df.merged$water.depth[cond & cond2] <- NA

pt <- "H" # ----------------------------------------------------------------------------------
dpth <- "7" # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
cond <- (df.merged$site==pt & df.merged$depth==dpth & !is.na(df.merged$water.depth))
cond2 <- df.merged$water.depth <= 5 | df.merged$water.depth >=8
df.merged$water.depth[cond & cond2] <- NA

# adjusting the differences (with respect to water level) in placing the measurement device 
x <- (df.merged %>% select(date_time,water.depth,site,depth) %>% na.omit() %>% filter(site==pt & depth==dpth & date_time < '2022-08-01'))$water.depth
y <- (df.merged %>% select(date_time,water.depth,site,depth) %>% na.omit() %>% filter(site==pt & depth==dpth & date_time >= '2022-08-01'))$water.depth
dL <- mean(x) - mean(y)
cond3 <- df.merged$date_time >= '2022-08-01'
df.merged$water.depth[cond & cond3] <- df.merged$water.depth[cond & cond3] + dL

dpth <- "25" # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

cond <- (df.merged$site==pt & df.merged$depth==dpth & !is.na(df.merged$water.depth))
cond2 <- df.merged$water.depth <= 20 
df.merged$water.depth[cond & cond2] <- NA

x <- (df.merged %>% select(date_time,water.depth,site,depth) %>% na.omit() %>% filter(site==pt & depth==dpth & date_time < '2022-08-01'))$water.depth
y <- (df.merged %>% select(date_time,water.depth,site,depth) %>% na.omit() %>% filter(site==pt & depth==dpth & date_time >= '2022-08-01'))$water.depth
dL <- mean(x) - mean(y)

cond3 <- df.merged$date_time >= '2022-08-01'
df.merged$water.depth[cond & cond3] <- df.merged$water.depth[cond & cond3] + dL


pt <- "S1" # ----------------------------------------------------------------------------------
dpth <- "7" # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

cond <- (df.merged$site==pt & df.merged$depth==dpth & !is.na(df.merged$water.depth))
cond2 <- df.merged$water.depth > 10 | df.merged$water.depth < 6
df.merged$water.depth[cond & cond2] <- NA

x <- (df.merged %>% select(date_time,water.depth,site,depth) %>% na.omit() %>% filter(site==pt & depth==dpth & date_time < "2023-02-07"))$water.depth
y <- (df.merged %>% select(date_time,water.depth,site,depth) %>% na.omit() %>% filter(site==pt & depth==dpth & date_time > "2023-02-07"))$water.depth
dL <- mean(x) - mean(y)

cond3 <- df.merged$date_time >= "2023-02-07"
df.merged$water.depth[cond & cond3] <- df.merged$water.depth[cond & cond3] + dL

cond4 <- df.merged$date_time >= "2023-02-07" & df.merged$date_time <= "2023-02-08"
df.merged$water.depth[cond & cond4] <- NA

cond5 <- df.merged$date_time > "2023-08-18 9:00"
df.merged$water.depth[cond & cond5] <- NA

dpth <- "25" # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
cond <- (df.merged$site==pt & df.merged$depth==dpth & !is.na(df.merged$water.depth))
cond2 <- df.merged$water.depth < 22 # 
df.merged$water.depth[cond & cond2] <- NA

x <- (df.merged %>% select(date_time,water.depth,site,depth) %>% na.omit() %>% filter(site==pt & depth==dpth & date_time < "2023-02-07"))$water.depth
y <- (df.merged %>% select(date_time,water.depth,site,depth) %>% na.omit() %>% filter(site==pt & depth==dpth & 
                                                                                      date_time > "2023-02-07 11:00" & date_time < "2023-08-07 11:00"))$water.depth
dL <- mean(x) - mean(y)

cond3 <- df.merged$date_time > "2023-02-07 11:00" & df.merged$date_time < "2023-08-07 11:00"
df.merged$water.depth[cond & cond3] <- df.merged$water.depth[cond & cond3] + dL

cond4 <- (df.merged$date_time > "2023-08-07 08:30" & df.merged$date_time <"2023-08-07 15:00") | (df.merged$date_time >="2023-02-07 09:30" & df.merged$date_time <"2023-02-07 12:00")
df.merged$water.depth[cond & cond4] <- NA

pt <- "S2" # ----------------------------------------------------------------------------------
dpth <- "7" # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
cond <- (df.merged$site==pt & df.merged$depth==dpth & !is.na(df.merged$water.depth))
cond2 <- df.merged$water.depth < 6 | df.merged$water.depth > 10
df.merged$water.depth[cond & cond2] <- NA

dpth <- "25" # * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
pt <- "S2"

cond <- (df.merged$site==pt & df.merged$depth==dpth & !is.na(df.merged$water.depth))
cond2 <- df.merged$water.depth < 22 
df.merged$water.depth[cond & cond2] <- NA

x <- (df.merged %>% select(date_time,water.depth,site,depth) %>% na.omit() %>% filter(site==pt & depth==dpth & date_time < "2022-08-01"))$water.depth
y <- (df.merged %>% select(date_time,water.depth,site,depth) %>% na.omit() %>% filter(site==pt & depth==dpth & date_time >= "2022-08-01"))$water.depth
dL <- mean(x) - mean(y)

cond3 <- df.merged$date_time > "2022-08-01" & df.merged$date_time < "2023-07-31 20:00"
df.merged$water.depth[cond & cond3] <- df.merged$water.depth[cond & cond3] + dL
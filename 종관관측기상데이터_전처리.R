
src_dir<-c("2010104050_박재호_졸업논문/데이터/원자료/종관관측기상데이터/")

src_file<-list.files(src_dir)
#src_file

src_file_cnt<-length(src_file)
#src_file_cnt


temp_Data<-read.csv(paste(src_dir, src_file[1], sep=""), header = F, stringsAsFactors = F)

for(i in 1:src_file_cnt){
  
  temp_Data<-read.csv(paste(src_dir, src_file[i], sep=""), header = F, stringsAsFactors = F)
  temp_Data<-temp_Data[-1,c(2:6)]
  colnames(temp_Data)<-c("측정일시","기온","강수량","풍속(m/s)","풍향(16방위)")
  
  
  temp_Data$측정일시 <- sub(pattern = " 0:",replacement = " 00:",x = temp_Data$측정일시)
  temp_Data$측정일시 <- sub(pattern = " 1:",replacement = " 01:",x = temp_Data$측정일시)
  temp_Data$측정일시 <- sub(pattern = " 2:",replacement = " 02:",x = temp_Data$측정일시)
  temp_Data$측정일시 <- sub(pattern = " 3:",replacement = " 03:",x = temp_Data$측정일시)
  temp_Data$측정일시 <- sub(pattern = " 4:",replacement = " 04:",x = temp_Data$측정일시)
  temp_Data$측정일시 <- sub(pattern = " 5:",replacement = " 05:",x = temp_Data$측정일시)
  temp_Data$측정일시 <- sub(pattern = " 6:",replacement = " 06:",x = temp_Data$측정일시)
  temp_Data$측정일시 <- sub(pattern = " 7:",replacement = " 07:",x = temp_Data$측정일시)
  temp_Data$측정일시 <- sub(pattern = " 8:",replacement = " 08:",x = temp_Data$측정일시)
  temp_Data$측정일시 <- sub(pattern = " 9:",replacement = " 09:",x = temp_Data$측정일시)
  
  temp_Data[is.na(temp_Data)]<-0
  
  write.csv(temp_Data,paste("2010104050_박재호_졸업논문/데이터/종관관측기상데이터/AOS_",src_file[i]))
  
}


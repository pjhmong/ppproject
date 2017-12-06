

src_dir<-c("2010104050_박재호_졸업논문/데이터/대기오염데이터/1차전처리(결측치제거 및 시간변수 통일)/")
src_file<-list.files(src_dir)
src_file_cnt<-length(src_file)

set_src_dir<-c("2010104050_박재호_졸업논문/데이터/대기오염데이터/2차전처리(지역별분할 및 곽측소 시별 통합 및 연도통합)/")

LocationNameList<-read.csv("2010104050_박재호_졸업논문/데이터/대기오염데이터/1차전처리(결측치제거 및 시간변수 통일)/set_2014_1.csv")
LocationNameList<-unique(LocationNameList$지역)
LocationNameList_cnt<-length(LocationNameList)

LocationDataList<-list()

for(i in 1:src_file_cnt){ 
  
  temp_Data<-read.csv(paste(src_dir, src_file[i], sep=""), stringsAsFactors = F)
  
  colnames(temp_Data)<-c("지역","측정소명","측정일시","SO2","CO","O3","NO2","PM10")
  
  set_Date<-temp_Data$측정일시
  set_Date<-substr(set_Date,6,16)
  temp_Data$측정일시<-set_Date
  
  temp_Data<-temp_Data[-1,]
  
  for(j in 1:LocationNameList_cnt){
    
    if(i==1){
      
      refactoring_Data<-subset(temp_Data,지역==LocationNameList[j])
      
      refactoring_Data[is.na(refactoring_Data)]<-0 #결측치 제거
      
      refactoring_Data<-data.frame( #서로다른 측정소들의 측정값을 평균으로 통합
        aggregate(SO2 ~ 측정일시,refactoring_Data,mean),
        aggregate(CO ~ 측정일시,refactoring_Data,mean),
        aggregate(O3 ~ 측정일시,refactoring_Data,mean),
        aggregate(NO2 ~ 측정일시,refactoring_Data,mean),
        aggregate(PM10 ~ 측정일시,refactoring_Data,mean)
        
      )
      refactoring_Data<-refactoring_Data[-c(3,5,7,9)]
      
      LocationDataList[[j]]<-refactoring_Data
      
    }else{
      
      refactoring_Data<-subset(temp_Data,지역==LocationNameList[j])
      
      refactoring_Data[is.na(refactoring_Data)]<-0 #결측치 제거
      
      refactoring_Data<-data.frame( #서로다른 측정소들의 측정값을 평균으로 통합
        aggregate(SO2 ~ 측정일시,refactoring_Data,mean),
        aggregate(CO ~ 측정일시,refactoring_Data,mean),
        aggregate(O3 ~ 측정일시,refactoring_Data,mean),
        aggregate(NO2 ~ 측정일시,refactoring_Data,mean),
        aggregate(PM10 ~ 측정일시,refactoring_Data,mean)
        
      )
      refactoring_Data<-refactoring_Data[-c(3,5,7,9)]
      
      rbind_data<-rbind(data.frame(LocationDataList[j]),refactoring_Data)
      
      LocationDataList[[j]]<-rbind_data
      
    }
  }
  
}


for(i in 1:LocationNameList_cnt){
  
  write.csv(data.frame(LocationDataList[i]),
            paste(set_src_dir,"전체/",LocationNameList[i],".csv",sep = ""), 
            sep = ",",
            row.names = FALSE,
            col.names = FALSE,
            quote = FALSE,
            append = FALSE)
  
}




src_dir<-c("2010104050_박재호_졸업논문/데이터/대기오염데이터/2차전처리(지역별분할 및 곽측소 시별 통합 및 연도통합)/2016/")
src_file<-list.files(src_dir)
src_file_cnt<-length(src_file)
#src_file_cnt

temp <- read.csv(paste(src_dir, src_file[j], sep=""), stringsAsFactors = F)


for(i in 1:3){ # 연도별 데이터 처리시 src_dir 과 substr 범위 수정
  
  for(j in 1:src_file_cnt){ 
    
    temp <- read.csv(paste(src_dir, src_file[j], sep=""), stringsAsFactors = F)
    if(i==2){
      temp$측정일시<-substr(temp$측정일시,1,10) # Day
    }
    if(i==3){
      temp$측정일시<-substr(temp$측정일시,1,7) # month
    }
    
    if(j==1){
      
      refactoring_Data<-temp
      
    }else{
      
      
      refactoring_Data<-rbind(refactoring_Data, temp)
      
      refactoring_Data<-data.frame( 
        aggregate(SO2 ~ 측정일시,refactoring_Data,mean),
        aggregate(CO ~ 측정일시,refactoring_Data,mean),
        aggregate(O3 ~ 측정일시,refactoring_Data,mean),
        aggregate(NO2 ~ 측정일시,refactoring_Data,mean),
        aggregate(PM10 ~ 측정일시,refactoring_Data,mean)
        
      )
      refactoring_Data<-refactoring_Data[-c(3,5,7,9)]
      
    }
    
  }
  
  if(i==1){
    write.csv(refactoring_Data, "2010104050_박재호_졸업논문/데이터/대기오염데이터/3차전처리(경기도 전체)/2016/경기도2016_Hour.csv")
  }
  if(i==2){
    write.csv(refactoring_Data, "2010104050_박재호_졸업논문/데이터/대기오염데이터/3차전처리(경기도 전체)/2016/경기도2016_Day.csv")
  }
  if(i==3){
    write.csv(refactoring_Data, "2010104050_박재호_졸업논문/데이터/대기오염데이터/3차전처리(경기도 전체)/2016/경기도2016_month.csv")
    
  }
  
}







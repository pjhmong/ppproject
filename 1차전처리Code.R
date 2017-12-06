
src_dir<-c("2010104050_박재호_졸업논문/데이터/원자료/대기오염데이터/")

src_file<-list.files(src_dir)
src_file
src_file_cnt<-length(src_file)

set_src_dir<-c("2010104050_박재호_졸업논문/데이터/대기오염데이터/1차전처리(결측치제거 및 시간변수 통일)/")

#for(i in 1:src_file_cnt){
  
#  rawdata_Set <- read.csv(
#    paste(src_dir,"/",src_file[i],sep=""),sep = ",",header = F,stringsAsFactors = F)
  
#  write.csv(rawdata_Set,
#            paste(src_dir,"/","2014~2017.csv",sep = ""),
#            sep = ",",
#            row.names = FALSE,
#            col.names = FALSE,
#            quote = FALSE,
#            append = TRUE) #append-> stacking임
  
#  rm(rawdata_Set)
  
#}
# 파일 용량이 커서 실패, R의 한계

for(i in 1:src_file_cnt){

  refactoring_Data<- read.csv(paste(src_dir, src_file[i], sep=""), header = F, stringsAsFactors = F)
  
  colnames(refactoring_Data)<-c("지역","측정소코드","측정소명","측정일시","SO2","CO","O3","NO2","PM10","PM25","주소")
  
  refactoring_Data[is.na(refactoring_Data)]<-0 #결측치 제거
  
  refactoring_Data<- refactoring_Data[-1,-c(2,10,11)] #1행 제거, 3열 제거(측정소코드, PM25, 주소)
  
  ## Start of 시간변수 분해 결합#####
  
  refactoring_Date<- refactoring_Data$측정일시
  
  year<-substr(refactoring_Date,1,4)
  month<-substr(refactoring_Date,5,6)
  day<-substr(refactoring_Date,7,8)
  hour<-substr(refactoring_Date,9,10)
  
  hour<-sub(pattern = "24",replacement = "00",x = hour)
  hour<-paste0(hour,sep=":00")
  
  refactoring_Date<-paste(year,month,sep="-")
  refactoring_Date<-paste(refactoring_Date,day,sep="-")
  refactoring_Date<-paste(refactoring_Date,hour,sep=" ")
  
  refactoring_Data$측정일시<-refactoring_Date
  
  ## End of 시간변수 분해 #####
  
  write.csv(refactoring_Data,
                        paste(set_src_dir,"set_", src_file[i],sep = ""),
                        sep = ",",
                        row.names = FALSE,
                        col.names = FALSE,
                        quote = FALSE,
                        append = FALSE)
} 

rm(i,src_dir,src_file,src_file_cnt,year,month,day,hour,refactoring_Date,refactoring_Data, set_src_dir)
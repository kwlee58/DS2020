#**********************************************************************  
#	*주의 사항
#		현재 스크립트 파일은 파일명만 출력되어 있습니다.
#		따라서, 저장된 추출 결과 파일의 경로를 'read.table' 또는 'read.fwf'에 추가하여야 합니다.
#	예) 다운로드 받은 폴더명 : C:\Download
#	  ※ 파일 경로 추가 : "[다운로드 받은 폴더명]\기업활동조사_기업활동조사(제공)_2019_20191201_92007.txt"
# 		read.table("C:\Download\기업활동조사_기업활동조사(제공)_2019_20191201_92007.txt", ~~~
#		또는
#		read.fwf("C:\Download\기업활동조사_기업활동조사(제공)_2019_20191201_92007.txt", ~~~
#
#		R 스크립트는 R 에서 파일 경로만 수정하시면 바로 실행(Ctrl+Alt+R)가능하며,
#		데이터셋 생성 후에 R 의 여러 가지 분석 기능을 사용할 수 있습니다.
#
#**********************************************************************

install.packages("dplyr")
library(dplyr)

mdis <- read.table("2020_연간자료(지출, 2019~) - 전체가구_1인이상_20221021_94526.csv", header=FALSE, sep=",", colClasses = c("numeric"
, "numeric", "numeric", "character", "character", "character"), skip=1, na.string=c("*","**","***","****","*****","******","*******","********","*********","**********","."))

        mdis$V4<- recode_factor(mdis$V4, '1'="1분위")
        mdis$V4<- recode_factor(mdis$V4, '2'="2분위")
        mdis$V4<- recode_factor(mdis$V4, '3'="3분위")
        mdis$V4<- recode_factor(mdis$V4, '4'="4분위")
        mdis$V4<- recode_factor(mdis$V4, '5'="5분위")
        mdis$V5<- recode_factor(mdis$V5, '01'="1분위")
        mdis$V5<- recode_factor(mdis$V5, '02'="2분위")
        mdis$V5<- recode_factor(mdis$V5, '03'="3분위")
        mdis$V5<- recode_factor(mdis$V5, '04'="4분위")
        mdis$V5<- recode_factor(mdis$V5, '05'="5분위")
        mdis$V5<- recode_factor(mdis$V5, '06'="6분위")
        mdis$V5<- recode_factor(mdis$V5, '07'="7분위")
        mdis$V5<- recode_factor(mdis$V5, '08'="8분위")
        mdis$V5<- recode_factor(mdis$V5, '09'="9분위")
        mdis$V5<- recode_factor(mdis$V5, '10'="10분위")
        mdis$V6<- recode_factor(mdis$V6, '1'="100만원 미만")
        mdis$V6<- recode_factor(mdis$V6, '2'="100~200만원 미만")
        mdis$V6<- recode_factor(mdis$V6, '3'="200~300만원 미만")
        mdis$V6<- recode_factor(mdis$V6, '4'="300~400만원 미만")
        mdis$V6<- recode_factor(mdis$V6, '5'="400~500만원 미만")
        mdis$V6<- recode_factor(mdis$V6, '6'="500~600만원 미만")
        mdis$V6<- recode_factor(mdis$V6, '7'="600~700만원 미만")
        mdis$V6<- recode_factor(mdis$V6, '8'="700만원 이상")

colnames(mdis) = c("가계지출금액"
, "가계지출_소비지출금액", "가계지출_비소비지출금액", "전국전체가구_1인이상소득5분위코드", "전국전체가구_1인이상소득10분위코드", "소득구간코드")


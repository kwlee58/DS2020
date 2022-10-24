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
library(magrittr)
library(ggplot2)
library(extrafont)
par(family = "KoPubWorldDotum Medium")
options(scipen = 999)
mdis <- 
  read.table("./data/mdis_79055.csv", 
             header=FALSE, 
             sep=",", 
             colClasses = c("character", "numeric", "numeric", "numeric", "numeric"), 
             na.string=c("*","**","***","****","*****","******","*******","********","*********","**********","."))

colnames(mdis) = c("가구일련번호", "소득", "가계지출금액", "가계지출_소비지출금액", "가계지출_비소비지출금액")

str(mdis)
mdis$처분가능소득 <- mdis$소득 - mdis$가계지출_비소비지출금액
str(mdis)
table(mdis$가구일련번호) %>% 
  str
income_hh <- tapply(mdis$소득, mdis$가구일련번호, sum)
dispos_income_hh <- tapply(mdis$처분가능소득, mdis$가구일련번호, sum)
expenditure_hh <- tapply(mdis$가계지출_소비지출금액, mdis$가구일련번호, sum)
mdis_hh <- data.frame(Income = income_hh, Dispos_Income = dispos_income_hh, Expenditure = expenditure_hh)
mdis_hh <- mdis_hh / 1000000
str(mdis_hh)
summary(mdis_hh$Income)
sort(mdis_hh$Income, decreasing = TRUE)
o_income <- order(mdis_hh$Income, decreasing = FALSE)
income_level <- mdis_hh[, c("Income")] %>% cut_number(n = 100) 
mdis_hh$Income_Level <- income_level
mdis_hh[o_income, ] %>% tail(100)
mdis_df <- aggregate(cbind(Income, Dispos_Income, Expenditure) ~ Income_Level, data = mdis_hh, FUN = mean)
plot(x = 1:100, y = mdis_df$Income, type = "l", col = "blue", axes = FALSE, ann = FALSE)
lines(x = 1:100, y = mdis_df$Dispos_Income, type = "l", col = "skyblue")
lines(x = 1:100, y = mdis_df$Expenditure, type = "l", col = "red")
title(main = "소득 100분위별 소득과 지출", xlab = "분위", ylab = "금액(단위 백만원)", cex.main = 1.5, font.main = 2)
axis(side = 1, at = seq(0, 100, by = 25), labels = seq(0, 100, by = 25))
axis(side = 2, at = seq(0, 45, by = 5), labels = seq(0, 45, by = 5))
mdis_df[1:10, c("Income_Level", "Income", "Dispos_Income", "Expenditure")]
mdis_df[91:100, c("Income_Level", "Income", "Dispos_Income", "Expenditure")]
library(ggplot2)

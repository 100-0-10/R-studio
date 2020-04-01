
# ("", header = T)        컬럼명을 헤더값으로 가져옴
# (file.choose(), header = T)
exam <- read.csv("csv_exam.csv")
head(exam)
View(exam)

# dim() - 몇 행 몇 열로 구성되는지 알아보기 
dim(exam)  # 행 , 열 출력

# str() - 속성 파악하기 
str(exam)  # 데이터 속성 확인

# summary() - 요약통계량 산출하기 
summary(exam)  # 요약통계량 출 력

# mpg 데이터 파악하기 
# ggplo2 의 mpg 데이터를 데이터 프레임 형태로 불러오기
mpg <- as.data.frame(ggplot2::mpg) 
# mpg 데이터 파악하기 
head(mpg)    # Raw 데이터 앞부분 확인
tail(mpg)    # Raw 데이터 뒷부분 확인
View(mpg)    # Raw 데이터 뷰어 창 확인
dim(mpg)     # 행 , 열 출력
str(mpg)     # 데이터 속성 확인
summary(mpg)  # 요약통계량 출력

# 2. 데이터 수정하기 - 변수명 바꾸기 
# dplyr 패키지 설치 & 로드 
# install.packages("dplyr")  # dplyr 설치
# library(dplyr)             # dplyr 로드

# 데이터 프레임 생성
df_raw <- data.frame(var1 = c(1, 2, 3),
                     var2 = c(2, 3, 2))
df_raw

# 데이터 프레임 복사본 만들기
df_new <- df_raw # 복사본
df_new # 출력

# 변수명 바꾸기
df_new <- rename(df_new, v2 = var2)
df_new


# 변수 조합해 파생변수 만들기 
# 데이터 프레임 생성 
df <- data.frame(var1 = c(4, 3, 8),      
                 var2 = c(2, 6, 1)) 
df 

# 파생변수 생성 
df$var_sum <- df$var1 + df$var2  # var_sum 파생변수 생성
df

# 파생변수 생성 
df$var_mean <- (df$var1 + df$var2)/2  # var_mean 파생변수 생성
df 

# mpg 통합 연비 변수 만들기 
mpg$total <- (mpg$cty + mpg$hwy)/2  # 통합 연비 변수 생성
head(mpg)
mean(mpg$total)

# 조건문을 활용해 파생변수 만들기 
# 1.기준값 정하기 
summary(mpg$total)  # 요약 통계량 산출
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  
##   10.50   15.50   20.50   20.15   23.50   39.50 
hist(mpg$total)     # 히스토그램 생성

# 2. 조건문으로 합격 판정 변수 만들기 
# 20 이상이면 pass, 그렇지 않으면 fail 부여
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail") 

head(mpg, 20) # 데이터 확인

# 3. 빈도표로 합격 판정 자동차 수 살펴보기 
table(mpg$test)  # 연비 합격 빈도표 생성

# 4. 막대 그래프빈 빈도 표현하기 
# library(ggplot2)  # ggplot2 로드
qplot(mpg$test)   # 연비 합격 빈도 막대 그래프 생성

# total 을 기준으로 A, B, C 등급 부여
mpg$grade <- ifelse(mpg$total >= 30, "A",
                    ifelse(mpg$total >= 20, "B", "C")) 

head(mpg, 20)  # 데이터 확인

# 빈도표, 막대 그래프로 연비 등급 살펴보기 
table(mpg$grade) # 등급 빈도표 생성
qplot(mpg$grade) # 등급 빈도 막대 그래프 생성

# 원하는 만큼 범주 만들기 
# A, B, C, D 등급 부여
mpg$grade2 <- ifelse(mpg$total >= 30, "A",
                     ifelse(mpg$total >= 25, "B",
                            ifelse(mpg$total >= 20, "C", "D"))) 

midwest <- as.data.frame(ggplot2::midwest)
head(midwest)
summary(midwest)
df_midwest <- midwest
df_midwest
df_midwest <- rename(df_midwest, total = poptotal)
df_midwest <- rename(df_midwest, asian = popasian)
head(df_midwest)
df_midwest$total_asian <- (df_midwest$asian / df_midwest$total) * 100
hist(df_midwest$total_asian)
mean(df_midwest$total_asian)
df_midwest$total_asian <- ifelse(df_midwest$total_asian > mean(df_midwest$total_asian), "large",
                                 "small")
df_midwest$total_asian
table(df_midwest$total_asian)
qplot(df_midwest$total_asian)


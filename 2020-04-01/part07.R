

7. 데이터 정제 
빠진 데이터, 이상한 데이터 제거하기 

07-1. 빠진 데이터를 찾아라! - 결측치 정제하기 
결측치(Missing Value) 
• 누락된 값, 비어있는 값 
• 함수 적용 불가, 분석 결과 왜곡 
• 제거 후 분석 실시 

결측치 찾기 
결측치 만들기 • 결측치 표기 - 대문자 NA 
df <- data.frame(sex = c("M", "F", NA, "M", "F"), 
                 score = c(5, 4, 3, 4, NA))
df
[유의] NA 앞 뒤에 겹따옴표 없음

결측치 확인하기 
is.na(df)         # 결측치 확인
table(is.na(df))  # 결측치 빈도 출력

변수별로 결측치 확인하기 
table(is.na(df$sex))    # sex 결측치 빈도 출력
table(is.na(df$score))  # score 결측치 빈도 출력

결측치 포함된 상태로 분석 
mean(df$score)  # 평균 산출
sum(df$score)   # 합계 산출

결측치 제거하기 
결측치 있는 행 제거하기 
# library(dplyr) # dplyr 패키지 로드
df %>% filter(is.na(score))   # score 가 NA 인 데이터만 출력
df %>% filter(!is.na(score))  # score 결측치 제거

결측치 제외한 데이터로 분석하기 
df_nomiss <- df %>% filter(!is.na(score))  # score 결측치 제거
mean(df_nomiss$score)                      # score 평균 산출
sum(df_nomiss$score)                       # score 합계 산

여러 변수 동시에 결측치 없는 데이터 추출하기 
# score, sex 결측치 제외
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss

결측치가 하나라도 있으면 제거하기 
df_nomiss2 <- na.omit(df)  # 모든 변수에 결측치 없는 데이터 추출
df_nomiss2                 # 출력

함수의 결측치 제외 기능 이용하기 - na.rm = T 
mean(df$score, na.rm = T)  # 결측치 제외하고 평균 산출
sum(df$score, na.rm = T)   # 결측치 제외하고 합계 산출

summarise()에서 na.rm = T사용하기 • 결측치 생성 
exam <- read.csv("csv_exam.csv")            # 데이터 불러오기
exam[c(3, 8, 15), "math"] <- NA             # 3, 8, 15 행의 math 에 NA 할당

• 평균 구하기 
exam %>% summarise(mean_math = mean(math))             # 평균 산출
exam %>% summarise(mean_math = mean(math, na.rm = T))  # 결측치 제외하고 평균 산출

다른 함수들에 적용 
exam %>% summarise(mean_math = mean(math, na.rm = T),      # 평균 산출
                   sum_math = sum(math, na.rm = T),        # 합계 산출
                   median_math = median(math, na.rm = T))  # 중앙값 산출

결측치 대체하기 
• 결측치 많을 경우 모두 제외하면 데이터 손실 큼 
• 대안: 다른 값 채워넣기 

결측치 대체법(Imputation) 
• 대표값(평균, 최빈값 등)으로 일괄 대체 
• 통계분석 기법 적용, 예측값 추정해서 대체 

평균값으로 결측치 대체하기 
평균 구하기 
mean(exam$math, na.rm = T)  # 결측치 제외하고 math 평균 산출

평균으로 대체하기 
exam$math <- ifelse(is.na(exam$math), 55, exam$math)  # math 가 NA 면 55 로 대체
table(is.na(exam$math))                               # 결측치 빈도표 생

exam  # 출력
mean(exam$math)  # math 평균 산출


07-2. 이상한 데이터를 찾아라! - 이상치 정제하기 
이상치(Outlier) - 정상범주에서 크게 벗어난 값 
• 이상치 포함시 분석 결과 왜곡 
• 결측 처리 후 제외하고 분석 
이상치 종류           예                  해결 방법 
존재할 수 없는 값     성별 변수에 3       결측 처리 
극단적인 값           몸무게 변수에 200   정상범위 기준 정해서 결측 처리 

이상치 제거하기 - 1. 존재할 수 없는 값 
•논리적으로 존재할 수 없으므로 바로 결측 처리 후 분석시 제외 
이상치 포함된 데이터 생성 - sex 3, score 6 
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6))
outlier
table(outlier$sex)
table(outlier$score)

결측 처리하기 - sex 
# sex 가 3 이면 NA 할당
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier 

결측 처리하기 - score 
# sex 가 1~5 아니면 NA 할당
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score) 
outlier 

결측치 제외하고 분석 
outlier %>%   filter(!is.na(sex) & !is.na(score)) %>%
  group_by(sex) %>%
  summarise(mean_score = mean(score)) 


이상치 제거하기 - 2. 극단적인 값 
• 정상범위 기준 정해서 벗어나면 결측 처리 
판단 기준     예 
논리적 판단   성인 몸무게 40kg~150kg 벗어나면 극단치 
통계적 판단   상하위 0.3% 극단치 또는 상자그림 1.5 IQR 벗어나면 극단치 

상자그림으로 극단치 기준 정해서 제거하기 
상자그림 생성 
mpg <- as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)

상자 그림             값                설명
상자 아래 세로 점선   아래수염 하위      0~25% 내에 해당하는 값
상자 밑면             1사분위수(Q1)      하위 25% 위치 값
상자 내 굵은 선       2사분위수(Q2)      하위 50% 위치 값(중앙값)
상자 윗면             3사분위수(Q3)      하위 75% 위치 값 
상자 위 세로 점선     윗수염             하위 75~100% 내에 해당하는 값 
상자 밖 가로선        극단치 경계        Q1, Q3 밖 1.5 IQR 내 최대값 
상자 밖 점 표식       극단치             Q1, Q3 밖 1.5 IQR을 벗어난 값 

상자그림 통계치 출력 
boxplot(mpg$hwy)$stats  # 상자그림 통계치 출력


결측 처리하기 
# 12~37 벗어나면 NA 할당
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy)) 

결측치 제외하고 분석하기 
mpg %>%   group_by(drv) %>%
  summarise(mean_hwy = mean(hwy, na.rm = T)) 


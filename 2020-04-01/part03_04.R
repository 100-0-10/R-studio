

x <- c('a', 'a', 'b', 'c')
x

qplot(x)

# data 에 mpg, x축에 hwy 변수 지졍하여 그래프 생성
# ggplot2 이 가지고 있는 mpg 데이터셋
qplot(data = mpg, x = hwy)

View(mpg)
# qplot() 파라미터 바꿔보기
# x축 cty
qplot(data = mpg, x = cty)

# x축 drv, y축 hwy
qplot(data = mpg, x = drv, y = hwy)

# x축 drv, y축 hwy, 선 그래프 형태
qplot(data = mpg, x = drv, y = hwy, geom = "line")

# x축 drv, y축 hwy, 상자 그림 형태
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot")

# x 축 drv, y 축 hwy, 상자 그림 형태 , drv 별 색 표현
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot", colour = drv)

?qplot


english <- c(90, 80, 60, 70)  # 영어 점수 변수 생성
english
math <- c(50, 60, 100, 20)    # 수학 점수 변수 생성
math
df_midterm <- data.frame(english, math)
df_midterm
class <- c(1, 1, 2, 2)
class 
df_midterm <- data.frame(english, math, class)
df_midterm 
mean(df_midterm$english)  # df_midterm 의 english 로 평균 산출
mean(df_midterm$math)     # df_midterm 의 math 로 평균 산술

sales <- data.frame(fruit = c("사과", "딸기", "수박"), 
                    price = c(1800, 1500, 3000),  
                    volume = c(24, 38, 13))
# 데이터 프레임 출력하기
sales
mean(sales$price)   # 가격 평균
mean(sales$volume)  # 판매량 평균


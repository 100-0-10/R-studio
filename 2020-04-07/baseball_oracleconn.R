

# 나이팅 게일 차트로 표현
# 주요선수별 성적-2013년.csv

data <- read.csv("야구성적.csv", header = T)

row.names(data) <- data$선수명

data2 <- data[, c(7, 8, 11, 12, 13, 14, 17, 19)]

stars(data2,
      flip.labels = FALSE,
      draw.segments = TRUE,
      frame.plot = TRUE,
      full = TRUE,
      key.loc = c(1.5, 0),
      main = "야구 선수별 주요 성적 분석-2013년")

stars(x, full = TRUE, radius = TRUE,
      labels = dimnames(x)[[1], locations = NULL,
      nrow = NULL, ncol = NULL, len = 1,
      key.loc = NULL, key.labels = dimnames(2)[2]],
      xlim = NULL, ylim = NULL, flip.labes = NULL,
      draw.segments = FALSE,
      col.segments = 1:n.seg, col.stars = NA, col.lines = NA,
      axes = FALSE, frame.plot = axes,
      main = NULL, sub = NULL, xlab = "", ylab = "",
      cex = 0.8, lwd = 0.25, lty = par("lty"), xpd = FALSE,
      mar = pmin(par("mar"),
                 1.1 + c(2 * axes + (xlab != ""),
                  2 * axes + (ylab != ""), 1, 0)),
      add = FALSE, plot = TRUE, ...)

## 'Spider' or 'Radar' plot:
stars(mtcars[, 1:7], locations = c(0, 0), radius = FALSE,
      key.loc = c(0, 0), main = "Motor Trend Cars", lty = 2)

## Segment Diagrams:
palette(rainbow(12, s = 0.6, v = 0.75))

stars(mtcars[, 1:7], len = 0.8, key.loc = c(12, 1.5),
      main = "Motor Trend Cars", draw.segments = TRUE)

stars(mtcars[, 1:7], len = 0.6, key.loc = c(1.5, 0),
      main = "Motor Trend Cars", draw.segments = TRUE,
      frame.plot = TRUE, nrow = 4, cex = .7)



############################
# 한국프로야구선수별 기록분석-2013년
# 주요선수별성적-2013년.csv

data <- read.csv("주요선수별성적-2013년.csv", header = T)
data

data4 <- data[, c(2, 21, 22)]
data4

line1 <- data$연봉대비출루율

line2 <- data$연봉대비출루율


# par() : 그래픽 매개 변수를 설정하거나 쿼리하는데 사용할 수 있다.
# 매개 변수눈 tag = value 형식의 par 인수로 지정하거나
# 태그 값의 목록으로 전달하여 설정할 수 있다.

# 매개 변수 mar : 
# 플롯의 네면에 지정된 마진선 수를 나타내는
# c (아래쪽, 왼쪽 위, 오른쪽) 형태의 숫자 벡터.
# 기본값은 c (5, 4, 4, 2) + 0.1

# 매개 변수 new :
# 논리적이며 기본값은 FALSE
# TRUE로 설정하면 다음 높은 레벨의 플로팅 명령(실제로 plot.new)은
# 새 장치에 있는 것처럼 그리기 전에 프레임을 정리해서는 안된다.
# 현재 고수준 플롯이 없는 장치에서
# new = TRUE를 사용하려고 하면
# 오류 (경고와 함께 무시 됨)가 발생
dev.new()
par(mar=c(5,4,4,4)+0.1)

plot(line1,
     type = "o",
     axes = F,
     ylab = "",
     xlab = "",
     ylim = c(0, 50),
     lty = 2,
     col = "blue",
     main = "한국프로야구선수별 기록 분석-2013년",
     lwd = 2)

axis (1,
      at = 1:25,
      lab = data4$선수명,
      las = 2)

par(new = T)

plot(line2,
     type = "o",
     axes = F,
     ylab = "",
     xlab = "",
     ylim = c(0, 50),
     lty = 2,
     col = "red")

axis (4, las=1)

mtext(side = 4, line = 2.5, "연봉대비 타점율")
mtext(side = 2, line = 2.5, "연봉대비 출루율")


legend(18,
       50,
       names(data[21:22]),
       cex = 0.8,
       col = c("red", "blue"),
       lty = 1,
       lwd = 2,
       bg = "white")

savePlot("baseball_4.png", type = "png")



#############################
# 프로야구 KBO 타자 성적과 나이의 관계(hit20180827.csv)

# 루타(TB) / 추정득점(XR) / 타석(PA) 값을 이용하여
# 추정득점(XR) / 타석(PA) 값이 .18보다 큰 선수들만
# 별도로 시각화하여 성적과 기여도의 관계를 시각화

# 추정득점(XR) : 팀 득점에 얼마나 기여했는지 정도

hit5 <- read.csv("hit20180927.csv")
hit5


hit5$age <- c(30, 20, 28, 31, 30, 32, 37, 32,
              37, 34, 36, 30,
              30, 30, 28, 25, 28, 32, 28,
              25, 28, 33, 32, 28,
              29, 29, 28, 33, 34, 31, 39,
              30, 29, 35, 29, 28,
              26, 34,  31, 33, 28, 31, 22,
              29, 29, 28, 29, 19,
              31, 33, 33, 28, 19, 31, 34,
              28, 28, 31, 27, 24,
              31)
hit5$age


# 루타(TB) 값을 이용한 기본 차트

plot(hit5$age,
     hit5$TB,
     pch = 19,
     col = "steelblue",
     cex = 1.5,
     main = "나이와 타자 성적",
     xlab = "AGE",
     ylab = "TB")


# 추장득점(XR)/타석(PA) 값이 .18보다 큰 데이터만 추출

hit51 <- hit5[hit5$XR/hit5$PA > 0.18, ]

points(hit51$age,
       hit51$TB,
       pch = 19,
       col = "red",
       cex = 1.5)

text(hit51$age,
     hit51$TB,
     pos = 3,
     labels = hit51$name)



# lowess ()
# 이 함수는 국소 가중 다항 회귀를 사용하는
# LOWESS smoother에 대한 계산을 수행한다 (References 참조).

# lowess는 복잡한 알고리즘에 의해 정의되며,
# Ratfor 오리지널 (W.S. Cleveland)은
# R 소스에서 ㅍ ㅏ일 'src / appl / lowess.doc' 로 찾을 수 있다.

# 일반적으로 로컬 선형 다항식 피팅이 사용되지만
# 경우에 따라 (파일 참조) 로컬 상수 피팅을 사용할 수 있다.

# '로컬'은 가장 가까운 이웃 (f * n)까지의 거리로 정의되며,
# 이웃에 속하는 x 에 대해서는 삼중 가중이 사용된다.


# Arguments
# x,y : 산점도에서 점의 좌표를 제공하는 벡터.
# 또는 단일 플로팅 구조를 지정할 수 있습니다 (xy.coords 참조).

# f : 부드러운 스팬
# 이는 각 값에서 평활도에 영향을 주는 플롯의 점 비율을 제공
# 값이 클수록 더 부드러워진다

# iter
# 수행해야 할 '강화' 반복 횟수가
# 더 작은 iter 값을 사용하면 lowess 실행 속도가 빨라진다.

# delta : 기본값은 x 범위의 1/100

lines(lowess(hit5$TB~hit5$age),
      lwd = 2,
      lty = 3)

#################################

plot(hit5$age,
     hit5$TB,
     pch = 19,
     col = "steelblue",
     cex = .15,
     main = "프로야구 타자 - 나이와 성적",
     sub = "red: XR/PA>0.18",
     xlab = "AGE",
     ylab = "TB")

hit51 <- hit5[hit5$XR/hit5$PA>0.18,]

points <- hit[hit5$age, hit51$TB, pch = 19, col = "red", cex = 1.5)

text(hit5$age, hit5$TB, pos = 3, labels = hit5$name)

lines(lowess(hit5$TB~hit5$age), lwd = 2, lty = 3)


###############################
# KBO 프로야구 가을야구 예상 분석
# 플레이오프와 코리아시리즈
# hit20180919.csv

# 미리보는 KBO 2018 가을야구
# 플레이오프 : 한화 - SK
# 코리아시리즈 : SK - 두산
# 순서대로 진행된다고 했을 때 벌어질 타격전의 예상시나리오?
# 9.19일까지의 KBO 타격 통계를 바탕으로 예상해본다면?

#----------[EDA] KBO 가을야구 미리보기 연습 -----------#

# [1] scatter plot 을 통한 타자들 구성 분포 탐색
# [2] barplot을 활용한 팀별 성향 비교

# 데이터 불러오기
# KBO 데이터 타자순위로 60명. 2018.9.19일까지 통계 반영

hit0 <- read.csv("hit20180919.csv")

# 타석당 타점을 중요하다고 보고 비율변수 추가

hit0$pparbi <- hit0$RBI/hit0$PA

hit1 <- hit0[order(hit0$pparbi, decreasing = T), ]

head(hit1, 5)

# 전반적인 상관관계 확인

pairs(hit1[, 4:7])

# 타석이 많다고 타율이 자동적으로 높지는 않다

# 주요 관심 특정 변수를 활용한 scatter plot 으로 대세 파악하기

plot(hit1$AVG, hit1$ISOP,
     cex = 0.9, pch = 19,
     col = ifelse(hit1$team == "두산", "navy",
                   ifelse(hit1$team == "SK", "red",
                          ifelse(hit1$team == "한화", "orange", "lightblue")
                          )
                   ),
      main = "가을야구 Preview - stat a.o. 20180919",
      xlab = "AVG",
      ylab = "ISOP",
      sub = "only high XR/PA hitters labeled")



# 선수이름을 표시
# 타석대비 득점생산력이 높은 소수의 선수만 이름 표시

text(hit1$AVG,
     hit1$ISOP,
     labels = ifelse((hit1$XR/hit1$PA) > .17 & hit1$team %in% 
                        c("두산", "SK", "한화"),
                     as.character(hit1$name), ""),
     pos = 3,
     cex = 0.7)

abline(h = .28, lty = 3)
abline(v = .32, lty = 3)


# R에서 오라클 데이터 읽어오기

# R에서 데이터베이스에 접속해서 데이터를 가져오는 방법은 2가지 정도

# 하나는 자바의 기능을 이용한 것
# 또 다른 하나는 다른 언어의 기능을 사용하지 않고
# 순수 R의 패키지를 이용하는 방법

# R에서는 Select 구문을 실행하는 경우 바로 data.frame으로 리턴
# 관계형 데이터베이스의 데이터를 사용하는 것이
# 일반적인 프로그래밍 언어보다 편리.

# 자바의 JDBC를 이용하기 위한 패키지 설정
install.packages("RJDBC")
install.packages("igraph")

# 라이브러리 등록
library(RJDBC)
library(rJava)
library(igraph)

# 작업 디렉토리 안에 data 디렉토리에 ojdbc6.jar 파일이 존대
jdbcDriver <- JDBC(driverClass = "oracle.jdbc.OracleDriver",
                   classPath = "ojdbc6.jar")

# 데이터베이스 연결
con <- dbConnect(jdbcDriver,
                 "jdbc:oracle:thin:@localhost:1521:XE",
                 "byr",
                 "921215")

# 데이터베이스 연결 종료
# dbDisconnect(con)

# dbGetQuery나 dbSendQuery를 이용해서
# 첫 번째 매개변수로는 데이터베이스 연결변수를 주고
# 두 번째 매개변수로 select 구문을 주면 데이터를 가져온다.

# dbGetQuery는 data.frame을 리턴하고
# dbGetQuery는 무조건 모든 데이터를 가져와서
# data.frame을 만들기 때문에 많은 양의 데이터가 검색된 경우
# 메모리 부족 현상을 일으킬 수 있다.

# 이런 경우에는 dbSendQuery를 이용해서
# 데이터에 대한 포인터만 가져온 후
# fetch(커서, n=1)을 이용해서

# cursor는
# 데이터를 주고 다음으로 자동으로 넘어가는 특징을 가지고 있다.
# 하지만 전진만 하기 때문에 한번 읽은 데이터를 다시 읽지 못한다.

# select 구문을 실행하고 저장하기
result <- dbGetQuery(con, "select * from student")

# 결과 확인
result

# 유형 확인
class(result)

# 실행 결과를 가지고 그래프를 그릴 수 있는 프레임으로 변환
g <- graph.data.frame(result, directed = T)

# 관계도 작성
plot(g,
     layout = layout.fruchterman.reingold,
     vertext.size = 8,
     edge.array.size = 0.5)

# 오라클 쿼리 실행 (sqldf 패키지)
# 오라클 sql쿼리문을 이용하기 위한 패키지 설정
install.packages("sqldf")

# 오라클 sql쿼리문을 이용하기 위한 라이브러리 등록
library(sqldf)

head(iris)

sqldf("select Species from iris")

# head
head(iris)
sqldf("select * from iris limit 4")

# subset
subset(iris, Species %in% c("setosa"))
sqldf("select * from iris where Species in ('setosa')")

subset(iris, Sepal.Length >= 5 & Sepal.Length <= 5.2)
sqldf('select * from iris where "sepal.Length" between 5 and 6')


# 금일 날씨 xml 데이터
http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=109

# JSON 샘플 데이터
https://api.github.com/users/hadley/repos

########################
# XML 파싱
########################
# html 파싱과 동일
# XML은 엄격한 HTML이고 태그의 해석을 브라우저가 하지 않고
# 클라이언트가 직접 한다는 점이 HTML과 다른 점
# 모든 HTML 파싱 방법은 XML에 적용 가능
# XML파싱 방법으로는 파싱하지 못하는 HTML이 있을 수도 있다.

# 1. 태그의 내용 가져오기
# 문자열을 가지고 올 주소를 생성
url <- 'http://www.kma.go.kr/weather/forecast/mid-term-xml.jsp?stnId=109'

library(rvest)
# 문자열 다운로드
weather <- read_html(url)
weather

tmn <- weather %>% html_nodes("tmn") %>% html_text()
tmn


# JSON 파싱
###############################
# jsonlite 패키지와 httr 패키지를 이용
# frameJSON() 함수에 URL을 대입하면 data.frame으로 리턴

# 즉, https://api.github.com/users/hadley/repos 데이터를
# data.frame으로 변환

# 1. 필요한 패키지 설치
install.packages("jsonlite")
install.packages("httr")

# 2. 필요한 패키지 로드
rm(list = ls()) # Environment 제거

library(jsonlite)
library(httr)

# 3. json 데이터 가져오기
df <- fromJSON("https://api.github.com/users/hadley/repos")
df







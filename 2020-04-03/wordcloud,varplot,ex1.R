

# 패키지 설치 및 로드
# 패키지 설치
install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")


# 사전 설정하기
useNIADic()

# 데이터 준비
# 데이터 불러오기
txt <- readLines("hiphop.txt")

head(txt)


# 특수문자 제거
install.packages("stringr")
library(stringr)

# 특수문자 제거
txt <- str_replace_all(txt, "\\W", " ")

class(txt)
View(txt)

# 가장 많이 사용된 단어 알아보기
# 명사 추출하기
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")

# 가사에서 명사 추출
nouns <- extractNoun(txt)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))
dim(wordcount)
View(wordcount)
wordcount


# 자주 사용된 단어 빈도표 만들기
# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)

# 변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
df_word

# 두 글자 이상 단어 추출
df_word <- filter(df_word, nchar(word) >= 2)

top_20 <- df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)

View(top_20)


# 패키지 준비하기
# 패키지 설치
install.packages("wordcloud")

# 패키지 로드
library(wordcloud)

library(RColorBrewer)

# 단어 색상 목록 만들기
pal <- brewer.pal(8, "Dark2") # Dark2 색상 목록에서 8개 색상 추출

# 워드 클라우드 생성
set.seed(1234)                      # 난수 고정
wordcloud(words = df_word$word,     # 단어
          freq = df_word$freq,      # 빈도
          min.freq = 2,             # 최소 단어 빈도
          max.words = 200,          # 표현 단어 수
          random.order = F,         # 고빈도 단어 중앙 배치
          rot.pre = .1,             # 회전 단어 비율
          scale = c(4, 0.3),        # 단어 크기 범위
          colors = pal)             # 색깔 목록

txt2 <- readLines("remake.txt")

txt2 <- str_replace_all(txt2, "\\W", " ")

nouns2 <- extractNoun(txt2)

wordcount2 <- table(unlist(nouns2))

df_word2 <- as.data.frame(wordcount2, stringsAsFactors = F)

df_word2 <- rename(df_word2,
                  word = Var1,
                  freq = Freq)
df_word2
df_word2 <- filter(df_word2, nchar(word) >= 2)

top_40 <- df_word2 %>% 
  arrange(desc(freq)) %>% 
  head(40)

set.seed(1234)                      # 난수 고정
wordcloud(words = df_word2$word,     # 단어
          freq = df_word2$freq,      # 빈도
          min.freq = 2,             # 최소 단어 빈도
          max.words = 200,          # 표현 단어 수
          random.order = F,         # 고빈도 단어 중앙 배치
          rot.pre = .1,             # 회전 단어 비율
          scale = c(4, 0.3),        # 단어 크기 범위
          colors = pal)             # 색깔 목록


# 10-2 국정원 트윗 텍스트 마이닝
- 국정원 계정 트윗 데이터
  - 국정원 대선 개입 사실이 밝혀져 논란이 됐던 2013년 6월, 독립 언론 뉴스타파가 
  - 인터넷을 통해
  - 국정원 계정으로 작성된 3,744개 트윅

# 데이터 준비하기
# 데이터 로드
twitter <- read.csv("twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")

# 변수명 수정
twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)
View(twitter)
names(twitter)

# 특수문자 제거
twitter$tw <- str_replace_all(twitter$tw, "\\W", " ")


# 단어 빈도표 만들기
# 트윗에서 명사추출
nouns <- extractNoun(twitter$tw)

# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <- table(unlist(nouns))

# 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)

# 변수명 수정
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

# 단어 빈도 막대 그래프 만들기
library(ggplot2)


top40 <- df_word %>% 
  arrange(desc(freq)) %>% 
  head(40)


df_word <- filter(df_word, nchar(word) >= 3)

order <- arrange(top40, freq)$word      # 빈도 순서 변수 생성

ggplot(data = top40, aes(x = word, y = freq)) +
  ylim(0, 2500) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limit = order) +
  geom_text(aes(label = freq), hjust = -0.3)


View(df_word)





library(devtools)
library(htmlwidgets)
library(htmltools)
library(jsonlite)
library(yaml)
library(base64enc)
library(tm)
library(wordcloud2)


# 3. 워드클라우드2 그리기(기본)
wordcloud2(top40)

# 3.1 wordcloud2 크기, 색 변경(size, color)
wordcloud2(top40, size = 0.5, col = "random-dark")

# 3.2 키워드 회전 정도 조절(rotateRatio)
wordcloud2(top40, size = 0.5, col="random-dark", rotateRatio = 0)

# 3.3 배경 색 검정 (backgroundColor)
wordcloud2(top40, size = 0.5, col="random-light", backgroundColor = "black")


# 특정 개수 이상 추출되는 글자만 색깔을 변경하여 나타나도록 설정
# http://html-color-codes.info/Korean/

# 사이값 지정시 : (weight > 800 && weight < 1000)
# 100개 이상 검색될 시 노랑으로, 아니면 초록으로 표현한다.
In_out_colors = "function(word, weigiht) {
                    return (weight > 100) ? '#F3EF12':'#1EC612'
                  }"

# wordcloud2 그리기

# 기존모형으로 wordcloud2 생성
# 모양선택 : shape = 'circle', 'cardioid',
#                    'diamond', 'triangle-forward',
#                    'triangle', 'pentagon', 'star'

wordcloud2(df_word,
           shape = 'circle',
           size = 0.8,
           color = 'random-light',
           backgroundColor = "black")

wordcloud2(df_word,
           shape = 'diamond',
           size = 0.8,
           color = 'random-light',
           backgroundColor = "black")

wordcloud2(df_word,
           shape = 'pentagon',
           size = 0.8,
           color = 'random-light',
           backgroundColor = "black")

wordcloud2(df_word,
           shape = 'cardioid',
           size = 0.8,
           color = 'random-light',
           backgroundColor = "black")

# 단계 구분도(Choropleth Map)
# - 지역별 통계치를 색깔의 차이로 표현한 지도
# - 인구나 소득 같은 특성이 지역별로 얼마나 다른지 쉽게 이해할 수 있음

# 11-1. 미국 주별 강력 범죄율 단계 구분도 만들기
# 패키지 준비하기
install.packages("ggiraphExtra")
library(ggiraphExtra)

str(USArrests)

head(USArrests)

library(tibble)

# 행 이름을 state 변수로 바꿔 데이터 프레임 생성
crime <- rownames_to_column(USArrests, var = "state")

head(crime)
# 지도 데이터와 동일하게 맞추기 위해 state 의 값을 소문자로 수정
crime$state <- tolower(crime$state)

View(USArrests)
View(crime)


# tibble(티블)은 행 이름을 가질 수 있지만 (예: 일반 데이터 프레임에서 변환 할 때)
# [ 연산자로 서브 셋팅 할 때 제거됩니다.
# NULL이 아닌 행 이름을 티블에 지정하려고 하면 경고가 발생합니다.
# 일반적으로 행 이름은 기본적으로 다른 모든 열과
# 의미가 다른 문자 열이므로 행 이름을 사용하지 않는 것이 가장 좋습니다.
# 이러한 함수를 사용하면 데이터 프레임에 행 이름 (has_rownames())이 있는지 감지하거나,
# 제거하거나 (remove_rownames())
# 명시적 열 (rownames_to_column() 및 column_to_rownames()) 사이에서 앞뒤로 변환 할 수 있습니다.
# rowid_to_column ()도 포함되어 있습니다.
# 이것은 1부터 시작하여 순차적인 행 ID를 오름차순으로 하는 데이터 프레임의 시작
# 부분에 열을 추가합니다. 기존 행 이름이 제거됩니다.


# 미국 주 지도 데이터 준비하기
library(ggplot2)
states_map <- map_data("state")
str(states_map)

# 단계 구분도 만들기
ggChoropleth(data = crime,          # 지도에 표현할 데이터
             aes(fill = Murder,     # 색깔로 표현할 변수
                 map_id = state),   # 지역 기준 변수
             map = states_map)      # 지도 데이터
# install.package("mapproj")
# library(mpproj)
# Assault
ggChoropleth(data = crime,          # 지도에 표현할 데이터
             aes(fill = Assault,     # 색깔로 표현할 변수
                 map_id = state),   # 지역 기준 변수
             map = states_map)      # 지도 데이터
# UrbanPop
ggChoropleth(data = crime,          # 지도에 표현할 데이터
             aes(fill = UrbanPop,     # 색깔로 표현할 변수
                 map_id = state),   # 지역 기준 변수
             map = states_map)      # 지도 데이터


# 인터랙티브 단계 구분도 만들기

ggChoropleth(data = crime,          # 지도에 표현할 데이터
             aes(fill = Assault,     # 색깔로 표현할 변수
                 map_id = state),   # 지역 기준 변수
             map = states_map,      # 지도 데이터
             interactive = T)       # 인터랙티브


# 11-2. 대한민국 시도별 인구, 결핵 환자 수 단계 구분도 만들기
# 대한민국 시도별 인구 단계 구분도 만들기
# 패키지 준비하기
install.packages("stringi")

install.packages("devtools")

# kormaps2014 제작자 깃허브 설명서
# https://github.com/cardiomoon/kormaps2014/blob/master/kormaps2014.Rmd
devtools::install_github("cardiomoon/kormaps2014")
library(kormaps2014)

# 대한민국 시도별 인구 데이터 준비하기
str(changeCode(korpop1))

library(dplyr)
korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)

korpop2 <- rename(korpop2,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)
View(korpop2)
korpop3 <- rename(korpop3,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)
# 단계 구분도 만들기
ggChoropleth(data = korpop1,
             aes(fill = pop,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)

ggChoropleth(data = korpop2,
             aes(fill = pop,
                 map_id = code,
                 tooltip = name),
             map = kormap2,
             interactive = T)

ggChoropleth(data = korpop3,
             aes(fill = pop,
                 map_id = code,
                 tooltip = name),
             map = kormap3,
             interactive = T)


# 대한민국 시도별 결핵 환자 수 단계 구분도 만들기
str(changeCode(tbc))


ggChoropleth(data = tbc,
             aes(fill = NewPts,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)




# 12. 인터랙티브 그래프
# 12-1. plotly 패키지로 인터랙티브 그래프 만들기

# 인터랙티브 그래프 만들기
# 패키지 준비하기
install.packages("plotly")
library(plotly)

# ggplot으로 그래프 만들기
library(ggplot2)
p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()

# 사이트
# https://plotly.com/ 
ggplotly(p)

# 인터랙티브 막대 그래프 만들기
p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge")

ggplotly(p)


# 12-2. dygraphs 패키지로 인터랙티브 시계열 그래프 만들기

# 인터랙티브 시계열 그래프 만들기
# 패키지 준비하기
install.packages("dygraphs")
library(dygraphs)

# 데이터 준비하기
economics <- ggplot2::economics
head(economics)

# 시간 순서 속성을 지니는 xts 데이터 타입으로 변경
library(xts)

eco <- xts(economics$unemploy, order.by = economics$date)
head(eco)

# 그래프 생성
dygraph((eco))

# 날짜 범위 선택 기능
dygraph(eco) %>% dyRangeSelector()

# 여러 값 표현하기
# 저축률
eco_a <- xts(economics$psavert, order.by = economics$date)
head(eco_a)
# 실업자 수
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)
head(eco_b)
# 합치기
eco2 <- cbind(eco_a, eco_b)                   # 데이터 결합
colnames(eco2) <- c("psavert", "unemploy")    # 변수명 바꾸기
head(eco2)

# http://dygraphs.com/
dygraph(eco2) %>% dyRangeSelector()



# 13 통계 분석 기법을 이용
# 13-1 통계적 가설 검정이란
# 기술 통계와 추론 통계
# - 기술 통계(Descriptive statistics)
#   - 데이터를 요약해 설명하는 통계 기법
#   - ex) 사람들이 받는 월급을 집계해 전체 월급 평균 구하기
# - 추론 통게(Inferential statistics)
#   - 단순히 숫자를 요약하는 것을 넘어 어떤 값이 발생할 확률을 계산하는 통계 기법
#   - ex) 수집된 데이터에서 성별에 따라 월급에 차이가 있는 것으로 
#          나타났을 때, 이런 차이가 우연히 발생할 확률을 계산
# - 기술 통계 분석에서 집단 간 차이가 있는 것으로 나타났더라도 이는 우연에 의한 차이일 수 있음
#   - 데이터를 이용해 신뢰할 수 있는 결론을 내리려면 유의확률을 계산하는  
#      통계적 가설 검정절차를 거쳐야 함

# 통계적 가설 검정
# - 통계적 가설 검정(Statistical hypothesis text)
#   - 유의확률을 이용해 가설을 검정하는 방법
# - 유의확률(Significance probability, p-value)
#   - 실제로는 집단 간 차이가 없는데 우연히 차이가 있는 데이터가 추출될 확률
#   - 분석 결과 유의확률이 크게 나타났다면
#     - '집단 간 차이가 통계적으로 유의하지 않다'고 해석
#     - 실제로 차이가 없더라도 우연에 의해 이 정도의 차이가 관찰될 가능성이 크다는 의미
#   - 분석 결과 유의확률이 작게 나타났다면
#     - '집단 간 차이가 통계적으로 유의하다'고 해석
#     - 실제로 차이가 없는데 우연히 이 정도의 차이가 관찰될 가능성이 작다,
#        우연이라고 보기 힘들다는 의미


# 13-2. t 검정 - 두 집단의 평균 비교
# t검정(t-test)
# - 두 집단의 평균에 통계적으로 유의한 차이가 있는지 알아볼 때 사용하는 통계 분석 기법

# compact 자동차와 suv 자동차의 도시 연비 t 검정
# 데이터 준비
mpg <- as.data.frame(ggplot2::mpg)
str(mpg)

library(dplyr)
mpg_diff <- mpg %>% 
  select(class, cty) %>% 
  filter(class %in% c("compact", "suv"))

View(mpg_diff)

table(mpg_diff$class)

# t-test
t.test(data = mpg_diff, cty ~ class, var.equal = T)


# 일반 휘발유와 고급 휴ㅣ발유의 도시 연비 t검정
# 데이터 준비
mpg_diff2 <- mpg %>% 
  select(fl, cty) %>% 
  filter(fl %in% c("r", "p"))   # r:regular, p:premium

table(mpg_diff2$fl)

# t-test
t.test(data = mpg_diff2, cty ~ fl, var.equal = T)


# 13-3. 상관분석 - 두 변수의 관계성 분석
# 상관분석(Correlation Analysis)
# - 두 연속 변수가 서로 관련이 있는지 검정하는 통계 분석 기법
# - 상관계수(Correlation Coefficient)
#   - 두 변수가 얼마나 관련되어 있는지, 관련성의 정도를 나타내는 값
#   - 0~1 사이의 값을 지니고 1에 가까울수록 관련성이 크다는 의미
#   - 상관계수가 양수면 정비례, 음수면 반비례 관계


# 실업자 수와 개인 소비 지출의 상관관계
# 데이터 준비
economics <- as.data.frame(ggplot2::economics)

# 상관분석
cor.test(economics$unemploy, economics$pce)


# 상관행렬 히트맵 만들기
# - 상관행렬(Correlation Matrix)
#   - 여러 변수 간 상관계수를 행렬로 나타낸 표
#   - 어떤 변수끼리 관련이 크고 적은지 파악할 수 있음


# 데이터 준비
head(mtcars)

# 상관행렬 만들기
car_cor <- cor(mtcars)   # 상관행렬 생성
round(car_cor, 2)        # 소수점 셋째 자리에서 반올림해서 출력

# 상관행렬 히트맵 만들기
# - 히트맵(head map): 값의 크기를 색깔로 표현한 그래프
install.packages("corrplot")
library(corrplot)

corrplot(car_cor)

# 원 대신 상관계수 표시
corrplot(car_cor, method = "number")

# 다양한 파라미터 지정하기
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))

corrplot(car_cor,
         method = "color",      # 색깔로 표현
         col = col(200),        # 색상 200개 선정
         type = "lower",        # 왼쪽 아래 행렬만 표시
         order = "hclust",      # 유사한 상관계수끼리 군집화
         addCoef.col = "black", # 상관계수 색깔
         tl.col = "black",      # 변수명 색깔
         tl.srt = 45,           # 변수명 45도 기울임
         diag = F)              # 대각 행렬 제외




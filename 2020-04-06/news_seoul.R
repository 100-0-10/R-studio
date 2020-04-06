# [R] 파싱하여 데이터 가져오기

# 웹에서 문자열 가져오기
# rvest 패키지의 read_html("url");

# html 파싱
# 특정 노드의 데이터 가져오기

# 문자열에서 html_nodes(태그 또는 클래스 또는 아이디)를 이용하면
# 매개변수에 해당하는 모든 데이터를 가져온다.
# 마지막 데이터까지 가져온 경우
# html_text() 메소드나 html_attr(속성명)을 이용.

# 네이버 (http://www.naver.com")

install.packages("rvest")

library(rvest)

naver <- read_html("http://www.naver.com")
naver

# html 파싱

# 마지막 데이터까지 가져온 경우
# html_text() 메소드나 html_attr(속성명) 을ㅇ ㅣ용해서
# 문자열로 가져오는 것이 가능

# 테이블의 내용은 html_table() 메소드로
# 테이블의 데이터를 프레임으로 바로 변환해 준다.

# %>%은 메소드의 연산결과를 가지고
# 다음 메소드를 호출할 때 사용하는 chain operation 연산자이다.

#############################
# 네이버 팟 캐스트 크롤링
#############################

# 크롤링을 할 때 가장 중요한 것은
# 원하는 부분을 구분할 수 있는 태그나 클래스 또는 아이디를 찾아내는 일이다 
# 고려해야 할 또 하나의 부분은 현재 페이지에 원하는 데이터가 있는지
# 아니면 링크만 존재하는지 확인하는 것.

# 1. 웹에서 데이터를 가져오기 위한 패키지 설치
install.packages("rvest")

# 2. 패키지 메모리 로드
library(rvest)

# 3. 문자열을 가지고 올 주소를 생성
url <- 'http://tv.naver.com/r/category/drama'

# 4. 문자열 다운로드
cast <- read_html(url)

# 5. 문자열 확인
cast

# 6. span 안에 내용들이 출력
craw <- cast %>% html_nodes(".tit") %>% html_nodes('span')
craw

# 7. tit 클래스 안에 있는 span 안에 내용 가져오기
craw <- cast %>% html_nodes(".tit") %>% html_nodes('span') %>% html_text()
craw

# 8. tooltip 태그 안의 내용 가져오기
craw <- cast %>% html_nodes("tooltip") %>% html_text()
craw


# 한겨레 신문에서 데이터를 검색한 후
# 검색 결과를 가지고 워드 클라우드 만들기

# 한겨레 신문사에서 지진으로 뉴스 검색하는 경우
# url
# http://search.hani.co.kr/Search?command=query&keyword=검색어부분&sort=d&period=all&media=news

# 기사 검색이나 SNS검색을 하는 경우
# 검색어를 가지고 검색하면 그 결과는 검색어를 가진 URL의 모임이다
# 기사나 SNS 글이 아니다

# 검색결과에서 URL을 추출해서 그 URL의 기사내용을 다시 가져와야 한다
# dt 태그안에 있는 a태그의 href 속성의 값이 실제 기사의 링크이다

# 실제 기사에서 클래스가 text 안에 있는 내용이 기사 내용이다

# 1. 기존의 변수를 모두 제거
rm(list=ls())

# 2. 필요한 패키지 설치
install.packages("stringr")       # 문자열 패키지
install.packages("wordcloud")     # 시각화 패키지
install.packages("KoNLP")         # 사전을 포함한 패키지
install.packages("dplyr")         # 데이터프레임 조작하기 위한 전용 패키지
install.packages("RcolorBrewer")  # 색에 관련된 패키지
install.packages("rvest")         # 웹페이지 크롤링 할 때 기본적인 패키지

# 3. 필요한 패키지 로드
library(stringr)
library(wordcloud)
library(KoNLP)
library(dplyr)
library(RColorBrewer)
library(memoise)

# 3. 웹에서 문자열을 가져와서 html 파싱을 하기 위한 패키지 로드
library(rvest)

# 4. 기사 검색을 url을 생성
url <- 'http://search.hani.co.kr/Search?command=query&keyword=날씨&sort=d&period=all&media=news'

# 5. url에 해당하는 데이터 가져오기
k <- read_html(url, encoding = "utf-8")
k


# 6. dt 태그 안에 있는 a 태그들의 href 속성의 값을 가져오기
k <- k %>% html_nodes("dt") %>% html_nodes("a") %>% html_attr("href")
k

# 7. k에 저장된 모든 URL에 해당하는 데이터의 클래스가 text인 데이터를 읽어서 파일에 저장
# for(임시변수 in 컬렉션이름) {
# }

for(addr in k) {
  temp <- read_html(addr) %>% html_nodes(".text") %>% 
    html_text()
  cat(temp, file = "temp.txt", append = TRUE)
}

temp

# 8. 파일의 모든 내용 가져오기
txt <- readLines("temp.txt")
head(txt)

txt <- str_replace_all(txt, "\\W", " ")


# 9. 명사만 추출
useNIADic()
nouns <- extractNoun(txt)
nouns

# 10. 빈도수 만들기 - 각 단어가 몇 번씩 나왔는지
wordcount <- table(unlist(nouns))
wordcount


# 11. 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word
class(df_word)



# 12. 필터링
df_word <- filter(df_word, nchar(Var1) >= 2)

# 13. 워드클라우드 색상 판 생성
pal <- brewer.pal(8, "Dark2")

# 14. 시드 설정
set.seed(1234)

# 15. 워드 클라우드 생성
wordcloud(words = df_word$Var1,
          freq = df_word$Freq,
          min.freq = 2, max.words = 200,
          random.order = F,
          rot.per = .1, scale = c(4, 0.3), colors = pal)




# 동아일보
# http://news.donga.com/search?p=1&query=코로나19&check_news=1&more=1&sorting=1&search_date=1&v1=&v2=&range=1


# 4. 기사 검색을 url을 생성
donga <- 'http://news.donga.com/search?p=1&query=코로나19&check_news=1&more=1&sorting=1&v1=&v2&range=1'
# http://news.donga.com/search?p=1&query=코로나19&check_news=1&more=1&sorting=1&v1=&v2&range=1
# 5. url에 해당하는 데이터 가져오기
link <- read_html(donga, encoding = "utf-8")
link


# 6. dt 태그 안에 있는 a 태그들의 href 속성의 값을 가져오기
addr <- link %>% html_nodes(".t") %>% html_nodes(".tit") %>% html_nodes("a") %>% html_attr("href")
addr

k <- k %>% html_nodes("p") %>% html_nodes("a") %>% html_attr("href")
k

# 7. k에 저장된 모든 URL에 해당하는 데이터의 클래스가 text인 데이터를 읽어서 파일에 저장
# for(임시변수 in 컬렉션이름) {
# }

for(url in addr) {
  print(url)
}

for(url in addr) {
  content <- read_html(url) %>% html_nodes(".article_txt") %>%
    html_text()
  cat(content, file = "article.txt", append = TRUE)
}

content

# 8. 파일의 모든 내용 가져오기
txt <- readLines("article.txt")
head(txt)

txt <- str_replace_all(txt, "\\W", " ")


# 9. 명사만 추출
useNIADic()
nouns <- extractNoun(txt)
nouns

# 10. 빈도수 만들기 - 각 단어가 몇 번씩 나왔는지
wordcount <- table(unlist(nouns))
wordcount


# 11. 데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word
class(df_word)



# 12. 필터링
df_word <- filter(df_word, nchar(Var1) >= 2)

# 13. 워드클라우드 색상 판 생성
pal <- brewer.pal(8, "Dark2")

# 14. 시드 설정
set.seed(1234)

# 15. 워드 클라우드 생성
wordcloud(words = df_word$Var1,
          freq = df_word$Freq,
          min.freq = 2, max.words = 200,
          random.order = F,
          rot.per = .1, scale = c(4, 0.3), colors = pal)



#################
# R 키보드 이용한 데이터 입력

# c()함수를 이용한 데이터 입력
x <- c(10.4, 5, 6, 3.1, 6.4, 21.7)
x
# [1] 10.4, 5.6, 3.1, 6.4, 21.7

# scan()함수는 외부의 텍스트파일을 불러올 때 외에도
# 키보드 입력에도 이용할 수 있는 함수이며,
# 일반적으로 R Console에서 프로프트가 [1]과 보여지나
# scan()함수를 실행할 경우는 '1:'과 같은 형태로 출력된다.

# scan()함수 이용
x <- scan()

x

x <- scan(what=" ")


# edit()함수는 데이터 편집기 창을 직접 띄워
# 데이터를 직접 입력하는 방식으로
# 편집기는 셀의 형식을 띠고 있으며,
# 각 셀에 데이터를 입력한 후 수정할 경우는
# 메뉴에서 <편집> - <데이터 편집기>를 선택하여 수정할 수 있다.
# edit()함수를 이용하여 데이터 입력기를 호출한 후 데이터를 입력한다

age = data.frame()
age = edit(age)
age

library(KoNLP)
library(wordcloud)
library(stringr)

useSejongDic()

# 정규 표현식 예
text <- c("phone: 010-1234-5678",
          "home: 02-123-1123",
          "이름:홍길동")

grep("[[:digit:]]", text, value = T)
# [1] "phone: 010-1234-5678" "home: 02-123-1123"  

gsub("[[:digit:]]", "x", text)
# [1] "phone: xxx-xxxx-xxxx" "home: xx-xxx-xxxx"    "이름:홍길동"    

# 한글 문자열분석에서 매우 중요한 정규표현식.
grep("[가-핳]", text, value=T)
# [1] "이름:홍길동"

# 영문 소문자만
grep("[[:lower:]]", text, value=T)
# [1] "phone: 010-1234-5678" "home: 02-123-1123"   

# 정수로 인식하는 것들만
gsub("^[1-9][0-9]*$", " ", c("08", "1", "19 189", "78"))
# [1] "08"     " "      "19 189" " " 

# 
gsub("^[0-9]+(\\.[0-9]{1,2})?$", "zz",
     c("123","123.17","123.456","123.","12.79"))
# [1] "zz"      "zz"      "123.456" "123."    "zz"



# 블로거들이 추천하는 서울 명소 분석하기

# "seoul_go.txt" 파일을 사용하여
# 블로거들이 추천하는
# 서울 명소들을 워드 클라우드로 생성
# (서울명소추가 : 서울명소merge.txt)
# (제거단어 : 서울명소gsub.txt)

# setwd("c:\\r_temp")
# 필요 패키지를 설치하는데 이미 설치가 되어있어서
# 경고가 나오니 무시
install.packages("KoNLP")
install.packages("wordcloud")
install.packages("stringr")

useSejongDic()

mergeUserDic(data.frame(readLines("서울명소merge.txt"), "ncn"))

txt <- readLines("seoul_go.txt")
head(txt, 10)

place <- sapply(txt, extractNoun, USE.NAMES = F)


head(place, 10)
head(unlist(place), 30)

# 영어제거
c <- unlist(place)
res <- str_replace_all(c, "[^[:alpha:]]", "")


head(res, 30)

txt <- readLines("서울명소gsub.txt")
txt

cnt_txt <- length(txt)
cnt_txt

for(i in 1:cnt_txt) {
  res <- gsub((txt[i]), "", res)
}

res

res2 <- Filter(function(x) {nchar(x) >= 2}, res)
nrow(res2)

write(res2, "seoul_go2.txt")

res3 <- read.table("seoul_go2.txt")

# 테이블화
wordcount <- table(res3)
head(sort(wordcount, decreasing = T), 30)

library(RColorBrewer)

palete <- brewer.pal(8, "Set2")

wordcloud(names(wordcount),
          freq=wordcount,
          scale = c(3, 1),
          rot.per = 0.25,
          min.freq = 5,
          random.order = F,
          random.color = T,
          colors = palete)

legend(0.3,
       1,
       "블로거 추천 서울 명소 분석",
       cex = 0.6,
       fill = NA,
       border = NA,
       bg = "white",
       text.col = "red",
       text.font = 2,
       box.col = "red")
)


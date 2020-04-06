

# "제주도 여행코스 추천" 검색어 결과를 그래프로 표시.

# 단어 추가 (제주도여행지.txt) 를 읽어들인 후, dataframe 으로 변경하여 기존 사전에 추가
# 데이터 읽어오기 (jeju.txt)
# 한글 외 삭제, 영어
# 읽어들인 데이터로부터 제거할 단어 리스트 읽어오기 (제주도여행코수gsub.txt)
# 두 글자 이상인 단어만 추출
# 현재까지의 작업을 파일로 저장 후, 저장된 파일 읽기
# 단어 빈도 수 구한 후, 워드클라우드 작업

# 가장 추천 수가 많은 상위 10개를 골라서
# 1.pie 그래프로 출력.
# 2.bar 형태의 그래프로 표시하기
# 3. 옆으로 누운 바 그래프 그리기
# 4. 3D Pie Chart로 표현. (plotrix라는 패키지가 추가로 필요


mergeUserDic(data.frame("제주도여행지.txt"), "ncn")

txt <- readLines("jeju.txt")
head(txt, 10)

place <- sapply(txt, extractNoun, USE.NAMES = F)

head(place, 10)

# 영어제거
c <- unlist(place)
res <- str_replace_all(c, "[^[:alpha:]]", "")
res <- gsub(" ", "", res) # 공백 제거

txt <- readLines("제주도여행코스gsub.txt")
txt

cnt_txt <- length(txt)
cnt_txt

for(i in 1:cnt_txt) {
  res <- gsub((txt[i]), "", res)
}

res2 <- Filter(function(x) {nchar(x) >= 2}, res)

write(res2, "jeju_go2.txt")

res3 <- read.table("jeju_go2.txt")

# 단어 빈도 수
# 테이블화
wordcount <- table(res3)
top10 = data.frame(head(sort(wordcount, decreasing = T), 10))
top10
View(top10)

# pie 그래프
pie(top10$Freq, top10$res3, main="제주도 추천 여행 코스 TOP 10")

# pie 색상 변경
pie(top10$Freq,
    top10$res3,
    col = rainbow(10),
    radius = 1,
    main = "제주도 추천 여행 코스 TOP 10")

# 수치값을 함께 출력하기
# 출력값 계산
pct <- round(top10$Freq/sum(top10$Freq) * 100, 1)
names(top10$res3)

# 지명과 계산 결과를 합하기
lab <- paste(names(top10$Freq), "\n", pct, "%")
lab

pie(top10$Freq,
    main = "제주도 추천 여행 코스 TOP 10",
    col = rainbow(10),
    cex = 0.8,
    labels = lab)

# bar 형태의 그래프
barplot(top10$Freq, names.arg = top10$res3, main = "제주도 추천 여행 코스 TOP 10")

# bar형태의 그래프로 표시하기
bchart <- head(sort(wordcount, decreasing=T), 10)
bchart

bp <- barplot(bchart,
              main = "제주도 추천 여행 코스 TOP 10",
              col = rainbow(10),
              cex.names=0.7,
              las = 2,
              ylim = c(0, 25))

# 출력값 계산
pct <- round(bchart/sum(bchart) * 100, 1)
pct
# 수치값 출력하기 (%)
text(x = bp,
     y = bchart * 1.05,
     labels = paste("(", pct, "%", ")"),
     col = "black",
     cex = 0.7)
# 수치값 출력하기 (건)
text(x = bp,
     y = bchart * 0.95,
     labels = paste(bchart,"건"),
     col = "black",
     cex = 0.7)
# 가로로 출력
bp <- barplot(bchart,
        main = "제주도 추천 여행 코스 Top 10",
        col = rainbow(10),
        xlim = c(0, 25),
        cex.name = 0.7,
        las = 1,
        horiz = T)
# 수치값 출력하기 (%)
text(y = bp,
     x = bchart * 1.15,
     labels = paste("(", pct, "%", ")"),
     col = "black",
     cex = 0.7)
# 수치값 출력하기 (건)
text(y = bp,
     x = bchart * 0.9,
     labels = paste(bchart,"건"),
     col = "black",
     cex = 0.7)


# 색 지정
palete <- brewer.pal(8, "Set2")

# wordcloud
wordcloud(names(wordcount),
          freq=wordcount,
          scale = c(3, 1),
          rot.per = 0.25,
          min.freq = 5,
          random.order = F,
          random.color = T,
          colors = palete)


# 3D pie chart
install.packages("plotrix")
library(plotrix)

# 수치값을 함께 출력하기
# 출력값 계산
th_pct <- round(bchart/sum(bchart) * 100, 1)

# 지명과 계산 결과를 합하기
th_names <- names(bchart)
th_labels <- paste(th_names, "\n", "(", th_pct, ")")

pie3D(bchart,
      main = "제주도 추천 여행 코스 Top 10",
      col = rainbow(10),
      cex = 0.3,
      labels = th_labels,
      explode = 0.05)

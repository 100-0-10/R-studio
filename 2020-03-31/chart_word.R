x <- c(9, 15, 20, 6)
label <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")
pie(x, labels = label, main = "부서별 영업 실적")

View(x)


# 기준선 변경
pie (x, init.angle = 90, labels = label, main = "부서별 영업 실적")

# 색과 라벨 수정
pct <- round(x/sum(x) * 100)
label <- paste(label, pct)
label <- paste(label, "%", sep = "")
pie (x, labels = label,
     init.anlge = 90,
     col = rainbow(length(x)),
     main = "부서별 영업 실적")

pie3D(x,
      labels = label,
      explode = 0.1,
      labelcex = 0.8,
      main = "부서별 영업 실적")

# 기본 바 차트 출력
height <- c(9, 15, 20, 6)
name <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")
barplot(height, names.arg = name, main = "부서별 영업 실적")
)


# 막대의 색 지정
barplot(height,
        names.arg = name,
        main = "부서별 영업 실적",
        col = rainbow(length(height)))

barplot(height,
        names.arg = name,
        main = "부서별 영업 실적",
        col = rainbow(length(height)),
        xlab = "부서",
        ylab = "영업 실적(억 원)",
        ylim = c(0, 25))


# 데이터 라벨 출력
bp <- barplot(height,
        names.arg = name,
        main = "부서별 영업 실적",
        col = rainbow(length(height)),
        xlab = "부서",
        ylab = "영업 실적(억 원)",
        

# pos 내장되있는 함수 포지션 
text(x = bp, y = height, labels = round(height, -0), pos = 3)

# 바 차트의 수평 회전(가로 막대)
barplot(height,
        names.arg = name,
        main = "부서별 영업 실적",
        col = rainbow(length(height)),
        xlab = "부서",
        ylab = "영업 실적(억 원)",
        xlim = c(0, 25),
        horiz=TRUE,
        width=50)


# 스택형 바 차트(Stacked Bar Chart)
height1 <- c(4, 18, 5, 8)
height2 <- c(9, 15, 20, 6)
height <- rbind(height1, height2)
View(height)

name <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")
legend_lbl <- c("2014년", "2015년")

barplot(height,
        names.arg = name,
        main = "부서별 영업 실적",
        xlab = "부서",
        ylab = "영업 실적(억 원)",
        col = c("darkblue", "red"),
        legend.text = legend_lbl,
        ylim = c(0, 35))


height1 <- c(4, 18, 5, 8)
height2 <- c(9, 15, 20, 6)
height3 <- c(3, 10, 15, 8)
height <- rbind(height1, height2, height3)

name <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")
legend_lbl <- c("2014년", "2015년", "2016년")

barplot(height,
        names.arg = name,
        main = "부서별 영업 실적",
        xlab = "부서",
        ylab = "영업 실적(억 원)",
        col = c("darkblue", "red", "yellow"),
        legend.text = legend_lbl,
        ylim = c(0, 50))

# 그룹형 바 차트 (Grouped Bar Chart)
barplot(height,
        names.arg = name,
        main = "부서별 영업 실적",
        xlab = "부서",
        ylab = "영업 실적(억 원)",
        col = c("darkblue", "red", "orange"),
        legend.text = legend_lbl,
        ylim = c(0, 50),
        beside = TRUE,
        args.legend = list(x = 'topright'))


# 일반적인 X-Y 플로팅
View(women)

weight <- women$weight
plot(weight)

height <- women$height
plot(height, weight, xlab="키", ylab = "몸무게")

# 플로팅 문자의 출력
plot(height, weight,,
     xlab = "키", ylab = "몸무게",
     pch = 23,
     col = "blue",
     bg = "yellow",
     cex = 1.5)

# 지진의 강도에 대한 히스토그램
head(quakes)

mag <- quakes$mag
mag

hist(mag,
     main = "지진 발생 강도의 분포",
     xlab = "지진 강도", ylab = "발생 건수")

# 계급 구간과 색
colors <- c("red", "orange", "yellow",
            "green", "blue", "navy", "violet")

hist(mag,
     main = "지진 발생 강도의 분포",
     xlab = "지진 강도", ylab = "발생 건수",
     col = colors,
     breaks = seq(4, 6.5, by = 0.5))


# 확률밀도

hist(mag,
     main = "지진 발생 강도의 분포",
     xlab = "지진 강도", ylab = "발생 건수",
     col = colors,
     breaks = seq(4, 6.5, by = 0.5),
     freq = FALSE)

lines(density(mag))


# 박스 플롯
mag <- quakes$mag
min(mag)
max(mag)
median(mag)
quantile(mag, c(0.25, 0.5, 0.750))


boxplot(mag,
        main = "지진 발생 강도의 분포",
        xlab = "지진 강도", ylab = "발생 건수",
        col="red")


# install.wordcloud
# library(wordcloud)
word <- c("인천광역시", "강화군", "옹진군", "부안군", "서울")
frequency <- c(651, 120, 61, 200, 500)

wordcloud(word, frequency, colors = "blue")

# 단어들의 위치, 색 변환
wordcloud(word,
          frequency,
          random.order = F,
          random.color = F,
          colors = rainbow(length(word)))

# 다양한 단어 색 출력을 위한 팔레트 패키지의 활용
# instal.packages("RColorBrewer")
# library(RColorBrewer)

pal2 <- brewer.pal(8, "Dark2")

word <- c("인천광역시", "강화군", "옹진군", "부안군", "서울")
frequency <- c(651, 120, 61, 200, 500)

wordcloud(word, frequency, colors = pal2)


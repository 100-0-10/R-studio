

bnk0 <- read.csv("bnk05.csv")

head(bnk0)

bnk1 <- bnk0 %>% 
  filter(age >= 20 & age <= 29) 
bnk1  


names(bnk1)

# 연령 분포
plot(bnk1$X, bnk1$age)

# duration 분포
plot(bnk1$X, bnk1$duration)

# 연령과 잔고의 scatterplot(산점도)
plot(bnk1$age, bnk1$balance)

# jitter를 이용해 플롯을 만들고, point를 반두명 blue색으로 변경
plot(jitter(bnk1$age), jitter(bnk1$balance), col = adjustcolor("blue", alpha = 0.5))

# 결혼상태별 고객수를 막대차트로 작성하고 <20대의 결혼상태 분포> 라는 제목을 추가
qplot(bnk1$marital, main = "<20대의 결혼상태 분포>")

# 잔고와 duration간의 분포를 보여주는 scatterplot을 작성하고, 선형회귀선을 추가하라.

plot(jitter(bnk1$duration), jitter(bnk1$balance))

abline(lm(bnk1$duration~bnk1$balance), col = "blue")

# 결혼상태가 single인 경우는 blue, 아니라면 red인 반투명 point로 색상을 변경하라

plot(jitter(bnk1$duration), jitter(bnk1$balance),
     col = ifelse(bnk1$marital == "single", "blue", adjustcolor("red", alpha = 0.5)))

# duration과 balance 각각에 대한 중위수를 기준으로 수직, 수평의 보저 구분선을 추가하라.

abline(h = median(bnk1$duration) * 1.5, col = "black")

abline(v = median(bnk1$balance) * 1.5, col = "black")

# 개인대출여부 (loan) 별 잔고 분포를 box plot을 사용하여 나타내라
ggplot(data = bnk1, aes(x = bnk1$loan, y = bnk1$balance)) + geom_boxplot()

# 직업별 잔고의 중위수를 집계 산출하고, 막대 플롯을 작성하라.
jobs <- bnk1 %>% 
  group_by(job) %>% 
  summarise(median(balance))
jobs

barplot(jobs$`median(balance)`,
        names.arg = jobs$job,
        col = rainbow(10),
        main = '직업별 잔고의 중위수')

# 직업이 학생이면 blue로 아니면 grey로 생삭을 지정하라.
barplot(jobs$`median(balance)`,
        names.arg = jobs$job,
        col = ifelse(jobs$job == "student", "blue", "gray"),
        main = '직업별 잔고의 중위수')

# 20대 전체의 잔고 중위수 값을 기준으로 수평 보조선을 추가하라.

abline(h = median(bnk1$balance), lty = 2)

# 20대의 직업별 고객수 비율을 table 명령을 활용하여 구하고 20대 뿐 아닌 전체 고객의
# 직업별 비율을 역시 같은 방식으로 구한 후 두 가지를 하나의 데이터프레임으로
# 결합해서 생성하라
# 20대 직업별 고객수 비율
americano <- table(bnk1$job) / length(bnk1$X) * 100
americano

# 전체 직업별 고개수 비율
caferatte <- table(bnk0$job) / length(bnk0$X) * 100
caferatte

# 두 가지 데이터프레임으로 합치기
class((americano))
aaa <- data.frame((table(americano), table(caferatte)))


bnk2 <- data.frame(cbind(americano, caferatte))

bnk2

# 20대와 전체의 각 직업별 구성비 차이를 비교해 함께 보여주는 막대플롯을 작성하라
table(bnk2)
class(bnk2)
class(table(names(bnk2)))
names(bnk2)

barplot(table(bnk2),
        names.arg = names(bnk2))


# 30대 고객의 연령과 잔고간 scatterplot과 20대에 대한 그 것을
# 각각이 플롯으로 비교해 보여주는 한 장의 그림을 작성하라 (par mfrow 활용)










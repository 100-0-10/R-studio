# 바차트

# height 갯수와 name 갯수가 일치해야 함
height <- c(9, 15, 20, 6, 10, 11, 18, 22, 25, 30) # 판매액 할당
name <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀", "영업 5팀", "영업 6팀", "영업 7팀", "영업 8팀", "영업 9팀", "영업 10팀") # 부서명 할당

# 각 부서별로 height 값을 막대그래프로 출력.
# 각 부서의 이름(names.arg)에는 name 값들을 지정 arg = argument
barplot(height, names.arg = name, main = "부서별 영업실적", col = rainbow(length(height)), xlab = "부서", ylab = "영업 실적(억원)")


# 기본 파이차트

# 1. 영업 실적 할당
x <- c(9, 15, 20, 6, 5, 1, 10, 30, 50)

# 2. 부서명 할당
label <- c("영업1팀", "영업2팀", "영업 3팀", "영업 4팀", "영업 6팀", "영업 7팀", "영업 8팀", "영업 9팀", "영업 10팀")

# 3. 파이차트 출력 pie()
pie(x, labels = label, main = "부서별 영업 실적")

















# 6. 자유자재로 데이터 가공하기 
# 06-1. 데이터 전처리 - 원하는 형태로 데이터 가공하기 
# 데이터 전처리(Preprocessing) - dplyr 패키지 
함수         기능 
filter()      행 추출 
select()      열(변수) 추출 
arrange()     정렬 
mutate()      변수 추가 
summarise()   통계치 산출 
group_by()    집단별로 나누기 
left_join()   데이터 합치기(열) 
bind_rows() 데이터 합치기(행) 

조건에 맞는 데이터만 추출하기 
# exam에서 class가 1인 경우만 추출하여 출력
[참고] 단축키 [Ctrl+Shit+M]으로 %>% 기호 입력 
exam %>% filter (class == 1)

# 2 반인 경우만 추출
exam %>% filter(class == 2) 

# 1 반이 아닌 경우
exam %>% filter(class != 1) 

# 3 반이 아닌 경우
exam %>% filter(class != 3)

초과, 미만, 이상, 이하 조건 걸기 
# 수학 점수가 50 점을 초과한 경우
exam %>% filter(math > 50) 

# 영어점수가 80 점 이상인 경우
exam %>% filter(english >= 80)

여러 조건을 충족하는 행 추출하기 
# 1 반 이면서 수학 점수가 50 점 이상인 경우
exam %>% filter(class == 1 & math >= 50) 

여러 조건 중 하나 이상 충족하는 행 추출하기 
# 수학 점수가 90 점 이상이거나 영어점수가 90 점 이상인 경우
exam %>% filter(math >= 90 | english >= 90) 

목록에 해당되는 행 추출하기 
exam %>% filter(class == 1 | class == 3 | class == 5)  # 1, 3, 5 반에 해당되면 추출

%in% 기호 이용하기 
exam %>% filter(class %in% c(1,3,5))  # 1, 3, 5 반에 해당하면 추출
exam %>% filter(class %in% seq(1,5, by = 2)) # seq함수 이용


06-3. 필요한 변수만 추출하기 
exam %>% select(math)  # math 추출
exam %>% select(english)  # english 추출

여러 변수 추출하기 
exam %>% select(class, math, english)  # class, math, english 변수 추출

변수 제외하기 
exam %>% select(-math)  # math 제외
exam %>% select(-math, -english)  # math, english 제외

dplyr 함수 조합하기 
# class 가 1 인 행만 추출한 다음 english 추출
exam %>% filter(class == 1) %>% select(english)

가독성 있게 줄 바꾸기 
exam %>%   filter(class == 1) %>%  # class 가 1 인 행 추출
  select(english)         # english 추출

일부만 출력하기 
exam %>%   select(id, math) %>%  # id, math 추출
  head                  # 앞부분 6 행까지 추출

일부만 출력하기 
exam %>%   select(id, math) %>%  # id, math 추출
  head(10)              # 앞부분 10 행까지 추출


06-4. 순서대로 정렬하기

오름차순으로 정렬하기 
exam %>% arrange(math)  # math 오름차순 정렬

내림차순으로 정렬하기 
exam %>% arrange(desc(math))  # math 내림차순 정렬

정렬 기준 변수 여러개 지정 
exam %>% arrange(class, math)  # class 및 math 오름차순 정렬


06-5. 파생변수 추가하기 
exam %>%   mutate(total = math + english + science) %>%  # 총합 변수 추가
  head                                          # 일부 추출

여러 파생변수 한 번에 추가하기 
exam %>%   mutate(total = math + english + science,          # 총합 변수 추가
                  mean = (math + english + science)/3) %>%   # 총평균 변수 추가
  head

mutate()에 ifelse() 적용하기 
exam %>%  
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>%   
  head 

추가한 변수를 dplyr 코드에 바로 활용하기 
exam %>%   mutate(total = math + english + science) %>%  # 총합 변수 추가
  arrange(total) %>%                            # 총합 변수 기준 정렬
  head                                          # 일부 추출


06-6. 집단별로 요약하기 
집단별로 요약하기 
요약하기 
exam %>% summarise(mean_math = mean(math))  # math 평균 산출

집단별로 요약하기 
exam %>%   group_by(class) %>%                # class 별로 분리
  summarise(mean_math = mean(math))  # math 평균 산출
\

여러 요약통계량 한 번에 산출하기 
exam %>%   group_by(class) %>%                   # class 별로 분리
  summarise(mean_math = mean(math),     # math 평균
            sum_math = sum(math),       # math 합계
            median_math = median(math), # math 중앙값
            n = n())                    # 학생 수

각 집단별로 다시 집단 나누기 
mpg %>%   group_by(manufacturer, drv) %>%      # 회사별 , 구방방식별 분리
  summarise(mean_cty = mean(cty)) %>%  # cty 평균 산출
  head(10)                             # 일부 출력


dplyr 조합하기 
문제) 회사별로 "suv" 자동차의 도시 및 
고속도로 통합 연비 평균을 구해 내림차순으로 
정렬하고, 1~5위까지 출력하기

dplyr 조합하기 
mpg %>%   group_by(manufacturer) %>%           # 회사별로 분리
  filter(class == "suv") %>%           # suv 추출
  mutate(tot = (cty+hwy)/2) %>%        # 통합 연비 변수 생성
  summarise(mean_tot = mean(tot)) %>%  # 통합 연비 평균 산출
  arrange(desc(mean_tot)) %>%          # 내림차순 정렬
  head(5)                              # 1~5 위까지 출력


06-7. 데이터 합치기 
가로로 합치기 
데이터 생성 
# 중간고사 데이터 생성
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85)) 

# 기말고사 데이터 생성
test2 <- data.frame(id = c(1, 2, 3, 4, 5),        
                    final = c(70, 83, 65, 95, 80)) 
test1  # test1 출력
test2  # test2 출력

id 기준으로 합치기 
total <- left_join(test1, test2, by = "id")  # id 기준으로 합쳐 total 에 할당
total                                        # total 출력
[주의] by에 변수명을 지정할 때 변수명 앞 뒤에 겹따옴표 입력

다른 데이터 활용해 변수 추가하기 
반별 담임교사 명단 생성 
name <- data.frame(class = c(1, 2, 3, 4, 5),
                   teacher = c("kim", "lee", "park", "choi", "jung")) 
name

class 기준 합치기 
exam_new <- left_join(exam, name, by = "class") 
exam_new


세로로 합치기 
데이터 생성 
# 학생 1~5 번 시험 데이터 생성
group_a <- data.frame(id = c(1, 2, 3, 4, 5), 
                      test = c(60, 80, 70, 90, 85)) 

# 학생 6~10 번 시험 데이터 생성
group_b <- data.frame(id = c(6, 7, 8, 9, 10),         
                      test = c(70, 83, 65, 95, 80)) 
group_a  # group_a 출력
group_b  # group_b 출력

세로로 합치기 
group_all <- bind_rows(group_a, group_b)  # 데이터 합쳐서 group_all 에 할당
group_all   

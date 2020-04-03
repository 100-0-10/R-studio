

seoul_crime <- read.csv("crime_in_Seoul.csv")

# 쉼표를 공백("")으로 대체하여 제거
seoul_crime$절도.발생 <- gsub(",", "", seoul_crime$절도.발생)
seoul_crime$폭력.발생 <- gsub(",", "", seoul_crime$폭력.발생)
seoul_crime$절도.검거 <- gsub(",", "", seoul_crime$절도.검거)
seoul_crime$폭력.검거 <- gsub(",", "", seoul_crime$폭력.검거)


# 범주형 숫자형으로 변환
seoul_crime$절도.발생 <- as.integer(seoul_crime$절도.발생)
seoul_crime$폭력.발생 <- as.integer(seoul_crime$폭력.발생)
seoul_crime$절도.검거 <- as.integer(seoul_crime$절도.검거)
seoul_crime$폭력.검거 <- as.integer(seoul_crime$폭력.검거)


# 범죄율 총 발생 수
seoul_crime_total <- seoul_crime %>% 
  select(살인.발생, 강도.발생, 강간.발생, 절도.발생, 폭력.발생)

seoul_crime_total <- sum(seoul_crime_total)
seoul_crime_total

# 각 서의 범죄율 총 발생 수
seoul_local_total <- seoul_crime %>% 
  select(살인.발생, 강도.발생, 강간.발생, 절도.발생, 폭력.발생)

seoul_crime <- seoul_crime %>% 
  mutate(seoul_local_total = seoul_local_total$강도.발생 +
           seoul_local_total$강간.발생 + 
           seoul_local_total$절도.발생 + 
           seoul_local_total$폭력.발생 +
           seoul_local_total$살인.발생)

seoul_crime


# 각 서의 범죄율
seoul_crime <- seoul_crime %>% 
  mutate(seoul_crime_rate = round(seoul_crime$seoul_local_total/seoul_crime_total * 100, 2))
seoul_crime

seoul_crime <- rename(seoul_crime, "범죄발생율" = 'seoul_crime_rate')

table(seoul_crime_rate)
head(seoul_crime)

# 범죄율 총 검거 수
seoul_crime_total2 <- seoul_crime %>% 
  select(살인.검거, 강도.검거, 강간.검거, 절도.검거, 폭력.검거)

seoul_crime_total2 <- sum(seoul_crime_total2)
seoul_crime_total2

# 각 서의 범죄율 총 검거 수
seoul_local_total2 <- seoul_crime %>% 
  select(살인.검거, 강도.검거, 강간.검거, 절도.검거, 폭력.검거)


seoul_crime <- seoul_crime %>% 
  mutate(seoul_local_total2 = seoul_local_total2$강도.검거 +
           seoul_local_total2$강간.검거 + 
           seoul_local_total2$절도.검거 + 
           seoul_local_total2$폭력.검거 +
           seoul_local_total2$살인.검거)

seoul_crime


# 각 서의 검거율
seoul_crime <- seoul_crime %>% 
  mutate(seoul_crime_rate2 = round(seoul_crime$seoul_local_total2/seoul_crime_total2 * 100, 2))
seoul_crime

seoul_crime <- rename(seoul_crime, "범죄검거율" = 'seoul_crime_rate2')




# 각 서의 주소 불러오기
seoul_address <- read.csv("crime_in_Seoul_address.csv")

# 데이터 합치기
seoul_total <- left_join(seoul_address, seoul_crime, by = "관서명")

# 합친 데이터 확인하기
head(seoul_total)




seoul_address_code <- as.character(seoul_address$"주소") %>% enc2utf8() %>%  geocode()

View(seoul_address_code)


seoul_code_final <- cbind(seoul_total,
                          seoul_address_code) %>% select("관서명",
                                                         "범죄발생율",
                                                         "범죄검거율",
                                                         "주소",
                                                         lon, lat)
head(seoul_code_final)

seoul_map <- get_googlemap("seoul",
                          maptype = "roadmap",
                          zoom = 12)
ggmap(seoul_map)

seoul_address_final = cbind(seoul_address, seoul_address_code)

# 지도에 데이터 표시
ggmap(seoul_map) +
  geom_point(data = seoul_code_final,
             aes(x = lon, y = lat),
             colour = "blue",
             size = 3) +
  geom_text(data = seoul_code_final,
            aes(label = 관서명, vjust = -2), colour = "blue") +
  geom_text(data = seoul_code_final,
            aes(label = 범죄발생율, vjust = -1), colour = "blue") +
  geom_text(data = seoul_code_final,
            aes(label = 범죄검거율, vjust = 1), colour = "blue")

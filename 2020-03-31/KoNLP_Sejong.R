# 연설문의 단어에 대한 워드 클라우드 만들기
install.packages('rJava')
install.packages('stringr')
install.packages('hash')
install.packages('Sejong')
install.packages('RSQLite')
install.packages('devtools')
install.packages('tau')
install.packages("https://cran.r-project.org/src/contrib/Archive/KoNLP/KoNLP_0.80.2.tar.gz", repos = NULL, type="source")



useSejongDic()

pal2 <- brewer.pal(8, "Dark2")

text <- readLines(file.choose())
text

noun <- sapply(text, extractNoun, USE.NAMES=F)
noun

noun2 <- unlist(noun)
noun2

# p.221
word_count <- table(noun2)
word_count

head(sort(word_count, decreasing=TRUE), 10)

wordcloud(names(word_count),
          freq=word_count,
          scale = c(10, 0.1),
          min.freq = 3,
          random.order = F,
          rot.per = .1,
          colors = pal2)



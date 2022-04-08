# COP 4020 Fall 2018
# Abby Alperovich

library("stringr");
library("jsonlite");

con = file("review.data", open="r");
lines = readLines(con);

# provided by TA
nwords <- function (string, pseudo=F){
	ifelse(
		pseudo,
		pattern <- "\\S+",
		pattern <- "[[:alpha:]]+"
	)
	str_count(string, pattern)
}

df <- data.frame()
n <- 0
for(i in 1:length(lines)){
	line <- lines[i]
	review <- fromJSON(line)
	reviewdf <- as.data.frame(review)
	# Adds a new field to the data frame
	reviewdf$numsOfWords <- nwords(reviewdf$reviewText)

	df <- rbind(df, reviewdf)
}

close(con)

histdf <- data.frame()

# Calculates and prints average word counts per review rating
for(i in 1:5){
	avgWords <- mean(df[df$overall == i,]$numsOfWords)
	entrydf <- data.frame(i, avgWords)
	histdf <- rbind(histdf, entrydf)
	plot(
		histdf,
		main = "Words Per Rating",
		xlab = "Overall",
		ylab = "Average Number of Words"
	)
	lines(histdf)
	paste(
		"The average number of words for review of",
		i,
		"is",
	 	avgWords,
		sep=" "
	)
}


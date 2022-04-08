# COP 4020 Fall 2018
# Abby Alperovich

library("jsonlite")

con = file("review.data", open = "r")
lines = readLines(con)

df <- data.frame()
n <- 0
for(i in 1:length(lines))
{
	line <- lines[i]
	review <- fromJSON(line)
	reviewdf <- as.data.frame(review)

	df <- rbind(df, reviewdf)
}

close(con)

print("There are ")
numRows <- nrow(df[df$overall >= 4,])
print(numRows)
print(" entries with a score greater than or equal to 4.0")

#print(df)


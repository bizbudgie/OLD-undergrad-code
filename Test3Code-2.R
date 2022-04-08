# Abby Alperovich
# COP 4020 Fall 2018

test3Data <- read.csv("test3data.csv", header = TRUE)
cherryData <- read.csv("cherry.csv", header = TRUE)

test3Problem1 <- function(input = test3Data) {
	df <- input
	# Fix data: add States to the following rows
	df$State[130] = "Mississippi"
	df$State[156] = "Wyoming"
	df$State[199] = "California"
	# Omit NA values
	df <- na.omit(df, cols="Industry")
	# Consider only June
	df <- df[df$Month == 6,]
	# Converts given dollar amounts to numerics
	df <- data.frame(df[1:3], apply( df[4:5], -1, convertDollarsToNumeric ), df[6:7] )
	# Find Median of profit columns
	return (median(df[,'Profit']))
}


test3Problem2 <- function(input = cherryData) {
	# Plot data by height and volume and labels the axes
	barplot(
		cherryData$Volume,
		cherryData$Height,
		main = "Cherry Height Vs. Volume",
		xlab = "Volume",
		ylab = "Height",
		border = "red"
		)
	# The spread of this graph ranges from height 63 to 87 and volume 10.2 to 77
	# This graph is not symmetric as it trends upwards
	# The middle of this barplot is lower than the right side would indicate but closer to the average
	# This graph's only unusual feature is the last value in it being far larger than the rest, 
	# the other values are much more similar to each other
}
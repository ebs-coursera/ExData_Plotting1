# The following function reads "Electric Power Consumption" dataset for two
# days (Feb 1 and Feb 2, 2007) and generates PNG file with a histogram of
# houshold global minute-averaged active power consumption.

plot1 <- function() {
  filename <- "household_power_consumption.txt"

  # Get column names
  cnames <- names(read.csv(filename, sep = ";", nrows = 1))

  # Read data only for the two days we are interested in - Feb 1 and 2, 2007.
  # The following commands were used to determine the number of rows to skip:
  #   grep -n '^1/2/2007' household_power_consumption.txt | head -n 1 | cut -d: -f1
  # and to read:
  #   grep '^[12]/2/2007' household_power_consumption.txt | wc -l
  d <- read.csv(filename, header = FALSE, skip = 66637, nrows = 2880,
                sep = ";", col.names = cnames, na.strings = "?")

  # Generate output file.
  png("plot1.png", height = 480, width = 480)
  hist(d$Global_active_power, col = "red",
       main = "Global Active Power",
       xlab = "Global Active Power (kilowatts)")
  dev.off()

  invisible(NA)
}

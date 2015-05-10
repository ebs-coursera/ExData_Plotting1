# The following function reads "Electric Power Consumption" dataset for two
# days (Feb 1 and Feb 2, 2007) and generates PNG file with four graphs showing
# various aspects of houshold power consumption.

plot4 <- function() {
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

  ## Combine 'Date' and 'Time' columns into a single 'DateTime' one.
  d$Date <- as.POSIXct(paste(d$Date, d$Time), format="%d/%m/%Y %H:%M:%S")
  names(d)[names(d) == "Date"] <- "DateTime"
  d$Time <- NULL

  # Generate output file.
  png("plot4.png", height = 480, width = 480)
  par(mfcol = c(2,2))
  with(d, {
    # First plot
    plot(DateTime, Global_active_power, type = "l",
         ylab = "Global Active Power", xlab = "")

    # Second plot
    plot(DateTime, Sub_metering_1, type = "n",
         ylab = "Energy sub metering", xlab = "")

    lines(DateTime, Sub_metering_1)
    lines(DateTime, Sub_metering_2, col = "red")
    lines(DateTime, Sub_metering_3, col = "blue")

    legend("topright", lty = "solid", bty = "n",
           col = c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

    # Third plot
    plot(DateTime, Voltage, type = "l",
         ylab = "Voltage", xlab = "datetime")

    # Fourth plot
    plot(DateTime, Global_reactive_power, type = "l",
         xlab = "datetime")
  })
  dev.off()

  invisible(NA)
}

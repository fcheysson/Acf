#' @title Autocorrelation and partial autocorrelation function for time series
#'
#' @description This function is a wrapper for R native functions `acf` and `pacf` which provides better plots.
#'
#' @param x A univariate time series
#' @param lag.max (optional) Maximum lag at which to calculate the acf and pacf
#' @param ... Further arguments to be passed to `acf` and `pacf`
#'
#' @export
#'
#' @examples
#' e <- rnorm(100)
#' x <- filter(e, c(.5, -.3))
#' Acf(x)
Acf <- function(x, lag.max=NULL, ...) {
	mar.default <- par("mar")
	x.acf <- acf(x, lag.max=lag.max, plot=FALSE, ...)
	x.pacf <- pacf(x, lag.max=lag.max, plot=FALSE, ...)
	if (!is.null(tsp(x))) {
		x.acf$lag <- x.acf$lag * frequency(x)
		x.pacf$lag <- x.pacf$lag * frequency(x)
	}
	par(mfrow=c(2,1), mar=c(0, 4.1, 4.1, 2.1))
	plot(x.acf, xlab="", xaxt="n", ylim=range(c(x.acf$acf, x.pacf$acf)))
	par(mar=c(5.1, 4.1, 0, 2.1))
	plot(x.pacf, xlim=c(0, max(x.pacf$lag)), main="", ylab="PACF",
		ylim=range(c(x.acf$acf, x.pacf$acf)))
	par(mfrow=c(1,1), mar=mar.default)
}

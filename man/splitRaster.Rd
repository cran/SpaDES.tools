% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mergeRaster.R, R/splitRaster.R
\name{mergeRaster}
\alias{mergeRaster}
\alias{mergeRaster,list-method}
\alias{splitRaster}
\title{Split and re-merge \code{RasterLayer}(s)}
\usage{
mergeRaster(x, fun = NULL)

\S4method{mergeRaster}{list}(x, fun = NULL)

splitRaster(
  r,
  nx = 1,
  ny = 1,
  buffer = c(0, 0),
  path = NA,
  cl,
  rType = "FLT4S",
  fExt = ".tif"
)
}
\arguments{
\item{x}{A list of split raster tiles (i.e., from \code{splitRaster}).}

\item{fun}{Function (e.g. \code{mean}, \code{min}, or \code{max} that
accepts a \code{na.rm} argument. The default is \code{mean}.}

\item{r}{The raster to be split.}

\item{nx}{The number of tiles to make along the x-axis.}

\item{ny}{The number of tiles to make along the y-axis.}

\item{buffer}{Numeric vector of length 2 giving the size of the buffer along the x and y axes.
If values greater than or equal to \code{1} are used, this
is interpreted as the number of pixels (cells) to use as a buffer.
Values between \code{0} and \code{1} are interpreted as proportions
of the number of pixels in each tile (rounded up to an integer value).
Default is \code{c(0, 0)}, which means no buffer.}

\item{path}{Character specifying the directory to which the split tiles will be saved.
If missing, the function will write to memory.}

\item{cl}{A cluster object. Optional. This would generally be created using
\code{\link[parallel:makeCluster]{parallel::makeCluster()}} or equivalent. This is an alternative way, instead
of \code{beginCluster()}, to use parallelism for this function, allowing for
more control over cluster use.}

\item{rType}{Data type of the split rasters. Defaults to FLT4S.}

\item{fExt}{file extension (e.g., \code{".grd"} or \code{".tif"}) specifying the file format.}
}
\value{
\code{mergeRaster} returns a \code{RasterLayer} object.

\code{splitRaster} returns a list (length \code{nx*ny}) of cropped raster tiles.
}
\description{
\code{splitRaster} divides up a raster into an arbitrary number of pieces (tiles).
Split rasters can be recombined using \code{do.call(merge, y)} or \code{mergeRaster(y)},
where \code{y <- splitRaster(x)}.
}
\details{
\code{mergeRaster} differs from \code{merge} in how overlapping tile regions
are handled: \code{merge} retains the values of the first raster in the list.
This has the consequence of retaining the values from the buffered
region in the first tile in place of the values from the neighbouring tile.
On the other hand, \code{mergeRaster} retains the values of the tile region,
over the values in any buffered regions.
This is useful for reducing edge effects when performing raster operations involving
contagious processes.

This function is parallel-aware using the same mechanism as used in \pkg{raster}:
NOTE: This may not work as expected as we transition away from \code{raster}.
Specifically, if you start a cluster using \code{raster::beginCluster()},
then this function will automatically use that cluster.
It is always a good idea to stop the cluster when finished, using \code{raster::endCluster()}.
}
\examples{
library(terra)

origDTThreads <- data.table::setDTthreads(2L)
origNcpus <- options(Ncpus = 2L)
set.seed(1462)

## an example with dimensions: nrow = 77,  ncol = 101, nlayers = 3
b <- rast(system.file("ex/logo.tif", package = "terra"))
r <- b[[1]] # use first layer only
nx <- 3
ny <- 4

tmpdir <- dir.create(file.path(tempdir(), "splitRaster-example"), showWarnings = FALSE)

y0 <- splitRaster(r, nx, ny, path = file.path(tmpdir, "y0")) # no buffer

## buffer: 10 pixels along both axes
y1 <- splitRaster(r, nx, ny, c(10, 10), path = file.path(tmpdir, "y1"))

## buffer: half the width and length of each tile
y2 <- splitRaster(r, nx, ny, c(0.5, 0.5), path = file.path(tmpdir, "y2"))

## the original raster:
if (interactive()) plot(r) # may require a call to `dev()` if using RStudio

## the split raster:
layout(mat = matrix(seq_len(nx * ny), ncol = nx, nrow = ny))
plotOrder <- unlist(lapply(split(1:12, rep(1:nx, each = ny)), rev))

if (interactive()) {
  invisible(lapply(y0[plotOrder], terra::plot))
}

## parallel splitting
if (requireNamespace("raster", quietly = TRUE) &&
    requireNamespace("parallel")) {
  if (interactive()) {
    n <- pmin(parallel::detectCores(), 4) # use up to 4 cores
    raster::beginCluster(n, type = "PSOCK")
    y3 <- splitRaster(r, nx, ny, c(0.7, 0.7), path = file.path(tmpdir, "y3"))
    raster::endCluster()
    if (interactive()) {
      invisible(lapply(y3[plotOrder], terra::plot))
    }
  }
}

## can be recombined using `terra::merge`
m0 <- do.call(merge, y0)
all.equal(m0, r) ## TRUE

m1 <- do.call(merge, y1)
all.equal(m1, r) ## TRUE

m2 <- do.call(merge, y2)
all.equal(m2, r) ## TRUE

## or recombine using mergeRaster
n0 <- mergeRaster(y0)
all.equal(n0, r) ## TRUE

n1 <- mergeRaster(y1)
all.equal(n1, r) ## TRUE

n2 <- mergeRaster(y2)
all.equal(n2, r) ## TRUE

# clean up
data.table::setDTthreads(origDTThreads)
options(Ncpus = origNcpus)
unlink(tmpdir, recursive = TRUE)
}
\seealso{
\code{\link[terra:merge]{terra::merge()}}, \code{\link[terra:mosaic]{terra::mosaic()}}

\code{\link[=do.call]{do.call()}}, \code{\link[terra:merge]{terra::merge()}}.
}
\author{
Yong Luo, Alex Chubaty, Tati Micheletti & Ian Eddy

Alex Chubaty and Yong Luo
}

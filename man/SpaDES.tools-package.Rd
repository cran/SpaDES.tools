% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spades-tools-package.R
\docType{package}
\name{SpaDES.tools-package}
\alias{SpaDES.tools}
\alias{SpaDES.tools-package}
\title{Categorized overview of the \code{SpaDES.tools} package}
\description{
\if{html}{\figure{SpaDES.png}{options: width=100 alt="SpaDES logo" style="float: right;"}}
\if{latex}{\figure{SpaDES.png}{options: width=0.5in}}
}
\section{1 Spatial spreading/distances methods}{


Spatial contagion is a key phenomenon for spatially explicit simulation models.
Contagion can be modelled using discrete approaches or continuous approaches.
Several functions assist with these:

\tabular{ll}{
\code{\link[=adj]{adj()}} \tab An optimized (i.e., faster) version of
\code{\link[terra:adjacent]{terra::adjacent()}}\cr
\code{\link[=cir]{cir()}} \tab Identify pixels in a circle around a
\verb{SpatialPoints*} object\cr
\code{\link[=directionFromEachPoint]{directionFromEachPoint()}} \tab Fast calculation of direction and
distance surfaces\cr
\code{\link[=distanceFromEachPoint]{distanceFromEachPoint()}} \tab Fast calculation of distance surfaces\cr
\code{\link[=rings]{rings()}} \tab Identify rings around focal cells (e.g., buffers and donuts)\cr
\code{\link[=spokes]{spokes()}} \tab TO DO: need description\cr
\code{\link[=spread]{spread()}} \tab Contagious cellular automata\cr
\code{\link[=wrap]{wrap()}} \tab Create a torus from a grid\cr
}
}

\section{2 Spatial agent methods}{


Agents have several methods and functions specific to them:

\tabular{ll}{
\code{\link[=crw]{crw()}} \tab Simple correlated random walk function\cr
\code{\link[=heading]{heading()}} \tab Determines the heading between \verb{SpatialPoints*}\cr
\code{quickPlot::makeLines()} \tab Makes \code{SpatialLines} object for, e.g., drawing arrows\cr
\code{\link[=move]{move()}} \tab A meta function that can currently only take "crw"\cr
\code{\link[=specificNumPerPatch]{specificNumPerPatch()}} \tab Initiate a specific number of agents per patch\cr
}
}

\section{3 GIS operations}{


In addition to the vast amount of GIS operations available in R (mostly from
contributed packages such as \code{sp}, \code{raster}, \code{maps}, \code{maptools}
and many others), we provide the following GIS-related functions:
\tabular{ll}{
\code{quickPlot::equalExtent()} \tab Assess whether a list of extents are all equal\cr
}
}

\section{4 Map-reduce - type operations}{


These functions convert between reduced and mapped representations of the same data.
This allows compact representation of, e.g., rasters that have many individual pixels
that share identical information.
\tabular{ll}{
\code{\link[=rasterizeReduced]{rasterizeReduced()}} \tab Convert reduced representation to full raster\cr
}
}

\section{5 Random Map Generation}{


It is often useful to build dummy maps with which to build simulation models
before all data are available.
These dummy maps can later be replaced with actual data maps.

\tabular{ll}{
\code{\link[=randomPolygons]{randomPolygons()}} \tab Creates a random polygon with specified number of classes.\cr
}

See the \pkg{NLMR} package for tools to generate random landscapes (rasters).
}

\section{6 SELES-type approach to simulation}{


These functions are essentially skeletons and are not fully implemented.
They are intended to make translations from \href{http://www.gowlland.ca/}{SELES}.
You must know how to use SELES for these to be useful:
\tabular{ll}{
\code{\link[=agentLocation]{agentLocation()}} \tab Agent location\cr
\code{\link[=initiateAgents]{initiateAgents()}} \tab Initiate agents into a \code{SpatialPointsDataFrame}\cr
\code{\link[=numAgents]{numAgents()}} \tab Number of agents\cr
\code{\link[=probInit]{probInit()}} \tab Probability of initiating an agent or event\cr
\code{\link[=transitions]{transitions()}} \tab Transition probability\cr
}
}

\section{7 Package options}{


\code{SpaDES} packages use the following \code{\link[=options]{options()}} to configure behaviour:

\itemize{
\item \code{spades.lowMemory}: If true, some functions will use more memory
efficient (but slower) algorithms. Default \code{FALSE}.
}
}

\seealso{
Useful links:
\itemize{
  \item \url{https://spades-tools.predictiveecology.org}
  \item \url{https://github.com/PredictiveEcology/SpaDES.tools}
  \item Report bugs at \url{https://github.com/PredictiveEcology/SpaDES.tools/issues}
}

}
\author{
\strong{Maintainer}: Alex M Chubaty \email{achubaty@for-cast.ca} (\href{https://orcid.org/0000-0001-7146-8135}{ORCID})

Authors:
\itemize{
  \item Eliot J B McIntire \email{eliot.mcintire@nrcan-rncan.gc.ca} (\href{https://orcid.org/0000-0002-6914-8316}{ORCID})
}

Other contributors:
\itemize{
  \item Yong Luo \email{Yong.Luo@gov.bc.ca} [contributor]
  \item Ceres Barros \email{ceres.barros@ubc.ca} (\href{https://orcid.org/0000-0003-4036-977X}{ORCID}) [contributor]
  \item Steve Cumming \email{Steve.Cumming@sbf.ulaval.ca} [contributor]
  \item Jean Marchal \email{jean.d.marchal@gmail.com} [contributor]
  \item His Majesty the King in Right of Canada, as represented by the Minister of Natural Resources Canada [copyright holder]
}

}

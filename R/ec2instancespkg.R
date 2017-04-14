#' ec2 instances package
#'
#' This package contains a script to download data on Amazon EC2 pricing
#' from \link{ec2instances.info} and helper functions to format it nicely.
#'
#' @examples
#'
#' #data(ec2instances)
#' plot(memory~vCPU, ec2instances)
#'
#' @name ec2instances.info-package
#' @docType package
#' @seealso \code{\link{ec2instances}}
NULL

#' @export
format.vpc <- function(x, ...) sprintf('%sx%s', x$ips_per_eni, x$max_enis)

#' @export
format.storage <- function(x, ...) {
  with(x,
    ifelse(is.na(devices), "EBS only",
           sprintf("%s x %s%s%s",
                 devices,
                 size,
                 ifelse(nvme_ssd, ' nvme', ''),
                 ifelse(ssd, ' ssd', '')
                 )
    )
  )


}

#' @export
format.pricing <- function(x, ..., region=Sys.getenv("AWS_DEFAULT_REGION", 'us-west-2')) {
  sprintf('%5.3f', x[[region]]$linux$ondemand)
}

#' @export
format.linux_virtualization_types <-  function(x, ...) sapply(x, paste0, collapse=',')

#' @export
format.arch <- function(x, ...) sapply(x, paste0, collapse=',')

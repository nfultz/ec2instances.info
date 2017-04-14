#' ec2 Instances
#'
#'  This data frame lists the different types of instances currently availabe on Amazon EC2.
#'
#' \describe{
#' \item{ECU}{}
#' \item{arch}{i386 and/or x86_64}
#' \item{base_performance}{}
#' \item{burst_minutes}{}
#' \item{ebs_iops}{}
#' \item{ebs_max_bandwidth}{}
#' \item{ebs_optimized}{}
#' \item{ebs_throughput}{}
#' \item{enhanced_networking}{}
#' \item{family}{}
#' \item{generation}{previous or current}
#' \item{instance_type}{The short name, eg "m1.small"}
#' \item{ipv6_support}{}
#' \item{linux_virtualization_types}{PV and/or HVM}
#' \item{memory}{Gigabytes of memory}
#' \item{network_performance}{}
#' \item{placement_group_support}{}
#' \item{pretty_name}{eg  "M1 General Purpose Small"}
#' \item{pricing}{A nested data.frame containg prices for each AWS,
#'              region, OS, and on-demand or reservation contract}
#' \item{storage}{A nested data.frame containing storage size and type.}
#' \item{vCPU}{Number of virtual CPUs.}
#' \item{vpc}{A nested data.frame containg ips_per_eni and max_enis}
#' \item{vpc_only}{}
#' }
#'
#' @source
#' This data can be viewed on the web at \link{https://aws.amazon.com/ec2/pricing/on-demand/} and
#'  \link{https://aws.amazon.com/ec2/instance-types/}
#'
#' @importFrom  jsonlite fromJSON
#' @docType data
#' @name ec2instances
ec2instances <- within(
  jsonlite::fromJSON("http://www.ec2instances.info/instances.json"),
  {
    pricing <- rapply(pricing, as.numeric, how="replace")
    ECU <- as.integer(ECU)
    generation <- as.factor(generation)
    network_performance <- as.factor(network_performance)
    family <- as.factor(family)

    class(arch) <- 'arch'
    class(linux_virtualization_types) <- 'linux_virtualization_types'
    class(pricing) <- c('pricing', 'data.frame')
    class(storage) <- c('storage', 'data.frame')
    class(vpc) <- c('vpc', 'data.frame')
  }
)
rownames(ec2instances) <- ec2instances$instance_type

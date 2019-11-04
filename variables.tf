variable "project" {
  description = "Project of the project. Also used as a prefix in names of related resources."
  type        = string
}

variable "environment" {
  description = "Environment of the project. Also used as a prefix in names of related resources."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "domain" {
  description = "The main domain of the environment. The api and api-internal subdomains will be registered as subdomains of this domain."
  type        = string
}

variable "r53_hosted_zone_id" {
  description = "The zone_id of the hosted zone where the DNS record for validation needs to be added"
  type        = string
  default     = null
}

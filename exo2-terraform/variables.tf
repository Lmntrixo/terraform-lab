variable "aws_region" {
  description = " name of the aws region to create ressources"
  type        = string
  default     = "eu-central-1"
}


variable "bucket_prefix" {
  description = " contains prefix for bucket"
  type        = string
}

variable "buckets" {
  description = " map of bucket to create"
  type        = map(string)
  default = {
    logs = "logs of aplication"
    data = "for data"

  }
}

terraform {
    required_providers {
	aws = {
	  source = "hashicorp/aws"
	  version = "~>5.0"
        }
    }
}

provider "aws" {
    region = var.aws_region
}

variable "aws_region" {
   description = " aws region wher to deploy"
   type = string
   default = "eu-central-1"
}

variable "bucket_name" {
   description = "name of the bucket"
   type = string
}

variable "tags" {
    description  = "tag to aplly on resources"
    type  = map(string)
    default  = {
	Project = "terraform-lab"
        ManagedBy = "terraform"
    }
}

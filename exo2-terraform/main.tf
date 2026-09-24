terraform {
     required_providers{
         aws = {
	    source = "hashicorp/aws"
            version = "~>5.0"
         }
     }
}

provider "aws" {
    region = "eu-central-1"
}

resource "aws_s3_bucket" "my_bucket" {
     bucket = "my-s3-bucket-lmntrixo"
}

resource "aws_s3_object" "fichier" {
     bucket = aws_s3_bucket.my_bucket.id
     key = "hello.txt"
     content = "ceci est mon premier bucket s3 aws"
}

resource "aws_s3_bucket" "lecon1" {
     bucket = "${var.bucket_prefix}-lecon1"
}

#resource "aws_s3_object" "fichier" {
#     bucket = aws_s3_bucket.my_bucket.id
#     key = "hello.txt"
#     content = "ceci est mon premier bucket s3 aws"
#}

#======================================
#bucket S3 + object
#======================================

resource "aws_s3_bucket" "lecon2" {
	bucket = "${var.bucket_prefix}-lecon2"
}

resource "aws_s3_object" "lecon2" {
	bucket = aws_s3_bucket.lecon2.id
        key    = "hello.txt"
        content = "hello terraform from lecon2"
} 

#===========================================
#LeconA: count
#===========================================
resource "aws_s3_bucket" "multi" {
	count  = 3
        bucket = "${var.bucket_prefix}-multi-${count.index}"
}
#=============================================
#LeconB: foreach
#=============================================
resource "aws_s3_bucket" "nommes" {
     for_each = var.buckets
     bucket   = "${var.bucket_prefix}-${each.key}"

	tags = {
	    purpose = each.value
	}
}

#=============================================
#LeconC: data sources
#============================================

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

#data "aws_ami" "amazon_linux" {
#	most_recent = true
#	owners       = ["amazon"] 
#
 #   filter  {
#	name = "name"
#	values = ["a12023-ami-*-x84_64"]
#   }

#   filter  {
#	name = "architecture"
#	values = ["x84_64"]
#   } 
#}

data "aws_ssm_parameter" "amazon_linux_ami" {
	name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

#============================================================================
#LeconD: lifecycle: prevent_destroy, create_before_destroy, ignores_changes[]
#============================================================================

resource "aws_s3_bucket" "critical" {
	bucket = "${var.bucket_prefix}-critical"


#	lifecycle {
#		prevent_destroy = true
#	}
}

output "critical_bucket_id" {
	value = aws_s3_bucket.critical.id
}

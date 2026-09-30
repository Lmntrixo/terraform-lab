output "lecon1_bucket_id" {
  description = " bucket s3's ID for lecon1"
  value       = aws_s3_bucket.lecon1.id
}

output "lecon1_arn" {
  description = " showing the arn of the bucket s3"
  value       = aws_s3_bucket.lecon1.arn
}


output "lecon2_object_url" {
  description = " URL for object in s3 bucket"
  value       = "s3://${aws_s3_bucket.lecon2.id}/${aws_s3_object.lecon2.id}"

}

output "multi_bucket_id" {
  value = aws_s3_bucket.multi[*].id
}

output "nommes_bucket_id" {
  value = { for k, v in aws_s3_bucket.nommes : k => v.id }
}

output "accout_id" {
  value = data.aws_caller_identity.current.account_id
}

output "current_region" {
  value = data.aws_region.current.name
}

output "latest_amazon_linux" {
  value = nonsensitive(data.aws_ssm_parameter.amazon_linux_ami.value)
	
  #sensitive = true
}

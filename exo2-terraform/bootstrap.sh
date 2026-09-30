#!/usr/bin/env bash
set -euo pipefail

#variables
BUCKET="myapp-terrafor-state-$(whoami)-$(date +%s)"
REGION="eu-central-1"

echo "state bucket name is: $BUCKET"

#===============================
#Creation du bucket S3
#===============================
if aws s3api head-bucket --bucket $BUCKET 2>/dev/null; then
	echo " Bucket deja present, on passe"
else
   aws s3api create-bucket --bucket $BUCKET --region $REGION --create-bucket-configuration LocationConstraint=$REGION

#us-west-1 do not handle LocationConstraint

#==============================
#Activating versioning
#==============================

   aws s3api put-bucket-versioning --bucket $BUCKET --versioning-configuration  Status=Enabled

#===================================
#Activating Encryption
#==================================

   aws s3api put-bucket-encryption --bucket $BUCKET \
	--server-side-encryption-configuration '{
	"Rules": [{
	"ApplyServerSideEncryptionByDefault":{
	"SSEAlgorithm": "AES256"
	}
	}]
	}'

#======================================
#block public access
#======================================

   aws s3api put-public-access-block --bucket $BUCKET\
	 --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"

fi
#=====================================
#Create Dynamo table
#=====================================
if aws dynamo describe-table --table-name myapp-terraform-locks >/dev/null 2>&1; then
	echo "Table deja presente, on passe"
else
   aws dynamodb create-table\
	--table-name myapp-terraform-locks\
	--attribute-definitions AttributeName=LockID,AttributeType=S\
	--key-schema AttributeName=LockID,KeyType=HASH\
	--billing-mode PAY_PER_REQUEST\
	--region $REGION
fi

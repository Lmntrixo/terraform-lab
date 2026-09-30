terraform {
	backend "s3" {
	  bucket         ="myapp-terrafor-state-evans-1790796137"
	  key            ="terraform-lab/terraform.tfstate"
	  region         ="eu-central-1"
	  #dynamodb_table ="myapp-terraform-locks"
	  use_lockfile    = true
	  encrypt        = true	  
}
}

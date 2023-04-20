provider "aws" {
  region = "us-east-1"
 
}
provider "hcp" {
  
}

data "hcp_packer_iteration" "ubuntu" {
  bucket_name = "learn-packer-hcp-golden-base-image"
  channel     = "latest"
}
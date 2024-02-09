# provider "aws" {
#   profile = 879690171722
#   access_key = AKIA4ZUM6YVFOOF3ER7T
#   secret_key = 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

#       
# }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.34.0"
    }
  }
}

provider "aws" {
  # Configuration options
}
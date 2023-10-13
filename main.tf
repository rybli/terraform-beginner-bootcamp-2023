terraform {
    required_providers {
      terratowns = {
        source = "local.providers/local/terratowns"
        version = "1.0.0"
      }
    }
#   cloud {
#     organization = "rybli-terraform-beginner-bootcamp-2023"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }
}

provider "terratowns" {
    endpoint = "http://localhost:4567/api"
    user_uuid = "e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
    token = "9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

# module "terrahouse_aws" {
#     source = "./modules/terrahouse_aws"
#     user_uuid = var.user_uuid
#     bucket_name = var.bucket_name
#     error_html_filepath = var.error_html_filepath
#     index_html_filepath = var.index_html_filepath
#     content_version = var.content_version
#     assets_path = var.assets_path

resource "terratowns_home" "home" {
  name = "Reasons to Watch Cowboy Bebop"
  description = <<DESCRIPTION
Cowboy Bebop is a Japanese anime.
It follows closely with American TV shows in that it is mostly episodic.
It is set in the not so distant future of 2071 with a Sci-Fi/Space Western genre.
DESCRIPTION
  # domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "asdfasdf123.cloudfront.net"
  town = "video-valley"
  content_version = 1
}

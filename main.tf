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
    endpoint = var.terratowns_endpoint
    user_uuid = var.teacherseat_user_uuid
    token = var.terratowns_access_token
}

module "terrahouse_aws" {
    source = "./modules/terrahouse_aws"
    user_uuid = var.teacherseat_user_uuid
    error_html_filepath = var.error_html_filepath
    index_html_filepath = var.index_html_filepath
    content_version = var.content_version
    assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "Reasons to Watch Cowboy Bebop"
  description = <<DESCRIPTION
Cowboy Bebop is a Japanese anime.
It follows closely with American TV shows in that it is mostly episodic.
It is set in the not so distant future of 2071 with a Sci-Fi/Space Western genre.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  town = "missingo"
  content_version = 1
}

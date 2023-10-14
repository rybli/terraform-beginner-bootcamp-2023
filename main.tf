terraform {
    required_providers {
      terratowns = {
        source = "local.providers/local/terratowns"
        version = "1.0.0"
      }
    }
  cloud {
    organization = "rybli-terraform-beginner-bootcamp-2023"
    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
    endpoint = var.terratowns_endpoint
    user_uuid = var.teacherseat_user_uuid
    token = var.terratowns_access_token
}

module "home_cowboy_bebop_hosting" {
    source = "./modules/terrahome_aws"
    user_uuid = var.teacherseat_user_uuid
    public_path = var.cowboy_bebop.public_path
    content_version = var.cowboy_bebop.content_version
}

resource "terratowns_home" "home_cowboy_bebop" {
  name = "Reasons to Watch Cowboy Bebop"
  description = <<DESCRIPTION
Cowboy Bebop is a Japanese anime.
It follows closely with American TV shows in that it is mostly episodic.
It is set in the not so distant future of 2071 with a Sci-Fi/Space Western genre.
DESCRIPTION
  domain_name = module.home_cowboy_bebop_hosting.domain_name
  town = "missingo"
  content_version = var.cowboy_bebop.content_version
}

module "home_chicken_bog_hosting" {
    source = "./modules/terrahome_aws"
    user_uuid = var.teacherseat_user_uuid
    public_path = var.chicken_bog.public_path
    content_version = var.chicken_bog.content_version
}

resource "terratowns_home" "home_chicken_bog" {
  name = "How to make Chicken Bog"
  description = <<DESCRIPTION
Shredded Chicken (buy a rotisserie chicken)
Yello Onion (diced)
Bacon Ends
DESCRIPTION
  domain_name = module.home_chicken_bog_hosting.domain_name
  town = "cooker-cove"
  content_version = var.chicken_bog.content_version
}
terraform {
  required_providers {
    mezmo = {
      source  = "registry.terraform.io/mezmo/mezmo"
      version = "1.1.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "mezmo" {
  auth_key = "my secret"
}

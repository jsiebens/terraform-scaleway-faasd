terraform {
  required_version = ">= 1.0.0"
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = ">= 2.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}

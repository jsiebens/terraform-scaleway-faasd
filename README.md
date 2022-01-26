# faasd for Scaleway

This repo contains a Terraform Module for how to deploy a [faasd](https://github.com/openfaas/faasd) instance on
[Scaleway](https://scaleway.com/) using [Terraform](https://www.terraform.io/).

__faasd__, a lightweight & portable faas engine, is [OpenFaaS](https://github.com/openfaas/) reimagined, but without the cost and complexity of Kubernetes. It runs on a single host with very modest requirements, making it fast and easy to manage. Under the hood it uses [containerd](https://containerd.io/) and [Container Networking Interface (CNI)](https://github.com/containernetworking/cni) along with the same core OpenFaaS components from the main project.

## What's a Terraform Module?

A Terraform Module refers to a self-contained packages of Terraform configurations that are managed as a group. This repo
is a Terraform Module and contains many "submodules" which can be composed together to create useful infrastructure patterns.

## How do you use this module?

This repository defines a [Terraform module](https://www.terraform.io/docs/modules/usage.html), which you can use in your
code by adding a `module` configuration and setting its `source` parameter to URL of this repository:

```hcl
variable "project_id" {
  type = string
}

variable "zone" {
  type = string
}

module "faasd" {
  source     = "github.com/jsiebens/terraform-scaleway-faasd"
  name       = "faasd"
  project_id = var.project_id
  zone       = var.zone
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| random | >= 3.1.0 |
| scaleway | >= 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| random | >= 3.1.0 |
| scaleway | >= 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_password.faasd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [scaleway_instance_ip.faasd](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_ip) | resource |
| [scaleway_instance_security_group.faasd](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_security_group) | resource |
| [scaleway_instance_server.faasd](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| basic\_auth\_password | The basic auth password, if left empty, a random password is generated. | `string` | `null` | no |
| basic\_auth\_user | The basic auth user name. | `string` | `"admin"` | no |
| domain | A public domain for the faasd instance. This will the use of Caddy and a Let's Encrypt certificate | `string` | `""` | no |
| email | Email used to order a certificate from Let's Encrypt | `string` | `""` | no |
| name | The name of the faasd instance. All resources will be namespaced by this value. | `string` | n/a | yes |
| project\_id | n/a | `string` | n/a | yes |
| type | n/a | `string` | `"DEV1-S"` | no |
| zone | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| basic\_auth\_password | The basic auth password. |
| basic\_auth\_user | The basic auth user name. |
| gateway\_url | The url of the faasd gateway |
| ipv4\_address | The public IP address of the faasd instance |
<!-- END_TF_DOCS -->

## See Also

- [faasd on Google Cloud Platform with Terraform](https://github.com/jsiebens/terraform-google-faasd)
- [faasd on Microsoft Azure with Terraform](https://github.com/jsiebens/terraform-azurerm-faasd)
- [faasd on DigitalOcean with Terraform](https://github.com/jsiebens/terraform-digitalocean-faasd)
- [faasd on Equinix Metal with Terraform](https://github.com/jsiebens/terraform-equinix-faasd)
- [faasd on Scaleway with Terraform](https://github.com/jsiebens/terraform-scaleway-faasd)

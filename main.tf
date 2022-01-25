locals {
  generate_password   = var.basic_auth_password == null || var.basic_auth_password == ""
  basic_auth_user     = var.basic_auth_user
  basic_auth_password = local.generate_password ? random_password.faasd[0].result : var.basic_auth_password

  user_data_vars = {
    basic_auth_user     = local.basic_auth_user
    basic_auth_password = local.basic_auth_password
    domain              = var.domain
    email               = var.email
  }
}

resource "random_password" "faasd" {
  count   = local.generate_password ? 1 : 0
  length  = 16
  special = false
}

resource "scaleway_instance_ip" "faasd" {
  project_id = var.project_id
  zone       = var.zone
}

resource "scaleway_instance_security_group" "faasd" {
  project_id             = var.project_id
  zone                   = var.zone
  name                   = var.name
  inbound_default_policy = "drop"

  dynamic "inbound_rule" {
    for_each = var.domain == "" ? [1] : []
    content {
      action = "accept"
      port   = 8080
    }
  }

  dynamic "inbound_rule" {
    for_each = var.domain != "" ? [1] : []
    content {
      action = "accept"
      port   = 80
    }
  }

  dynamic "inbound_rule" {
    for_each = var.domain != "" ? [1] : []
    content {
      action = "accept"
      port   = 443
    }
  }

  inbound_rule {
    action = "accept"
    port   = 22
  }
}

resource "scaleway_instance_server" "faasd" {
  project_id        = var.project_id
  zone              = var.zone
  name              = var.name
  type              = var.type
  image             = "ubuntu_focal"
  ip_id             = scaleway_instance_ip.faasd.id
  security_group_id = scaleway_instance_security_group.faasd.id
  user_data = {
    cloud-init = templatefile("${path.module}/templates/startup.sh", local.user_data_vars)
  }
}
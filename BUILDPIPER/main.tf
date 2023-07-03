locals {
  vpc_id         = var.vpc_id
  private_subnet_id = var.private_subnet_id
  openvpn_sg_id = var.openvpn_sg_id
  openvpn_ip = var.openvpn_ip
}

module "ec2_instance" {
  source               = "OT-CLOUD-KIT/ec2-instance/aws"
  version              = "0.0.3"
  count                = var.instance_count
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  public_ip            = var.public_ip
  key_name             = var.key_name
  subnet               = local.private_subnet_id
  security_groups      = [module.buildpiper_security_group.sg_id]
  volume_size          = var.volume_size
  volume_type          = var.volume_type
  encrypted_volume     = var.encrypted_volume
  iam_instance_profile = var.iam_instance_profile
  ec2_name             = var.ec2_name
  tags                 = var.tags
}
module "buildpiper_security_group" {
  source                              = "OT-CLOUD-KIT/security-groups/aws"
  version                             = "1.0.0"
  name_sg                             = var.sg_name
  tags                                = var.tags
  enable_whitelist_ip                 = true
  enable_source_security_group_entry  = true
  create_outbound_rule_with_src_sg_id = false

  vpc_id = local.vpc_id
  ingress_rule = {
    rules = {
      rule_list = [
         {
      description  = "Allow port 22 for ssh"
      from_port    = 22
      to_port      = 22
      protocol     = "tcp"
      cidr         = [local.openvpn_ip]      
      source_SG_ID = local.openvpn_sg_id
    },
    {
      description  = "Allow port 80 for vpn"
      from_port    = 80
      to_port      = 80
      protocol     = "tcp"
      cidr         = [local.openvpn_ip]     
      source_SG_ID = local.openvpn_sg_id
    },
    {
      description  = "Allow port 9001 for vpn "
      from_port    = 9001
      to_port      = 9001
      protocol     = "tcp"
      cidr         = [local.openvpn_ip]
      ipv6_cidr    = []
      source_SG_ID = local.openvpn_sg_id
    }
      ]
    }
  }
}

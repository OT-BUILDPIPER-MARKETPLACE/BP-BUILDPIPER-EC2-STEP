locals {
  buildpiper_sg_ids     = var.buildpiper_sg_ids
  private_subnet_id = var.private_subnet_id
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
  security_groups      = local.buildpiper_sg_ids
  volume_size          = var.volume_size
  volume_type          = var.volume_type
  encrypted_volume     = var.encrypted_volume
  iam_instance_profile = var.iam_instance_profile
  ec2_name             = var.ec2_name
  tags                 = var.tags
}
module "buildpiper_sg" {
  source                             = "git@github.com:OT-CLOUD-KIT/terraform-aws-security-groups.git?ref=v0.0.1"
  name_sg                            = local.buildpiper_sg_name
  enable_source_security_group_entry = true
  vpc_id                             = data.terraform_remote_state.remote.outputs.vpc_id
  ingress_rule                       = local.buildpiper_sg_ingress_rule
  tags                               = var.buildpiper_sg_tags
}

variable "region" {
  type        = string
  description = "Region where resource will be created."
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-12345678"
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "public_ip" {
  description = "Whether to assign a public IP address to the EC2 instances"
  type        = bool
  default     = false
}

variable "key_name" {
  description = "Name of the key pair to associate with the EC2 instances"
  type        = string
  default     = ""
}

variable "private_subnet_id" {
  description = "ID of the subnet for the EC2 instances"
  type        = string
  default     = "subnet-12345678"
}



variable "volume_size" {
  description = "Size of the root volume for the EC2 instances (in GB)"
  type        = number
  default     = 100
}

variable "volume_type" {
  description = "Type of the root volume for the EC2 instances"
  type        = string
  default     = "gp2"
}

variable "encrypted_volume" {
  description = "Whether the root volume should be encrypted"
  type        = bool
  default     = false
}

variable "iam_instance_profile" {
  description = "IAM instance profile for the EC2 instances"
  type        = string
  default     = ""
}

variable "ec2_name" {
  description = "Name for the EC2 instances"
  type        = string
  default     = "my-ec2-instance"
}

variable "tags" {
  description = "Additional tags for the EC2 instances"
  type        = map(string)
  default     = {}
}
variable "sg_name" {
  description = "Name of the security group"
  type        = string
}

variable "openvpn_sg_id" {
  description = "Name of the security group"
  type        = list(string)
  default = [ "sg-1234" ]
}

variable "vpc_id" {
  description = "Name of the security group"
  type        =  string
  default = "vpc-1234"
}
module "vpc" {
  source   = "../../modules/vpc"
  vpc_name = "main"
}

module "ec2" {
  source             = "../../modules/ec2"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids  # Pass all public subnets
  private_subnet_ids = module.vpc.private_subnet_ids  # Pass all private subnets dynamically

  ami_id        = var.ami_id
  instance_type = var.instance_type
}

module "bastion" {
  source           = "../../modules/bastion"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_1_id
  ami_id           = var.ami_id
  allowed_ip       = "0.0.0.0/0"  # Replace with your IP address
  environment      = "dev"
}


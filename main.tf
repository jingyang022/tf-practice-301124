module "web_app" {
  source         = "./modules/web_app"
  name_prefix    = "yap"
  instance_type  = "t2.micro"
  instance_count = 2
  vpc_id         = "vpc-0a877fb493052e5d3"
  public_subnet  = false  # true = put ec2 into public subnets
}
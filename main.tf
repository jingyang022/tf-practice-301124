module "web_app" {
  source         = "./modules/web_app"

  name_prefix    = "yap"
  
  instance_type  = "t2.micro"
  instance_count = 2

  vpc_id         = "vpc-0e9fb7b522389991b"
  public_subnet  = false # true = put ec2 into public subnets

  alb_listener_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:255945442255:listener/app/yap-alb/eea94f7bd65e8c45/8dceb4c10b05ee7b"
}
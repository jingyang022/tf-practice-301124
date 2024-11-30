locals {
    selected_subnet_ids = var.public_subnet ? data.aws_subnets.public.ids : data.aws_subnets.private.ids
}

resource "aws_instance" "web_app" {

    count = 1
    ami = "ami-04c913012f8977029"
    instance_type = "t2.micro"
    #subnet_id = data.aws_subnets.public.ids[count.index %length(data.aws_subnets.public.ids)] # for public subnets
    subnet_id = local.selected_subnet_ids[count.index %length(local.selected_subnet_ids)] # for private subnets
    vpc_security_group_ids = [aws_security_group.web_app.id]
    user_data = templatefile("${path.module}/init-script.sh", {
        file_content = "webapp-#${count.index}"
        })

    associate_public_ip_address = true
    tags = {
        Name = "${var.name_prefix}-webapp-${count.index}"
        }
}

resource "aws_security_group" "web_app" {
    name_prefix = "${var.name_prefix}-webapp"
    description = "Allow traffic to webapp"
    vpc_id = data.aws_vpc.selected.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        }

egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    }

lifecycle {
    create_before_destroy = true
    }
}

output "some_value"{
    value = data.aws_subnets.public
}
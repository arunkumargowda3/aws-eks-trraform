resource "aws_instance" "fussion_ec2" {
    ami = var.ami_ec2
    instance_type = var.instance_type_ec2
    vpc_security_group_ids = var.security_group_ec2
    availability_zone = var.subnet_azs[0]
    associate_public_ip_address = true
    key_name = var.key_name
    subnet_id = var.ec2_subnets[0]
    tenancy = "default"  
    root_block_device {
      delete_on_termination = true
      volume_size = "30"
      volume_type = "standard"
      encrypted = true
      tags =  {
        Name = "${var.app_name}-root_block"
        environment =var.env
      }
    }
    ebs_block_device {
        delete_on_termination = true
        device_name = "/dev/sdf"
        encrypted = true
        volume_type = "gp3"
        iops = "3000"
        volume_size = "30"
        tags   = {
            Name= "${var.app_name}-ebs_block"
            environment =var.env

        }
      
    }

    user_data = base64encode(file("modules/EC2/script.sh"))
    tags = {
        Name = "${var.app_name}-${var.env}-ec2"
        environment = var.env

    }

  
}
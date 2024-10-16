resource "aws_launch_template" "template_ec2_node" {
  name = var.node_name

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size           = var.volume_size_ec2_nodes
      volume_type           = var.type_volume
      delete_on_termination = var.ebs_termination
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "none"
  }

  cpu_options {
    #when we select  4 cores and 2 threads per core, the instance will have a total of 8 vCPUs.
    core_count       = 1
    threads_per_core = 1
  }

  credit_specification {
    #where instances earn credits when running below their baseline performance and spend them when they need to burst above the baseline
    #standard Or unlimited
    cpu_credits = "standard"

  }
  # Prevent stopping and termination via API/console
  disable_api_stop        = var.disable_api_stop
  disable_api_termination = var.disable_api_termination
  # Enable EBS optimization for better I/O performance
  ebs_optimized = var.ebs_optimized
  /*
  elastic_gpu_specifications {
#eg1.medium: Provides 1 GiB of GPU memory.
#eg1.large: Provides 2 GiB of GPU memory.
#eg1.xlarge: Provides 4 GiB of GPU memory.
#eg1.2xlarge: Provides 8 GiB of GPU memory.
    type = "medium"
  }
*/

  /*
#here we can select the IAM policy and attach to instance 
  iam_instance_profile {
    name = "test"
  }*/

  image_id = var.image_id_for_node
  /*
  #it will stop the instances when it OS was shutdown
  instance_initiated_shutdown_behavior = "start"
*/
  instance_type = var.instance_type_node

  key_name = var.key_name
  #NOTE: if we are mention the network_interface we cant specifi the security seperately insted we need to specift inide the network_interface
  #security_group_names = var.security_node_group_cluster because tis attribute will not support if we are creating any instance in vpc
  #vpc_security_group_ids = var.security_node_group_cluster 

  monitoring {
    enabled = var.monitoring_ec2
  }

  network_interfaces {
    associate_public_ip_address = var.network_interfaces_associate_public_ip_address
    security_groups             = var.security_node_group_cluster
  }
  /*
  placement {
    #we cant select the multipal azs if we need need to create a another templet
    #availability_zone = var.subnet_azs[0]
    # Do not specify availability zone here; it's set during the node group creation because its asingle templete 
  }
*/
  #user_data = base64encode(file("modules/aws_templete/script.sh"))
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.cluster_name}-${var.env}"
    }
  }


}
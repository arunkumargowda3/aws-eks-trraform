
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#blue_green_update
# create the subnet group for the rds instance
resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "data-mysql-subnets"
  subnet_ids  = var.subnet_id_rds
  description = "sub for az"

  tags = {
    Name = "${var.app_name}-${var.env}-mysql-db"
  }
}


# create the rds instance
resource "aws_db_instance" "db_instance" {
  engine              = "mysql"
  engine_version      = var.engine_version
  multi_az            = false
  identifier          = "fusionscloud-db"
  username            = "admin"
  password            = "admin123"
  instance_class      = "db.t3.micro"
  publicly_accessible = true
  allocated_storage   = 20
  #max_allocated_storage = 1000
  storage_type                = "gp3"
  backup_retention_period     = 0
  allow_major_version_upgrade = true
  db_subnet_group_name        = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids      = var.vpc_security_group_ids_db
  availability_zone           = var.subnet_azs[0]
  db_name                     = "app"
  skip_final_snapshot         = true
  apply_immediately           = false

  timeouts {
    create = "3h"
    delete = "3h"
    update = "3h"
  }

}


#https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.CreatingConnecting.MySQL.html
#sudo dnf install mariadb105
#mysql -h fusionscloud-db.cjq88eamwgd7.us-east-1.rds.amazonaws.com -P 3306 -u admin -p




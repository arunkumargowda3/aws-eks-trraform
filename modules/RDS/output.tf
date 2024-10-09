output "endpoint_rds"{
    value = aws_db_instance.db_instance.endpoint
  
}

output "mysql_version" {
    value = aws_db_instance.db_instance.engine_version
  
}
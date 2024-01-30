provider "aws" {
  region = "ap-south-1"
}
resource "aws_db_instance" "default" {
    identifier = "mysql-db-01"
    engine= "mysql"
    engine_version = "8.0"
    instance_class= "db.t2.micro"
    username= "testdb1"
    password= "testdb1234"
    allocated_storage= 20
    parameter_group_name= "default.mysql8.0"
    skip_final_snapshot= true
}
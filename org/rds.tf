resource "aws_db_subnet_group" "this" {
    provider = aws.aws
    name          = "database subnet"
    subnet_ids    = keys(module.vpc.vpc_data_subnets)
    description   = "Subnet for Database Instance"

    tags = {
        Name = "database-subnet"
    }
}

resource "aws_db_instance" "database-instance" {
    provider                = aws.aws
    engine                  = "postgres"
    engine_version          = "13.4"
    instance_class          = "db.t3.micro"
    allocated_storage       = 10
    skip_final_snapshot     = true
    availability_zone       = "us-east-1a"
    username                = "postgres"
    password                = "postgres"
    db_subnet_group_name    = aws_db_subnet_group.this.name
    vpc_security_group_ids  = [aws_security_group.database.id]
}
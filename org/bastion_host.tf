resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
    provider = aws.aws
    key_name   = "bastion_host"
    public_key = tls_private_key.this.public_key_openssh
}

resource "aws_instance" "bastion_host" {
    for_each                    = module.vpc.vpc_public_subnets
    provider                    = aws.aws
    ami                         = data.aws_ami.ubuntu.id
    instance_type               = "t2.micro"
    subnet_id                   = each.key
    security_groups             = [aws_security_group.bastion_host.id]
    associate_public_ip_address = true
    key_name                    = aws_key_pair.generated_key.key_name

    tags = {
        Name = format("bastion-host")
    }
}

output "private_key" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}
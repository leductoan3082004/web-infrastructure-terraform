
resource "aws_key_pair" "my_key_pair" {
  key_name   = "${var.project}-keypair"
  public_key = file("~/.ssh/id_rsa.pub") # Replace with the path to your public key
}


# Create a security group allowing SSH (port 22) and HTTP (port 80) from any IP
resource "aws_security_group" "allow_ssh_and_http" {
  name        = "allow-ssh-and-http"
  description = "Allow SSH (port 22) and HTTP (port 80) from any IP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch an EC2 instance
resource "aws_instance" "my_instance" {
  ami             = "ami-078c1149d8ad719a7" # Replace with your desired AMI ID
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.my_key_pair.key_name
  security_groups = [aws_security_group.allow_ssh_and_http.name]
  tags = {
    Name = var.project
  }

}
output "ec2_public_ip" {
  value = aws_instance.my_instance.public_ip
}

resource "aws_instance" "team10" {
  ami           = "ami-0df435f331839b2d6"
  instance_type = "t2.micro"
  #user_data     = file("${path.module}/script.sh")
  key_name      = "team10_key"

  tags = {
    Name = "Team-10"
  }

}

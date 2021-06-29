resource "aws_instance" "web" {

  ami                    = var.ami
  key_name               = var.aws_key_pair
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_a.id
  private_ip             = "192.168.1.10"
  vpc_security_group_ids = [aws_security_group.sg-kroton.id]
  user_data              = data.template_file.user_data.rendered

  tags = var.tags

  depends_on = [aws_security_group.sg-kroton]
}

data "template_file" "user_data" {
  template = file("templates/user_data.tpl")

}

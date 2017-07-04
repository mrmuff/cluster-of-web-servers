provider "aws" {
  region = "us-west-1"
}

/*
resource "aws_instance" "example" {
  ami = "ami-327f5352"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
  tags {
    Name = "terraform-example"
  }
}
*/

resource "aws_launch_configuration" "example" {
  image_id = "ami-327f5352"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.instance.id}"]
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "server_port" {
  description = "Port web server listens on"
  default = 8080
}
/*
output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}
*/

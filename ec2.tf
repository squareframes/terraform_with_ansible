
variable "key_name" {}

resource "tls_private_key" "createcert" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2key" {
  key_name   = "${var.key_name}"
  public_key = "${file("${path.module}/data/id_rsa.pub")}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "launchEC2" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id = "${data.aws_subnet.subnet-selected3.id}"
  vpc_security_group_ids = ["${aws_security_group.sg1.id}"]
  #iam_instance_profile = "${aws_iam_instance_profile.profileforEC2.name}"
  #user_data     = "${file("${path.module}/user_data.sh")}"
  key_name ="${aws_key_pair.ec2key.key_name}"
  associate_public_ip_address = true
 

  # LAMP installation 
  provisioner "local-exec" {
    command = <<EOT
      sleep 60;
	  >lamp.ini;
	  echo "[web]" | tee -a lamp.ini;
	  echo "${aws_instance.launchEC2.private_ip} ansible_user=${var.ubuntu_user} ansible_ssh_private_key_file=${var.private_key} ansible_python_interpreter=/usr/bin/python3" | tee -a lamp.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
	  ansible-playbook -u ${var.ubuntu_user} --private-key "${var.private_key}" -i lamp.ini playbooks/install_lamp.yaml
    EOT
  }
  tags = {
    Name = "Test_APP"
    environment = "${var.environmentName}"
  }
}
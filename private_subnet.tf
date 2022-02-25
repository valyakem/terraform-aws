
resource "aws_subnet" "private" {
  count                   = "${length(slice(local.az_names, 0, 2))}"   //count all AZs in the variable. slice is to pick different elements
  vpc_id                  = "${aws_vpc.nb_app.id}"   //passed th vpc id from the vpc.tf file 
  cidr_block              = "${cidrsubnet(var.vpc_cidr, 8, count.index + length(local.az_names))}"    //loop though to create private subnets beginning from where we left from public subnet
  availability_zone       = "${local.az_names[count.index]}"      //create the subnet on the current AZ based on index count
  map_public_ip_on_launch = true   //in terraform boolen variables could be assigned without string qoutes

  tags = {
    Name                  = "PrivateSubnet-${count.index + 1}"   //tag the subnet based on the AZ index and increment the count by 1
  }
} 

resource "aws_instance" "natinstance" {
  ami                      = "${var.nat_amis[var.region]}" //use the nat variable, call the region using the region variable from the map
  instance_type            = "t2.micro"
  subnet_id                = "${local.pub_sub_ids[0]}"
  source_dest_check        = false
  vpc_security_group_ids  = ["${aws_security_group.nat_sg.id}"]

  tags = {
    Name = "nbHomeNat"
  } 
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.nb_app.id

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.natinstance.id}"
  }

  tags = {
    Name = "NbPRT"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  count          = "${length(slice(local.az_names, 0, 2))}"
  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private-rt.id}"
}

//whe have to secure nat instances using security groups
resource "aws_security_group" "nat_sg" {
  name        = "nat_sg"
  description = "Allow TLS inbound  traffic for private subnet"
  vpc_id      = aws_vpc.nb_app.id

  # ingress {
  #   description      = "TLS from VPC"
  #   from_port        = 443
  #   to_port          = 443
  #   protocol         = "tcp"
  #   cidr_blocks      = [aws_vpc.main.cidr_block]
  #   ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  # }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
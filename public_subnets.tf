//set a local variable which helps you loop through all AZs in the chosen region
locals{
    az_names = "${data.aws_availability_zones.azs.names}" //store all the available AZs in a variable
    pub_sub_ids = "${aws_subnet.public.*.id}"
}


//listing availability zoness
resource "aws_subnet" "public" {
  count = "${length(local.az_names)}"   //count all AZs in the variable
  vpc_id     = "${aws_vpc.nb_app.id}"   //passed th vpc id from the vpc.tf file 
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index)}"    //loop though to create subnets with a block size of eight 
  availability_zone = "${local.az_names[count.index]}"      //create the subnet on the current AZ based on index count
  tags = {
    Name = "PublicSubnet-${count.index + 1}"   //tag the subnet based on the AZ index and increment the count by 1
  }
}

//internet gateway assignment to VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.nb_app.id

  tags = {
    Name = "NbHomeIgw"
  }
}

//Working with public route tables
resource "aws_route_table" "prt" {
  vpc_id = aws_vpc.nb_app.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "NbPRT"
  }
}

resource "aws_route_table_association" "pub_sub_association" {
  //get all public subnets here and loop for it
  count           = "${length(local.az_names)}"
  subnet_id       = "${local.pub_sub_ids[count.index]}"
  route_table_id  = "${aws_route_table.prt.id}"
}


# resource "aws_subnet" "public" {
#   count = "${length(local.az_names)}"
#   vpc_id     = "${aws_vpc.nb_app.id}"
#   cidr_block = "10.0.1.0/24"
#   availability_zone = "${data.aws_availability_zones.azs.names[count.index]}"
#   tags = {
#     Name = "PublicSubnet-${count.index + 1}"
#   }
# }
//to get subnets created on AZ dynamically, data sources are need
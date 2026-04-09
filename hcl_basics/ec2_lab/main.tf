resource "aws_instance" "cerberus" {
    ami = "ami-06178cf087598769c"
    instance_type = "m5.large"
    key_name = "cerberus-key"
    #first boot
    user_data = file("install-nginx.sh")

}

#Using the public key, 
#create a new key-pair in AWS with the following specifications:
resource "aws_key_pair" "cerberus-key" {
    key_name = "cerberus"
    public_key = file(".ssh/cerverus.pub")

}

resource "aws_eip" "eip" {
    vpc = true
    instance = aws_instance.cerberus.id
    provisioner "local-exec" {
        command = "echo ${aws_eip.eip.public_dns} >> /root/cerberus_public_dns.txt"      
    } 
}


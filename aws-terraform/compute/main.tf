resource "tls_private_key" "personal_pract_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair" "personal_pract_key_pair" {
    key_name = "${var.name}-${var.project}-key"
    public_key = tls_private_key.personal_pract_key.public_key_openssh
}

resource "aws_ssm_parameter" "personal_pract_private_key" {
    name = "/ec2/keypairs/my-keypair/private"
    type = "SecureString"
    value = tls_private_key.personal_pract_key.private_key_openssh
    description = "Private key for my personal_pract keypair"
}

resource "aws_ssm_parameter" "personal_pract_public_key" {
    name = "/ec2/keypairs/my-keypair/public"
    type = "String"
    value = tls_private_key.personal_pract_key.public_key_openssh
}
resource "aws_instance" "personal_pract_instances" {
    count = var.instance_count
    ami = data.aws_ami.ami.id
    instance_type = "t2.micro"
    subnet_id = var.private_subnet_id[count.index]
    key_name = aws_key_pair.personal_pract_key_pair.key_name
    iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
    root_block_device {
        volume_size = var.root_volume_size
        volume_type = var.volume_type
        encrypted = var.volume_encrypted
        delete_on_termination = true
    }
    tags = {
        Name = "${var.name}-instance"
        Project = var.project
    }
}
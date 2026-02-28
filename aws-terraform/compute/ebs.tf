resource "aws_ebs_volume" "personal_pract_root_volume" {
    count = var.create_data_volume ? var.instance_count : 0
    availability_zone = aws_instance.personal_pract_instances[count.index].availability_zone
    size = var.root_volume_size
    type = var.volume_type
    encrypted = var.volume_encrypted

    tags = {
      Name = "${var.name}-root-volume-${count.index}"
    }
}
resource "aws_ebs_volume" "personal_pract_data_volume" {
    count = var.create_data_volume ? var.instance_count : 0
    availability_zone = aws_instance.personal_pract_instances[count.index].availability_zone
    size = var.data_volume_size
    type = var.volume_type
    encrypted = var.volume_encrypted

    tags = {
      Name = "${var.name}-data-volume-${count.index}"
    }
}

resource "aws_volume_attachment" "data_volume" {
    count = var.instance_count
    device_name = "/dev/xvdf"
    volume_id = aws_ebs_volume.personal_pract_data_volume[count.index].id
    instance_id = aws_instance.personal_pract_instances[count.index].id
}
output "ami_id" {
  description = "AMI ID"
  value       = data.aws_ami.this.id
}

output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = aws_instance.this[*].id
}

output "public_ips" {
  description = "List of public IPs"
  value       = [for instance in aws_instance.this : instance.public_ip if instance.public_ip != ""]
}

output "private_ips" {
  description = "List of private IPs"
  value       = aws_instance.this[*].private_ip
}

output "fsuh_ec2_sg" {
  value = aws_security_group.fsuh_http_server_sg

}

output "fsuh_ec2_instance" {
  value = aws_instance.fsuh_http_server
}

output "fsuh_http_server_dns" {
  value = aws_instance.fsuh_http_server.public_dns
}
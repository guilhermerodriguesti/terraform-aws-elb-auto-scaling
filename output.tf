output "availabilityzones" {
  value = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

output "elb-dns" {
  value = "${aws_elb.elb1.dns_name}"
}
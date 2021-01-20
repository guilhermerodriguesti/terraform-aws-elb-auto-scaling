resource "aws_launch_configuration" "web_cluster" {
  image_id        = "${var.ami}"
  instance_type   = "${var.instance_type}"
  security_groups = ["${aws_security_group.sg_web.id}"]
  key_name        = "${aws_key_pair.chave.key_name}"
  user_data       = "${file("user-data/setup.sh")}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "scalegroup" {
  launch_configuration = "${aws_launch_configuration.web_cluster.name}"
  availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]
  min_size             = aws_asg_min_size // AWS_ASG_MIN_SIZE
  max_size             = aws_asg_max_size // AWS_ASG_MAX_SIZE
  enabled_metrics      = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
  metrics_granularity  = "1Minute"
  load_balancers       = ["${aws_elb.elb1.id}"]
  health_check_type    = "ELB"
  tag {
    key                 = "Name"
    value               = "WEBSERVER-00"
    propagate_at_launch = true
  }
}


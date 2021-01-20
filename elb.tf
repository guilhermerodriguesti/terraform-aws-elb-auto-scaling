resource "aws_elb" "elb1" {
  name               = "webserver-elb"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  security_groups    = ["${aws_security_group.sg_elb.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name      = "webserver-elb"
    Env       = "PRD"
    CreatedBy = "DevOps Team"
  }
}

resource "aws_lb_cookie_stickiness_policy" "cookie_stickness" {
  name                     = "cookiestickness"
  load_balancer            = "${aws_elb.elb1.id}"
  lb_port                  = 80
  cookie_expiration_period = 600
}
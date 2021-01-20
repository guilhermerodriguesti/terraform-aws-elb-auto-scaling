resource "aws_autoscaling_policy" "autopolicy" {
  name                   = "webserver-stress-test-autoplicy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.scalegroup.name}"
}

resource "aws_cloudwatch_metric_alarm" "cpualarm" {
  alarm_name          = "webserver-stress-test-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.scalegroup.name}"
  }

  alarm_description = "This metric monitor EC2 instance cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.autopolicy.arn}"]
}

#
resource "aws_autoscaling_policy" "autopolicy-down" {
  name                   = "webserver-stress-test-autoplicy-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.scalegroup.name}"
}

resource "aws_cloudwatch_metric_alarm" "cpualarm-down" {
  alarm_name          = "webserver-stress-test-alarm-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.scalegroup.name}"
  }

  alarm_description = "This metric monitor EC2 instance cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.autopolicy-down.arn}"]
}
# resource "aws_alb_target_group" "webserver-target-group" {
#  name     = "webserver-tg"
#  port     = 443
#  protocol = "HTTPS"
#  vpc_id   = "${aws_vpc.myvpc.id}"
#  health_check {
#    interval            = 30
#    path                = "/"
#    protocol            = "HTTPS"
#    port                = 443
#    timeout             = 5
#    healthy_threshold   = 5
#    unhealthy_threshold = 2
#    matcher             = "200,302"
#  }
#  tags = {
#    Name        = "webserver-target-group"
#    Owner       = "DevOps Team"
#    Environment = "PRD"
#  }
# }

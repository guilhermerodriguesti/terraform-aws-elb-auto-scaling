#!/bin/sh
export AWS_ACCESS_KEY_ID="AKIA5AFRSKL5AHDFCVMV"
export AWS_SECRET_ACCESS_KEY="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"
export AWS_DEFAULT_REGION="us-east-1"

echo "*** Deployment started"


AMI_IMAGE_NAME="ami-058e81222d278fd15"
EC2_INSTANCE_TYPE="t2.micro"
AWS_DEFAULT_REGION="us-east-1"
AWS_ASG_MIN_SIZE="3"
AWS_ASG_MAX_SIZE="4"
AWS_KEY_PAIR="webserver-keypair"

echo "Build File Variables"

cat <<EOF > variables.tf

variable "region" {
  description = "AWS Region"
  default     = "aws_region" // AWS_DEFAULT_REGION
}
variable "ami" {
  description = "AMI"
  default     = "ami_image_name" // AMI_IMAGE_NAME
}
variable "instance_type" {
  description = "EC2 instance type"
  default     = "ec2_instance_type" // EC2_INSTANCE_TYPE
}
EOF

echo "Build Variables"

sed -i -e "s/ami_image_name/${AMI_IMAGE_NAME}/g"        variables.tf
sed -i -e "s/ec2_instance_type/${EC2_INSTANCE_TYPE}/g"  variables.tf
sed -i -e "s/aws_region/${AWS_DEFAULT_REGION}/g"        variables.tf

echo "Configure AutoScaling"

sed -i -e "s/aws_asg_min_size/${AWS_ASG_MIN_SIZE}/g"    autoscaling.tf
sed -i -e "s/aws_asg_max_size/${AWS_ASG_MAX_SIZE}/g"    autoscaling.tf
sed -i -e "s/awskeypair/${AWS_KEY_PAIR}/g"              key.tf

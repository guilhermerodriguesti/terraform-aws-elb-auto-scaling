resource "aws_key_pair" "chave" {
  key_name = "awskeypair" // AWS_KEY_PAIR
  #public_key = "${file("mykeypair.pem")}"
  #public_key = file("~/.ssh/id_rsa.pub")
  #public_key = ""
  #public_key = "${file("/Users/smaug/Downloads/webserver-test.pem")}"
  public_key = file("~/.ssh/id_rsa.pub")
}


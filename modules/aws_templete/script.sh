MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="boundary_string"

--boundary_string
Content-Type: text/x-shellscript; name="setup_httpd.sh"
Content-Disposition: attachment; filename="setup_httpd.sh"

#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
echo "<html><body><div>Welcome to EKS POC!</div></body></html>" > /var/www/html/index.html

--boundary_string--

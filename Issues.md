### terraform apply recreating ec2 without any change
https://github.com/hashicorp/terraform-provider-aws/issues/1041  
solution: `For VPC SG, it should just be an update, but I think you intend to use vpc_security_group_ids instead of security_group (EC2-Classic)`.


### Installing Nginx

```sh
sudo apt update
sudo apt install nginx
sudo systemctl restart nginx

systemctl enable nginx
systemctl start nginx
```

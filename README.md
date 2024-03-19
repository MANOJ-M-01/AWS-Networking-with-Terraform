### Network Diagram

<img src="./Network Diagram.png">  

### Steps
 - `terraform init`
 - `terraform plan`
 - `terraform apply`
 - `terraform destroy`

### EC2 Notes
````
Amazon Linux 2023 AMI 2023.3. ami-0d7a109bf30624c99
Amazon Linux old ami-007868005aea67c54
ubuntu 22.04 ami-080e1f13689e07408
````

#### Terraform apply Result

````sh

Outputs:

````

### Terraform to diagram

https://developer.hashicorp.com/terraform/cli/commands/graph  

````sh 
terraform graph -type=plan | dot -Tpng >graph.png
````

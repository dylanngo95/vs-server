# Make sure you did make things

* Create VPC
* Create Internet Gateway -> Attack to VPC
* Create Public Subnet / Private Subnet
* Create Public Route Table / Private Route Table -> Link to Subnet, Internet Gateway
* Create Security Groups
* Create Network ACLs

# How to use

```bash
terraform init
terraform plan -var-file=prod.tfvars
terraform apply -var-file=prod.tfvars
```

# Make sure you did make things

* Create VPC
* Create Internet Gateway -> Attack to VPC
* Create Public Subnet / Private Subnet
* Create Public Route Table / Private Route Table -> Link to Subnet, Internet Gateway
* Create Security Groups
* Create Network ACLs

# How to use

```bash
cd prod
terraform init
terraform plan -var-file=prod.tfvars
terraform apply -var-file=prod.tfvars
```
# How to configuration ssh

```bash
# Move private key to ~/.ssh/
cp private_key ~/.ssh

# Edit ssh config
Host bastion
    HostName <bastion_public_ip>
    User ubuntu
    IdentityFile ~/.ssh/private_key
Host service
    HostName <service_private_ip>
    User ubuntu
    IdentityFile ~/.ssh/private_key
    ProxyCommand ssh -W %h:%p bastion

# ssh to services
ssh bastion
ssh service
```
# How to ssh to rds
```bash
1, ssh to magento instance
2, connect to mysql
mysql -u'admin' -p'admin123' -h'rds-endpoint'
```
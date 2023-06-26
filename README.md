# terraform-from-scratch
this repo is to enhance and get familiar with Terraform

---
## Naming Conventions
[common rules]
1. all naming convention that is prefix with # can be ommitted
2. naming can be abbreviated 

&emsp;

vpc: [project_name]-[aws region or country name that company's physically located]-[env]-[#usage]-[resource]

ex) toyproject-jp-beta-k8s-vpc <br />
ex) dataplatform-kr-prod-workload-vpc

&emsp;

subnet: [vpc_name without resource name]-[public or private]-[resource]-[az]

ex) toyproject-jp-beta-k8s-public-sn-c <br />
ex) dataplatform-kr-prod-workload-private-sn-a

&emsp;

igw: [vpc_name without resource name]-igw

ex) dataplatform-kr-prod-workload-igw

&emsp;

eip: [vpc_name without resource name]-[#usage]-[resource]

ex) dataplatform-kr-prod-workload-nat-eip

&emsp;

nat: [vpc_name without resource name]-[resource]

ex) dataplatform-kr-prod-workload-ngw

&emsp;

# terraform-from-scratch
this repo is to enhance and get familiar with Terraform

*** all resources that are created by ``terrafrom apply`` are the followings:

1 vpc <br />
6 subnets (3 public, 3 private) <br />
1 internet gateway <br />
1 nat gateway (with 1 elastic ip and elastic network interface for elastic ip) <br />
1 customer gateway <br />
1 virtual private gateway <br />
2 route tables (1 public, 1 private) <br />
1 network acl 

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

subnet: [vpc_name without resource suffix]-[public or private]-[resource]-[az]

ex) toyproject-jp-beta-k8s-public-sn-c <br />
ex) dataplatform-kr-prod-workload-private-sn-a

&emsp;

igw: [vpc_name without resource suffix]-igw

ex) dataplatform-kr-prod-workload-igw

&emsp;

eip: [vpc_name without resource suffix]-[#usage]-[resource]

ex) dataplatform-kr-prod-workload-nat-eip

&emsp;

nat: [vpc_name without resource suffix]-[resource]

ex) dataplatform-kr-prod-workload-ngw

&emsp;

nacl: [vpc_name without resource suffix]-nacl

ex) dataplatform-kr-prod-workload-nacl

&emsp;

rtb: [vpc_name without resource suffix]-[public or private]-rtb

ex) dataplatform-kr-prod-workload-public-rtb
ex) dataplatform-kr-prod-workload-private-rtb

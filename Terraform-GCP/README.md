Steps to build infrastructure using Terraform 

1. Install Terraform (>=1.12.0)
2. Install Gcloud CLI 

3. Choose the folder where you have your terraform module and initialize 
       --> terraform init

4. Check all the module and make changes as per requirements
   apis.tf file - to enable apis
   backend.tf file -
   firewall.tf file - firewall and GCP ports and security
   instance.tf file - VM instance configurations
   networks.tf file - all network configuration (VPC, Subnet, NAT, Cloud Router)

5. Authentication :- We are using short lived credentials for authentication purpose 
      --> gcloud auth application-default login   (if this doesnt work)
      --> export GOOGLE_OAUTH_ACCESS_TOKEN=$(gcloud auth print-access-token --impersonate-service-account <service_account_email.com>)

# You will get a token (short lived token) check using below command
      --> echo $GOOGLE_OAUTH_ACCESS_TOKEN

6. Check the format of the module
      --> terraform fmt

7. Validate the terraform module
      --> terraform validate

8. Plan and Apply changes
      --> terraform plan 
      --> terraform apply --auto-approve





References:  
https://medium.com/@neamulkabiremon/building-a-production-ready-gke-cluster-with-terraform-helm-secure-kubernetes-practices-4df5507ca3fd
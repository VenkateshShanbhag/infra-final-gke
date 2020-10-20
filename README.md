### **Terraform to deploy GKE cluster and VPC network.**
 
Initialize working directory of the containing Terraform configuration files. 

 `terraform init -input=false -backend-config=../../properties/dev/gcs-bucket.tfvars`

Plan and create the plan file. The state file is also generated or updated. The state file will be stored in the bucket specified during init state -backend-config. 

 `terraform plan -out=tf-plan.tfplan -var-file=../../properties/dev/variables.tfvars`

Apply the changes to the desired state of the resources. 

 `terraform apply -input=false tf-plan.tfplan`
 
**Terraform Module:**

A module is a container for multiple resources that are used together. To call a module means to include the contents of that module into the configuration with specific values for its input variables.

Refer : [https://www.terraform.io/docs/configuration/modules.html]
